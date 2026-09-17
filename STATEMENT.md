# Exact JSP-000108 target

## English

**Verification status: complete proof build and fresh dependency kernel replay passed.** The following are the exact two statements proved in `Jsp108/Main.lean` inside the source archive.

```lean
Jsp108.jsp_000108 :
  ¬ ∃ o : ℕ → ℝ, o =o[Filter.atTop] (1 : ℕ → ℝ) ∧
    ∀ n, (Erdos92.f n : ℝ) ≤ (n : ℝ) ^ (o n)

Jsp108.jsp_000108_eventually :
  ¬ ∃ o : ℕ → ℝ, o =o[Filter.atTop] (1 : ℕ → ℝ) ∧
    ∀ᶠ n in Filter.atTop, (Erdos92.f n : ℝ) ≤ (n : ℝ) ^ (o n)
```

Here `o =o[Filter.atTop] (1 : ℕ → ℝ)` means that the real sequence `o(n)` tends to zero. The second endpoint rules out the upper bound even after discarding any finite initial segment, so it implies the first endpoint without relying on exceptional small cardinalities.

For a finite subset `A` of `EuclideanSpace ℝ (Fin 2)` and `x ∈ A`, `maxEquidistantPointsAt x A` is the largest size of a distance class among `A.erase x`. The radius may depend on `x`. `hasMinEquidistantProperty k A` means `A` is nonempty and this count is at least `k` for every center in `A`. `possible_f_values n` collects such values `k` realized by some set of exactly `n` points, and `Erdos92.f n` is their supremum in `ℕ`. A bound by `n` is proved, so the relevant extremal set is bounded.

These are the definitions in the [canonical weak variant of Erdős 92](https://github.com/google-deepmind/formal-conjectures/blob/40e7c98697de6f66b8cbdbf641749ab39ed9c152/FormalConjectures/ErdosProblems/92.lean). Its plane notation `ℝ²` is the same Euclidean-space type used here. The canonical file has an Apache-2.0 notice; it is referenced for the statement and definitions, not imported as a proof of its still-placeholder endpoint.

The [official JSP-000108 wording](https://github.com/TheJustinSunPrize/awards/blob/f4e7173d89dfe91022a185427d63452c8ffbf6ae/problems/catalog-0101-0200.md#JSP-000108) asks whether this extremal count is smaller than every fixed positive power of the number of points. The present target answers that subpolynomial question negatively. The [existing fixed-constant submission](https://github.com/TheJustinSunPrize/awards/pull/256) negates `∃ C > 0, eventually f(n) ≤ n^(C / log log n)`. Negating that narrower family does not by itself negate an arbitrary exponent tending to zero.

The required positive-exponent input is supplied by the complete assembly as `Jsp108.unit_distance_fixed_power`: one fixed `δ > 0` precedes every cardinality threshold. Dense unit-distance graphs yield nonempty induced cores with minimum degree at least `k`; the transfer also proves `k ≤ |core|`, ensuring arbitrarily large cores. Ordered/unordered pairs are reconciled explicitly, and the supremum-based geometric input is realized by actual finite configurations.

The top-level theorems have no mathematical hypotheses. Both endpoints and the fixed-power input report exactly `propext`, `Classical.choice`, and `Quot.sound`; canonical axiom types and the full dependency closure were checked. Original mathematical and formal contributors, license boundaries, and the local integration contribution are listed in [README.md](README.md); detailed source-level fidelity documentation is inside the archive at `docs/FINAL_FIDELITY_CHECKLIST.md`.
