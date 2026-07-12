# theory-verdict — 5 outcomes of verification

#convention
## Thesis

math-coding-birth declares 5 verdict outcomes (VERIFIED,
NEEDS_REVISION, UNVERIFIABLE:TOOL_MISSING, UNVERIFIABLE:OUT_OF_SCOPE,
UNVERIFIABLE:DEFERRED). But what does each MEAN structurally?

## Antithesis

Without formal semantics, verdicts are just labels. Convention
authors might interpret VERIFIED differently than the next.
UNVERIFIABLE:* might be a failure or a partial success.

## Synthesis

Map each verdict to a formal outcome:
- VERIFIED: Spec holds under test conditions
- NEEDS_REVISION: Spec does NOT hold, counterexample found
- UNVERIFIABLE:TOOL_MISSING: tool unavailable, convention suspended
- UNVERIFIABLE:OUT_OF_SCOPE: requires human review (prose, ethics)
- UNVERIFIABLE:DEFERRED: data not yet available, wait

These map to FSM transitions (from theory-fsm-as-packet):
- VERIFIED → working→verified transition
- NEEDS_REVISION → working→sketch (regression) or stays working
- UNVERIFIABLE:* → stays at working, but explicit verdict recorded

## What this packet commits to

- 5 verdict outcomes are convention-closed enum
- No other verdicts exist (no UNVERIFIABLE:REJECTED)
- VERIFIED maps to lifecycle: verified
- UNVERIFIABLE:* stays at lifecycle: working but records reason

## What this packet does NOT commit to

- A formal verifier implementation (deferred to verifier-as-packet)
- A specific tool (TLC, jqwik, etc.)
- Auto-generation of verdict

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-verdict-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-verdict-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-verdict-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-verdict-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-verdict-as-packet/packet.yaml)

## Decision

#convention
## Thesis
math-coding-birth declares 5 verdict outcomes (VERIFIED,
NEEDS_REVISION, UNVERIFIABLE:TOOL_MISSING, UNVERIFIABLE:OUT_OF_SCOPE,
UNVERIFIABLE:DEFERRED). But what does each MEAN structurally?
## Antithesis
Without formal semantics, verdicts are just labels. Convention
authors might interpret VERIFIED differently than the next.
UNVERIFIABLE:* might be a failure or a partial success.
## Synthesis
Map each verdict to a formal outcome:
- VERIFIED: Spec holds under test conditions
- NEEDS_REVISION: Spec does NOT hold, counterexample found
- UNVERIFIABLE:TOOL_MISSING: tool unavailable, convention suspended
- UNVERIFIABLE:OUT_OF_SCOPE: requires human review (prose, ethics)
- UNVERIFIABLE:DEFERRED: data not yet available, wait
These map to FSM transitions (from theory-fsm-as-packet):
- VERIFIED → working→verified transition
- NEEDS_REVISION → working→sketch (regression) or stays working
- UNVERIFIABLE:* → stays at working, but explicit verdict recorded
## What this packet commits to
- 5 verdict outcomes are convention-closed enum
- No other verdicts exist (no UNVERIFIABLE:REJECTED)
- VERIFIED maps to lifecycle: verified
- UNVERIFIABLE:* stays at lifecycle: working but records reason
## What this packet does NOT commit to
- A formal verifier implementation (deferred to verifier-as-packet)

## Task

# theory-verdict — task

#convention
## Problem

math-coding-birth declares 5 verdict outcomes but doesn't
formalize when each applies. Convention authors need to know
which verdict to record.

## Desired outcome

Each verdict has clear semantic:
- VERIFIED: claims hold under test
- NEEDS_REVISION: claims do NOT hold, counterexample
- UNVERIFIABLE:TOOL_MISSING: tool needed
- UNVERIFIABLE:OUT_OF_SCOPE: needs human
- UNVERIFIABLE:DEFERRED: waiting for data

Mapping to FSM (from theory-fsm-as-packet):
- VERIFIED → working→verified
- NEEDS_REVISION → working→working (or regression to sketch)
- UNVERIFIABLE:* → working→working (no transition)

