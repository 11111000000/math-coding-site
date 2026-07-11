# theory-deprecation — packet DAG and supersession

## Thesis

math-coding-birth declares that packet.yaml:lifecycle may
take value superseded with a supersession block. But what
STRUCTURALLY does this mean? When a new packet supersedes an
old one, what are the guarantees?

## Antithesis

A formal partial-order (P_old ⊥ P_new) is heavy. But convention
already declares that packets form a DAG (via depends_on).
Supersession extends this with a formal antisymmetric relation.

## Synthesis

Apply deprecation theory to convention:
- supersession is an antisymmetric relation P_old ⊥ P_new
- Properties: irreflexive, asymmetric, transitive (= strict
  partial order)
- P_old ⊥ P_new implies DAG edge P_old → P_new
- Convention requires superseded packets to have lifecycle:
  superseded and a supersession block

## What this packet commits to

- Supersession is a strict partial order
- Convention requires 3 properties in supersession blocks
- Convention authors must not create supersession cycles

## What this packet does NOT commit to

- Auto-detection of superseded packets
- Migration tools
- Versioning system

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-deprecation-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-deprecation-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-deprecation-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-deprecation-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-deprecation-as-packet/packet.yaml)

## Decision

## Thesis
math-coding-birth declares that packet.yaml:lifecycle may
take value superseded with a supersession block. But what
STRUCTURALLY does this mean? When a new packet supersedes an
old one, what are the guarantees?
## Antithesis
A formal partial-order (P_old ⊥ P_new) is heavy. But convention
already declares that packets form a DAG (via depends_on).
Supersession extends this with a formal antisymmetric relation.
## Synthesis
Apply deprecation theory to convention:
- supersession is an antisymmetric relation P_old ⊥ P_new
- Properties: irreflexive, asymmetric, transitive (= strict
  partial order)
- P_old ⊥ P_new implies DAG edge P_old → P_new
- Convention requires superseded packets to have lifecycle:
  superseded and a supersession block
## What this packet commits to
- Supersession is a strict partial order
- Convention requires 3 properties in supersession blocks
- Convention authors must not create supersession cycles
## What this packet does NOT commit to
- Auto-detection of superseded packets

## Task

# theory-deprecation — task

## Problem

Convention has lifecycle: superseded and supersession block
but doesn't formalize what these mean. Without formalization,
convention authors may create invalid supersession relations
(cycles, asymmetric violations).

## Desired outcome

Convention declares supersession ⊥ as a strict partial order:
- Irreflexive: ¬(P ⊥ P)
- Asymmetric: P₁ ⊥ P₂ ⇒ ¬(P₂ ⊥ P₁)
- Transitive: P₁ ⊥ P₂ ∧ P₂ ⊥ P₃ ⇒ P₁ ⊥ P₃

These 3 properties must hold for every supersession relation in
convention.

## Constraints

- No formal theorem prover
- Convention authors ensure 3 properties when creating
  supersession packets
- Future verifier-as-packet will check

## Assumptions

```yaml
task_id: theory-deprecation-as-packet
assumptions:
  - id: A1
    statement: "Supersession P_old ⊥ P_new is a strict partial order"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard definition. Reproduced in
      core/theories/deprecation.md. 3 properties:
      irreflexive, asymmetric, transitive.
      See: core/theories/deprecation.md

  - id: A2
    statement: "Convention's supersession must satisfy 3 properties"
    status: judgment
    epistemology: judgment
    evidence: |
      math-coding-birth/refinement.md mentions supersession
      but doesn't formalize the 3 properties.
      This packet declares them as convention rules.
      See: packet:math-coding-birth/refinement.md#supersession

  - id: A3
    statement: "P_old ⊥ P_new implies a DAG edge P_old → P_new"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention says depends_on: [...] creates DAG.
      Supersession adds explicit edge.
      See: packet:theory-fsm-as-packet/refinement.md

  - id: A4
    statement: "Convention has 3 supersession types: renamed, replaced, removed"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      math-coding-birth/refinement.md#supersession
      lists 3 types.
      See: packet:math-coding-birth/refinement.md#supersession

  - id: A5
    statement: "Supersession cycles are FORBIDDEN"
    status: judgment
    epistemology: judgment
    evidence: |
      Cycles violate transitive property of strict partial
      order. Convention forbids them.
      See: packet:math-coding-birth/refinement.md#supersession
```

## Refinement

# Refinement: theory-deprecation

## State

- P_old, P_new: packets
- ⊥: supersession relation (antisymmetric)
- DAG: directed acyclic graph of packets

## Operations

- Create new packet with supersession: {supersedes: <old-id>}
- Convention checks: 3 properties of strict partial order
- Update old packet's lifecycle to superseded (post-hoc)

## Mapping (supersession semantics)

| Type | Meaning | Properties |
|------|---------|-------------|
| renamed | Same concept, new name | P_new carries forward P_old's claims |
| replaced | Different approach, same goal | P_new supersedes P_old entirely |
| removed | P_old is obsolete, no successor | P_old archived, no replacement |

## Invariant preservation

- 3 properties hold for every ⊥ relation:
  - Irreflexive: ¬(P ⊥ P)
  - Asymmetric: P₁ ⊥ P₂ ⇒ ¬(P₂ ⊥ P₁)
  - Transitive: P₁ ⊥ P₂ ∧ P₂ ⊥ P₃ ⇒ P₁ ⊥ P₃

## Mapping to convention axes

- **Axis 5 (Lifecycle FSM):** supersession is a transition
  to lifecycle: superseded
- **Axis 9 (Coverage):** superseded packets remain in DAG,
  contributing to recursive observability
- **Axis 13 (Theories):** deprecation theory formalizes
  history of theory evolution

## Test obligation

- future verifier-as-packet checks DAG has no cycles
- convention author manually checks 3 properties when
  creating supersession packets

## Runtime check

- None yet (verifier-as-packet deferred to Phase B)
- Manual: when creating supersession, check antisymmetry

