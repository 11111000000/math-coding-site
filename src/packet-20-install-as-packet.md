# install — convention installer

## Thesis

math-coding's value lies in its runtime: 13 shell scripts,
12 theory docs, the .mathrc config schema, and the Obsidian
interop layer. None of these are useful to a project that
doesn't have them. Convention needs a bootstrap path: a
single command that takes a target project from "no
convention" to "convention ready".

## Antithesis

Two failure modes for the bootstrap:

- **Manual copy**: user reads README, finds `core/`, copies
  it. Drift on every update. Errors with `.mathrc` setup.
- **Git submodule**: fragile under multi-user workflows,
  hides convention behind submodule mechanics.

## Synthesis

`core/install.sh` is the canonical installer. POSIX shell,
~250 lines, copies 38 files into `.math-coding/` of the
target project, generates a `.mathrc` with project-specific
defaults (vault_name from directory basename), and leaves
`math/` to the user.

Three modes:
- `install` (default): preserve existing files, copy new
  ones, generate `.mathrc` if absent
- `upgrade`: overwrite conflicting files, keep `.mathrc` and
  `math/`
- `uninstall`: remove `.math-coding/`, leave `.mathrc` for
  manual review

`core/upgrade.sh` and `core/uninstall.sh` are thin wrappers
that delegate to `install.sh` with the right flags.

`.mathrc` schema is the same everywhere — global
`~/.mathrc`, project `.mathrc`, default values in
`mathrc.sh`. The schema lives in `.mathrc.example` (copied
to every install).

## What this packet commits to

- `core/install.sh` accepts target-dir, mode, dry-run,
  preserve/upgrade flags
- `core/upgrade.sh` and `core/uninstall.sh` delegate to it
- 38 files copied per install (10 shell scripts + 12
  theories + 4 docs + 3 schema + LICENSE + README + agents.md
  + .mathrc.example)
- `.mathrc` generated with vault_name from target basename
- Verify on freshly-installed target returns 0 errors

## What this packet does NOT commit to

- A package manager wrapper (apt, brew, npm) — deferred
- Online update channels — deferred
- Per-user templates in `~/.math-coding/` — deferred
- Brownfield auto-detection (which existing files are
  architectural decisions worth packaging) — deferred

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/install-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/install-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/install-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/install-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/install-as-packet/packet.yaml)

## Decision

## Thesis
math-coding's value lies in its runtime: 13 shell scripts,
12 theory docs, the .mathrc config schema, and the Obsidian
interop layer. None of these are useful to a project that
doesn't have them. Convention needs a bootstrap path: a
single command that takes a target project from "no
convention" to "convention ready".
## Antithesis
Two failure modes for the bootstrap:
- **Manual copy**: user reads README, finds `core/`, copies
  it. Drift on every update. Errors with `.mathrc` setup.
- **Git submodule**: fragile under multi-user workflows,
  hides convention behind submodule mechanics.
## Synthesis
`core/install.sh` is the canonical installer. POSIX shell,
~250 lines, copies 38 files into `.math-coding/` of the
target project, generates a `.mathrc` with project-specific
defaults (vault_name from directory basename), and leaves
`math/` to the user.
Three modes:
- `install` (default): preserve existing files, copy new
  ones, generate `.mathrc` if absent
- `upgrade`: overwrite conflicting files, keep `.mathrc` and
  `math/`
- `uninstall`: remove `.math-coding/`, leave `.mathrc` for
  manual review
`core/upgrade.sh` and `core/uninstall.sh` are thin wrappers
that delegate to `install.sh` with the right flags.
`.mathrc` schema is the same everywhere — global
`~/.mathrc`, project `.mathrc`, default values in
`mathrc.sh`. The schema lives in `.mathrc.example` (copied
to every install).
## What this packet commits to
- `core/install.sh` accepts target-dir, mode, dry-run,
  preserve/upgrade flags
- `core/upgrade.sh` and `core/uninstall.sh` delegate to it
- 38 files copied per install (10 shell scripts + 12
  theories + 4 docs + 3 schema + LICENSE + README + agents.md
  + .mathrc.example)
