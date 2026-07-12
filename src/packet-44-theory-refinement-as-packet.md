# theory-refinement — packet as spec, code as implementation

#convention
## Thesis

math-coding declares packets as the "intent before code".
But what does that mean structurally? How does a packet (intent)
relate to actual code? Without a refinement map, packet is
aspirational, not operational.

## Antithesis

A formal refinement (S_impl → S_spec with stuttering equivalence)
is too heavy for a convention. Most refinements in practice
are informal: "this packet says login works, and src/login.sh
implements login". Convention should declare the informal
mapping as a convention requirement.

## Synthesis

Refinement in math-coding means:
- packet.yaml:lifecycle declares the spec state
- code (when present) implements that state
- convention requires that the code respects the spec

This packet formalizes the refinement pattern:
- State Mapping: packet state → impl state
- Operation Mapping: spec action → impl function
- Invariant Preservation: spec invariants → impl invariants
- Test Obligation: spec properties → impl tests
- Runtime Check: spec monitors → impl monitors (when present)

The 5 sections of refinement.md ARE the refinement pattern.

## What this packet commits to

- Every packet with code has refinement.md in 5 sections
- Every refinement.md maps packet states to impl states
- Convention requires invariants in spec match impl invariants
- convention authors must satisfy these rules when writing code

## What this packet does NOT commit to

- A formal refinement framework (TLA+, refinement calculus)
- A refinement-checker tool (deferred to verifier-as-packet)
- Specific mappings for all future code

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-refinement-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-refinement-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-refinement-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-refinement-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-refinement-as-packet/packet.yaml)

## Decision

#convention
## Thesis
math-coding declares packets as the "intent before code".
But what does that mean structurally? How does a packet (intent)
relate to actual code? Without a refinement map, packet is
aspirational, not operational.
## Antithesis
A formal refinement (S_impl → S_spec with stuttering equivalence)
is too heavy for a convention. Most refinements in practice
are informal: "this packet says login works, and src/login.sh
implements login". Convention should declare the informal
mapping as a convention requirement.
## Synthesis
Refinement in math-coding means:
- packet.yaml:lifecycle declares the spec state
- code (when present) implements that state
- convention requires that the code respects the spec
This packet formalizes the refinement pattern:
- State Mapping: packet state → impl state
- Operation Mapping: spec action → impl function
- Invariant Preservation: spec invariants → impl invariants
- Test Obligation: spec properties → impl tests
- Runtime Check: spec monitors → impl monitors (when present)
The 5 sections of refinement.md ARE the refinement pattern.
## What this packet commits to
- Every packet with code has refinement.md in 5 sections
- Every refinement.md maps packet states to impl states
- Convention requires invariants in spec match impl invariants
- convention authors must satisfy these rules when writing code
## What this packet does NOT commit to
- A formal refinement framework (TLA+, refinement calculus)

## Task

# theory-refinement — task

#convention
## Problem

math-coding-birth declares packets as "intent before code" but
doesn't formalize how packet relates to code. Without a
refinement pattern, the relation between packet and code is
aspirational.

## Desired outcome

The 5 sections of refinement.md (State/Operation/Invariant/
Test/Runtime) are declared as the canonical refinement pattern.
Every packet with code uses this pattern. Every convention
author writing code follows this pattern.

## Constraints

- No formal refinement framework (informal pattern is enough)
- Pattern is what math-coding-birth already documents in
  refinement.md sections (just formalized as a separate packet)
- This packet does NOT introduce a tool or verifier
- Recursive: this packet itself uses its own pattern

## Assumptions

```yaml
task_id: theory-refinement-as-packet
assumptions:
  - id: A1
    statement: "Refinement is a function R: S_impl → S_spec with stuttering equivalence"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Standard definition. Stuttering equivalence = for every
      impl transition, there's a matching spec transition
      sequence. See core/theories/refinement.md.
      See: core/theories/refinement.md

  - id: A2
    statement: "Packet is the spec, code is the implementation"
    status: judgment
    epistemology: judgment
    evidence: |
      math-coding-birth/refinement.md establishes packet
      as "spec, not implementation". Code is what implements
      the packet.
      See: packet:math-coding-birth/refinement.md

  - id: A3
    statement: "refinement.md has 5 canonical sections (State, Operation, Invariant, Test, Runtime)"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Every packet in math/ has refinement.md with these
      5 sections. See all refinement.md files.
      See: packet:math-coding-birth/refinement.md (sections)

  - id: A4
    statement: "When no code exists, refinement.md describes implementation as deferred"
    status: judgment
    epistemology: judgment
    evidence: |
      theory-predicate-as-packet/refinement.md says
      "Implementation as deferred". convention allows packets
      without code; refinement.md still documents the
      intended mapping.
      See: packet:theory-predicate-as-packet/refinement.md

  - id: A5
    statement: "Convention does not require formal proof of refinement correctness"
    status: judgment
    epistemology: judgment
    evidence: |
      Formality would require substrate: tla packets (future).
      Convention authors are responsible for ensuring
      refinement is correct.
      See: packet:theory-fsm-as-packet/refinement.md
```

## Refinement

# Refinement: theory-refinement

#convention
## State

- S_spec = packet state space (lifecycle + structural claims)
- S_impl = implementation state space (code + runtime)

## Operations

- State Mapping R: S_impl → S_spec
- Operation Mapping: packet actions → code functions
- Invariant Preservation: I_spec(s) ⇒ I_impl(R(s))
- Test Obligation: spec tests + impl tests
- Runtime Check: spec monitors → impl monitors (when present)

## Mapping (this packet itself)

| Aspect | Spec (this packet) | Impl (refinement.md) |
|--------|---------------------|-----------------------|
| State | packet decision | State section |
| Operation | create packet | create file, edit content |
| Invariant | 5 sections exist | State/Operation/etc. listed |
| Test | convention author follows | convention author reads |
| Runtime | recursive check (future) | manual review (now) |

## Mapping (future code packets)

When code exists:
- packet.yaml:lifecycle → impl state
- packet.yaml:verifier command → impl test runner
- assumptions.yaml statements → impl invariants
- decision.md claims → impl behavior

## Invariant preservation

- Every packet has all 5 refinement sections
- State section names the lifecycle states being mapped
- Operation section names the actions
- Invariant section names the spec invariants preserved
- Test section names the obligation
- Runtime section names the check (deferred is OK)

## Mapping to convention axes

- **Axis 10 (Refinement pattern):** this packet IS the
  formalization of axis 10.
- **Axis 4 (Verdicts):** the Test section maps to verdict
  generation when code exists.
- **Axis 5 (Lifecycle FSM):** State section maps FSM states
  to implementation states.

## Test obligation

- Every future code packet has refinement.md in 5 sections
- convention author manually checks at packet creation
- Future verifier-as-packet will automate this check

## Runtime check

- None yet (verifier-as-packet deferred to Phase B)
- Manual convention-author review of refinement sections

## Cross-reference

Canonical spec: `core/theories/refinement.md` (R: S_impl → S_spec).
This file applies the refinement pattern to math-coding
packets (5 sections of refinement.md). Drift between the
two is detected by `core/verify.sh`.

