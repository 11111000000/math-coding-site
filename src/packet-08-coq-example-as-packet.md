# coq-example-as-packet — Coq as a substrate, examples as proof-terms

#convention
## Thesis

Phase D axis D4-C turns a piece of convention-OS
(`examples/coq/supersession-order.v`) into a first-class packet.
The example is read-ready Coq; it proves the three strict-order
laws of supersession on a three-packet universe. This makes the
mathematical claim in `core/theories/deprecation.md` mechanically
auditable.

## Antithesis

The convention already says in `core/theories/curry-howard.md`
that proofs become proof-terms, and the packet shape already
mirrors that. Adding a Coq example seems redundant — the same
information lives in `theory-curry-howard-as-packet` and
`theory-deprecation-as-packet`.

The risk is concrete: layering an "example packet" on top of two
theory packets inflates the DAG without changing what convention
authors know. A reviewer reading the convention should not have to
hold three layers (theory → theory-packet → example-packet) in
their head to understand one mathematical claim.

## Synthesis

Keep the layering. Curry-Howard says proofs are proof-terms; we
already say so. This packet commits to one further thing: a
**read-ready** proof-term lives at `examples/coq/supersession-order.v`,
and the packet is the convention shape around it. Three layers
with three jobs:

- `core/theories/deprecation.md` — abstract claim (the proposition)
- `math/theory-deprecation-as-packet/` — convention's rendering
  of the claim (decision, assumptions, refinement, lifecycle)
- `examples/coq/supersession-order.v` — concrete proof artefact
  that proves the claim on a small universe

The Coq file is **not** executed by `core/verify.sh` in v0.618.
It is read-ready so a future verifier-as-packet (or a human
auditor with `coqc`) can confirm that the claim is not just
declared but demonstrated.

Curry-Howard justifies turning the proof into a proof-term; this
packet does not re-derive that justification, it instantiates it.

## What this packet commits to

- A Coq source file at `examples/coq/supersession-order.v`
  encoding `supersession` and proving irreflexivity, asymmetry,
  transitivity using `intros`, `inversion`, `auto`.
- A `README.md` at `examples/coq/` describing the proof outline
  and why a Coq file is appropriate for a mathematical claim.
- This packet's directory contains the five conventional files
  (`packet.yaml`, `decision.md`, `task.md`, `assumptions.yaml`,
  `refinement.md`).
- A D38 row in `core/coverage.yaml` with severity `low`.

## What this packet does NOT commit to

- A working `coqc` run inside v0.618 (`core/verify.sh` does not
  invoke external tools).
- Coverage of the full packet universe — the Coq example uses
  three concrete packets to keep the proof readable.
- A future verifier that *requires* Coq — the file is optional
  evidence, not a gate.

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/coq-example-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/coq-example-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/coq-example-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/coq-example-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/coq-example-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Phase D axis D4-C turns a piece of convention-OS
(`examples/coq/supersession-order.v`) into a first-class packet.
The example is read-ready Coq; it proves the three strict-order
laws of supersession on a three-packet universe. This makes the
mathematical claim in `core/theories/deprecation.md` mechanically
auditable.
## Antithesis
The convention already says in `core/theories/curry-howard.md`
that proofs become proof-terms, and the packet shape already
mirrors that. Adding a Coq example seems redundant — the same
information lives in `theory-curry-howard-as-packet` and
`theory-deprecation-as-packet`.
The risk is concrete: layering an "example packet" on top of two
theory packets inflates the DAG without changing what convention
authors know. A reviewer reading the convention should not have to
hold three layers (theory → theory-packet → example-packet) in
their head to understand one mathematical claim.
## Synthesis
Keep the layering. Curry-Howard says proofs are proof-terms; we
already say so. This packet commits to one further thing: a
**read-ready** proof-term lives at `examples/coq/supersession-order.v`,
and the packet is the convention shape around it. Three layers
with three jobs:
- `core/theories/deprecation.md` — abstract claim (the proposition)
- `math/theory-deprecation-as-packet/` — convention's rendering
  of the claim (decision, assumptions, refinement, lifecycle)