- `.mathrc` generated with vault_name from target basename
- Verify on freshly-installed target returns 0 errors
## What this packet does NOT commit to
- A package manager wrapper (apt, brew, npm) — deferred
- Online update channels — deferred
- Per-user templates in `~/.math-coding/` — deferred

## Task

# install — task

## Problem

math-coding's 38 files (scripts, theories, docs, schema,
config) need a single-command bootstrap into any target
project. Convention author may want to install fresh,
upgrade existing, or remove.

## Desired outcome

- `sh core/install.sh /path/to/project` — 1 command, 38
  files copied, `.mathrc` generated
- `sh core/upgrade.sh` — overwrites scripts but keeps
  `.mathrc` and `math/`
- `sh core/uninstall.sh` — removes `.math-coding/`
- Dry-run mode for preview
- Existing-project preserve-existing default

## Constraints

- POSIX shell only
- No new external dependencies
- Idempotent (running twice doesn't break)
- Fresh-install verifier passes 0 errors (orphan-check is
  conditional on having math/*/ packets)
## Assumptions

```yaml
task_id: install
assumptions:
  - id: A1
    statement: "Single-command install is sufficient for typical adoption"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      38 files copied in <1s. Adding package-manager layer
      would add complexity for marginal value at v0.618.
      See: phase-e-roadmap-as-packet/decision.md

  - id: A2
    statement: "Convention lives in .math-coding/ subdir, not core/, to avoid mixing with user code"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Subdir keeps convention's existence obvious and
      deletion safe (`rm -rf .math-coding/` reverts).
      See: install-as-packet/decision.md (synthesis)

  - id: A3
    statement: "Pure POSIX sh parser is portable across mawk/gawk/busybox"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Shell-only mathrc.sh loader tested with GNU bash.
      No awk-dependent logic. Will work on mawk/busybox too.
      See: core/mathrc.sh

  - id: A4
    statement: "Fresh install has no packets; orphan-check must skip in that case"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Drift-check 1 in core/verify.sh now reads
      has_packets flag before failing on orphan theory.
      See: core/verify.sh

  - id: A5
    statement: "Upgrade preserves .mathrc to retain user customizations"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      .mathrc is user-specific (vault_name, plugins,
      excludes). Convection scripts are universal.
      Different update policies.
      See: install-as-packet/decision.md```

## Refinement

# Refinement: install

## State

- **pre**: 38 convention files exist only in math-coding
  source. New projects have no way to install.
- **post**: `sh core/install.sh /path/to/project` deploys
  convention. Fresh installs pass verifier with 0 errors.

## Operation

- Created `core/install.sh` (~250 lines, POSIX)
- Created `core/upgrade.sh` (delegator, ~20 lines)
- Created `core/uninstall.sh` (delegator, ~20 lines)
- Modified `core/verify.sh` drift-check 1: orphan theories
  are only flagged when at least one packet exists
- Generated frontmatter for the new packet

## Mapping (artifact → convention axis)

| Artifact | Axis |
|----------|------|
| `core/install.sh` | D50 (this packet) |
| `core/upgrade.sh` | D50 follow-on |
| `core/uninstall.sh` | D50 follow-on |
| `core/verify.sh` change | drift-check 1 conditional |
| `math/install-as-packet/` | D50 owner |

## Invariant preservation

- 44 existing packets still pass `core/verify.sh` after the
  change
- `AGENTS.md` ≤ 60 lines (not touched)
- Fresh-install test passes (0 errors with 0 packets)

## Test obligation

- `sh core/install.sh /tmp/test-target` — installs 38 files,
  generates `.mathrc`
- `sh /tmp/test-target/.math-coding/core/verify.sh` —
  VERIFIED, 0 errors, 26 checks
- `sh core/install.sh /tmp/test-target --upgrade` —
  overwrites conflicting files, preserves `.mathrc`
- `sh core/install.sh /tmp/test-target --uninstall` —
  removes `.math-coding/`, leaves `.mathrc`

## Runtime check

- After installation, agent runs `core/agent.sh --role <role>`
  to begin work
- Convention is now usable from any project

## Cross-reference

Pairs with:

- `core/mathrc.sh` — configuration loader
- `.mathrc.example` — schema template
- `core/verify.sh` — verifier, conditional on math/*/
- `math/mathrc-as-packet/` — config design packet
