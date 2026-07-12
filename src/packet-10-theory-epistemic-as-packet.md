# theory-epistemic — 5 markers as action protocol

#convention
## Thesis

math-coding-birth declares 4 epistemic markers (fact/hypothesis/
judgment/unknown) for assumptions, plus a 5th marker (`proven`,
added in convention-spec-as-packet via core/theories/epistemic.md)
for claims whose evidence chain closes through convention's own
verifier. Markers without action are decoration. Convention
needs each marker to drive a specific agent behavior.

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
- proven: agent trusts until convention's own probe reports
  failure; demotes on real-world counterexample, not opinion

These are NOT formal logic. They are convention rules that
agents should follow. The `proven` marker is reserved for
claims whose evidence chain closes through convention's own
machinery (e.g. axiom A4 in math-coding-birth, where
`sh core/probe.sh` exit 0 against the convention's own
repository is the evidence).

## What this packet commits to

- 5 epistemic markers (fact, hypothesis, judgment, unknown,
  proven) with explicit agent actions
- Convention requires agents to apply these actions
- markers in assumptions.yaml drive agent behavior
- the `proven` marker is symmetric with `fact`: it
  carries `confidence: 1.0` and `status: user-confirmed`,
  and the agent's verification job is to *observe* the
  convention's verifier exit 0 rather than to re-derive
  the evidence

## What this packet does NOT commit to

- A formal belief-state update logic
- A belief-state storage format
- Auto-verification of marker correctness
- Claims that `proven` is permanent — it can be demoted
  to `fact` if the end-to-end check becomes partial

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
judgment/unknown) for assumptions, plus a 5th marker (`proven`,
added in convention-spec-as-packet via core/theories/epistemic.md)
for claims whose evidence chain closes through convention's own
verifier. Markers without action are decoration. Convention
needs each marker to drive a specific agent behavior.
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
- proven: agent trusts until convention's own probe reports
  failure; demotes on real-world counterexample, not opinion
These are NOT formal logic. They are convention rules that
agents should follow. The `proven` marker is reserved for
claims whose evidence chain closes through convention's own
machinery (e.g. axiom A4 in math-coding-birth, where
`sh core/probe.sh` exit 0 against the convention's own
repository is the evidence).
## What this packet commits to
- 5 epistemic markers (fact, hypothesis, judgment, unknown,
  proven) with explicit agent actions
- Convention requires agents to apply these actions
- markers in assumptions.yaml drive agent behavior
- the `proven` marker is symmetric with `fact`: it
  carries `confidence: 1.0` and `status: user-confirmed`,
  and the agent's verification job is to *observe* the
  convention's verifier exit 0 rather than to re-derive
  the evidence
## What this packet does NOT commit to
- A formal belief-state update logic
- A belief-state storage format
- Auto-verification of marker correctness

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
- marker: fact | hypothesis | judgment | unknown | proven
- convention threshold: confidence ≥ 0.95 = fact
- `proven` is the verifier-validated subset of `fact`:
  the evidence chain closes through convention's own
  machinery (`sh core/probe.sh` exit 0)

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
| proven | claim verified end-to-end by convention's own tools | Trust the claim. Demote on real-world counterexample, not on opinion. |

## Mapping (confidence values)

- 0.95 ≤ B ≤ 1.0: fact
- 0.5 < B < 0.95: hypothesis
- B ∈ {0, 1}: judgment (confidence omitted)
- B = 0: unknown (confidence omitted)
- B = 1.0 (verifier exit 0): proven (confidence 1.0)

## Invariant preservation

- Every assumption has exactly one marker
- confidence is present iff marker is fact, hypothesis,
  or proven (judgment and unknown carry no confidence)
- status: open means marker is unknown or under review
- `proven` is **demotable**: a proven claim that later
  fails the end-to-end check becomes fact → hypothesis

## Mapping to convention axes

- **Axis 3 (Epistemics):** this packet IS the formalization
  of axis 3.
- **Axis 4 (Verdicts):** verdict generation uses epistemic
  markers (e.g., fact → trust, hypothesis → verify,
  proven → cite-and-move-on).

## Test obligation

- convention author: read every marker's status + epistemology
- convention author: apply agent action when reviewing
- convention author: when a marker's evidence chain relies
  on `sh core/probe.sh`, document the verdict file path
  in `See:` (see math-coding-birth A4 for canonical example)

## Runtime check

- `core/verify.sh` drift-check 4: matches the SPEC_EPISTEMIC_MARKERS
  set in `core/convention-spec.yaml`. Adding a new marker
  is a single-line spec edit; this packet and `verify.sh`
  follow automatically.
- Manual: each assumption's marker matches its meaning.

## Cross-reference

Canonical spec: `core/theories/epistemic.md` (B: Prop × Agent
→ [0,1] and 5 markers: fact, hypothesis, judgment, unknown,
proven). This file maps markers to agent actions. The marker
list is sourced from `core/convention-spec.yaml`
(`SPEC_EPISTEMIC_MARKERS`) and consumed by `core/verify.sh`
drift-check 4. Drift between theory, packet, and convention-spec
is detected by `core/verify.sh`.