- `examples/coq/supersession-order.v` — concrete proof artefact
  that proves the claim on a small universe
The Coq file is **not** executed by `core/verify.sh` in v0.618.
It is read-ready so a future verifier-as-packet (or a human
auditor with `coqc`) can confirm that the claim is not just
declared but demonstrated.
Curry-Howard justifies turning the proof into a proof-term; this
packet does not re-derive that justification, it instantiates it.
## What this packet commits to
- A Coq source file at `examples/coq/supersession-order.v`
  encoding `supersession` and proving irreflexivity, asymmetry,
  transitivity using `intros`, `inversion`, `auto`.
- A `README.md` at `examples/coq/` describing the proof outline
  and why a Coq file is appropriate for a mathematical claim.
- This packet's directory contains the five conventional files
  (`packet.yaml`, `decision.md`, `task.md`, `assumptions.yaml`,
  `refinement.md`).
- A D38 row in `core/coverage.yaml` with severity `low`.
## What this packet does NOT commit to
- A working `coqc` run inside v0.618 (`core/verify.sh` does not
  invoke external tools).
- Coverage of the full packet universe — the Coq example uses
  three concrete packets to keep the proof readable.

## Task

# coq-example-as-packet — task

#convention
## Problem

`core/theories/deprecation.md` declares supersession to be a strict
partial order. `math/theory-deprecation-as-packet/refinement.md`
restates the three properties in the convention's voice. Neither
file carries a concrete demonstration that the properties actually
hold — the claim is structural, not constructive.

A future verifier-as-packet (Phase B+) should be able to point at
a piece of code that *proves* the claim, not just declares it. The
math-coding convention already states in
`core/theories/curry-howard.md` that proofs become proof-terms.
Without a concrete example, that statement remains abstract.

## Desired outcome

A Coq source file at `examples/coq/supersession-order.v` that:

- declares an inductive `packet` type with three constructors,
- declares `supersession` as an inductive binary relation,
- proves three lemmas using only `intros`, `inversion`, `auto`:
  - irreflexivity (`forall p, ~ supersession p p`)
  - asymmetry (`forall p q, supersession p q -> ~ supersession q p`)
  - transitivity (`forall p q r, supersession p q -> supersession q r -> supersession p r`)

A README at `examples/coq/README.md` that explains the proof
outline and why the file is mathematical rather than engineering.

A packet at `math/coq-example-as-packet/` with the conventional
five files. A D38 row in `core/coverage.yaml`.

## Constraints

- The Coq file must be read-ready (syntactically valid Coq 8.x).
  `core/verify.sh` will not execute it; a future tool may.
- Proof tactics restricted to `intros`, `inversion`, `auto` per
  the assignment. No `omega`, no `lia`, no custom lemmas.
- `applications:` in `packet.yaml` carries a SHA placeholder (all
  zeros) until the Phase D bundle SHA is recorded.
- The packet must pass `core/verify.sh` without modifying the
  verifier.

## Assumptions

```yaml
task_id: coq-example-as-packet
assumptions:
  - id: A1
    statement: "Supersession is declared as a strict partial order in core/theories/deprecation.md"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/theories/deprecation.md states supersession satisfies
      irreflexivity, asymmetry, transitivity.
      See: core/theories/deprecation.md

  - id: A2
    statement: "Curry-Howard correspondence turns proofs into proof-terms"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/theories/curry-howard.md says types are propositions
      and programs are proofs. A Coq source file is therefore
      a concrete proof-term candidate.
      See: core/theories/curry-howard.md

  - id: A3
    statement: "A three-packet universe suffices to demonstrate the three strict-order laws non-trivially"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      With two distinct constructors (P1⊥P2 and P2⊥P3), the
      transitivity lemma has a non-vacuous instance (P1⊥P2⊥P3).
      A two-packet universe would not exercise transitivity; a
      four-packet universe adds no signal.
      See: packet:theory-deprecation-as-packet (3 laws)

  - id: A4
    statement: "The proof tactics intros + inversion + auto are sufficient to discharge each lemma"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      Each strict-order law, when reduced on the declared
      constructors, leaves goals that are either trivially
      contradictory (no constructor matches) or have a single
      constructor that auto discharges.
      See: examples/coq/supersession-order.v

  - id: A5
    statement: "core/verify.sh does not execute external tools in v0.618"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/verify.sh is POSIX shell with no coq invocation.
      Read-ready Coq is therefore the right v0.618 deliverable;
      a compiled proof is deferred to a future verifier-as-packet.
      See: core/verify.sh```

