# self-as-probe — math-coding proves its own convention by applying it

#convention
## Thesis

math-coding's load-bearing claim is "the convention applies to
itself" (axiom A4, math-coding-birth/refinement.md §9, §13).
Without an executable probe, this claim is a slogan. A
self-probe is the smallest concrete demonstration: the agent
creates a packet, edits code, declares the application, and
runs every verifier — and every step yields a verdict.

## Antithesis

A self-probe can become theatre: the agent runs a script that
"passes" because it was written to. Real probe must (a) admit
real failure modes, (b) generate reports that humans inspect,
(c) have a manual override when a test is genuinely wrong.
The probe that says "always pass" hides bugs; the probe that
admits "failed because of X" exposes them.

## Synthesis

D3 has three parts:

1. A **probe protocol** (`core/probe.sh`) that an agent runs
   after every non-trivial commit:
   - `sh core/verify.sh` — structural check
   - `sh core/semantic-check.sh math/<packet>/` — per-packet
     semantic verdict
   - `sh core/drift-check.sh` — applications[] drift
   - exit 0 if all three pass; non-zero if any fails
2. A **probe report** (`core/probe-report.md`) that aggregates
   the three outputs into a single markdown table; humans read
   this on every PR.
3. A **commit hook convention**: the agent commits only after
   `sh core/probe.sh` returns VERIFIED.

This packet runs the probe against *itself* at the end of
this commit, demonstrating that the convention's contracts
hold end-to-end.

## What this packet commits to

- `core/probe.sh` exists, POSIX-only
- `core/probe-report.md` is generated from `core/probe.sh`
- The probe output for the current commit is captured at
  `core/probe-report-2026-07-12.md` (one snapshot per commit)
- `core/verify.sh` includes an indirect check: every packet's
  5 files exist (already)

## What this packet does NOT commit to

- A pre-commit hook in git (the convention stays
  shell-and-git, not git-hooks-yet)
- A CI integration (Phase D+)
- Per-packet probes (the convention says probes are per-commit,
  not per-packet)
- Auto-failure recovery — the probe reports, the human/agent
  acts

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/self-as-probe-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/self-as-probe-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/self-as-probe-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/self-as-probe-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/self-as-probe-as-packet/packet.yaml)

## Decision

#convention
## Thesis
math-coding's load-bearing claim is "the convention applies to
itself" (axiom A4, math-coding-birth/refinement.md §9, §13).
Without an executable probe, this claim is a slogan. A
self-probe is the smallest concrete demonstration: the agent
creates a packet, edits code, declares the application, and
runs every verifier — and every step yields a verdict.
## Antithesis
A self-probe can become theatre: the agent runs a script that
"passes" because it was written to. Real probe must (a) admit
real failure modes, (b) generate reports that humans inspect,
(c) have a manual override when a test is genuinely wrong.
The probe that says "always pass" hides bugs; the probe that
admits "failed because of X" exposes them.
## Synthesis
D3 has three parts:
1. A **probe protocol** (`core/probe.sh`) that an agent runs
   after every non-trivial commit:
   - `sh core/verify.sh` — structural check
   - `sh core/semantic-check.sh math/<packet>/` — per-packet
     semantic verdict
   - `sh core/drift-check.sh` — applications[] drift
   - exit 0 if all three pass; non-zero if any fails
2. A **probe report** (`core/probe-report.md`) that aggregates
   the three outputs into a single markdown table; humans read
   this on every PR.
3. A **commit hook convention**: the agent commits only after
   `sh core/probe.sh` returns VERIFIED.
This packet runs the probe against *itself* at the end of
this commit, demonstrating that the convention's contracts
hold end-to-end.
## What this packet commits to
- `core/probe.sh` exists, POSIX-only
- `core/probe-report.md` is generated from `core/probe.sh`
- The probe output for the current commit is captured at
  `core/probe-report-2026-07-12.md` (one snapshot per commit)
- `core/verify.sh` includes an indirect check: every packet's
  5 files exist (already)
## What this packet does NOT commit to
- A pre-commit hook in git (the convention stays
  shell-and-git, not git-hooks-yet)
- A CI integration (Phase D+)
- Per-packet probes (the convention says probes are per-commit,
  not per-packet)

## Task

# self-as-probe — task

#convention
## Problem

Axiom A4 (math-coding verifies itself) is claimed, but until
now there was no single script that exercises the whole claim.
Three verifiers exist independently (verify.sh, semantic-check.sh,
drift-check.sh) but no orchestration runs all three and reports
a unified verdict.

