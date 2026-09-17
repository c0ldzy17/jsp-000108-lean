# Reproducible source package

## Version 1.1 source boundaries

This revision replaces the two adapters reconstructed in v1.0.0 from
`plby/lean-proofs@8822f7ddef30fadbd92e1c6ab4ed897af356af5e`.
The prior development remains credited as a source of the graph-pruning reduction.
The replacement changes the Lean implementations, not the underlying mathematics
or the final proposition. No legal clean-room process or new mathematical discovery
is claimed.

`Jsp108/Pruning.lean` gives a new proof using a subset maximizing the integer
surplus of its edge count over its vertex-count threshold. `Jsp108/Geometry.lean`
supplies the geometric adapters. The canonical extremal definitions and their
boundedness lemma retain the explicit Apache-2.0 attribution to
[Formal Conjectures](https://github.com/google-deepmind/formal-conjectures/blob/40e7c98697de6f66b8cbdbf641749ab39ed9c152/FormalConjectures/ErdosProblems/92.lean).

Both adapter files are included as ordinary source files. No plby download or
source-extraction step is required. The old extraction script and recipe are not
part of this revision. The original release is preserved for historical comparison.

The original additions are offered under Apache-2.0. Reused components retain
their own notices. See `LICENSE`, `LICENSES/README.md`, and `docs/ATTRIBUTION.md`
for the specific boundaries; repository ownership does not transfer authorship
of upstream results.

## Reproduction

Use Lean `4.33.1` and Python 3. From the extracted project directory:

```sh
lake exe cache get
sh scripts/verify.sh
```

Lake obtains Mathlib and its transitive packages at the exact revisions in
`lake-manifest.json`. All 1,600 Sawin development modules and the 12-module
Logical Intelligence import closure are included in `vendor/`. The source archive
contains no `.lake` directories, compiled proof objects, git metadata, or private
research files.

The verifier checks every mathematical source hash, builds the proof, audits all
three final endpoints, compares the permitted axioms against the pinned toolchain's
`Init`, replays the final theorem dependencies into an empty trust-level-zero
environment, and runs stock `leanchecker` on the local modules. Reports are under
`verification/`.

These checks use Lean's stock kernel. They do not constitute verification by an
independently implemented kernel or designated official review. The exact cache
and network-isolation scope is recorded in `verification/ENVIRONMENT.md`.

## Preserved dependencies

The Sawin development is pinned to
`n-yamaguchi-0729/SawinTotallyRealTowers@3a455e1aa9140dbbe7b7d68f508392a69c86d0f4`.
One declaration has a documented `set_option maxHeartbeats 0 in`; its mathematical
statement and proof body remain unchanged.

The Logical Intelligence development is pinned to
`logical-intelligence/erdos-unit-distance@b6493074dd103ca32ea4f5e9b0bc9cb3a0379f2e`.
The compatibility adaptations and new tower bridge are listed in
`vendor/li/PATCHES.md`. Its conditional headline theorem is not imported or assumed.

Mathlib is pinned to `0df444a360eaa60ab8c11dca51a86af692955474`. All distributed
mathematical source hashes appear in `SOURCE_MANIFEST.json`.
