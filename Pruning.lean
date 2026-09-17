/-
Copyright (c) 2026 c0ldzy17 contributors.
Released under Apache 2.0 license as described in LICENSE.
SPDX-License-Identifier: Apache-2.0
-/
/-
A finite dense graph contains a nonempty induced graph of large minimum degree.

This implementation maximizes the integer-valued edge surplus among subsets.
The geometric reduction was previously informed by plby/lean-proofs,
Erdos92.lean at 8822f7ddef30fadbd92e1c6ab4ed897af356af5e. The proof below is
newly written using Mathlib's edge filters and finite maximization. No claim of
new mathematics or legal clean-room provenance is made.
-/
import Mathlib

namespace Jsp108

def edgeCount {α : Type*} [Fintype α] (G : SimpleGraph α) [DecidableRel G.Adj]
    (s : Finset α) : ℕ :=
  (G.induce (s : Set α)).edgeFinset.card

open scoped Classical in
private lemma edgeCount_as_filter {α : Type*} [Fintype α] (G : SimpleGraph α)
    [DecidableRel G.Adj] (s : Finset α) :
    edgeCount G s = (G.edgeFinset.filter fun e => e.toFinset ⊆ s).card := by
  classical
  exact (G.card_filter_edgeFinset_toFinset_subset s).symm

lemma edgeCount_univ {α : Type*} [Fintype α] (G : SimpleGraph α)
    [DecidableRel G.Adj] :
    edgeCount G Finset.univ = G.edgeFinset.card := by
  classical
  rw [edgeCount_as_filter]
  simp

open scoped Classical in
/-- Counting the edges lost at a vertex by their other endpoint. -/
private lemma edgeCount_partition {α : Type*} [Fintype α] (G : SimpleGraph α)
    [DecidableRel G.Adj] (s : Finset α) {v : α} (hv : v ∈ s) :
    edgeCount G s = edgeCount G (s.erase v) +
      ((s.erase v).filter fun w => G.Adj v w).card := by
  classical
  let E := G.edgeFinset.filter fun e => e.toFinset ⊆ s
  let N := (s.erase v).filter fun w => G.Adj v w
  have haway : E.filter (fun e => v ∉ e.toFinset) =
      G.edgeFinset.filter (fun e => e.toFinset ⊆ s.erase v) := by
    ext e
    simp only [E, Finset.mem_filter, Finset.subset_erase]
    tauto
  have hincident : E.filter (fun e => v ∈ e.toFinset) = N.image (fun w => s(v, w)) := by
    ext e
    constructor
    · intro he
      have he' : e ∈ G.edgeFinset ∧ e.toFinset ⊆ s ∧ v ∈ e.toFinset := by
        simpa only [E, Finset.mem_filter, and_assoc] using he
      obtain ⟨hedge, hsubset, hmem⟩ := he'
      obtain ⟨w, rfl⟩ := Sym2.mem_iff_exists.mp (Sym2.mem_toFinset.mp hmem)
      have hadj : G.Adj v w := by simpa using hedge
      apply Finset.mem_image.mpr
      refine ⟨w, ?_, rfl⟩
      apply Finset.mem_filter.mpr
      refine ⟨Finset.mem_erase.mpr ⟨hadj.ne.symm, ?_⟩, hadj⟩
      exact hsubset (by simp)
    · rintro he
      obtain ⟨w, hw, rfl⟩ := Finset.mem_image.mp he
      obtain ⟨hws, hadj⟩ := Finset.mem_filter.mp hw
      apply Finset.mem_filter.mpr
      constructor
      · apply Finset.mem_filter.mpr
        exact ⟨by simpa using hadj, by simpa only [Sym2.toFinset_mk_eq, Finset.insert_subset_iff, Finset.singleton_subset_iff] using (show v ∈ s ∧ w ∈ s from ⟨hv, Finset.mem_of_mem_erase hws⟩)⟩
      · simp
  have hinj : Function.Injective (fun w : α => s(v, w)) := by
    intro x y hxy
    rcases Sym2.eq_iff.mp hxy with h | h
    · exact h.2
    · exact h.2.trans h.1
  have hsplit := Finset.card_filter_add_card_filter_not (s := E) (fun e : Sym2 α => v ∈ e.toFinset)
  rw [hincident, Finset.card_image_of_injective N hinj, haway] at hsplit
  simpa only [edgeCount_as_filter, E, N, Nat.add_comm] using hsplit.symm

open scoped Classical in
lemma core_of_dense {α : Type*} [Fintype α] (G : SimpleGraph α)
    [DecidableRel G.Adj] (k : ℕ) (s : Finset α)
    (h : k * s.card < edgeCount G s) :
    ∃ t : Finset α, t ⊆ s ∧ t.Nonempty ∧
      ∀ v ∈ t, k ≤ ((t.erase v).filter fun w => G.Adj v w).card := by
  classical
  let excess (t : Finset α) : ℤ := (edgeCount G t : ℤ) - (k : ℤ) * t.card
  obtain ⟨t, ht, hmax⟩ := s.powerset.exists_max_image excess
    ⟨s, Finset.mem_powerset.mpr Finset.Subset.rfl⟩
  have hts : t ⊆ s := Finset.mem_powerset.mp ht
  have hpos : 0 < excess t := by
    have hs : excess s ≤ excess t := hmax s (Finset.mem_powerset.mpr Finset.Subset.rfl)
    have hh : (k : ℤ) * s.card < edgeCount G s := by exact_mod_cast h
    dsimp [excess] at *
    omega
  have hempty : edgeCount G (∅ : Finset α) = 0 := by
    rw [edgeCount_as_filter]
    simp
  have htne : t.Nonempty := by
    by_contra hn
    have ht0 : t = ∅ := Finset.not_nonempty_iff_eq_empty.mp hn
    simpa [excess, ht0, hempty] using hpos
  refine ⟨t, hts, htne, ?_⟩
  intro v hv
  have hremove := hmax (t.erase v)
    (Finset.mem_powerset.mpr ((Finset.erase_subset v t).trans hts))
  have hsplit := edgeCount_partition G t hv
  have hsize := Finset.card_erase_add_one hv
  have hsplitZ : (edgeCount G t : ℤ) = (edgeCount G (t.erase v) : ℤ) +
      (((t.erase v).filter fun w => G.Adj v w).card : ℤ) := by exact_mod_cast hsplit
  have hsizeZ : ((t.erase v).card : ℤ) + 1 = t.card := by exact_mod_cast hsize
  dsimp [excess] at hremove
  have hdegree : (k : ℤ) ≤ ((t.erase v).filter fun w => G.Adj v w).card := by
    nlinarith
  exact_mod_cast hdegree

open scoped Classical in
lemma core_of_dense_card {α : Type*} [Fintype α] (G : SimpleGraph α)
    [DecidableRel G.Adj] (k : ℕ) (s : Finset α)
    (h : k * s.card < edgeCount G s) :
    ∃ t : Finset α, t ⊆ s ∧ k < t.card ∧
      ∀ v ∈ t, k ≤ ((t.erase v).filter fun w => G.Adj v w).card := by
  classical
  obtain ⟨t, hts, hnonempty, hmin⟩ := core_of_dense G k s h
  refine ⟨t, hts, ?_, hmin⟩
  obtain ⟨v, hv⟩ := hnonempty
  exact (hmin v hv).trans_lt ((Finset.card_filter_le _ _).trans_lt
    (Finset.card_lt_card (Finset.erase_ssubset hv)))

end Jsp108
