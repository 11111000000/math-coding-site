# theory-curry-howard — packet as proof-term

#convention
## Thesis

Curry-Howard says: types are propositions, programs are proofs.
In convention: packets are proof-terms. assumptions.yaml = Γ,
decision.md claim = P, lifecycle = verdict on proof.

## Antithesis

Curry-Howard applies to formal systems. convention is informal
in most places. A "proof" in convention is just a structural
declaration, not a formal derivation.

## Synthesis

Apply Curry-Howard informally:
- assumptions.yaml = Γ (context)
- decision.md claim = P (proposition)
- packet's existence = proof term π
- lifecycle: verified = P holds (proof accepted)
- NEEDS_REVISION = proof rejected

Convention doesn't require formal proof, but the analogy
helps convention authors understand structure.

## What this packet commits to

- Packet IS analogous to a proof-term
- assumptions.yaml IS the context Γ
- decision.md IS the proposition P
- Lifecycle verdict IS the proof outcome

## What this packet does NOT commit to

- A formal proof system
- Theorem provers
- A specific proof calculus

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-curry-howard-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-curry-howard-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-curry-howard-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-curry-howard-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-curry-howard-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Curry-Howard says: types are propositions, programs are proofs.
In convention: packets are proof-terms. assumptions.yaml = Γ,
decision.md claim = P, lifecycle = verdict on proof.
## Antithesis
Curry-Howard applies to formal systems. convention is informal
in most places. A "proof" in convention is just a structural
declaration, not a formal derivation.
## Synthesis
Apply Curry-Howard informally:
- assumptions.yaml = Γ (context)
- decision.md claim = P (proposition)
- packet's existence = proof term π
- lifecycle: verified = P holds (proof accepted)
- NEEDS_REVISION = proof rejected
Convention doesn't require formal proof, but the analogy
helps convention authors understand structure.
## What this packet commits to
- Packet IS analogous to a proof-term
- assumptions.yaml IS the context Γ
- decision.md IS the proposition P
- Lifecycle verdict IS the proof outcome
## What this packet does NOT commit to
- A formal proof system

## Task

# theory-curry-howard — task

#convention
## Problem

math-coding-birth doesn't formalize the relationship between
packets, assumptions, and decisions. Without this, packet
structure is arbitrary.

## Desired outcome

Apply Curry-Howard correspondence informally:
- Packet = proof-term (proof candidate)
- assumptions.yaml = Γ (context)
- decision.md claim = P (proposition)
- Lifecycle: verified = proof accepted

This gives convention authors a mental model: each packet IS
a proof attempt of the decision.md claim, justified by its
assumptions.yaml context.

## Constraints

- rigor: proof+ (this packet uses higher rigor than others)
- No formal proof system required
- Convention authors should understand the analogy

## Assumptions

```yaml
task_id: theory-curry-howard-as-packet
assumptions:
  - id: A1
    statement: "Curry-Howard: types ↔ propositions, programs ↔ proofs"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard Curry-Howard correspondence. Reproduced in
      core/theories/curry-howard.md.
      See: core/theories/curry-howard.md

  - id: A2
    statement: "Packet = proof-term in Curry-Howard sense"
    status: judgment
    epistemology: judgment
    evidence: |
      Each packet has: assumptions (Γ), claim (P), verdict
      (outcome). This matches the proof structure.
      See: packet:theory-assumption-as-packet (Σ ⊢ Spec)
      See: packet:theory-verdict-as-packet (outcomes)

  - id: A3
    statement: "assumptions.yaml = Γ (proof context)"
    status: judgment
    epistemology: judgment
    evidence: |
      Each assumption is part of Γ. status: open means NOT
      in Γ yet.
      See: packet:theory-assumption-as-packet/refinement.md

  - id: A4
    statement: "decision.md claim = P (proposition)"
    status: judgment
    epistemology: judgment
    evidence: |
      decision.md declares what packet proves. This is P.
      See: packet:math-coding-birth/decision.md#synthesis

  - id: A5
    statement: "lifecycle: verified = proof accepted"
    status: judgment
    epistemology: judgment
    evidence: |
      Verdict-as-packet maps VERIFIED to lifecycle: verified.
      This matches proof acceptance.
      See: packet:theory-verdict-as-packet/refinement.md
```

## Refinement

# Refinement: theory-curry-howard

#convention
## State

- Γ: assumptions (proof context)
- P: proposition (decision.md claim)
- π: packet (proof term candidate)
- verdict: outcome of proof attempt

## Operations

- Construct Γ (assumptions.yaml)
- State P (decision.md)
- Build π (packet itself)
- Attempt proof (verifier run)
- Get verdict (lifecycle update)

## Mapping (Curry-Howard → convention)

| Curry-Howard | math-coding |
|--------------|-------------|
| Type / proposition P | decision.md claim |
| Context Γ | assumptions.yaml |
| Proof term π | packet itself |
| Type checking | verifier (when present) |
| Proof accepted | lifecycle: verified, verdict: VERIFIED |
| Proof rejected | lifecycle: working, verdict: NEEDS_REVISION |
| Incomplete proof | status: open (assumption not yet justified) |

## Invariant preservation

- Every packet has Γ (assumptions) AND P (claim)
- Γ must be complete (status: open means incomplete)
- Lifecycle reflects proof state
- Supersession preserves proof history (P_old → P_new)

## Mapping to convention axes

- **Axis 13 (Mathematical theories):** this packet formalizes
  how convention uses proofs
- **Axis 4 (Verdicts):** verdicts are proof outcomes
- **Axis 3 (Epistemics):** Γ content must be epistemically sound

## Test obligation

- future verifier-as-packet ensures Γ is complete for P
- convention author manually structures Γ and P

## Runtime check

- None yet (verifier-as-packet deferred to Phase B)
- Manual: convention author writes assumptions that justify claims

## Cross-reference

Canonical spec: `core/theories/curry-howard.md` (types ↔
propositions, programs ↔ proofs). This file applies CH to
the convention's packet shape (P, Γ, π, verdict). Drift
between the two is detected by `core/verify.sh`.

