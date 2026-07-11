# theory-assumption — Hoare logic applied to convention

## Thesis

math-coding has 5 fields per assumption (id, statement, status,
epistemology, confidence, evidence). These are convention rules,
not mathematical primitives. Without grounding in Hoare logic,
the field semantics is arbitrary.

## Antithesis

Hoare logic is formal. Convention should not require convention
authors to write formal proofs. But the *structure* of
assumptions (preconditions for the convention's correctness)
maps directly to Hoare-style "Σ ⊢ Spec".

## Synthesis

Apply Hoare logic informally:
- assumptions.yaml entries are the context Γ
- decision.md claim is the proposition P
- "Σ ⊢ Spec" reads as: given Σ of assumptions, Spec is
  justified (the convention holds)

This packet declares the formal semantic of the assumption
fields without requiring formal proofs.

## What this packet commits to

- assumptions.yaml has 4 fields (status + epistemology + confidence + evidence)
- Each assumption is part of Σ (context)
- decision.md claims (Spec) are justified by Σ
- "Open" status means assumption is NOT in Σ yet

## What this packet does NOT commit to

- Formal proofs (out of convention scope)
- Σ ⊢ Spec theorem provers (out of scope)
- Auto-validation of assumption correctness

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-assumption-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-assumption-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-assumption-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-assumption-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-assumption-as-packet/packet.yaml)

## Decision

## Thesis
math-coding has 5 fields per assumption (id, statement, status,
epistemology, confidence, evidence). These are convention rules,
not mathematical primitives. Without grounding in Hoare logic,
the field semantics is arbitrary.
## Antithesis
Hoare logic is formal. Convention should not require convention
authors to write formal proofs. But the *structure* of
assumptions (preconditions for the convention's correctness)
maps directly to Hoare-style "Σ ⊢ Spec".
## Synthesis
Apply Hoare logic informally:
- assumptions.yaml entries are the context Γ
- decision.md claim is the proposition P
- "Σ ⊢ Spec" reads as: given Σ of assumptions, Spec is
  justified (the convention holds)
This packet declares the formal semantic of the assumption
fields without requiring formal proofs.
## What this packet commits to
- assumptions.yaml has 4 fields (status + epistemology + confidence + evidence)
- Each assumption is part of Σ (context)
- decision.md claims (Spec) are justified by Σ
- "Open" status means assumption is NOT in Σ yet
## What this packet does NOT commit to
- Formal proofs (out of convention scope)

## Task

# theory-assumption — task

## Problem

math-coding-birth declares 5 fields per assumption but
doesn't formalize the semantics. Why exactly 4 fields (not 3
or 5)? Convention authors need to understand what each
field MEANS, not just what to write.

## Desired outcome

A formal semantic of the 4 assumption fields, based on Hoare
logic:
- status: whether assumption is in Σ (context) or open
- epistemology: nature of the claim (fact/hypothesis/judgment/unknown)
- confidence: probability value 0-1 (when applicable)
- evidence: where the assumption is justified

Each field has a clear semantic and convention authors know
when to use which values.

## Constraints

- No formal proof required
- Informal semantic only
- Compatible with all existing packets (no schema change)

## Assumptions

```yaml
task_id: theory-assumption-as-packet
assumptions:
  - id: A1
    statement: "Hoare logic: Spec = (Pre, Post), satisfies iff ∀s: Pre(s) ⇒ Post(P(s))"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Standard Hoare logic. Reproduced in
      core/theories/assumption.md.
      See: core/theories/assumption.md

  - id: A2
    statement: "Σ in math-coding = set of assumptions.yaml entries"
    status: judgment
    epistemology: judgment
    evidence: |
      Each assumption entry is a statement about the world.
      Together they form the context for the convention.
      See: packet:math-coding-birth/assumptions.yaml

  - id: A3
    statement: "Spec in math-coding = the convention itself (rules, structure)"
    status: judgment
    epistemology: judgment
    evidence: |
      decision.md of each packet declares Spec claims
      (thesis, what is committed to).
      See: packet:math-coding-birth/decision.md

  - id: A4
    statement: "status: user-confirmed means assumption is IN Σ with human authority"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention says humans confirm; agents don't override.
      See: packet:math-coding-birth/assumptions.yaml (A1)

  - id: A5
    statement: "status: agent-inferred means assumption is IN Σ with agent's authority (debatable)"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention says agents infer but mark it as agent-derived.
      See: packet:math-coding-birth/assumptions.yaml (A2)
```

## Refinement

# Refinement: theory-assumption

## State

- S = (Pre, Post) pair (spec state)
- Σ = set of assumptions.yaml entries (context)
- "Σ ⊢ Spec" reads: convention holds given assumptions

## Operations

- For each assumption entry: status ∈ {user-confirmed, agent-inferred, open}
- status: open means NOT in Σ (assumed, not justified)
- status: user-confirmed means IN Σ with human authority
- status: agent-inferred means IN Σ with agent authority
- confidence ∈ [0, 1] when applicable (omitted for judgment/unknown)

## Mapping to convention

| Spec claim (decision.md) | Σ entries (assumptions.yaml) | Σ ⊢ Spec? |
|---------------------------|-------------------------------|------------|
| "Convention replaces vibe-coding" | A1, A2, A3 from birth | yes |
| "agents read files" | A1 from birth | yes |
| "OS files need authorization" | A1 from core-as | yes |
| "Recursive observability holds" | A4 from birth, A4 from core-as | yes (if A4 is true) |

## Invariant preservation

- Every convention claim (Spec) has at least one supporting
  assumption (Σ entry). Spec without Σ is not allowed.
- status: open means Σ is incomplete; Spec must remain
  "tentative" or be revised.

## Mapping to convention axes

- **Axis 3 (Epistemics):** this packet IS the formalization
  of axis 3.
- **Axis 9 (Coverage):** Σ ⊢ Spec means convention is covered.
  Open entries mean uncovered territory.

## Test obligation

- Every packet: assertions in decision.md have corresponding
  assumptions with status: user-confirmed or agent-inferred
- Convention author responsibility: Σ must be complete

## Runtime check

- None yet (verifier-as-packet deferred)
- Manual check: every Spec claim has Σ backing

