# JSP-000108: the subpolynomial equidistance question

**Version 1.1 passed the complete build (10,329 jobs), endpoint axiom audits, canonical-axiom comparison, fresh stock-kernel replay (132,615 declarations), and local-module checking. A separate rebuild from the published v1.0.0 archive also passed. Official review remains pending.**

This project proves the negative answer to [JSP-000108](https://github.com/TheJustinSunPrize/awards/blob/f4e7173d89dfe91022a185427d63452c8ffbf6ae/problems/catalog-0101-0200.md#JSP-000108), the weak variant of Erdős Problem 92. For an `n`-point planar set, each center may choose its own distance. The extremal count `f(n)` admits no upper bound `n^(o(n))` with `o(n) → 0`.

The source endpoints in `Jsp108/Main.lean` are:

- `Jsp108.jsp_000108`: the exact negative all-cardinalities statement;
- `Jsp108.jsp_000108_eventually`: the stronger negative eventual statement;
- `Jsp108.unit_distance_fixed_power`: the unconditional fixed-exponent geometric input.

The proof combines Naganori Yamaguchi's formal Sawin tower theorem with the unconditional arithmetic and geometry in Logical Intelligence's unit-distance development, then applies a finite-graph reduction and an asymptotic argument. The final theorem types have no mathematical hypotheses. The conditional hypotheses in Logical Intelligence's original headline theorem are not assumed. Source boundaries are recorded in [ATTRIBUTION.md](ATTRIBUTION.md).

## Reproduction

Use Python 3 and Lean `4.33.1` via `elan`:

```sh
unzip jsp-000108-source.zip -d jsp-000108-project
cd jsp-000108-project
lake exe cache get
sh scripts/verify.sh
```

The [source archive](jsp-000108-source.zip) contains the complete buildable project. The root-level Lean files are inspection copies. All project, Sawin, and Logical Intelligence proof sources are included. Mathlib and its transitive packages are obtained at the pinned revisions in the Lake manifests; Mathlib is `0df444a360eaa60ab8c11dca51a86af692955474`. No plby source download or extraction step is required in this revision.

The verifier checks source hashes, builds the proof, audits the three endpoint axiom sets, compares the permitted axioms with pinned `Init`, replays the endpoint dependencies into an empty trust-level-zero kernel environment, and runs stock `leanchecker` on the local modules. The [environment report](ENVIRONMENT.md) states the exact cache and network-isolation scope.

## Changes from version 1.0

The two formerly reconstructed adapters are replaced by newly written proofs and distributed directly. The graph proof maximizes integer edge surplus over vertex subsets. The geometry proof uses a circle-fiber bound and injective count transport. The canonical definitions and boundedness lemma are reused directly from the explicitly Apache-2.0 Formal Conjectures source. The original plby reduction remains credited as prior work; these replacements do not claim new mathematics or a legal clean-room process.

The original additions and local modifications are expressly licensed under Apache-2.0; all upstream notices remain. See [LICENSE_SCOPE.md](LICENSE_SCOPE.md) and the license inventory inside the archive. The original release and its evidence are preserved separately.

## Package and evidence

- `Jsp108/`: the local reductions, adapters, and final assembly.
- `vendor/li/`: the 12-module arithmetic/geometric import closure and tower bridge.
- `vendor/sawin/Lean4/`: 1,600 upstream tower-development modules, with one documented resource-setting change.
- `SOURCE_MANIFEST.json`: exact origins, source hashes, and verification metadata.
- `verification/`: build, axiom, canonical-axiom, fresh replay, and stock-checker reports.

The fidelity checklist inside the archive explains the exact predicates and quantifiers. These checks use Lean's stock kernel; they are not independently implemented external-kernel checks or official curator verification. Priority, recipient attribution, eligibility, and any award remain subject to official review of [PR 665](https://github.com/TheJustinSunPrize/awards/pull/665).

Exact file hashes are in [SHA256SUMS](SHA256SUMS). Logs: [revised build](lake-build.log), [original archive rebuild](original-clean-build.log), [axioms](axioms.txt), [canonical axiom types](canonical-axioms.txt), [fresh replay](kernel-replay.txt), and [stock checker](leanchecker.txt).
