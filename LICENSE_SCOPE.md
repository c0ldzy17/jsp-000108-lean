# License scope and third-party notices

The original additions and local modifications contributed to this project by
`c0ldzy17`, with OpenAI Codex assistance, are licensed under the Apache License,
Version 2.0. The complete license text is in [`LICENSE`](LICENSE).

This grant covers the original content in:

- `Jsp108.lean` and `Jsp108/Asymptotic.lean`, `CountTransport.lean`, `Main.lean`,
  `Reduction.lean`, and `UnitDistanceInput.lean`;
- the v1.1 replacement proofs in `Jsp108/Pruning.lean` and `Jsp108/Geometry.lean`,
  subject to the separately attributed Formal Conjectures content below;
- the original additions to `vendor/li/ErdosUnitDistance/TowerBridge.lean`,
  beginning with `classNumber_le_of_rootDiscr_le`, and local compatibility
  modifications to the vendored developments;
- locally authored verification drivers, packaging scripts, configuration,
  and documentation, except material identified as third-party content.

This grant applies to our contributions, not to ownership of upstream work.
Existing copyright notices, license notices, and source attributions remain in
force. The following components retain their own Apache-2.0 grants:

| Component | Origin and retained scope |
|---|---|
| Canonical definitions and `possible_f_values_BddAbove` in `Jsp108/Geometry.lean` | Copyright 2025 The Formal Conjectures Authors; `google-deepmind/formal-conjectures@40e7c98697de6f66b8cbdbf641749ab39ed9c152`, `FormalConjectures/ErdosProblems/92.lean`. |
| `Jsp108/Counting.lean` | Copyright (c) 2026 Kim Morrison; the existing file header and Apache-2.0 notice are preserved. Hosting this source in the plby repository does not change its explicit file-level license. |
| `vendor/li` | Logical Intelligence's `erdos-unit-distance@b6493074dd103ca32ea4f5e9b0bc9cb3a0379f2e`; retain `vendor/li/LICENSE`, source notices, and `PATCHES.md`. In particular, `TowerBridge.lean` reuses the upstream `prop38_mkAdmissibleDatum` construction; that theorem is not an original local contribution. |
| `vendor/sawin` | Naganori Yamaguchi's `SawinTotallyRealTowers@3a455e1aa9140dbbe7b7d68f508392a69c86d0f4`, with disclosed Codex assistance; retain `vendor/sawin/LICENSE` and source notices. |
| Mathlib, Lean, and other dependencies | Their own licenses and notices apply. A local import or verifier calling Lean's APIs does not transfer ownership of their implementation. |

## History of the replaced adapters

Version v1.0 used copied or adapted proof blocks from
`plby/lean-proofs@8822f7ddef30fadbd92e1c6ab4ed897af356af5e`,
`src/latest/ErdosProblems/Erdos92.lean`, in `Pruning.lean` and `Geometry.lean`.
That source credits Codex / GPT-5.6 Sol for the formalization. An express license
grant covering its additional proof blocks was not established. Its parent
license notice about some external-source files was not a blanket grant.

The v1.1 revision replaces those copied adapters: pruning uses a maximum-surplus
argument, and the geometry proofs are newly implemented using Mathlib and the
explicitly licensed canonical Formal Conjectures material. The prior plby
development informed the earlier integration and remains credited in
[`ATTRIBUTION.md`](ATTRIBUTION.md). This license does not retroactively
license the earlier copied proof blocks. We make no claim of new underlying
mathematics or legal clean-room development.
