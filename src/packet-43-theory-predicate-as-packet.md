# theory-predicate — Predicate and Invariant in math-coding

#convention
## Thesis

math-coding claims to be "grounded in mathematics". This claim
is vacuous unless each mathematical theory is concretely applied
to the convention. Without application, "Predicate" is just a
word; with application, it is a tool that explains why a packet
is verified or not.

## Antithesis

A 20-line theory doc in `core/theories/predicate.md` is enough
as mathematical reference. But it does not explain HOW math-coding
uses the predicate. The convention says "lifecycle: 6 states" but
does not say "lifecycle is a predicate over packet state".

## Synthesis

This packet connects the abstract theory (Predicate and
Invariant) to the concrete convention (lifecycle FSM, packet
completeness check, structural verifier). It says:
1. The packet lifecycle IS a predicate (an OS file should
   authorize this claim, which this packet does)
2. The packet structure check IS a predicate (each file's
   existence is a propositional variable)
3. The "packet is verified" verdict IS a predicate satisfaction
   check

## What this packet commits to

- The mathematical connection between Predicate theory and
  math-coding's lifecycle, structural check, and verifier
- Clarifies WHY math-coding is "grounded in math" — not just
  abstract theories in core/theories/, but applied reasoning
- This packet authorizes core/theories/predicate.md as
  the canonical application of Predicate theory to math-coding

## What this packet does NOT commit to

- A formal theorem prover (deferred — we use the theory
  informally for now)
- Additional theories beyond the existing 11
- Changing core/theories/predicate.md content (it's already
  correct as a reference doc)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-predicate-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-predicate-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-predicate-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-predicate-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-predicate-as-packet/packet.yaml)

## Decision

#convention
## Thesis
math-coding claims to be "grounded in mathematics". This claim
is vacuous unless each mathematical theory is concretely applied
to the convention. Without application, "Predicate" is just a
word; with application, it is a tool that explains why a packet
is verified or not.
## Antithesis
A 20-line theory doc in `core/theories/predicate.md` is enough
as mathematical reference. But it does not explain HOW math-coding
uses the predicate. The convention says "lifecycle: 6 states" but
does not say "lifecycle is a predicate over packet state".
## Synthesis
This packet connects the abstract theory (Predicate and
Invariant) to the concrete convention (lifecycle FSM, packet
completeness check, structural verifier). It says:
1. The packet lifecycle IS a predicate (an OS file should
   authorize this claim, which this packet does)
2. The packet structure check IS a predicate (each file's
   existence is a propositional variable)
3. The "packet is verified" verdict IS a predicate satisfaction
   check
## What this packet commits to
- The mathematical connection between Predicate theory and
  math-coding's lifecycle, structural check, and verifier
- Clarifies WHY math-coding is "grounded in math" — not just
  abstract theories in core/theories/, but applied reasoning
- This packet authorizes core/theories/predicate.md as
  the canonical application of Predicate theory to math-coding
## What this packet does NOT commit to
- A formal theorem prover (deferred — we use the theory
  informally for now)
- Additional theories beyond the existing 11

## Task

# theory-predicate — task

#convention
## Problem

math-coding claims to be grounded in 11 mathematical theories
(math-coding-birth/decision.md). But the theories in
core/theories/ are abstract reference docs. They don't say HOW
math-coding uses them. The Predicate theory is the most
fundamental (any other state-based check uses it), so it's
the right place to start showing application.

## Desired outcome

A packet that explicitly connects the Predicate theory to
math-coding's lifecycle, structural check, and verifier. The
packet shows the convention: "every assertion in math-coding is
a predicate over some state space". This makes the "grounded in
math" claim concrete.

## Constraints

- This packet does NOT modify core/theories/predicate.md
  (that's OS, not a packet)
- This packet extends the birth-пакет's claim by showing
  application
- No formal proof required (rigor: light at this stage)

## Assumptions

```yaml
task_id: theory-predicate-as-packet
assumptions:
  - id: A1
    statement: "A predicate is a function from a state space to {true, false}"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard mathematical definition. Reproduced in
      core/theories/predicate.md.
      See: core/theories/predicate.md

  - id: A2
    statement: "The packet lifecycle IS a predicate over packet state"
    status: agent-inferred
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Lifecycle has 6 states (sketch, working, verified, deprecated,
      archived, superseded). A packet at any moment is in exactly
      one state. This is a predicate over the packet state space.
      See: packet:math-coding-birth/refinement.md#invariant

  - id: A3
    statement: "The packet structure check IS a conjunction of 5 file-existence predicates"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      The structural check verifies:
      file_exists(packet.yaml) ∧ file_exists(decision.md) ∧
      file_exists(task.md) ∧ file_exists(assumptions.yaml) ∧
      file_exists(refinement.md).
      Each file_exists is a predicate; their conjunction is a
      predicate. This is the predicate that the structural
      verifier checks.
      See: packet:math-coding-birth/refinement.md#invariant

  - id: A4
    statement: "The recursive observability invariant IS a predicate over the repository"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      "Every packet in math/ can be verified against the repo
      at its commit" — this is a predicate over the repo state
      space. The verifier reads decision.md and checks claims.
      See: packet:math-coding-birth/refinement.md#invariant

  - id: A5
    statement: "Math-coding is grounded in math because all assertions are predicate checks"
    status: judgment
    epistemology: judgment
    evidence: |
      When every verification in convention is a predicate
      satisfaction check, the convention's "grounded in math"
      claim becomes concrete, not abstract.
      See: packet:math-coding-birth/decision.md#synthesis
```

## Refinement

# Refinement: theory-predicate

#convention
## State

- **pre**: math-coding claims to be grounded in math, but
  core/theories/predicate.md is abstract and doesn't show how
  math-coding uses it
- **post**: math-coding's predicate theory is concretely
  applied to lifecycle, structure check, and recursive
  observability

## Operation

- This packet documents the application of Predicate theory
  to math-coding
- It does NOT modify core/theories/predicate.md (OS file)
- It uses core/theories/predicate.md as a reference

## Invariant

- All 4 packets in math/ have 5 files each
- This packet's 5 assumptions all have evidence
- Every assertion in math-coding's invariants is now
  demonstrably a predicate

## Convention axes affected

- **Mathematics grounding (refinement.md §13):** this packet
  is the first demonstration that theory-to-application works.
  Future theory packets (FSM, LTL, etc.) follow this pattern.

## Mapping: theory → application

| Predicate theory concept | math-coding application |
|--------------------------|---------------------------|
| Predicate I: S → B | Lifecycle predicate: S = packet states, I = "packet is verified" |
| State space S | Packet state (lifecycle, file existence, decision-recursive) |
| Invariant | Recursive observability: "every packet in math/ verifiable" |
| Satisfaction check | Structural verifier (file_exists ∧ ...) |
| Counterexample | NEEDS_REVISION verdict |
| Cannot decide | UNVERIFIABLE:* verdict |

## Test obligation

- This packet documents a single mathematical pattern
  (predicate applied to convention)
- Future packets can copy this pattern for FSM, LTL, etc.

## Runtime check

- None required yet (informal application of theory)

## Cross-reference

Canonical spec: `core/theories/predicate.md` (I: S → B).
This file applies the predicate to math-coding invariants
(5-file structure, recursive observability, lifecycle).
Drift between the two is detected by `core/verify.sh`.