## Constraints

- 5 outcomes are closed enum (no other verdicts)
- Verifier-as-packet will automate; this packet just declares
- No formal proof of correctness required

## Assumptions

```yaml
task_id: theory-verdict-as-packet
assumptions:
  - id: A1
    statement: "A verdict is the result of verification: Spec ⊨ P?"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard definition. Reproduced in core/theories/verdict.md.
      See: core/theories/verdict.md

  - id: A2
    statement: "5 verdict outcomes are a closed enum"
    status: judgment
    epistemology: judgment
    evidence: |
      math-coding-birth/refinement.md#verdict declares
      exactly 5 outcomes. No UNVERIFIABLE:REJECTED.
      See: packet:math-coding-birth/refinement.md#verdict

  - id: A3
    statement: "VERIFIED means Spec holds under test conditions"
    status: judgment
    epistemology: judgment
    evidence: |
      convention refinement.md#runtime declares verifier
      exits 0 iff all critical checks pass.
      See: packet:math-coding-birth/refinement.md#runtime-check

  - id: A4
    statement: "UNVERIFIABLE:* does NOT mean failure"
    status: judgment
    epistemology: judgment
    evidence: |
      UNVERIFIABLE means verifier could not run, but convention
      is not rejected. Human review or future re-run may resolve.
      See: packet:math-coding-birth/refinement.md#verdict

  - id: A5
    statement: "Each verdict maps to a specific FSM transition"
    status: judgment
    epistemology: judgment
    evidence: |
      VERIFIED → working→verified (lifecycle advance)
      NEEDS_REVISION → working→working (stays, fix needed)
      UNVERIFIABLE:* → working→working (no transition, reason logged)
      See: packet:theory-fsm-as-packet/refinement.md
```

## Refinement

# Refinement: theory-verdict

#convention
## State

- Verdict state: V ∈ {VERIFIED, NEEDS_REVISION, UNVERIFIABLE:*}
- Spec state: S_spec (packet lifecycle + claims)
- Test execution: runs verifier

## Operations

- Run verifier → returns verdict
- Map verdict to FSM transition
- Record verdict in verifier-output.yaml (when present)

## Mapping (verdict → FSM)

| Verdict | FSM transition | New state |
|---------|----------------|-----------|
| VERIFIED | working → verified | verified |
| NEEDS_REVISION | (no transition, fix needed) | working (or sketch after regression) |
| UNVERIFIABLE:TOOL_MISSING | (no transition, log reason) | working |
| UNVERIFIABLE:OUT_OF_SCOPE | (no transition, needs human) | working |
| UNVERIFIABLE:DEFERRED | (no transition, wait) | working |

## Mapping (verdict → spec outcome)

- VERIFIED: Spec holds under test
- NEEDS_REVISION: Spec does NOT hold, counterexample
- UNVERIFIABLE:TOOL_MISSING: tool absent
- UNVERIFIABLE:OUT_OF_SCOPE: human needed
- UNVERIFIABLE:DEFERRED: data not yet available

## Invariant preservation

- Every verdict maps to exactly one FSM transition (or no-op)
- Every packet's lifecycle reflects its verdicts
- Multiple verdicts over time → final verdict at lifecycle: verified

## Mapping to convention axes

- **Axis 4 (Verdicts):** this packet IS the formalization
  of axis 4.
- **Axis 5 (Lifecycle FSM):** verdicts drive FSM transitions.
- **Axis 10 (Refinement):** the Test section maps to verdict
  generation.

## Test obligation

- convention author manually records verdict when packet is verified
- future verifier-as-packet (Phase B) will automate this

## Runtime check

- None yet (verifier-as-packet deferred)
- convention author manually ensures verdict matches reality

## Cross-reference

Canonical spec: `core/theories/verdict.md` (Spec ⊨ P, 5
outcomes). This file maps verdicts to FSM transitions.
Drift between the two is detected by `core/verify.sh`.

