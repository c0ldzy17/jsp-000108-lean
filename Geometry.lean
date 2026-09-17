/-
Copyright (c) 2026 c0ldzy17 contributors, for the original additions.
Released under Apache 2.0 license as described in LICENSE.
SPDX-License-Identifier: Apache-2.0
-/
/-
The definitions of the Erdős 92 invariant and `possible_f_values_BddAbove`
below are from the Formal Conjectures Authors (copyright 2025), released
under Apache 2.0, at commit 40e7c98697de6f66b8cbdbf641749ab39ed9c152.

The remaining proofs were written anew for this integration. Earlier work
on this reduction was informed by plby/lean-proofs, Erdos92.lean, commit
8822f7ddef30fadbd92e1c6ab4ed897af356af5e. No claim of new mathematics or
legal clean-room provenance is made. See docs/ATTRIBUTION.md.
-/
import Jsp108.Pruning
import Jsp108.Counting

open Jsp108

namespace Erdos92

noncomputable def maxEquidistantPointsAt (x : EuclideanSpace ℝ (Fin 2))
    (points : Finset (EuclideanSpace ℝ (Fin 2))) : ℕ :=
  letI otherPoints := points.erase x
  letI distances := otherPoints.image (dist x)
  sSup (distances.image fun d ↦ (otherPoints.filter fun p ↦ dist x p = d).card)

def hasMinEquidistantProperty (k : ℕ) (A : Finset (EuclideanSpace ℝ (Fin 2))) : Prop :=
  A.Nonempty ∧ ∀ x ∈ A, k ≤ maxEquidistantPointsAt x A

noncomputable def possible_f_values (n : ℕ) : Set ℕ :=
  {k | ∃ (points : Finset (EuclideanSpace ℝ (Fin 2))) (_ : points.card = n),
    hasMinEquidistantProperty k points}

theorem possible_f_values_BddAbove (n : ℕ) : BddAbove (possible_f_values n) := by
  refine ⟨n, fun k hk => ?_⟩
  obtain ⟨points, hcard, ⟨x, hx⟩, hall⟩ := hk
  refine (hall x hx).trans ?_
  unfold maxEquidistantPointsAt
  refine csSup_le' fun m hm => ?_
  rw [Finset.mem_coe, Finset.mem_image] at hm
  obtain ⟨d, hd, rfl⟩ := hm
  calc ((points.erase x).filter fun p => dist x p = d).card
      ≤ (points.erase x).card := Finset.card_filter_le _ _
    _ ≤ points.card := Finset.card_erase_le
    _ = n := hcard

noncomputable def f (n : ℕ) : ℕ := sSup <| possible_f_values n

/-- Every finite circle fiber is bounded by the maximum, including an empty fiber. -/
private lemma circle_fiber_le_max (A : Finset (EuclideanSpace ℝ (Fin 2)))
    (x : EuclideanSpace ℝ (Fin 2)) (r : ℝ) :
    ((A.erase x).filter fun y => dist x y = r).card ≤ maxEquidistantPointsAt x A := by
  classical
  by_cases hempty : ((A.erase x).filter fun y => dist x y = r) = ∅
  · simp [hempty]
  · obtain ⟨y, hy⟩ := Finset.nonempty_iff_ne_empty.mpr hempty
    obtain ⟨hyA, hyr⟩ := Finset.mem_filter.mp hy
    apply le_csSup (Finset.finite_toSet _).bddAbove
    apply Finset.mem_coe.mpr
    exact Finset.mem_image.mpr ⟨r, Finset.mem_image.mpr ⟨y, hyA, hyr⟩, rfl⟩

lemma possible_value_le_card {n k : ℕ} (hk : k ∈ possible_f_values n) : k ≤ n := by
  rcases hk with ⟨A, hAn, hnonempty, hcenters⟩
  obtain ⟨x, hx⟩ := hnonempty
  have hmax : maxEquidistantPointsAt x A ≤ A.card := by
    apply csSup_le'
    intro b hb
    obtain ⟨r, _, rfl⟩ := Finset.mem_image.mp hb
    exact (Finset.card_filter_le _ _).trans Finset.card_erase_le
  exact hAn ▸ (hcenters x hx).trans hmax

/-- Unit distance is the adjacency relation on the finite configuration. -/
def unitGraph (P : Finset (EuclideanSpace ℝ (Fin 2))) : SimpleGraph P where
  Adj x y := dist (x : EuclideanSpace ℝ (Fin 2)) y = 1
  symm := ⟨fun _ _ h => (dist_comm _ _).trans h⟩
  loopless := ⟨fun x h => zero_ne_one ((dist_self (x : EuclideanSpace ℝ (Fin 2))).symm.trans h)⟩

noncomputable instance (P : Finset (EuclideanSpace ℝ (Fin 2))) :
    DecidableRel (unitGraph P).Adj := Classical.decRel _