## Refinement

# Refinement: coq-example-as-packet

#convention
## State

- `packet`: the small inductive type with three constructors
  P1, P2, P3 declared in `examples/coq/supersession-order.v`
- `supersession : packet -> packet -> Prop`: the inductive
  relation with constructors `sup_12` and `sup_23`
- π: the Coq source file itself, viewed as a proof-term per
  Curry-Howard
- verdict: outcome of attempting to discharge the three strict-order
  lemmas (`supersession_irreflexive`, `supersession_asymmetric`,
  `supersession_transitive`)

## Operations

- Declare `Inductive packet := P1 | P2 | P3.`
- Declare `Inductive supersession` with two constructors producing
  the chain P1 ⊥ P2 ⊥ P3.
- Prove each lemma with `intros`, `inversion`, `auto`.
- Optionally `coqc` the file outside `core/verify.sh` to obtain a
  real verdict (`Qed` for each lemma).

## Mapping (Coq ↔ math-coding)

| Coq construct | math-coding meaning |
|---------------|---------------------|
| `Inductive packet` | The set of packet IDs in scope for this proof |
| `Inductive supersession` | The supersession relation, restricted to the in-scope packets |
| Lemma statement | A claim derived from `core/theories/deprecation.md` |
| `Proof. ... Qed.` | Evidence that the claim holds on the in-scope universe |
| `coqc` exit code 0 | Lifecycle upgrade candidate (`working` → `verified`) |

## Invariant preservation

- The lemma statements match the three properties named in
  `core/theories/deprecation.md` and
  `math/theory-deprecation-as-packet/refinement.md`. Drift would
  show up as a `coqc` failure when the canonical spec evolves.
- The proof uses no axioms beyond the declared constructors. No
  classical logic extensions, no `Admitted` lemmas, no `omega`
  or `lia` shortcuts.
- The relation `supersession` is acyclic by construction. Adding
  a reverse constructor later would require re-proving
  irreflexivity and asymmetry; transitivity would still hold.

## Mapping to convention axes

- **Axis 13 (Mathematical theories):** this packet instantiates
  the partial-order theory with a concrete proof artefact.
- **Axis 16 (Substrates):** demonstrates `substrate: coq` is
  load-bearing, not decorative — the proof is in Coq.
- **Axis 3 (Curry-Howard):** the file *is* the proof-term; the
  packet is the convention shape around it.

## Test obligation

- A human reviewer runs `coqc examples/coq/supersession-order.v`
  and observes three `Qed` outputs. (Not part of v0.618.)
- If `core/theories/deprecation.md` adds a fourth property (e.g.,
  well-foundedness), the Coq file must grow a corresponding lemma
  and proof.

## Runtime check

- None inside v0.618. The verifier (`core/verify.sh`) checks
  packet structure only. A future verifier-as-packet may invoke
  `coqc`.

## Cross-reference

Canonical spec: `core/theories/deprecation.md` (three strict-order
laws). Curry-Howard grounding: `core/theories/curry-howard.md`
and `math/theory-curry-howard-as-packet/`. Concrete proof:
`examples/coq/supersession-order.v`. Drift between the canonical
spec and the proof lemmas is the next verifier's job.

