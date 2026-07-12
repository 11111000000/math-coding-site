# theory-epistemic — 4 markers as action protocol

#convention
## Thesis

math-coding-birth declares 4 epistemic markers (fact/hypothesis/
judgment/unknown) for assumptions. But markers without action
are decoration. Convention needs each marker to drive a
specific agent behavior.

## Antithesis

A formal belief logic (Fagin-Halpern) is too heavy. Convention
authors shouldn't write epistemic formulas. But the **action
protocol** — what an agent does when it sees each marker — must
be convention.

## Synthesis

Apply epistemic markers as a convention rule:
- fact: agent verifies if possible, downgrades if cannot
- hypothesis: agent searches for evidence, upgrades or downgrades
- judgment: agent respects, does not challenge
- unknown: agent asks user, does not proceed

These are NOT formal logic. They are convention rules that
agents should follow.

## What this packet commits to

- 4 epistemic markers with explicit agent actions
- Convention requires agents to apply these actions
- markers in assumptions.yaml drive agent behavior

## What this packet does NOT commit to

- A formal belief-state update logic
- A belief-state storage format
- Auto-verification of marker correctness

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-epistemic-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-epistemic-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-epistemic-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-epistemic-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-epistemic-as-packet/packet.yaml)

## Decision

#convention
## Thesis
math-coding-birth declares 4 epistemic markers (fact/hypothesis/
judgment/unknown) for assumptions. But markers without action
are decoration. Convention needs each marker to drive a
specific agent behavior.
## Antithesis
A formal belief logic (Fagin-Halpern) is too heavy. Convention
authors shouldn't write epistemic formulas. But the **action
protocol** — what an agent does when it sees each marker — must
be convention.
## Synthesis
Apply epistemic markers as a convention rule:
- fact: agent verifies if possible, downgrades if cannot
- hypothesis: agent searches for evidence, upgrades or downgrades
- judgment: agent respects, does not challenge
- unknown: agent asks user, does not proceed
These are NOT formal logic. They are convention rules that
agents should follow.
## What this packet commits to
- 4 epistemic markers with explicit agent actions
- Convention requires agents to apply these actions
- markers in assumptions.yaml drive agent behavior
## What this packet does NOT commit to
- A formal belief-state update logic

## Task

# theory-epistemic — task

#convention
## Problem

Epistemic markers in assumptions.yaml need clear agent action
protocols. Without them, markers are arbitrary labels and
agents don't know how to use them.

## Desired outcome

A 4-marker table where each marker has:
- definition (what it means)
- agent action (what agent does when seeing it)
- examples (in convention usage)

This becomes part of convention's epistemic protocol.

## Constraints

- No formal belief logic
- Informal action protocol only
- Compatible with all existing packets

## Assumptions

```yaml
task_id: theory-epistemic-as-packet
assumptions:
  - id: A1
    statement: "Belief state B: Prop × Agent → [0,1]"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard epistemic logic definition. Reproduced
      in core/theories/epistemic.md.
      See: core/theories/epistemic.md

  - id: A2
    statement: "fact means B(P, agent) ≥ 0.95 — agent fully believes P"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention threshold: confidence ≥ 0.95 means fact.
      Established in math-coding-birth/decision.md.
      See: packet:math-coding-birth/decision.md#synthesis

  - id: A3
    statement: "hypothesis means B(P, agent) ∈ (0.5, 0.95) — uncertain"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention threshold: hypothesis with confidence.
      agents search for evidence.
      See: packet:math-coding-birth/refinement.md#epistemics

  - id: A4
    statement: "judgment means B(P, agent) ∈ {0, 1} — design decision"
    status: judgment
    epistemology: judgment
    evidence: |
      Judgment is for design decisions (not probabilistic).
      Confidence is omitted for judgment in convention.
      See: packet:math-coding-birth/refinement.md#epistemics

  - id: A5
    statement: "unknown means B(P, agent) = 0 — agent has no belief"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention says unknown requires asking user, not
      proceeding. Standard epistemic interpretation.
      See: core/theories/epistemic.md
```

## Refinement

# Refinement: theory-epistemic

#convention
## State

- belief: B(Prop × Agent) → [0, 1]
- marker: fact | hypothesis | judgment | unknown
- convention threshold: confidence ≥ 0.95 = fact

## Operations

- Read marker from assumption entry
- Apply agent action per marker
- (Optional) Update marker based on new evidence

## Mapping (marker → agent action)

| Marker | Definition | Agent action |
|--------|------------|--------------|
| fact | B ≥ 0.95 | Verify if possible. If cannot verify, downgrade to hypothesis with low confidence. |
| hypothesis | B ∈ (0.5, 0.95) | Search for evidence. If found, upgrade to fact with high confidence. If contradicted, downgrade to unknown. |
| judgment | B ∈ {0, 1} | Respect. Do not propose alternatives without explicit user request. |
| unknown | B = 0 | Ask user. Mark status: open if not already. Do not proceed. |

## Mapping (confidence values)

- 0.95 ≤ B ≤ 1.0: fact
- 0.5 < B < 0.95: hypothesis
- B ∈ {0, 1}: judgment (confidence omitted)
- B = 0: unknown (confidence omitted)

## Invariant preservation

- Every assumption has exactly one marker
- confidence is present iff marker is fact or hypothesis
- status: open means marker is unknown or under review

## Mapping to convention axes

- **Axis 3 (Epistemics):** this packet IS the formalization
  of axis 3.
- **Axis 4 (Verdicts):** verdict generation uses epistemic
  markers (e.g., fact → trust, hypothesis → verify).

## Test obligation

- convention author: read every marker's status + epistemology
- convention author: apply agent action when reviewing

## Runtime check

- None yet (verifier-as-packet deferred)
- Manual check: each assumption's marker matches its meaning

## Cross-reference

Canonical spec: `core/theories/epistemic.md` (B: Prop × Agent
→ [0,1] and 4 markers). This file maps markers to agent
actions. Drift between the two is detected by `core/verify.sh`.