/-- Count ordered edges by mapping the entire product, then filtering it. -/
private lemma ordered_edges_map (P : Finset (EuclideanSpace ℝ (Fin 2))) :
    ((Finset.univ : Finset (P × P)).filter fun xy => (unitGraph P).Adj xy.1 xy.2).card =
      (P.offDiag.filter fun xy => dist xy.1 xy.2 = 1).card := by
  classical
  let e := (Function.Embedding.subtype (· ∈ P)).prodMap
    (Function.Embedding.subtype (· ∈ P))
  have hproduct : (Finset.univ : Finset (P × P)).map e = P ×ˢ P := by
    change (P.attach ×ˢ P.attach).map e = P ×ˢ P
    rw [Finset.prodMap_map_product, Finset.attach_map_val]
  have hdist : (P ×ˢ P).filter (fun xy => dist xy.1 xy.2 = 1) =
      P.offDiag.filter (fun xy => dist xy.1 xy.2 = 1) := by
    ext xy
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_offDiag]
    constructor
    · rintro ⟨⟨hx, hy⟩, hd⟩
      exact ⟨⟨hx, hy, fun heq => by simp [heq] at hd⟩, hd⟩
    · tauto
  rw [← hdist, ← hproduct, Finset.filter_map, Finset.card_map]
  rfl

lemma card_edgeFinset_unitGraph (P : Finset (EuclideanSpace ℝ (Fin 2))) :
    (unitGraph P).edgeFinset.card = Erdos.unitDist P := by
  classical
  have htwice := (unitGraph P).two_mul_card_edgeFinset
  rw [ordered_edges_map, ← Erdos.two_mul_unitDist] at htwice
  omega

open scoped Classical in
/-- Neighbors transport injectively into one circle in the planar image. -/
private lemma neighbors_le_circle (P : Finset (EuclideanSpace ℝ (Fin 2))) [DecidableEq P]
    (t : Finset P) (v : P) :
    ((t.erase v).filter fun w => (unitGraph P).Adj v w).card ≤
      maxEquidistantPointsAt (v : EuclideanSpace ℝ (Fin 2))
        (t.map (Function.Embedding.subtype (· ∈ P))) := by
  classical
  let e := Function.Embedding.subtype (· ∈ P)
  let neighbors := (t.erase v).filter fun w => (unitGraph P).Adj v w
  have hinclusion : neighbors.map e ⊆
      ((t.map e).erase (e v)).filter fun y => dist (e v) y = 1 := by
    intro y hy
    obtain ⟨w, hw, rfl⟩ := Finset.mem_map.mp hy
    obtain ⟨hw, hadj⟩ := Finset.mem_filter.mp hw
    obtain ⟨hne, hwt⟩ := Finset.mem_erase.mp hw
    exact Finset.mem_filter.mpr ⟨Finset.mem_erase.mpr
      ⟨fun h => hne (e.injective h), Finset.mem_map.mpr ⟨w, hwt, rfl⟩⟩, hadj⟩
  calc neighbors.card = (neighbors.map e).card := (Finset.card_map _).symm
    _ ≤ _ := Finset.card_le_card hinclusion
    _ ≤ _ := circle_fiber_le_max (t.map e) (e v) 1

open scoped Classical in
lemma lower_f_of_unitDist {P : Finset (EuclideanSpace ℝ (Fin 2))} {k : ℕ} (_hk : 0 < k)
    (h : k * P.card < Erdos.unitDist P) :
    ∃ A : Finset (EuclideanSpace ℝ (Fin 2)), A ⊆ P ∧ A.Nonempty ∧
      k ∈ possible_f_values A.card ∧ k ≤ f A.card := by
  classical
  have hgraph : k * (Finset.univ : Finset P).card < edgeCount (unitGraph P) Finset.univ := by
    simpa only [edgeCount_univ, card_edgeFinset_unitGraph, Finset.card_univ,
      Fintype.card_coe] using h
  obtain ⟨t, _, ht, hdegree⟩ := core_of_dense (unitGraph P) k Finset.univ hgraph
  let e := Function.Embedding.subtype (· ∈ P)
  let A := t.map e
  have hproperty : hasMinEquidistantProperty k A := by
    refine ⟨ht.map, ?_⟩
    intro x hx
    obtain ⟨v, hv, rfl⟩ := Finset.mem_map.mp hx
    exact (hdegree v hv).trans (@neighbors_le_circle P (Classical.decEq P) t v)
  have hvalue : k ∈ possible_f_values A.card := ⟨A, rfl, hproperty⟩
  refine ⟨A, ?_, hproperty.1, hvalue, le_csSup (possible_f_values_BddAbove _) hvalue⟩
  intro x hx
  obtain ⟨v, _, rfl⟩ := Finset.mem_map.mp hx
  exact v.property

end Erdos92
