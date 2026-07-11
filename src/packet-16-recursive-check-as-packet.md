# recursive-check-as-packet — convention verifies itself

## Thesis

Recursive observability (axiom A4 in math-coding-birth) says
convention verifies itself. Without concrete implementation,
this axiom is aspirational. Convention needs a self-check
verifier that confirms its own structural claims.

## Antithesis

Bootstrapping problem: how does convention verify itself
when it has no verifier yet? Naively, you'd need a verifier
before you can verify anything. But: convention can verify
itself by checking structural properties (5 files, valid
enums, depends_on DAG) without interpreting packet content.

## Synthesis

Recursive-check is a self-referential verifier:
- Walks every math/<name>/ directory
- Verifies the structural invariant (5 files exist, fields valid)
- For each packet that declares a verifier, checks the verdict
  file exists and has valid format
- Reports aggregated verdict in self-test

The recursive-check-as-packet's OWN verifier checks itself:
- if recursive-check-as-packet fails its own check, convention
  has a bug

## What this packet commits to

- Recursive observability is implementable, not just aspirational
- Convention can self-test (axiom A4 has a concrete form)
- Future iterations of convention are validated against this check

## What this packet does NOT commit to

- A separate verifier-as-packet version 2
- Tooling beyond what recursive-check-as-packet establishes
- Content-level verification

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/recursive-check-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/recursive-check-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/recursive-check-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/recursive-check-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/recursive-check-as-packet/packet.yaml)

## Decision

## Thesis
Recursive observability (axiom A4 in math-coding-birth) says
convention verifies itself. Without concrete implementation,
this axiom is aspirational. Convention needs a self-check
verifier that confirms its own structural claims.
## Antithesis
Bootstrapping problem: how does convention verify itself
when it has no verifier yet? Naively, you'd need a verifier
before you can verify anything. But: convention can verify
itself by checking structural properties (5 files, valid
enums, depends_on DAG) without interpreting packet content.
## Synthesis
Recursive-check is a self-referential verifier:
- Walks every math/<name>/ directory
- Verifies the structural invariant (5 files exist, fields valid)
- For each packet that declares a verifier, checks the verdict
  file exists and has valid format
- Reports aggregated verdict in self-test
The recursive-check-as-packet's OWN verifier checks itself:
- if recursive-check-as-packet fails its own check, convention
  has a bug
## What this packet commits to
- Recursive observability is implementable, not just aspirational
- Convention can self-test (axiom A4 has a concrete form)
- Future iterations of convention are validated against this check
## What this packet does NOT commit to
- A separate verifier-as-packet version 2

## Task

# recursive-check-as-packet — task

## Problem

convention declares axiom A4 (recursive observability) but
has no concrete implementation. Convention needs a self-check
that proves the axiom is not just aspirational.

## Desired outcome

Recursive-check is a small shell script that:
- Walks all math/<name>/ directories
- For each: checks 5-file structure, packet.yaml fields,
  enum values, depends_on syntax
- For each packet with verifier: checks verdict_file exists
- For itself: applies the same checks (recursive)
- Reports verdict

## Constraints

- POSIX shell only (matches verifier-as-packet constraint)
- No external tools
- Self-contained

## Assumptions

```yaml
task_id: recursive-check-as-packet
assumptions:
  - id: A1
    statement: "Recursive observability is implementable as self-check"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      Birth-packet A4 declares this axiom. Recursive-check
      makes it concrete.
      See: packet:math-coding-birth/assumptions.yaml#A4

  - id: A2
    statement: "Self-check works by applying same rules to self"
    status: judgment
    epistemology: judgment
    evidence: |
      Quine-like structure. The verifier verifies itself
      using the same rules it uses to verify others.
      See: packet:this file/decision.md#synthesis

  - id: A3
    statement: "5-file structure is the core invariant to verify"
    status: judgment
    epistemology: judgment
    evidence: |
      math-coding-birth/refinement.md#invariant requires
      5 files. recursive-check verifies this for every packet.
      See: packet:math-coding-birth/refinement.md#invariant

  - id: A4
    statement: "Verdict files must be valid (proper YAML structure)"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention says verdicts are recorded in
      verifier-output.yaml. The structure must be checked.
      See: packet:theory-verdict-as-packet/refinement.md

  - id: A5
    statement: "Recursive-check is a tool, not a content packet"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      This packet authorizes a script, similar to
      verifier-as-packet. It doesn't add convention content.
      See: packet:verifier-as-packet/decision.md
```

## Refinement

# Refinement: recursive-check-as-packet

## State

- convention repo at this commit
- S = all packets in math/
- verdict = result of self-check

## Operations

- walk all math/<name>/
- for each: check structural invariant
- for self: apply same checks (this IS recursive)
- aggregate verdict

## Mapping (recursive observability → implementation)

| Concept | Implementation |
|---------|----------------|
| convention verifies itself | recursive-check runs on every commit |
| axiom A4 is concrete | recursive-check IS the verifier for axiom A4 |
| verifier is checked | recursive-check verifies verifier-as-packet too |

## Invariant preservation

- recursive-check verifies every packet's 5-file structure
- recursive-check verifies every packet.yaml field
- recursive-check verifies depends_on references
- recursive-check verifies itself (axiom A4)

## Mapping to convention axes

- **Axis 9 (Coverage / recursive observability):** this packet
  IS the implementation.
- **Axis 4 (Verdicts):** produces verdict: VERIFIED | NEEDS_REVISION
- **Axis 5 (Lifecycle FSM):** verification is a transition

## Test obligation

- future iterations of convention must pass recursive-check
- recursive-check-as-packet verifies the verifier verifies itself
- convention authors self-check after each commit

## Runtime check

- recursive-check runs after each commit
- exit 0 = convention intact; exit 1 = drift
- convention discipline: maintain recursive observability

