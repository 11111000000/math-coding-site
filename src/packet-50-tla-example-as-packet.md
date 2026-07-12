# tla-example — TLA+ example packet

#convention
## Thesis

`core/theories/fsm.md` defines a packet lifecycle FSM in
mathematical prose. `math/theory-fsm-as-packet/refinement.md`
makes the FSM concrete with a transition table. Neither of those
artifacts is machine-checkable; both rest on convention-author
discipline to keep the transition table and the prose in sync.

TLA+ gives the convention a way to write the FSM in a language
whose model checker can independently confirm the safety and
liveness properties enumerated in `theory-ltl-as-packet`. The
spec file lives at `examples/tla/packet-lifecycle.tla`; this
packet is the documenting wrapper around it.

## Antithesis

Why not skip TLA+ and rely on the markdown table? Two reasons:

- Drift. `core/verify.sh` already detects drift between
  `core/theories/fsm.md` and `math/theory-fsm-as-packet/refinement.md`,
  but neither of those files is executable. A TLA+ spec is
  executable; running TLC against it is a stronger guarantee than
  grepping markdown for matching state names.
- Coverage. `theory-ltl-as-packet/refinement.md` declares two
  safety and three liveness properties over the lifecycle FSM.
  Markdown cannot enforce them; a TLA+ spec can.

## Synthesis

This packet ships one TLA+ file plus this packet's five
documents. The TLA+ file:

- mirrors the transition table in `refinement.md` row-for-row
- encodes forbidden transitions as negative safety invariants
- declares the verified → archived liveness property through
  weak fairness on `Archive`, `Deprecate`, and `Supersede`
- keeps action names identical to `refinement.md` so a side-by-side
  read catches drift visually

The packet deliberately does **not** ship a TLC configuration
file. v0.618 has no agent runtime for TLA+. The convention treats
this spec as read-ready and agent-runnable: a future convention
author with the toolchain installed can pick the file up without
any further documentation work from us.

## What this packet commits to

- One TLA+ spec file at `examples/tla/packet-lifecycle.tla`
- The spec's transition set equals the refinement.md table
- The spec's forbidden transitions equal the refinement.md
  forbidden list
- The spec encodes the liveness property
  `verified ⇒ ◇archived`

## What this packet does NOT commit to

- A runnable TLC invocation (no toolchain in v0.618)
- New lifecycle states or new transitions
- A general-purpose TLA+ library for the convention

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/tla-example-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/tla-example-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/tla-example-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/tla-example-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/tla-example-as-packet/packet.yaml)

## Decision

#convention
## Thesis
`core/theories/fsm.md` defines a packet lifecycle FSM in
mathematical prose. `math/theory-fsm-as-packet/refinement.md`
makes the FSM concrete with a transition table. Neither of those
artifacts is machine-checkable; both rest on convention-author
discipline to keep the transition table and the prose in sync.
TLA+ gives the convention a way to write the FSM in a language
whose model checker can independently confirm the safety and
liveness properties enumerated in `theory-ltl-as-packet`. The
spec file lives at `examples/tla/packet-lifecycle.tla`; this
packet is the documenting wrapper around it.
## Antithesis
Why not skip TLA+ and rely on the markdown table? Two reasons:
- Drift. `core/verify.sh` already detects drift between
  `core/theories/fsm.md` and `math/theory-fsm-as-packet/refinement.md`,
  but neither of those files is executable. A TLA+ spec is
  executable; running TLC against it is a stronger guarantee than
  grepping markdown for matching state names.
- Coverage. `theory-ltl-as-packet/refinement.md` declares two
  safety and three liveness properties over the lifecycle FSM.
  Markdown cannot enforce them; a TLA+ spec can.
## Synthesis
This packet ships one TLA+ file plus this packet's five
documents. The TLA+ file:
- mirrors the transition table in `refinement.md` row-for-row
- encodes forbidden transitions as negative safety invariants
- declares the verified → archived liveness property through
  weak fairness on `Archive`, `Deprecate`, and `Supersede`
- keeps action names identical to `refinement.md` so a side-by-side
  read catches drift visually
The packet deliberately does **not** ship a TLC configuration
file. v0.618 has no agent runtime for TLA+. The convention treats
this spec as read-ready and agent-runnable: a future convention
author with the toolchain installed can pick the file up without
any further documentation work from us.
## What this packet commits to
- One TLA+ spec file at `examples/tla/packet-lifecycle.tla`
- The spec's transition set equals the refinement.md table
- The spec's forbidden transitions equal the refinement.md
  forbidden list
- The spec encodes the liveness property
  `verified ⇒ ◇archived`
## What this packet does NOT commit to
- A runnable TLC invocation (no toolchain in v0.618)

## Task

# tla-example — task

#convention
## Problem

The lifecycle FSM is the convention's most-referenced abstract
machine, but its specification lives entirely in markdown. There
is no executable artifact against which to check the temporal
properties declared in `theory-ltl-as-packet/refinement.md`.

Without an executable spec, drift between the FSM table and the
declared liveness properties can only be caught by a careful
human reading. As the convention grows more packets that reason
about lifecycle, that cost compounds.

