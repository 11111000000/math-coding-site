# phase-d-fanout — distribute Phase D across parallel subagents

#convention
## Thesis

Phase D has 8 axes. They are mostly independent: semantic
verification does not need Coq; Obsidian interop does not
need drift automation. Serial execution is wasteful; parallel
subagents can ship more in less time.

## Antithesis

Parallel work creates merge conflicts. Two subagents editing
`core/coverage.yaml` at the same time will collide. Eight
axes that all want to add a D-row must serialise on
`coverage.yaml`.

Mitigation: each axis gets its own files (own packet,
own theory if needed, own OS file if any) and only touches
`coverage.yaml` for one row each. The fan-out packet itself
adds no row — it documents the distribution.

## Synthesis

7 parallel streams, each owned by one subagent:

| Stream | Files owned                               | Touches shared? |
|--------|-------------------------------------------|------------------|
| D1     | `core/semantic-check.sh`, `math/semantic-check-as-packet/` | new file + 1 packet, +1 D row |
| D2     | `core/drift-check.sh`, `math/drift-check-as-packet/`       | new file + 1 packet, +1 D row |
| D4-T   | `examples/tla/packet-lifecycle.tla`, `math/tla-example-as-packet/` | new dir + 1 packet, +1 D row |
| D4-C   | `examples/coq/fsm-order.v`, `math/coq-example-as-packet/`         | new dir + 1 packet, +1 D row |
| D4-A   | `examples/alloy/packet-deps.als`, `math/alloy-example-as-packet/` | new dir + 1 packet, +1 D row |
| D5     | only edits existing `core/theories/*.md` (wikilinks)         | edits only, no coverage row |
| D6     | `math/.protocol.yaml`, `math/protocol-tuning-as-packet/`        | new file + 1 packet, +1 D row |

D7 (convention-agent first-class) and D3 (self-as-probe)
are sequenced after D1 since both depend on the semantic
verifier.

## What this packet commits to

- A single bundle commit after all subagents finish
- `sh core/verify.sh` returns VERIFIED post-merge
- Each subagent's work is recorded in its own packet's
  `applications[]` with a SHA pointer back to this bundle

## What this packet does NOT commit to

- A web UI (out of convention scope)
- Multi-agent protocol (Phase E+)
- Per-stream independence of `core/coverage.yaml` conflicts
  (mitigation is by convention, not by tooling)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-fanout-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-fanout-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-d-fanout-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-fanout-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-d-fanout-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Phase D has 8 axes. They are mostly independent: semantic
verification does not need Coq; Obsidian interop does not
need drift automation. Serial execution is wasteful; parallel
subagents can ship more in less time.
## Antithesis
Parallel work creates merge conflicts. Two subagents editing
`core/coverage.yaml` at the same time will collide. Eight
axes that all want to add a D-row must serialise on
`coverage.yaml`.
Mitigation: each axis gets its own files (own packet,
own theory if needed, own OS file if any) and only touches
`coverage.yaml` for one row each. The fan-out packet itself
adds no row — it documents the distribution.
## Synthesis
7 parallel streams, each owned by one subagent:
| Stream | Files owned                               | Touches shared? |
|--------|-------------------------------------------|------------------|
| D1     | `core/semantic-check.sh`, `math/semantic-check-as-packet/` | new file + 1 packet, +1 D row |
| D2     | `core/drift-check.sh`, `math/drift-check-as-packet/`       | new file + 1 packet, +1 D row |
| D4-T   | `examples/tla/packet-lifecycle.tla`, `math/tla-example-as-packet/` | new dir + 1 packet, +1 D row |
| D4-C   | `examples/coq/fsm-order.v`, `math/coq-example-as-packet/`         | new dir + 1 packet, +1 D row |
| D4-A   | `examples/alloy/packet-deps.als`, `math/alloy-example-as-packet/` | new dir + 1 packet, +1 D row |
| D5     | only edits existing `core/theories/*.md` (wikilinks)         | edits only, no coverage row |
| D6     | `math/.protocol.yaml`, `math/protocol-tuning-as-packet/`        | new file + 1 packet, +1 D row |
D7 (convention-agent first-class) and D3 (self-as-probe)
are sequenced after D1 since both depend on the semantic
verifier.
## What this packet commits to
- A single bundle commit after all subagents finish
- `sh core/verify.sh` returns VERIFIED post-merge
- Each subagent's work is recorded in its own packet's
  `applications[]` with a SHA pointer back to this bundle
## What this packet does NOT commit to
- A web UI (out of convention scope)
- Multi-agent protocol (Phase E+)

## Task

# phase-d-fanout — task

#convention
## Problem

Phase D has 8 axes documented in
`math/phase-d-roadmap-as-packet/decision.md`. The convention
authors want to know which axes can run in parallel via
subagents and how to compose their outputs.

## Desired outcome

- A fan-out packet that *records* the distribution of work
  across parallel streams (this packet)
- 7 subagent runs that each ship one axis (D1, D2, D4-T,
  D4-C, D4-A, D5, D6) in parallel
