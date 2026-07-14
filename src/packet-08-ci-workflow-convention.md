# ci-workflow-convention

## Thesis

State the proposition this packet commits to.

## Antithesis

State what could contradict the thesis.

## Synthesis

State the resolution.

## Surface impact

(if applicable) touches: <element> [FROZEN|FLUID]

## Proof

(if applicable) tests/contract/<test>.spec

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/ci-workflow-convention/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/ci-workflow-convention/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/ci-workflow-convention/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/ci-workflow-convention/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/ci-workflow-convention/packet.yaml)

## Decision

## Thesis
State the proposition this packet commits to.
## Antithesis
State what could contradict the thesis.
## Synthesis
State the resolution.
## Surface impact
(if applicable) touches: <element> [FROZEN|FLUID]

## Task

# ci-workflow-convention

## Problem

What problem does this packet address?

## Desired outcome

What does success look like?

## Constraints

- must be testable

## Assumptions

```yaml
task_id: ci-workflow-convention
assumptions:
  - id: A1
    statement: "<your first assumption>"
    status: agent-inferred
    epistemology: hypothesis
    confidence: 0.5
    evidence: |
      <one-line evidence>
```

## Refinement

# Refinement: ci-workflow-convention

## State

- pre: <what was true before this packet>
- post: <what this packet makes true>

## Operation

- <what action implements this packet>

## Mapping

<spec state to impl state mapping>

## Invariant preservation

- <what stays true>

## Test obligation

- <how to verify this packet>

## Runtime check

- <how to monitor at runtime>

