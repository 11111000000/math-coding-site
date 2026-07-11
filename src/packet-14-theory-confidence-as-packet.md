# theory-confidence — entropy and readiness signal

## Thesis

math-coding's epistemic markers include confidence values
(0-1) for fact and hypothesis. But what does confidence mean
quantitatively? Why is the threshold 0.95 for fact? Convention
should use information theory to justify thresholds.

## Antithesis

Information theory (entropy) is formal. Convention authors
shouldn't compute entropies. But the threshold of 0.95 needs
justification, not arbitrary choice.

## Synthesis

Apply Shannon entropy:
- I(c) = -c·log₂(c) - (1-c)·log₂(1-c) bits
- Total uncertainty of packet = sum of I(c) over hypothesis entries
- Threshold 2 bits = "too uncertain to verify"
- 0.95 means I(c) = 0.286 bits (very confident)
- 0.5 means I(c) = 1.0 bit (max uncertainty)

Convention uses this as readiness signal:
- Total I(c) over all hypothesis < 2 bits: ready to verify
- Total I(c) > 2 bits: more work needed before verify

## What this packet commits to

- Each hypothesis entry contributes entropy to packet uncertainty
- Convention defines threshold for "ready to verify"
- I(c) formula is convention-level (in core/theories/confidence.md)

## What this packet does NOT commit to

- Auto-computation of I(c) (deferred to verifier-as-packet)
- Strict thresholds (convention provides guidance, not enforcement)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-confidence-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-confidence-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-confidence-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-confidence-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-confidence-as-packet/packet.yaml)

## Decision

## Thesis
math-coding's epistemic markers include confidence values
(0-1) for fact and hypothesis. But what does confidence mean
quantitatively? Why is the threshold 0.95 for fact? Convention
should use information theory to justify thresholds.
## Antithesis
Information theory (entropy) is formal. Convention authors
shouldn't compute entropies. But the threshold of 0.95 needs
justification, not arbitrary choice.
## Synthesis
Apply Shannon entropy:
- I(c) = -c·log₂(c) - (1-c)·log₂(1-c) bits
- Total uncertainty of packet = sum of I(c) over hypothesis entries
- Threshold 2 bits = "too uncertain to verify"
- 0.95 means I(c) = 0.286 bits (very confident)
- 0.5 means I(c) = 1.0 bit (max uncertainty)
Convention uses this as readiness signal:
- Total I(c) over all hypothesis < 2 bits: ready to verify
- Total I(c) > 2 bits: more work needed before verify
## What this packet commits to
- Each hypothesis entry contributes entropy to packet uncertainty
- Convention defines threshold for "ready to verify"
- I(c) formula is convention-level (in core/theories/confidence.md)
## What this packet does NOT commit to

## Task

# theory-confidence — task

## Problem

convention has confidence: 0.0-1.0 in assumptions.yaml
entries, but the meaning is unclear. Why 0.95 for fact? Why
even have confidence?

## Desired outcome

Formalize confidence using Shannon entropy:
- I(c) = -c·log₂(c) - (1-c)·log₂(1-c) bits
- Each hypothesis contributes I(c) bits
- Total uncertainty = sum over hypothesis entries
- Threshold 2 bits = "ready to verify"

Convention uses confidence as readiness signal:
- Total < 2 bits → packet is ready for verification
- Total > 2 bits → more work needed

## Constraints

- rigor: light (this is just a measurement convention)
- No formal entropy computation required
- convention authors read guidance, don't compute

## Assumptions

```yaml
task_id: theory-confidence-as-packet
assumptions:
  - id: A1
    statement: "Shannon entropy I(c) = -c·log₂(c) - (1-c)·log₂(1-c) bits"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard information theory definition. Reproduced in
      core/theories/confidence.md.
      See: core/theories/confidence.md

  - id: A2
    statement: "Convention uses I(c) as readiness signal"
    status: judgment
    epistemology: judgment
    evidence: |
      I(c) measures information content. A packet with high
      total I(c) over hypotheses is uncertain.
      See: packet:math-coding-birth/decision.md#synthesis

  - id: A3
    statement: "Threshold 2 bits means ready for verification"
    status: judgment
    epistemology: judgment
    evidence: |
      convention chooses threshold 2 because:
      - I(0.5) = 1 bit (max uncertainty per hypothesis)
      - 2 hypotheses at 0.5 = 2 bits (full uncertainty budget)
      See: packet:math-coding-birth/refinement.md#synthesis

  - id: A4
    statement: "I(c) is highest at c=0.5 (1 bit) and lowest at c=0 or c=1 (0 bits)"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard result of entropy function.
      I(0.5) = -0.5·log₂(0.5) - 0.5·log₂(0.5) = 0.5 + 0.5 = 1 bit.
      I(0.95) = 0.286 bits. I(0.99) = 0.080 bits.
      See: core/theories/confidence.md

  - id: A5
    statement: "confidence is optional for judgment and unknown"
    status: judgment
    epistemology: judgment
    evidence: |
      Judgment is for design decisions (not probabilistic).
      Unknown is for questions (no belief at all).
      Neither needs a confidence value.
      See: packet:theory-epistemic-as-packet/refinement.md
```

## Refinement

# Refinement: theory-confidence

## State

- c ∈ [0, 1]: confidence value per assumption
- I(c): information content (bits)
- Total_I: sum over hypothesis entries

## Operations

- Compute I(c) for each hypothesis
- Sum Total_I = Σ I(c) for all hypothesis
- Compare Total_I with threshold (2 bits)

## Mapping (confidence → readiness)

| Total_I | Status | Meaning |
|---------|--------|---------|
| 0 | ready | All assumptions are fact (no uncertainty) |
| 0 < I ≤ 1 | mostly ready | Few uncertainties |
| 1 < I ≤ 2 | borderline | Need to resolve more hypotheses |
| I > 2 | not ready | Too uncertain for verification |

## Mapping (epistemic → confidence)

| Marker | Confidence | I(c) |
|--------|-----------|------|
| fact | 0.95-1.0 | 0.286-0 bits |
| hypothesis | 0.5-0.95 | 1.0-0.286 bits |
| judgment | N/A | 0 (not probabilistic) |
| unknown | N/A | 0 (not probabilistic) |

## Invariant preservation

- Convention: total_I < 2 bits before packet reaches verified
- Total_I ∈ [0, ∞)
- I(c) ∈ [0, 1] for c ∈ [0, 1]
- Sum is monotonic: adding hypotheses increases Total_I

## Mapping to convention axes

- **Axis 3 (Epistemics):** confidence is part of epistemic markers
- **Axis 9 (Coverage):** total_I as readiness signal
- **Axis 4 (Verdicts):** total_I < 2 → lifecycle: verified

## Test obligation

- future verifier-as-packet computes total_I automatically
- convention author manually checks hypothesis count

## Runtime check

- None yet (verifier-as-packet deferred)
- Manual check: when packet has hypothesis entries,
  total_I should be considered before verification

