# Local verification environment

Verification date: 2026-09-17 (UTC).
Platform: macOS / Darwin, Apple arm64.
Toolchain: `leanprover/lean4:v4.33.1` (exact version output in `toolchain.txt`).
Mathlib: `0df444a360eaa60ab8c11dca51a86af692955474`.

The full project build completed successfully: 10,329 jobs, including the 1,600-module Sawin dependency closure, the 12-module unit-distance closure, and the final assembly. The build reused already checked dependency outputs where Lake found them current; this is not described as a separate clean build from an empty cache. Its full log is `lake-build.log`.

`axioms.txt` records the three final endpoint reports. `tower-axioms.txt` records the unconditional tower and splitting-bridge reports. Only `propext`, `Classical.choice`, and `Quot.sound` occur.

The stock `leanchecker -v Jsp108` passed for all nine local modules; its log is `leanchecker.txt`.

The fresh dependency replay uses Lean's stock `Lean.Environment.Replay` and a new empty environment with trust level 0. The driver recursively replays the complete proof dependency closure of all three final endpoints, checks postponed constructors and recursors, rejects other axiom names, and compares the resulting endpoint types and proof terms with their inputs. It is a fresh stock-kernel verification, not an independently implemented external proof checker. See `scripts/focusedFreshReplay.md`.

A separate check compares the exact types and universe parameters of the three permitted axioms with `Init` loaded solely from the pinned toolchain. The canonical-axiom check complements the replay's axiom-name allowlist.

Both replay checks are run with network access disabled using macOS `sandbox-exec` and the profile `(version 1)(allow default)(deny network*)`. This isolates verification from the network; it does not claim hardware isolation or a clean operating-system image. Lean's standard kernel is trusted, and no `native_decide` result is used as an additional axiom.

Reproduction requires an initial online preparation phase to obtain pinned dependencies and reconstruct the two non-bundled adapter files. After preparation, run `sh scripts/verify.sh`; the Lean checks themselves need no network access. Cached build products are absent from the published source archive.

Designated independent review and official prize acceptance are pending. These are submitter-side checks, not curator signatures.
