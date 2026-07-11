# theory-fsm — FSM applied to packet lifecycle

## Thesis

math-coding declares 6 lifecycle states (sketch → working →
verified → deprecated → archived) plus superseded. But declaring
states is not enough: convention needs to say when transitions
are allowed. Without a transition table, agents may skip
states (sketch → verified) or invent new ones.

## Antithesis

Specifying a full FSM with explicit transition table is more
work but provides:
- Mechanically checkable invariant: every transition is allowed
- Invariant preservation: what holds at each state
- Forbidden transitions: list of illegal moves

## Synthesis

This packet makes the FSM concrete:
- 6 states (sketch, working, verified, deprecated, archived,
  superseded) — see packet.yaml:lifecycle
- s₀ = sketch (every new packet starts here)
- Transitions defined in refinement.md
- I = convention invariants (5-file structure, depends_on DAG,
  etc.)
- Concrete FSM, no formalism beyond the existing math-coding-birth

## What this packet commits to

- Packet lifecycle IS a finite state machine (recursively)
- Transitions are restricted (no skipping, no inventing)
- Each transition requires explicit action (verification, code,
  etc.)

## What this packet does NOT commit to

- A formal FSM in TLA+ (deferred — informal table is enough)
- New lifecycle states (we keep the 6 from birth-packet)
- Auto-transitions (no FSM runs itself; humans/agents trigger)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-fsm-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-fsm-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-fsm-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-fsm-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-fsm-as-packet/packet.yaml)

## Decision

## Thesis
math-coding declares 6 lifecycle states (sketch → working →
verified → deprecated → archived) plus superseded. But declaring
states is not enough: convention needs to say when transitions
are allowed. Without a transition table, agents may skip
states (sketch → verified) or invent new ones.
## Antithesis
Specifying a full FSM with explicit transition table is more
work but provides:
- Mechanically checkable invariant: every transition is allowed
- Invariant preservation: what holds at each state
- Forbidden transitions: list of illegal moves
## Synthesis
This packet makes the FSM concrete:
- 6 states (sketch, working, verified, deprecated, archived,
  superseded) — see packet.yaml:lifecycle
- s₀ = sketch (every new packet starts here)
- Transitions defined in refinement.md
- I = convention invariants (5-file structure, depends_on DAG,
  etc.)
- Concrete FSM, no formalism beyond the existing math-coding-birth
## What this packet commits to
- Packet lifecycle IS a finite state machine (recursively)
- Transitions are restricted (no skipping, no inventing)
- Each transition requires explicit action (verification, code,
  etc.)
## What this packet does NOT commit to
- A formal FSM in TLA+ (deferred — informal table is enough)

## Task

# theory-fsm — task

## Problem

math-coding-birth declares 6 lifecycle states but doesn't
specify which transitions between them are legal. Without a
transition table, agents may skip states (sketch → verified) or
invent new ones (created → done).

## Desired outcome

A concrete FSM that:
- Lists all 6 states + initial state
- Defines legal transitions
- Lists forbidden transitions
- Connects to invariants from math-coding-birth

## Constraints

- 6 states (no new ones in this commit)
- Transitions listed as a table in refinement.md
- Forbidden transitions listed explicitly
- No formal TLA+ model (deferred to substrate: tla packets)

## Assumptions

```yaml
task_id: theory-fsm-as-packet
assumptions:
  - id: A1
    statement: "An FSM is a tuple ⟨S, s₀, A, →, I⟩"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard mathematical definition. Reproduced in
      core/theories/fsm.md.
      See: core/theories/fsm.md

  - id: A2
    statement: "Packet lifecycle FSM has exactly 6 states (sketch, working, verified, deprecated, archived, superseded)"
    status: judgment
    epistemology: judgment
    evidence: |
      math-coding-birth/refinement.md#lifecycle declares
      6 states. This packet does not introduce new states.
      See: packet:math-coding-birth/refinement.md#lifecycle

  - id: A3
    statement: "Initial state s₀ is sketch"
    status: judgment
    epistemology: judgment
    evidence: |
      Every new packet starts at sketch (see init-packet.sh).
      core/verify.sh (future) will check this.
      See: core/init-packet.sh (when present)

  - id: A4
    statement: "Transition from sketch to verified is FORBIDDEN (no skipping)"
    status: judgment
    epistemology: judgment
    evidence: |
      Skipping working violates FSM constraint: a packet
      without verifier cannot be verified. Convention
      says lifecycle: sketch → working → verified.
      See: packet:math-coding-birth/refinement.md#lifecycle

  - id: A5
    statement: "Invariant I: packet.yaml + task.md + assumptions.yaml + decision.md + refinement.md all exist"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      math-coding-birth/refinement.md#invariant requires
      5 files per packet. FSM invariant: every state in S
      has all 5 files present.
      See: packet:math-coding-birth/refinement.md#invariant
```

## Refinement

# Refinement: theory-fsm

## State

- **S** = {sketch, working, verified, deprecated, archived, superseded}
- **s₀** = sketch
- **A** = {
    create,
    add_code (sketch → working),
    run_verifier (working → verified),
    add_checklist (sketch → working, alternate),
    remove_packet (sketch → archived),
    deprecate (verified → deprecated),
    supersede (verified/deprecated → superseded),
    archive (deprecated → archived),
    regression (verified → working)
  }
- **→ ⊆ S × A × S** (transitions table below)
- **I: S → B** = packet has 5 files (exists predicate)

## Operations (transition table)

| From | Action | To |
|------|--------|-----|
| sketch | create | sketch (initial) |
| sketch | add_code | working |
| sketch | add_checklist | working |
| sketch | remove_packet | archived |
| working | run_verifier | verified |
| working | regression | sketch (lose artifacts, restart) |
| working | remove_packet | archived |
| verified | regression | working (verifier fails) |
| verified | deprecate | deprecated |
| verified | supersede | superseded |
| deprecated | supersede | superseded |
| deprecated | archive | archived |
| superseded | archive | archived |

## Forbidden transitions

- sketch → verified (must pass through working)
- sketch → deprecated/archived/superseded (must formalize first)
- archived → * (immutable)
- working → superseded (must be verified first)

## Invariant preservation

For every state s ∈ S, invariant I(s) holds:
- 5 files present (packet.yaml, decision.md, task.md, assumptions.yaml, refinement.md)
- packet.yaml:lifecycle field equals the state name
- depends_on forms a valid DAG (no cycles)

## Mapping to convention axes

- **Axis 5 (Lifecycle FSM):** this packet IS the formalization.
- **Axis 4 (Verdicts):** run_verifier transition maps to verdict
  → VERIFIED. Failed verdict maps to regression.
- **Axis 9 (Coverage):** verifier checks every state has 5 files.

## Test obligation

- core/verify.sh (future packet) checks I(s) for every packet
- transition log records every A → s' change
- invariant I is the recursive observability check

## Runtime check

- None yet (verifier-as-packet is deferred to Phase B)
- Until then, transitions are validated manually by convention authors

