# lifecycle-temporal-argument — rigor: temporal example

#convention
## Thesis

The convention's `rigor:` enum includes `temporal` and
`temporal+`, but no shipped packet demonstrates what a
temporal argument looks like. Most packets are `rigor: light`
(short claim, single justification) or `rigor: property`
(statement + invariant). A `rigor: temporal` packet would
show the convention's third level — a multi-state property
across time, expressed with □ ◇ ~> and cross-checked against
the FSM transition table.

## Antithesis

A purely temporal argument without the FSM pinning it to
concrete states becomes poetry. The argument must be
*grounded* — every □ or ◇ claim references an FSM state and
an action; every reachable-state claim references the FSM
transition graph. Otherwise the rigor level is decoration.

## Synthesis

This packet carries the temporal argument that the packet
lifecycle:

- is **safe** — no transition from `archived` (□archived is
  invariant)
- is **live** — every `verified` packet eventually reaches
  `archived` (□verified → ◇archived)
- is **unbounded forward** — every packet can always reach
  `working` from any non-terminal state (◇working from
  sketch, verified, deprecated, superseded)
- is **confluent** — the supersession partial order has no
  cycles (irreflexive + asymmetric + transitive, see
  theory-deprecation-as-packet)

The argument references FSM states (core/theories/fsm.md),
LTL operators (core/theories/ltl.md), and modal operators
(core/theories/modal.md) and is cross-checkable by
core/semantic-check.sh.

## What this packet commits to

- The convention's `rigor: temporal` is concretely demonstrated
- 4 temporal properties are recorded:
  - □archived (safety)
  - □(verified → ◇archived) (liveness)
  - ◇working from non-terminal states (recoverability)
  - irreflexive + asymmetric + transitive (supersession safety)
- Future temporal packets can use this as a template

## What this packet does NOT commit to

- A formal model checker run (the convention's TLA+ substrate
  is read-ready but not run-ready in v0.618)
- A proof (rigor: proof would be a separate example packet)
- A live check in core/verify.sh for temporal properties
  (deferred to core/semantic-check.sh Phase D extension)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/lifecycle-temporal-argument-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/lifecycle-temporal-argument-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/lifecycle-temporal-argument-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/lifecycle-temporal-argument-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/lifecycle-temporal-argument-as-packet/packet.yaml)

## Decision

#convention
## Thesis
The convention's `rigor:` enum includes `temporal` and
`temporal+`, but no shipped packet demonstrates what a
temporal argument looks like. Most packets are `rigor: light`
(short claim, single justification) or `rigor: property`
(statement + invariant). A `rigor: temporal` packet would
show the convention's third level — a multi-state property
across time, expressed with □ ◇ ~> and cross-checked against
the FSM transition table.
## Antithesis
A purely temporal argument without the FSM pinning it to
concrete states becomes poetry. The argument must be
*grounded* — every □ or ◇ claim references an FSM state and
an action; every reachable-state claim references the FSM
transition graph. Otherwise the rigor level is decoration.
## Synthesis
This packet carries the temporal argument that the packet
lifecycle:
- is **safe** — no transition from `archived` (□archived is
  invariant)
- is **live** — every `verified` packet eventually reaches
  `archived` (□verified → ◇archived)
- is **unbounded forward** — every packet can always reach
  `working` from any non-terminal state (◇working from
  sketch, verified, deprecated, superseded)
- is **confluent** — the supersession partial order has no
  cycles (irreflexive + asymmetric + transitive, see
  theory-deprecation-as-packet)
The argument references FSM states (core/theories/fsm.md),
LTL operators (core/theories/ltl.md), and modal operators
(core/theories/modal.md) and is cross-checkable by
core/semantic-check.sh.
## What this packet commits to
- The convention's `rigor: temporal` is concretely demonstrated
- 4 temporal properties are recorded:
  - □archived (safety)
  - □(verified → ◇archived) (liveness)
  - ◇working from non-terminal states (recoverability)
  - irreflexive + asymmetric + transitive (supersession safety)
- Future temporal packets can use this as a template
## What this packet does NOT commit to
- A formal model checker run (the convention's TLA+ substrate
  is read-ready but not run-ready in v0.618)
- A proof (rigor: proof would be a separate example packet)

## Task

# lifecycle-temporal-argument — task

#convention
## Problem

The `rigor:` enum allows `light`, `property`, `temporal`,
`proof`. Phase C confirms `light` and `property` exist; no
packet demonstrates `temporal` yet. A future contributor
considering `rigor: temporal` has no template.

## Desired outcome

A self-contained packet at `rigor: temporal` whose body and
refinement.md carry at least 4 temporal properties
(safety + liveness + reachability + partial-order safety),
each anchored to FSM states and operators.

## Constraints

- `substrate: none` (no runnable substrate; the argument is
  textual, like theory-fsm-as-packet)
- `lifecycle: working` (not sketch — this is an exemplar)
- `rigor: temporal` — the verbatim rigor enum value
- `applications[]` declares its own authoring commit
- No new external dependencies

