# agent-as-packet — LLM-as-runtime, the convention's load-bearing substrate

#convention
## Thesis

Phase C established that text = code for an LLM interpreter.
Without an explicit *agent* theory the convention relies on an
implicit assumption ("agents read files and write files").
That assumption must be named so that Phase D substrates
(TLA+, Coq, Alloy, PBT) can be applied *through* an agent
rather than around it.

## Antithesis

Naming the agent might create a "homunculus" fallacy — the
convention starts reasoning about an idealised agent instead
of the real one. The fix is to stay operational: only file
read/write actions count; "reasoning" is implicit in the
order of reads and writes.

## Synthesis

This packet authorises `core/theories/agent.md` and exposes
the agent as a **mode × role** substrate:

- The mode (`skip`, `light`, `standard`, `strict`) is the
  agent's per-request policy.
- The role (5 presets) pins the default mode.
- The agent's trace is observable in `packet.yaml:applications[]`.

Future packets (TLA+-as-packet, Coq-as-packet, …) will declare
which agent actions generate TLA+/Coq/Alloy code.

## What this packet commits to

- `core/theories/agent.md` is the canonical agent spec.
- The role is declared once per session via
  `# role: <role>` (see `core/decision-modes.md`).
- The mode is declared per request via `# mode: <mode>`.

## What this packet does NOT commit to

- Reasoning observability beyond file I/O.
- A standard protocol for agent-to-agent messaging.
- Real-time cost optimisation for LLM calls (out of scope).

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/agent-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/agent-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/agent-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/agent-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/agent-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Phase C established that text = code for an LLM interpreter.
Without an explicit *agent* theory the convention relies on an
implicit assumption ("agents read files and write files").
That assumption must be named so that Phase D substrates
(TLA+, Coq, Alloy, PBT) can be applied *through* an agent
rather than around it.
## Antithesis
Naming the agent might create a "homunculus" fallacy — the
convention starts reasoning about an idealised agent instead
of the real one. The fix is to stay operational: only file
read/write actions count; "reasoning" is implicit in the
order of reads and writes.
## Synthesis
This packet authorises `core/theories/agent.md` and exposes
the agent as a **mode × role** substrate:
- The mode (`skip`, `light`, `standard`, `strict`) is the
  agent's per-request policy.
- The role (5 presets) pins the default mode.
- The agent's trace is observable in `packet.yaml:applications[]`.
Future packets (TLA+-as-packet, Coq-as-packet, …) will declare
which agent actions generate TLA+/Coq/Alloy code.
## What this packet commits to
- `core/theories/agent.md` is the canonical agent spec.
- The role is declared once per session via
  `# role: <role>` (see `core/decision-modes.md`).
- The mode is declared per request via `# mode: <mode>`.
## What this packet does NOT commit to
- Reasoning observability beyond file I/O.

## Task

# agent-as-packet — task

#convention
## Problem

The convention's Phase C treats the LLM as the interpreter of
the convention's text. But there is no canonical spec for that
interpreter — only an implicit assumption ("agents read agents.md
and act on it"). Phase D will add formal substrate examples
(TLA+, Coq, Alloy). Those examples need an explicit agent
theory to anchor.

## Desired outcome

- `core/theories/agent.md` defines the agent as a runtime
  substrate: state, trace, mode, role.
- `math/agent-as-packet` authorises the theory file with
  5 files matching the convention.
- `core/decision-modes.md` gains a "Role declaration" line and
  a one-time-per-session role pin.

## Constraints

- `agents.md` stays at the 60-line cap (this packet does not
  change `agents.md` directly)
- The agent theory is compact and LLM-readable
- No new runtime dependencies

## Assumptions

```yaml
task_id: agent-as-packet
assumptions:
  - id: A1
    statement: "An LLM agent's behaviour can be modelled as a tuple (state, mode, role, trace) without loss of operational fidelity"
    status: agent-inferred
    epistemology: fact
    confidence: 0.85
    evidence: |
      The convention observed in Phase C (LLM reads files,
      writes files, follows modes) holds for the agents we
      use (Claude Code, opencode). Mapping to a tuple is the
      smallest abstraction that captures it.
      See: core/think-before-do.md

  - id: A2
    statement: "agent.md is foundational (Rigor: any), not a derived theory"
    status: judgment
    epistemology: judgment
    evidence: |
      Agent theory is the substrate for any Phase D formal
      example; placing it at rigor: any keeps the 11-theory
      hierarchy consistent.
      See: core/theories/predicate.md#rigor-foundational

  - id: A3
    statement: "Role is pinned once per session and persists across requests unless re-declared"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      Pinning per-request is ceremony; pinning forever
      buries intent. Session-level pinning matches
      epistemic markers (fact vs hypothesis vs judgment)
      vs runtime context.
      See: packet:fast-track-as-packet/refinement.md

  - id: A4
    statement: "agent-as-packet can stay at lifecycle: sketch with rigor: light until Phase D substrate examples are opened"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      The agent theory is the seed for future packets;
      staying sketch avoids claiming more than is justified.
      See: packet:phase-d-roadmap-as-packet/decision.md

  - id: A5
    statement: "Every Phase D substrate packet (TLA+, Coq, Alloy) declares the agent as depends_on"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      Substrate packets apply theory through an agent;
      depends_on formalises that ordering.
      See: packet:phase-d-roadmap-as-packet/refinement.md
```

## Refinement

# Refinement: agent-as-packet

#convention
## State

- **pre**: convention treats the LLM as the interpreter, but
  no theory spec describes that interpreter. Phase D substrate
  packets (TLA+, Coq, Alloy) would need an implicit one.
- **post**: `core/theories/agent.md` defines the agent as a
  runtime substrate; `core/decision-modes.md` gains role
  pinning.

## Operation

- Created `core/theories/agent.md` (12th theory)
- Created `math/agent-as-packet/` with 5 files
- Extended `core/decision-modes.md` with a "Role declaration"
  line and a one-question role-detection protocol

## Mapping (this packet → convention)

| Spec (this packet)             | Impl (artifact)                    |
|--------------------------------|-------------------------------------|
| Agent theory                   | `core/theories/agent.md`           |
| Role-detection protocol        | `core/decision-modes.md` (extended)|
| Decision D32 (agent theory)    | `core/coverage.yaml`               |

## Invariant preservation

- 21 existing packets still pass `core/verify.sh`
- `AGENTS.md` line count unchanged (≤ 60)

## Test obligation

- `sh core/verify.sh` returns VERIFIED, 0 errors
- `core/theories/agent.md` is referenced by
  `math/agent-as-packet/assumptions.yaml` (drift check 1 passes)
- Role declaration example present in `core/decision-modes.md`

## Runtime check

- Future Phase D packets reference `agent-as-packet` in
  `depends_on`

## Cross-reference

Canonical spec: `core/theories/agent.md`. The mode × role
runtime is documented in `core/decision-modes.md`.
`core/coverage.yaml:D32` records this packet.

