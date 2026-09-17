# Verification environment and reconstruction scope

Date: 2026-09-17 UTC. Platform: macOS / Apple arm64.
Lean: `leanprover/lean4:v4.33.1`.
Mathlib: `0df444a360eaa60ab8c11dca51a86af692955474`.

## Rebuild of the published original archive

Release v1.0.0 was downloaded from GitHub, its ZIP and SHA-256 checked, and its
two historical adapters reconstructed from the pinned source. The archive hash
is `01c27dce2820c79bdda6ed400b13d69736847e1db7e971d9fda984cd53e42ef8`. All 1,621 proof-source hashes matched the originally verified
source tree. There were no project or vendored build artifacts in this extracted
directory before this run.

The complete build passed (10,329 jobs). The build log and reconstruction
scope are preserved in `verification/v1.0.0-clean-rebuild/` inside the source archive. The original wrapper was then
stopped to avoid repeating its historical replay: the complete revised proof
undergoes the separate full axiom, canonical-axiom, fresh-replay and stock-checker
sequence described below. No new full replay of v1.0.0 is claimed by this rebuild.

Only pinned Mathlib and its transitive package caches were reused. Every cached
package's git revision matched the manifest and its tracked worktree was clean.
This was a clean rebuild of the project and both bundled proof developments,
not a rebuild of Lean or Mathlib from an empty machine.

## Revised version 1.1

All nine project modules were rebuilt from the revised sources (10,329
total build jobs). This build reused existing compiled vendor dependencies;
their mathematical source files are byte-identical to the separate original
archive rebuild above. The revised build is therefore not described as another
empty-cache build of the entire vendor tree.

All three final endpoints use exactly `propext`, `Classical.choice`, and
`Quot.sound`. Their axiom declaration kinds, types, and universe parameters match
`Init` from the pinned toolchain. The revised full dependency replay loaded
811,775 source declarations and checked 132,615 declarations
in an empty trust-level-zero environment. Stock `leanchecker` also passed for
all nine local modules. Source verification covers 1,621 mathematical Lean files
and both verification drivers.

Both verification sequences ran with networking denied by macOS `sandbox-exec`
using `(version 1)(allow default)(deny network*)`. Dependency preparation was
completed beforehand. Version 1.1 requires no plby download or reconstruction.

The compiler, replay, and stock checker use the same Lean kernel implementation.
They are not independently implemented external checkers or designated official
review. Official acceptance, attribution, priority, and any award remain pending.

The rebuilt vendor artifacts matched byte-for-byte in 3,210 cases. Seven LI object files and their seven hash sidecars differed. A separate comparison of the two independently loaded environments found all 377 declaration records from all 12 LI modules identical, including every type and all 371 available proof/definition values. This comparison does not establish equality of source-location environment extensions or classify every differing byte. The artifact inventory, declaration-comparison log, and comparison driver are included under `verification/` in the archive.
