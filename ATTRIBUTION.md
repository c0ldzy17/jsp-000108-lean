# Attribution and provenance

This project formalizes known mathematics. The problem is due to Paul Erdős.
The polynomial unit-distance disproof is described in
[Will Sawin's explicit construction](https://arxiv.org/abs/2605.20579) and the
[human-verified exposition by Alon, Bloom, Gowers, Litt, Sawin, Shankar,
Tsimerman, Wang and Matchett Wood](https://arxiv.org/abs/2605.20695), which credits
the preceding OpenAI-generated construction and its mathematical antecedents.
This project claims no new underlying mathematical construction.

## Canonical statement and counting

The extremal definitions and `possible_f_values_BddAbove` in `Geometry.lean`
come directly from
[Formal Conjectures, Erdős 92](https://github.com/google-deepmind/formal-conjectures/blob/40e7c98697de6f66b8cbdbf641749ab39ed9c152/FormalConjectures/ErdosProblems/92.lean),
Copyright 2025 The Formal Conjectures Authors, under Apache-2.0. Its unfinished
target proof is not imported as a proved theorem.

`Jsp108/Counting.lean` is the existing unit-distance counting development by
Kim Morrison, with its explicit copyright 2026 and Apache-2.0 file notice
preserved. The pinned source is
[`Erdos90b/External/ErdosUnitDistance/Counting.lean`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos90b/External/ErdosUnitDistance/Counting.lean).
The surrounding earlier arbitrary-constant unit-distance construction is
attributed to L. Alpöge; the `Erdos90b` wrapper credits Kim Morrison and the Tau
Ceti contributors. That earlier construction is not described here as proving
the fixed positive polynomial exponent used by this project.

## Pruning and geometry: v1.0 and v1.1

The v1.0 integration used copied or adapted pruning and geometry proof blocks
from
[`plby/lean-proofs`, `Erdos92.lean`](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos92.lean).
That source credits the Formal Conjectures authors for the statement and
Codex / GPT-5.6 Sol for the formalization. It informed the earlier reduction
from many unit-distance edges to a subset with many equidistant neighbours.

An express license grant for the additional plby proof blocks was not
established. The parent `LICENSE` refers to some external-source files and was
not treated as a blanket Apache grant. Omitting copied bodies from the v1.0
archive and reconstructing them from a pinned source did not establish such
a grant.

The v1.1 revision replaces the copied adapters with a maximum-surplus pruning
proof and new geometry proofs built using Mathlib. Canonical definitions and
the boundedness lemma are reused from their explicitly licensed Formal
Conjectures source. The history above remains part of the provenance; replacing
the implementation is not a claim of new mathematics or legal clean-room
development. The local Apache grant does not retroactively license the old
copied proof blocks.

## Arithmetic and geometric construction

The project uses arithmetic and geometric components from
[Logical Intelligence's unit-distance development](https://github.com/logical-intelligence/erdos-unit-distance/tree/b6493074dd103ca32ea4f5e9b0bc9cb3a0379f2e),
pinned at `b6493074dd103ca32ea4f5e9b0bc9cb3a0379f2e`, under Apache-2.0. Its
upstream headline result assumes two class-field-theoretic hypotheses. We reuse
individual unconditional components; we do not claim to have proved those
two hypotheses in that development.

The reused `prop38_mkAdmissibleDatum` constructor in
`vendor/li/ErdosUnitDistance/TowerBridge.lean` comes from LI's Section3 and
constructs admissible data for `K = L(i)`. It remains upstream work. The local
additions beginning with `classNumber_le_of_rootDiscr_le` connect a supplied
family of totally real fields to the geometric theorem. Other compatibility
changes, including splitting Section2 into smaller files and porting the
class-number helpers, retain the mathematical proofs and their attribution.
See `vendor/li/PATCHES.md` for the changes.

The unconditional tower is provided by
[Naganori Yamaguchi's SawinTotallyRealTowers](https://github.com/n-yamaguchi-0729/SawinTotallyRealTowers/tree/3a455e1aa9140dbbe7b7d68f508392a69c86d0f4),
pinned at `3a455e1aa9140dbbe7b7d68f508392a69c86d0f4`, with disclosed OpenAI Codex
assistance and an Apache-2.0 license. The reused endpoint is
`ClassFieldTower.Sawin.sawin_totally_real_tower`. The dependency closure includes
1,600 tower modules. The local change in `CyclotomicTorsionFixedField.lean` is
one `set_option maxHeartbeats 0 in` resource setting; the affected statement and
proof body are unchanged. The tower and its underlying mathematics are not
local contributions.

## Local contributions and license

The original local work, contributed by `c0ldzy17` with OpenAI Codex assistance,
consists of the Lean 4.33.1 compatibility port, the unconditional
tower-to-geometry bridge, exact counting transport, asymptotic reduction, final
assembly, v1.1 replacement proofs, and verification and packaging drivers.
`CountTransport.lean` connects LI's count to actual finite point sets;
`UnitDistanceInput.lean` converts the tower's prime-ideal families to the precise
splitting interface. These are separate from the substantial upstream proofs
credited above.

Original additions and local modifications are released under Apache-2.0; see
[`LICENSE_SCOPE.md`](LICENSE_SCOPE.md) and [`LICENSE`](LICENSE). Existing
third-party notices and licenses remain in force. Verification results belong
to the source revision identified in their logs; this provenance document does
not assert that checks of v1.0 also verify the changed v1.1 sources. Neither
attribution nor licensing establishes first priority, official acceptance, or
award eligibility.
