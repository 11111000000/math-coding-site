# alloy-example-as-packet — Alloy as substrate for relational claims

#convention
## Thesis

Some math-coding claims are *structural* rather than
behavioural. They are about the shape of the convention
itself: which packets depend on which, which supersede
which, which fields are required. These are relational facts
about a finite universe. Alloy is the lightest substrate
that expresses them precisely.

## Antithesis

A TLA+ spec would also work, and would carry stronger
temporal claims. Coq would carry a proof. Both are heavier
than the claim warrants. The packet DAG is not a state
machine; it is a graph with an irreflexivity invariant.
Forcing it through a temporal-logic or proof-assistant
substrate buys nothing and raises the barrier to reading.

## Synthesis

Attach an Alloy sig and one fact to the convention. The
sig declares `Packet` with two relations: `deps: set Packet`
and `superseded_by: lone Packet`. The fact forbids cycles
in `^deps` and forbids two-way supersession. A `run {} for 5`
asks the analyser for any concrete instance, demonstrating
that the model is satisfiable.

The example lives at `examples/alloy/packet-deps.als`. It
is intentionally read-ready, not executed in this commit.
A future `core/semantic-check.sh` (Phase D axis 1) is the
intended executor.

## What this packet commits to

- A new directory `examples/alloy/` with one `.als` file
  and one README.
- A demonstration that the packet DAG is a strict partial
  order, made verifiable by Alloy's relational logic.
- Coverage row D39 in `core/coverage.yaml`, severity: low.

## What this packet does NOT commit to

- Running the Alloy Analyser as part of `core/verify.sh`.
  That belongs to Phase D axis 1 (semantic-check).
- Replacing any TLA+ or Coq substrate. Each substrate has
  its own use case; Alloy is for *structural* claims.
- A proof that the convention's DAG is currently acyclic.
  The model proves the *shape* is well-defined; finding
  cycles in the live DAG is `core/verify.sh`'s job.

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/alloy-example-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/alloy-example-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/alloy-example-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/alloy-example-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/alloy-example-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Some math-coding claims are *structural* rather than
behavioural. They are about the shape of the convention
itself: which packets depend on which, which supersede
which, which fields are required. These are relational facts
about a finite universe. Alloy is the lightest substrate
that expresses them precisely.
## Antithesis
A TLA+ spec would also work, and would carry stronger
temporal claims. Coq would carry a proof. Both are heavier
than the claim warrants. The packet DAG is not a state
machine; it is a graph with an irreflexivity invariant.
Forcing it through a temporal-logic or proof-assistant
substrate buys nothing and raises the barrier to reading.
## Synthesis
Attach an Alloy sig and one fact to the convention. The
sig declares `Packet` with two relations: `deps: set Packet`
and `superseded_by: lone Packet`. The fact forbids cycles
in `^deps` and forbids two-way supersession. A `run {} for 5`
asks the analyser for any concrete instance, demonstrating
that the model is satisfiable.
The example lives at `examples/alloy/packet-deps.als`. It
is intentionally read-ready, not executed in this commit.
A future `core/semantic-check.sh` (Phase D axis 1) is the
intended executor.
## What this packet commits to
- A new directory `examples/alloy/` with one `.als` file
  and one README.
- A demonstration that the packet DAG is a strict partial
  order, made verifiable by Alloy's relational logic.
- Coverage row D39 in `core/coverage.yaml`, severity: low.
## What this packet does NOT commit to
- Running the Alloy Analyser as part of `core/verify.sh`.
  That belongs to Phase D axis 1 (semantic-check).
- Replacing any TLA+ or Coq substrate. Each substrate has
  its own use case; Alloy is for *structural* claims.
- A proof that the convention's DAG is currently acyclic.

## Task

# alloy-example-as-packet

#convention
## Problem

The convention asserts that packets form a DAG via their
`depends_on` and `superseded_by` fields. The assertion is
written in prose (`core/theories/deprecation.md`, D15) and
enforced structurally (every `depends_on` value resolves to
an existing packet). What is missing is a *relational* spec
that says, in one place, what shape the graph must have.

The convention supports multiple formal substrates. Choosing
the right one matters: a substrate heavier than the claim
costs more to read than it returns in confidence.