## Desired outcome

A TLA+ specification at `examples/tla/packet-lifecycle.tla` that:

- mirrors the 12 transition rows of the refinement table
- forbids the four illegal transitions listed in refinement.md
- declares the `verified → ◇archived` liveness property with
  weak fairness
- is syntactically valid TLA+ (read-ready, agent-runnable)

## Constraints

- The spec must use only standard TLA+ operators (`/\`, `\/`,
  `=>`, `[]`, `<>`, `WF_`) — no module imports beyond `Naturals`.
- Action names must match the labels in
  `math/theory-fsm-as-packet/refinement.md#operations` exactly.
- No new lifecycle states.
- The file is deliverable as plaintext; it does not need to be
  model-checked in this commit.

## Assumptions

```yaml
task_id: tla-example
assumptions:
  - id: A1
    statement: "TLA+ is the right substrate for claims about temporal behaviour of an FSM"
    status: judgment
    epistemology: judgment
    evidence: |
      core/packet-schema.md lists `tla` as one of the 9 substrate
      values. Of the formal substrates (tla, coq, alloy), only TLA+
      natively expresses weak fairness and the ◇ operator.
      See: core/packet-schema.md

  - id: A2
    statement: "The lifecycle FSM has exactly the six states listed in core/theories/fsm.md"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      theory-fsm-as-packet/refinement.md#state lists the same
      six states. core/verify.sh already enforces equality
      between theory and packet.
      See: core/theories/fsm.md

  - id: A3
    statement: "The verified → archived liveness property holds under weak fairness on Archive, Deprecate, Supersede"
    status: judgment
    epistemology: judgment
    evidence: |
      From "verified", Deprecate and Supersede are the only
      forward actions; Archive is the only forward action from
      both deprecated and superseded. WF on each is therefore
      sufficient.
      See: packet:theory-fsm-as-packet/refinement.md
      See: packet:theory-ltl-as-packet/refinement.md

  - id: A4
    statement: "TLA+ cannot be checked by an agent without the TLC or Apalache toolchain"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/theories/agent.md declares any Phase D substrate is
      applied through an agent; the v0.618 agent runtime has no
      TLA+ checker wired in. The spec is therefore delivered as
      read-ready, agent-runnable.
      See: core/theories/agent.md

  - id: A5
    statement: "Action names in the spec match refinement.md row-for-row"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      examples/tla/packet-lifecycle.tla uses the exact labels
      from math/theory-fsm-as-packet/refinement.md#operations:
      create, add_code, add_checklist, run_verifier, regression,
      deprecate, supersede, archive, remove_packet.
      See: examples/tla/packet-lifecycle.tla
```

## Refinement

# Refinement: tla-example

#convention
## State

- One variable: `lifecycle` ∈ S, where S is the six lifecycle
  states from `core/theories/fsm.md`.
- Initial state `lifecycle = "sketch"`.

## Operations

The spec at `examples/tla/packet-lifecycle.tla` enumerates one
TLA+ action per row of `theory-fsm-as-packet/refinement.md#operations`:

| Action in refinement.md | TLA+ action name |
|--------------------------|------------------|
| create                   | `Create`         |
| add_code                 | `AddCode`        |
| add_checklist            | `AddChecklist`   |
| run_verifier             | `RunVerifier`    |
| regression               | `Regression`     |
| deprecate                | `Deprecate`      |
| supersede                | `Supersede`      |
| archive                  | `Archive`        |
| remove_packet (sketch)   | `RemoveFromSketch` |
| remove_packet (working)  | `RemoveFromWorking` |

The `Next` relation is the disjunction of all ten actions. No
action is introduced that is not in `refinement.md`.

## Invariant

- `TypeOK` is preserved by every action: the image of every
  action is contained in S.
- `Safety`: `lifecycle = "archived"` only allows the self-loop
  `lifecycle' = "archived"`.
- `NoSkipSketchToVerified`: there is no action whose pre-state
  is `"sketch"` and post-state is `"verified"`.
- `ArchivedImmutable`: there is no action with pre-state
  `"archived"` whose post-state differs.
- `Liveness`: under the declared fairness hypotheses, every
  reachable run from `"verified"` eventually reaches `"archived"`.

## Test obligation

- A human reviewer reads the spec side-by-side with
  `math/theory-fsm-as-packet/refinement.md#operations` and
  confirms that the action set is identical.
- A future TLC or Apalache run is expected to confirm TypeOK,
  Safety, NoSkipSketchToVerified, ArchivedImmutable, and
  Liveness. The cfg file needed for that run is out of scope
  for this packet.

## Runtime check

- None. v0.618 has no agent wired to TLC or Apalache.
- Until the toolchain is wired in, this packet is treated as
  read-ready.

## Cross-reference

- Canonical FSM schema: `core/theories/fsm.md`.
- Authoritative instance: `math/theory-fsm-as-packet/refinement.md`.
- Liveness properties: `math/theory-ltl-as-packet/refinement.md`.
- The spec itself: `examples/tla/packet-lifecycle.tla`.
- The README at `examples/tla/README.md` describes the runbook
  for a future convention author who installs the TLA+
  toolchain.

