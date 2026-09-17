/-
SPDX-License-Identifier: Apache-2.0

Original JSP-000108 additions contributed by c0ldzy17 with OpenAI Codex assistance.
Licensed under the Apache License, Version 2.0; see LICENSE and LICENSE_SCOPE.md.
Third-party source attributions and notices remain in force.
-/
import Jsp108.UnitDistanceInput
import Jsp108.CountTransport
import ErdosUnitDistance.TowerBridge

open Filter
open scoped Topology

namespace Jsp108

/-- Fixed-power unit-distance growth, with the number-field input discharged
by the unconditional Sawin tower theorem. -/
theorem unit_distance_fixed_power : PolynomialUnitDistanceGrowth :=
  polynomial_growth_of_li_main
    (ErdosUnitDistance.polynomial_of_totally_real_split_fields exists_split_tower)

/-- Negative answer to the original JSP-000108 / Erdős 92 question. -/
theorem jsp_000108 :
    ¬ ∃ o : ℕ → ℝ, o =o[atTop] (1 : ℕ → ℝ) ∧
      ∀ n, (Erdos92.f n : ℝ) ≤ (n : ℝ) ^ (o n) :=
  not_subpolynomial_of_unit_distance_growth unit_distance_fixed_power

/-- Stronger form: the bound cannot hold even just for all sufficiently large n. -/
theorem jsp_000108_eventually :
    ¬ ∃ o : ℕ → ℝ, o =o[atTop] (1 : ℕ → ℝ) ∧
      ∀ᶠ n in atTop, (Erdos92.f n : ℝ) ≤ (n : ℝ) ^ (o n) :=
  not_subpolynomial_eventually_of_unit_distance_growth unit_distance_fixed_power

#print axioms unit_distance_fixed_power
#print axioms jsp_000108
#print axioms jsp_000108_eventually

end Jsp108