## Assumptions

```yaml
task_id: lifecycle-temporal-argument
assumptions:
  - id: A1
    statement: "rigor: temporal is a valid enum value; packets can declare it"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/verify.sh accepts rigor in
      {light,property,temporal,proof}. convention
      declares the value but currently no packet
      uses it.
      See: core/packet-schema.md

  - id: A2
    statement: "A temporal argument without substrate (no TLA+/Coq executor) is still rigorous — the argument is structured text"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      Many math papers present temporal arguments without
      a model checker. The rigor is in the argument's
      structure, not the tool that runs it.
      See: examples/tla/packet-lifecycle.tla (read-ready)

  - id: A3
    statement: "The four temporal properties chosen (□archived, □verified→◇archived, ◇working, partial-order safety) cover the load-bearing claims of the FSM"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      These properties appear in
      theory-fsm-as-packet/refinement.md,
      theory-ltl-as-packet/refinement.md, and
      theory-deprecation-as-packet/refinement.md. They
      are the convention's actual safety and liveness
      claims.
      See: math/theory-fsm-as-packet/refinement.md#forbidden

  - id: A4
    statement: "A rigor: temporal packet must pin every □/◇ to specific FSM states"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Floating temporal claims without state anchors are
      theatrical. Pinning to FSM states keeps the argument
      auditable against core/theories/fsm.md.
      See: theory-fsm-as-packet/refinement.md

  - id: A5
    statement: "Cross-references between theories (FSM/LTL/modal/deprecation) are the value; the packet is their junction"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      The four theories are independent in core/theories/
      but they are designed to compose. This packet is the
      first demonstration that they compose into a coherent
      safety+liveness argument.
      See: core/coverage.yaml D11/D12/D15/D17
```

## Refinement

# Refinement: lifecycle-temporal-argument

#convention
## State

- **pre**: rigor: temporal exists in the enum but is unused.
  Future contributors have no template for what
  "rigor: temporal" looks like.
- **post**: this packet serves as the template, with 4
  temporal properties cross-referenced to FSM, LTL, modal,
  deprecation theories.

## State

The packet lifecycle FSM has the following states and
properties (cross-referenced from theory-fsm-as-packet,
theory-ltl-as-packet, theory-modal-as-packet):

```
S = {sketch, working, verified, deprecated, archived, superseded}
s₀ = sketch
```

### Property 1 — Safety (terminal state is terminal)

```
□archived
```

No reachable state escapes `archived`. The FSM's
refinement.md:Forbidden Transitions table bans all outgoing
edges from `archived`.

### Property 2 — Liveness (verified eventually reaches archived)

```
□(verified → ◇archived)
```

Any packet that has reached `verified` will, by convention
discipline, eventually reach `archived` via `deprecated` or
`superseded`.

### Property 3 — Recoverability (every non-terminal state can reach working)

```
◇working  (from sketch, verified, deprecated, superseded)
```

The convention does not require agents to roll back to
working — but every state can return to working through
explicit actions (regression, deprecate+re-create, etc.).

### Property 4 — Confluence (supersession is a strict partial order)

```
irreflexive:  ¬(P ⊥ P)
asymmetric:   P₁ ⊥ P₂ ⇒ ¬(P₂ ⊥ P₁)
transitive:   P₁ ⊥ P₂ ∧ P₂ ⊥ P₃ ⇒ P₁ ⊥ P₃
```

Cycle-free DAG of packet lifetimes. Each property is
mechanically checkable by `core/verify.sh` if we add a
deps_on cycle check (Phase D follow-up).

## Operation

- New packet math/lifecycle-temporal-argument-as-packet/
  with 5 files
- `substrate: none`, `rigor: temporal`
- Cross-references the 4 theories via the `## Cross-reference`
  section above

## Mapping (artifact → convention axis)

| Artifact            | Axis                              |
|---------------------|------------------------------------|
| this packet         | D9 (rigor: temporal example)      |
| core/theories/fsm   | Property 1, 2, 3 anchors          |
| core/theories/ltl   | Property 2 grammar                |
| core/theories/modal | Property 3 grammar                |
| core/theories/deprecation | Property 4 grammar         |

## Invariant preservation

- This packet does not modify any core/theories/*.md
- `sh core/verify.sh` returns VERIFIED after addition
- 36 existing packets still pass

## Test obligation

- 4 properties listed above are visible in this packet's
  refinement.md
- `git grep "□"` returns the safety property in this file
- `git grep "◇"` returns liveness and recoverability

## Runtime check

- A future `core/semantic-check.sh` extension may evaluate
  these properties at `substrate: temporal` (deferred).

## Cross-reference

Pairs with theory-fsm-as-packet, theory-ltl-as-packet,
theory-modal-as-packet, theory-deprecation-as-packet.
This packet is the **junction** of those four theories into
one temporal safety/liveness argument.