## Desired outcome

- `core/probe.sh` runs all three verifiers in sequence and
  emits a single `probe-report-<date>.md` with a table of
  packet × verifier × verdict.
- The probe itself is a shell script that humans can audit;
  no hidden magic.
- This packet's own commit demonstrates the probe end-to-end.

## Constraints

- POSIX shell only; reuses existing `core/*.sh`
- The probe must admit real failures: a single non-zero exit
  from any verifier bubbles up
- The probe must be idempotent — running it twice in a row
  on the same tree yields the same report modulo timestamps
- The probe report filename includes the date so history is
  preserved per-commit without rewriting prior snapshots

## Assumptions

```yaml
task_id: self-as-probe
assumptions:
  - id: A1
    statement: "The three verifiers (verify.sh, semantic-check.sh, drift-check.sh) cover orthogonal aspects: structure, semantic, drift"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Verify.sh checks file existence, enum values, depends_on,
      FSM-state equality, epistemic-marker equality.
      Semantic-check.sh dispatches per substrate to produce
      per-packet verdicts. Drift-check.sh reports stale
      applications[]. Each catches a different bug class.
      See: core/verify.sh, core/semantic-check.sh, core/drift-check.sh

  - id: A2
    statement: "A single probe orchestration script is small enough to stay POSIX shell + bash-equivalent"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      The probe is `verify + per-packet semantic + drift`,
      three sequential commands plus output collection. No
      parallelism needed; ~40 lines of shell.
      See: math/verifier-as-packet/refinement.md#operation

  - id: A3
    statement: "Storing one probe-report-<date>.md per commit preserves history without overwriting prior reports"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Phase C committed to a `core/verifier-output.yaml`
      that always overwrites. The probe records snapshot
      history — same convention but with date suffix.
      See: core/verifier-output.yaml

  - id: A4
    statement: "Applying the probe to this very packet is the strongest test of axiom A4"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      The probe must pass on this packet's commit if the
      claim "convention verifies itself" is to be taken
      seriously. Either it passes or axiom A4 is wrong.
      See: math-coding-birth/refinement.md#9-recursive

  - id: A5
    statement: "Probe reports stay human-readable and short; Markdown tables over JSON"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      Convention is text-first; a Markdown table renders
      well in any viewer (including the future Phase D
      web-ui). JSON is more parseable but less human-friendly.
      See: core/coverage.yaml#version
```

## Refinement

# Refinement: self-as-probe

#convention
## State

- **pre**: three independent verifiers exist; no orchestration
  that runs all three and reports a unified verdict.
  Axiom A4 (convention verifies itself) is therefore a slogan.
- **post**: `core/probe.sh` orchestrates the three verifiers
  and writes a probe-report-<date>.md that *this very commit*
  demonstrates in working order.

## Operation

- Created `core/probe.sh` (POSIX shell, ~50 lines)
- Ran `sh core/probe.sh` and stored the result as
  `core/probe-report-2026-07-12.md`
- Created `math/self-as-probe-as-packet/` with 5 files
- `applications[]` records the bundle commit `d311ac7` as
  the application that the probe verifies

## Mapping (probe → convention axis)

| Probe component       | Convention axis                  |
|-----------------------|----------------------------------|
| `verify.sh`           | structural, drift detection      |
| `semantic-check.sh`   | per-packet semantic verdict      |
| `drift-check.sh`      | applications[] drift             |
| probe-report.md       | axiom A4 evidence                |

## Invariant preservation

- 32 existing packets still pass
- This packet uses `substrate: shell` to express that the
  probe dispatches shell commands
- `depends_on` lists semantic-check-as-packet and
  drift-check-as-packet explicitly (the probe requires them)

## Test obligation

- `sh core/probe.sh` returns 0
- The probe-report demonstrates three verdicts aggregated
- Adding `self-as-probe-as-packet` does not break `verify.sh`

## Runtime check

- After every bundle commit, the probe is re-run and a fresh
  report is written. Reports form a `probe-report-YYYY-MM-DD.md`
  series.
- The probe itself is read-only; it does not change
  applications[] or any packet.

## Cross-reference

Pairs with axiom A4 (math-coding-birth/refinement.md §9) and
with `core/semantic-check.sh` / `core/drift-check.sh`.
This is the keystone that makes axiom A4 executable, not
declarative.