## Desired outcome

A small Alloy file at `examples/alloy/packet-deps.als` that
defines `Packet` with `deps` and `superseded_by` relations
and a single fact forbidding cycles and two-way
supersession. The file is readable on its own by a reviewer
who knows Alloy's basic syntax (sig, fact, pred, run). The
`run {} for 5` line at the end is enough to demonstrate
satisfiability.

A `math/alloy-example-as-packet/` directory records the
example as a packet so it shows up in `coverage.yaml` and
its applications are auditable.

## Constraints

- Substrate: alloy. The packet.yaml records this so a future
  semantic-check can dispatch to the Alloy Analyser.
- Rigor: light. No temporal claims, no proof obligations.
- The example file must be self-contained: no imports from
  other `.als` files.
- The packet must follow the 5-file structure mandated by
  D02.
- Cycle fact is the *only* behavioural claim; the rest is
  structural shape.
- One coverage row (D39), severity: low.

## Assumptions

```yaml
task_id: alloy-example-as-packet
assumptions:
  - id: A1
    statement: "Alloy's relational logic is sufficient to express the packet DAG invariant"
    status: judgment
    epistemology: judgment
    evidence: |
      The DAG invariant reduces to irreflexivity on `^deps`
      and asymmetry on `superseded_by`. Both are first-order
      over a finite universe. Alloy handles both natively;
      no temporal logic or proof terms are required.
      See: packet:theory-deprecation-as-packet/refinement.md#invariant-preservation

  - id: A2
    statement: "A structural (relational) claim belongs on the alloy substrate, not tla or coq"
    status: judgment
    epistemology: judgment
    evidence: |
      TLA+ targets state machines with temporal claims; the
      packet DAG has no state transitions. Coq targets proof
      terms; the DAG invariant is one fact, not a proof
      obligation. Alloy sits at the right level of weight.
      See: packet:math-coding-birth/refinement.md#packet-kinds-3-types

  - id: A3
    statement: "Readiness does not require running the Alloy Analyser in this commit"
    status: agent-inferred
    epistemology: hypothesis
    confidence: 0.9
    evidence: |
      The example is documented but not executed. Phase D
      axis 1 (semantic-check) will dispatch to the analyser
      when `substrate: alloy` is set; until then the file
      serves as executable documentation.
      See: packet:phase-d-roadmap-as-packet/decision.md#synthesis
```

## Refinement

# Refinement: alloy-example-as-packet

#convention
## State

- **pre**: the convention had no example of an alloy
  substrate. `substrate: alloy` was an enum value (D06) but
  no packet used it.
- **post**: `examples/alloy/packet-deps.als` models the
  packet DAG. `math/alloy-example-as-packet/` records the
  example as a packet.

## Operation

- Add a new directory `examples/alloy/` with one `.als`
  file and one README.
- Add a new packet directory `math/alloy-example-as-packet/`
  with the 5 standard files.
- Append coverage row D39 to `core/coverage.yaml`.

## Invariant

- The 5-file packet structure is preserved (D02).
- The example file declares `sig Packet { deps, superseded_by }`
  and a single fact forbidding cycles. The shape of the
  model is unchanged by future edits; only the bound in
  `run {}` may grow.
- Coverage.yaml row D39 references this packet and the
  example file.

## Test obligation

- A reviewer reading `examples/alloy/packet-deps.als` can
  see, by inspection, that the fact forbids both self-loops
  and longer cycles via `p not in p.^deps`.
- A reviewer reading `core/coverage.yaml` finds D39 with
  `packet: math/alloy-example-as-packet/` and severity: low.

## Runtime check

- None in this commit. The Alloy Analyser is not invoked by
  `core/verify.sh`. When Phase D axis 1 ships
  (`core/semantic-check.sh`), this packet will be a target
  of dispatch by `substrate: alloy`.

## Cross-reference

- Theory: `core/theories/deprecation.md` (strict partial
  order, the property the fact enforces)
- Sibling examples (Phase D axis 4 in parallel):
  `examples/tla/packet-lifecycle.tla` (TLA+),
  `examples/coq/fsm-order.v` (Coq)
- Coverage: D39, severity: low

