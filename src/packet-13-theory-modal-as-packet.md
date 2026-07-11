# theory-modal — □ ◇ for FSM lifecycle properties

## Thesis

LTL (theory-ltl-as-packet) defines □ ◇ ~> over packet
lifetimes. But LTL's □ is "always along this run". Modal logic
adds: □ = "in all reachable states" (universal) and ◇ =
"in some reachable state" (existential). For packet lifecycle,
modal operators express stronger claims.

## Antithesis

Modal logic adds complexity. LTL is enough for most
properties. But for safety properties about ALL possible
futures, modal logic is cleaner.

## Synthesis

Apply modal logic to packet lifecycle FSM:
- Safety: □¬(archived → ¬archived) — in no reachable state
  does archived become non-archived
- Liveness: ◇archived from any reachable state — terminal
  states are reachable
- Necessity: □stable(lifecycle: verified) — verified is stable
  until superseded

These complement LTL with explicit reachability.

## What this packet commits to

- Packet lifecycle FSM satisfies modal properties
- □ for universal (all states), ◇ for existential (some state)
- Safety + reachability formalized

## What this packet does NOT commit to

- A formal modal logic prover
- New lifecycle properties beyond what LTL already covers

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/theory-modal-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/theory-modal-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-modal-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/theory-modal-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/theory-modal-as-packet/packet.yaml)

## Decision

## Thesis
LTL (theory-ltl-as-packet) defines □ ◇ ~> over packet
lifetimes. But LTL's □ is "always along this run". Modal logic
adds: □ = "in all reachable states" (universal) and ◇ =
"in some reachable state" (existential). For packet lifecycle,
modal operators express stronger claims.
## Antithesis
Modal logic adds complexity. LTL is enough for most
properties. But for safety properties about ALL possible
futures, modal logic is cleaner.
## Synthesis
Apply modal logic to packet lifecycle FSM:
- Safety: □¬(archived → ¬archived) — in no reachable state
  does archived become non-archived
- Liveness: ◇archived from any reachable state — terminal
  states are reachable
- Necessity: □stable(lifecycle: verified) — verified is stable
  until superseded
These complement LTL with explicit reachability.
## What this packet commits to
- Packet lifecycle FSM satisfies modal properties
- □ for universal (all states), ◇ for existential (some state)
- Safety + reachability formalized
## What this packet does NOT commit to

## Task

# theory-modal — task

## Problem

LTL defines □ ◇ over packet lifetimes. But LTL's □ is "always
along this run". For safety properties about ALL reachable
states (not just one run), modal logic is cleaner.

## Desired outcome

Modal logic applied to FSM:
- Safety: □¬X (in no reachable state does X happen)
- Liveness: ◇Y (Y is reachable)
- Use cases for packet lifecycle

## Constraints

- rigor: temporal+ (this packet uses higher than light)
- No formal modal logic prover required
- Complements LTL (not replaces)

## Assumptions

```yaml
task_id: theory-modal-as-packet
assumptions:
  - id: A1
    statement: "Modal operators □ ◇ formalize 'always/sometimes in reachable states'"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard modal logic. Reproduced in
      core/theories/modal.md.
      See: core/theories/modal.md

  - id: A2
    statement: "Safety in modal logic = □¬X for any reachable state"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention safety = no path leads to bad state.
      In FSM, □(no transition from archived) formalizes this.
      See: core/theories/modal.md

  - id: A3
    statement: "Packet lifecycle satisfies □(verified → ◇archived)"
    status: judgment
    epistemology: judgment
    evidence: |
      theory-ltl-as-packet declares this LTL property.
      In modal terms: verified is reachable AND ◇archived
      is reachable.
      See: packet:theory-ltl-as-packet/refinement.md

  - id: A4
    statement: "Modal logic complements LTL for state-reachability claims"
    status: judgment
    epistemology: judgment
    evidence: |
      LTL = path properties, modal = state properties.
      Convention needs both.
      See: core/theories/modal.md

  - id: A5
    statement: "rigor: temporal+ reflects modal+temporal aspect of convention"
    status: judgment
    epistemology: judgment
    evidence: |
      Some packets are static (rules, structure = light).
      Others are dynamic (FSM, LTL = temporal).
      Modal logic extends temporal with state-reachability.
      See: packet:theory-fsm-as-packet/refinement.md
```

## Refinement

# Refinement: theory-modal

## State

- S = {sketch, working, verified, deprecated, archived, superseded}
- → = FSM transitions (from theory-fsm-as-packet)
- R(S) = set of reachable states from initial state s₀

## Operations

- Modal operators: □ (necessity), ◇ (possibility)
- Properties over R(S)

## Mapping (modal → convention)

| Modal property | Convention meaning |
|----------------|---------------------|
| □(lifecycle: archived) | No reachable state escapes archived |
| □¬(working ∧ verified) | Cannot be in both working and verified simultaneously |
| ◇archived (from verified) | archived is reachable from verified (liveness) |
| □(lifecycle: sketch → ◇working) | From sketch, working is reachable |

## Safety properties (modal)

- □¬(archived ∧ working) — cannot be both archived and working
- □¬(archived ∧ verified) — archived means no more verification

## Liveness properties (modal)

- ◇archived (from any non-terminal state) — every state can
  reach archived
- □(verified → ◇archived) — verified can reach archived
  (already in LTL packet)

## Mapping to convention axes

- **Axis 5 (Lifecycle FSM):** modal properties formalize
  FSM invariants
- **Axis 6 (Rigor):** this packet uses rigor: temporal+
- **Axis 10 (Refinement):** State Mapping section of
  refinement.md uses modal properties

## Test obligation

- future verifier-as-packet checks modal properties
- convention author manually ensures modal properties hold

## Runtime check

- None yet (verifier-as-packet deferred to Phase B)
- Manual check: lifecycle transitions preserve □ and ◇ properties

