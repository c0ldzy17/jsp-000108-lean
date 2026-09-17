# JSP-000108: subpolynomial equidistance bounds

## English

**Complete proof verified locally with Lean 4.33.1.** The build passed (10,329 jobs), all three endpoints use only the standard three axioms, and the full dependency closure passed a fresh stock-kernel replay: 132,794 declarations in an empty trust-level-zero environment. Official review and prize decisions are pending.

This package proves the full negative answer to [JSP-000108](https://github.com/TheJustinSunPrize/awards/blob/f4e7173d89dfe91022a185427d63452c8ffbf6ae/problems/catalog-0101-0200.md#JSP-000108), corresponding to the weak variant of Erdős Problem 92. The maximum equidistance count guaranteed at every center in some `n`-point planar set is not bounded by `n^(o(1))`. Each center may choose its own radius.

The two exact source endpoints are `Jsp108.jsp_000108` and the stronger `Jsp108.jsp_000108_eventually`. See [STATEMENT.md](STATEMENT.md) for their types and the quantifier comparison. Existing [PR 256](https://github.com/TheJustinSunPrize/awards/pull/256) treats the fixed-constant `C / log log n` bound and explicitly excludes this full subpolynomial target.

The [source archive](jsp-000108-source.zip) contains the complete portable project, its 12-module Logical Intelligence dependency closure, 1,600 Sawin tower modules, license notices, pinned manifests, source hashes, and a deterministic preparation recipe. [SHA256SUMS](SHA256SUMS) identifies the exact packaged files. The completed checks are recorded in [lake-build.log](lake-build.log), [axioms.txt](axioms.txt), [kernel-replay.txt](kernel-replay.txt), [canonical-axioms.txt](canonical-axioms.txt), and [leanchecker.txt](leanchecker.txt).

## Reproduction

Use Python 3, `unzip`, and Lean 4.33.1 via `elan`:

```sh
unzip jsp-000108-source.zip -d jsp-000108-project
cd jsp-000108-project
python3 scripts/prepare_pruning_geometry.py
lake exe cache get
sh scripts/verify.sh
```

The preparation step obtains one exact upstream file and checks its source and generated-file SHA-256 values. It supplies two adapters deliberately omitted from the archive because an express license for plby's additional proof code has not been established. This reproducibility mechanism does not grant a license. Full boundaries and notices are inside the archive at `docs/REPRODUCIBLE_PACKAGING.md` and `LICENSES/README.md`.

The verification script checks source hashes, builds the project, audits all three endpoint axioms, compares their types with the pinned toolchain Init, replays all final theorem dependencies into an empty trust-level-zero kernel, and runs stock `leanchecker -v Jsp108`. Only `propext`, `Classical.choice`, and `Quot.sound` occur. The fresh replay uses Lean’s stock kernel and is not an independently implemented external checker. See [ENVIRONMENT.md](ENVIRONMENT.md) for the environment and network-isolation scope.

## Attribution

The question is due to Paul Erdős. The polynomial unit-distance construction is described by [Will Sawin](https://arxiv.org/abs/2605.20579) and the [Alon–Bloom–Gowers–Litt–Sawin–Shankar–Tsimerman–Wang–Matchett Wood exposition](https://arxiv.org/abs/2605.20695), which credits the preceding OpenAI-generated construction and its antecedents.

The reused formal work is credited as follows:

- Naganori Yamaguchi, with disclosed Codex assistance: [SawinTotallyRealTowers](https://github.com/n-yamaguchi-0729/SawinTotallyRealTowers/tree/3a455e1aa9140dbbe7b7d68f508392a69c86d0f4), Apache-2.0.
- Logical Intelligence: [unit-distance arithmetic and geometry](https://github.com/logical-intelligence/erdos-unit-distance/tree/b6493074dd103ca32ea4f5e9b0bc9cb3a0379f2e), Apache-2.0. The conditional upstream Section3 is replaced by the separate unconditional tower input.
- Formal Conjectures authors: [the canonical definitions and statement](https://github.com/google-deepmind/formal-conjectures/blob/40e7c98697de6f66b8cbdbf641749ab39ed9c152/FormalConjectures/ErdosProblems/92.lean), Apache-2.0.
- Kim Morrison and the Tau Ceti contributors: unit-distance counting infrastructure; the copied counting file retains its Apache-2.0 notice.
- The [plby Erdős 92 development](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos92.lean), credited there to Codex / GPT-5.6 Sol: reused graph-pruning and geometric adapter proofs, reconstructed from the pinned source with the license qualification above.

The local contribution is the integration and compatibility work, the bridge from the unconditional split-field tower to the geometric theorem, the exact pair-count and extremal-count transfers, the strengthened core-size argument, and the asymptotic reduction to the full JSP-000108 target. It does not claim authorship of the reused mathematics or upstream proofs. GitHub account `c0ldzy17` is the submitting account; no recipient identity or award decision is asserted.

The final assembly is also available as [Main.lean](Main.lean) for easy inspection; the buildable project is inside the source archive. Submitted by `c0ldzy17` with OpenAI Codex and cooperating agents.
