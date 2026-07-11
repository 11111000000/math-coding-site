# verifier-as-packet — convention mechanically checks itself

## Thesis

math-coding is "grounded in mathematics" but until now the
checks are manual. Convention authors read packets, ensure
5-file structure, etc. Without mechanical verification, the
convention can drift.

## Antithesis

Heavy verifiers (Python-based like v1.x, TLA+ models) add
external dependencies. Convention says "plain text + git, no
external tools beyond POSIX sh". A POSIX shell verifier IS
possible and matches the constraint.

## Synthesis

core/verify.sh is a structural verifier in POSIX shell:
- Walks convention repo
- Finds every math/<packet>/packet.yaml
- Checks required fields and enums
- Reports verdict via verifier-output.yaml (if present)
- 5 categories of check, all in pure shell + awk + grep

This packet authorizes core/verify.sh as convention OS.

## What this packet commits to

- core/verify.sh exists and is POSIX-only
- It checks 5 things: packet.yaml fields, enum values, 5-file
  structure, depends_on syntax, recursive observability

## What this packet does NOT commit to

- Temporal logic checking (deferred to recursive-check)
- Content validation (convention authors are responsible)
- Auto-fixing violations (verifier reports, doesn't fix)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/verifier-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/verifier-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/verifier-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/verifier-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/verifier-as-packet/packet.yaml)

## Decision

## Thesis
math-coding is "grounded in mathematics" but until now the
checks are manual. Convention authors read packets, ensure
5-file structure, etc. Without mechanical verification, the
convention can drift.
## Antithesis
Heavy verifiers (Python-based like v1.x, TLA+ models) add
external dependencies. Convention says "plain text + git, no
external tools beyond POSIX sh". A POSIX shell verifier IS
possible and matches the constraint.
## Synthesis
core/verify.sh is a structural verifier in POSIX shell:
- Walks convention repo
- Finds every math/<packet>/packet.yaml
- Checks required fields and enums
- Reports verdict via verifier-output.yaml (if present)
- 5 categories of check, all in pure shell + awk + grep
This packet authorizes core/verify.sh as convention OS.
## What this packet commits to
- core/verify.sh exists and is POSIX-only
- It checks 5 things: packet.yaml fields, enum values, 5-file
  structure, depends_on syntax, recursive observability
## What this packet does NOT commit to
- Temporal logic checking (deferred to recursive-check)

## Task

# verifier-as-packet — task

## Problem

Convention checks are manual. Drift can occur: lifecycle field
gets a typo, enum value is wrong, packet is missing a file.

## Desired outcome

A POSIX shell verifier that:
- finds every math/<packet>/packet.yaml
- checks required fields exist (task_id, title, lifecycle, etc.)
- validates enum values (lifecycle ∈ 6 values, substrate ∈ 9, etc.)
- verifies 5-file structure
- reports verdict in stdout (verdict: VERIFIED or NEEDS_REVISION)

## Constraints

- POSIX shell only (sh, awk, grep, sed, find)
- No Python, no Java, no TLA+
- Matches math-coding-birth constraint of "plain text + git"

## Assumptions

```yaml
task_id: verifier-as-packet
assumptions:
  - id: A1
    statement: "POSIX shell is sufficient to verify convention's structural claims"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention requires "plain text + git, no external tools
      beyond POSIX sh, awk, grep, sed, find". A structural
      verifier can be written in POSIX shell.
      See: packet:math-coding-birth/decision.md#what-this-packet-commits-to

  - id: A2
    statement: "core/verify.sh checks 5 categories: fields, enums, 5-file structure, depends_on, recursive observability"
    status: agent-inferred
    epistemology: judgment
    confidence: 0.95
    evidence: |
      These 5 categories match convention's invariants:
      5 files, enum values, depends_on, recursive observability.
      See: packet:math-coding-birth/refinement.md#invariant

  - id: A3
    statement: "Verifier reports verdict but does not fix"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention says verifier is informational. Fixing
      requires human review. This is convention discipline.
      See: packet:theory-curry-howard-as-packet/refinement.md

  - id: A4
    statement: "Recursive observability means verifier checks itself"
    status: judgment
    epistemology: judgment
    evidence: |
      A convention-verifier-as-packet should itself be checkable.
      recursive-check-as-packet handles this in the next commit.
      See: packet:math-coding-birth/decision.md#synthesis

  - id: A5
    statement: "verifier-as-packet's lifecycle is working (not verified yet)"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Once verifier-as-packet exists, core/verify.sh can run.
      When it returns VERIFIED, this packet can be promoted.
      See: packet:this file/packet.yaml#lifecycle: working
```

## Refinement

# Refinement: verifier-as-packet

## State

- Convention repo at current commit
- S = set of packets (math/<name>/)
- verdict: VERIFIED | NEEDS_REVISION

## Operations

- find all packet.yaml
- for each: parse and check
- aggregate errors
- report verdict

## Mapping (verifier checks → convention invariants)

| Check | Convention invariant |
|-------|----------------------|
| 5 files present | math/<name>/ has all required files |
| required fields in packet.yaml | task_id, title, lifecycle, etc. |
| enum values | lifecycle ∈ 6, substrate ∈ 9, etc. |
| depends_on syntax | valid task_id references |
| recursive observability | math-coding-birth is origin |

## Invariant preservation

- Verifier checks invariants but does not change convention
- Every packet's packet.yaml is checked against its own
  declared lifecycle
- Failed check → NEEDS_REVISION (no auto-fix)

## Mapping to convention axes

- **Axis 4 (Verdicts):** verifier produces 5 verdict outcomes
- **Axis 5 (Lifecycle FSM):** check FSM transitions are valid
- **Axis 9 (Coverage):** recursive observability check

## Test obligation

- future recursive-check-as-packet verifies the verifier
  itself (axiom of convention)
- convention author runs verifier on each commit

## Runtime check

- core/verify.sh runs on each commit (manual or via git hook)
- Future: CI workflow runs verifier on push to main

