# theory-ltl — temporal properties of packet lifecycle

#convention
## Thesis

The FSM packet (theory-fsm-as-packet) defines states and
transitions but says nothing about liveness. Liveness answers:
"what MUST eventually happen?". A packet stuck in `working`
forever is broken. Convention needs to say: every packet
eventually reaches `archived` or `superseded`.

## Antithesis

LTL is formal logic. Adding it might over-formalize the
convention. But the convention already declares 5 verdicts and
6 states — adding temporal properties is consistent with
that level of rigor.

## Synthesis

This packet applies LTL informally:
- Safety: never go from `archived` to anywhere
- Liveness: every `verified` packet eventually reaches `archived`
- Liveness: every `deprecated` packet eventually reaches `archived`
- Liveness: every `superseded` packet eventually reaches `archived`

No formal proof required. The temporal properties are
properties that convention authors must satisfy (manually
checked or by future verifier).

## What this packet commits to

- Packet lifecycle satisfies basic LTL safety + liveness
- Safety = no transitions from `archived`
- Liveness = terminal states are reachable
- These properties apply to every packet in math/

## What this packet does NOT commit to

- A formal TLA+ model (deferred — informal list is enough)
- A theorem prover (out of scope for now)
- New lifecycle states

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-ltl-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-ltl-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-ltl-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-ltl-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-ltl-as-packet/packet.yaml)

## Decision

#convention
## Thesis
The FSM packet (theory-fsm-as-packet) defines states and
transitions but says nothing about liveness. Liveness answers:
"what MUST eventually happen?". A packet stuck in `working`
forever is broken. Convention needs to say: every packet
eventually reaches `archived` or `superseded`.
## Antithesis
LTL is formal logic. Adding it might over-formalize the
convention. But the convention already declares 5 verdicts and
6 states — adding temporal properties is consistent with
that level of rigor.
## Synthesis
This packet applies LTL informally:
- Safety: never go from `archived` to anywhere
- Liveness: every `verified` packet eventually reaches `archived`
- Liveness: every `deprecated` packet eventually reaches `archived`
- Liveness: every `superseded` packet eventually reaches `archived`
No formal proof required. The temporal properties are
properties that convention authors must satisfy (manually
checked or by future verifier).
## What this packet commits to
- Packet lifecycle satisfies basic LTL safety + liveness
- Safety = no transitions from `archived`
- Liveness = terminal states are reachable
- These properties apply to every packet in math/
## What this packet does NOT commit to
- A formal TLA+ model (deferred — informal list is enough)

## Task

# theory-ltl — task

#convention
## Problem

theory-fsm-as-packet defines states and transitions but says
nothing about liveness. A packet can sit in `working`
forever. Convention must declare that packets eventually reach
terminal states.

## Desired outcome

LTL properties (informally) for packet lifecycle:
- Safety: □(archived → archived) (no outgoing from archived)
- Liveness: □(verified → ◇archived)
- Liveness: □(deprecated → ◇archived)
- Liveness: □(superseded → ◇archived)

These are convention requirements — every packet must satisfy.

## Constraints

- No formal TLA+ model required (deferred)
- Properties are declared in refinement.md as a list
- Verifier-as-packet (future) will check these properties

## Assumptions

```yaml
task_id: theory-ltl-as-packet
assumptions:
  - id: A1
    statement: "LTL operators □ ◇ ~> are sufficient for safety and liveness"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard LTL definitions. □ = always, ◇ = eventually,
      ~> = leads-to. See core/theories/ltl.md.
      See: core/theories/ltl.md

  - id: A2
    statement: "Packet lifecycle must satisfy safety: archived is terminal"
    status: judgment
    epistemology: judgment
    evidence: |
      theory-fsm-as-packet/refinement.md lists archived as
      terminal state with no outgoing transitions.
      See: packet:theory-fsm-as-packet/refinement.md#operations

  - id: A3
    statement: "Packet lifecycle must satisfy liveness: verified reaches archived"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention says packets are eventually deprecated or
      superseded, and then archived. This is liveness from
      verified to archived.
      See: packet:math-coding-birth/refinement.md#lifecycle

  - id: A4
    statement: "Packet lifecycle must satisfy liveness: superseded reaches archived"
    status: judgment
    epistemology: judgment
    evidence: |
      Once superseded, a packet is archived eventually. Old
      packets don't sit as superseded forever.
      See: packet:theory-fsm-as-packet/refinement.md#operations

  - id: A5
    statement: "Liveness is satisfied by convention authors, not automatically"
    status: judgment
    epistemology: judgment
    evidence: |
      FSM transitions require actions. Liveness is convention
      discipline: agents declare superseded when needed,
      humans archive old packets.
      See: packet:theory-fsm-as-packet/refinement.md#operations
```

## Refinement

# Refinement: theory-ltl

#convention
## State

- S, s₀, → from theory-fsm-as-packet
- LTL properties apply over S × ℕ (state × time)

## Operations

- LTL operators: □ (always), ◇ (eventually), ~> (leads-to)
- Properties over packet lifecycle trajectory

## Safety properties

- □(archived → archived) — no outgoing from archived
- □(superseded → superseded | archived) — superseded is
  also terminal (or transitions only to archived)

## Liveness properties

- □(verified → ◇archived) — every verified packet eventually
  reaches archived (via deprecated or superseded)
- □(deprecated → ◇archived) — every deprecated packet
  eventually reaches archived
- □(superseded → ◇archived) — every superseded packet
  eventually reaches archived

## Mapping to convention axes

- **Axis 5 (Lifecycle FSM):** this packet adds temporal
  properties to the FSM.
- **Axis 9 (Coverage):** these properties must be checked
  by future verifier-as-packet (recursive observability).

## Test obligation

- Future verifier-as-packet reads lifecycle history of each
  packet and verifies temporal properties
- Until then, manual check: every packet ≥30 days old
  should be deprecated or superseded

## Runtime check

- None yet (verifier-as-packet deferred to Phase B)
- Convention authors self-check liveness when archiving

## Cross-reference

Canonical spec: `core/theories/ltl.md` (□, ◇, ~>). This file
is the authoritative list of math-coding liveness and safety
properties over packet lifecycle. Drift between the two is
detected by `core/verify.sh`.