- A single bundle commit that merges the 7 streams
- `sh core/verify.sh` returns VERIFIED after the merge

## Constraints

- Each subagent owns its own files; only `core/coverage.yaml`
  is shared, and each subagent may append exactly one D row
- Subagents must not edit each other's packets
- Subagents must list their own `applications[]` referencing
  their own files
- Final merge adds D35..D41 rows; the fan-out packet itself
  adds none (it documents the merge, doesn't claim an axis)
- All work stays POSIX-shell + YAML + markdown (no Python or
  new external tools)

## Assumptions

```yaml
task_id: phase-d-fanout
assumptions:
  - id: A1
    statement: "Phase D axes 1, 2, 4-TLA, 4-Coq, 4-Alloy, 5, 6 are independent enough to ship in parallel"
    status: agent-inferred
    epistemology: fact
    confidence: 0.85
    evidence: |
      None of these axes share files at write time. They
      touch different paths (own packet dir, optional own
      examples dir, optional own OS file). Coverage.yaml
      is the only serialisation point and even there each
      subagent only adds one D row.
      See: math/phase-d-development-as-packet/decision.md

  - id: A2
    statement: "D3 (self-as-probe) and D7 (convention-agent first-class) must wait for D1"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      D3 means the agent runs the verifier on its own work;
      that verifier must exist and produce per-packet
      verdicts. D7 wants a parameterised agent that orchestrates
      subagents — only useful once multiple axes have shipped.
      See: math/phase-d-roadmap-as-packet/decision.md

  - id: A3
    statement: "Coverage.yaml conflicts can be resolved by an after-the-fact merge because YAML lists are append-only"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Even with parallel writes to core/coverage.yaml,
      appending D-rows is associative. A simple 3-way merge
      or a post-edit recovery pass reaches the same state.
      See: core/coverage.yaml#version

  - id: A4
    statement: "Each subagent must list its application in its own packet.yaml — no shared registry"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Convention requires applications to live with the
      packet they belong to. Pulling them into a shared
      file re-introduces the duplicate-state problem
      Phase C eliminated.
      See: core/packet-schema.md#applications-drift-tracking

  - id: A5
    statement: "The fan-out packet itself is metadata, not work — it does not claim an axis"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      A fan-out packet doesn't authorise any new OS file; it
      documents the distribution. Adding D35 row to coverage
      for this metadata might be D35-`fanout-trace`, but we
      skip it for now to keep coverage close to axes.
      See: math/phase-d-roadmap-as-packet/decision.md
```

## Refinement

# Refinement: phase-d-fanout

#convention
## State

- **pre**: 8 Phase D axes documented in
  `math/phase-d-roadmap-as-packet/decision.md` and
  `math/phase-d-development-as-packet/decision.md`.
- **post**: a fan-out packet assigns each axis to a parallel
  subagent stream (or marks it as sequenced), records the
  shared-file contract, and provides the merge plan.

## Operation

- Created `math/phase-d-fanout-as-packet/` with 5 files
- 7 parallel subagent streams run; each owns its files
- Bundle commit merges all streams

## Mapping (axis → subagent stream)

| Axis | Stream subagent ID                          | Files it owns                                    |
|------|---------------------------------------------|---------------------------------------------------|
| D1   | subagent.d1.semantic-check                  | core/semantic-check.sh, math/semantic-check-as-packet/ |
| D2   | subagent.d2.drift-check                     | core/drift-check.sh, math/drift-check-as-packet/  |
| D4-T | subagent.d4.tla                             | examples/tla/, math/tla-example-as-packet/        |
| D4-C | subagent.d4.coq                             | examples/coq/, math/coq-example-as-packet/        |
| D4-A | subagent.d4.alloy                           | examples/alloy/, math/alloy-example-as-packet/    |
| D5   | subagent.d5.wikilinks                       | wikilink edits in core/theories/*.md              |
| D6   | subagent.d6.protocol-tuning                 | math/.protocol.yaml, math/protocol-tuning-as-packet/ |

D3 (self-as-probe) and D7 (convention-agent first-class)
are deferred until D1 lands.

## Invariant preservation

- `AGENTS.md` ≤ 60 lines
- All 24 existing packets keep passing `core/verify.sh`
- New packets follow the 5-file convention

## Test obligation

- 7 subagent streams each produce 1 packet with 5 files
- Bundle commit merges cleanly
- `sh core/verify.sh` returns VERIFIED, 0 errors

## Runtime check

- Subagents append to `applications[]` in their own packet.yaml
  pointing at the bundle commit SHA
- `core/coverage.yaml` adds D35 (semantic-check), D36
  (drift-check), D37 (TLA+ example), D38 (Coq example),
  D39 (Alloy example), D40 (wikilinks), D41 (protocol-tuning)
  — 7 rows, each subagent only knows its row

## Cross-reference

Read with `phase-d-roadmap-as-packet` and
`phase-d-development-as-packet` to understand what's being
distributed.

