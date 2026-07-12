# think-before-do — Curry-Howard applied as the convention principle

#convention
## Thesis

math-coding's load-bearing claim is that code becomes more
honest when spec precedes impl. Without an explicit principle,
agents and humans default to whichever makes the immediate
commit look plausible — which is the failure mode vibe-coding
already has.

## Antithesis

Adding a "principle" risks ceremony: agents paste the line
about Think-before-Do and then ignore it. The principle must
do work — it must name an ordering that the convention's own
tools can detect when violated.

## Synthesis

Curry-Howard gives the principle teeth: a proof term follows
the proposition it proves. In math-coding this means:

- `decision.md` declares the proposition (P).
- `assumptions.yaml` declares the context (Γ).
- The packet itself is the proof term candidate (π).
- `core/verify.sh` plays the role of type-checker.
- `verdict: VERIFIED` is proof acceptance; `lifecycle: verified`
  is the post-acceptance state.

The convention then enforces two ordering checks:

1. `core/verify.sh` walks `applications[]` and reports drift
   between the application SHA and current HEAD for the listed
   files.
2. A new field on every `packet.yaml` records applications so
   drift is auditable, not inferred.

## What this packet commits to

- A runtime manifest `core/think-before-do.md` that summarises
  the principle for any agent that reads `core/` first.
- A new required `applications:` field on `packet.yaml`.
- An audit field structure validated by `core/verify.sh`.
- Three other packets (`phase-c-harmony-as-packet`,
  `fast-track-as-packet`, and any future spec-change) reference
  this one as their dependency.

## What this packet does NOT commit to

- Semantic diff between packet claims and runtime reality
  (deferred — Phase D).
- Automatic appending of applications on commit (still manual).
- TLA+, Coq, or Alloy substrate examples (Phase D).

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/think-before-do-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/think-before-do-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/think-before-do-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/think-before-do-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/think-before-do-as-packet/packet.yaml)

## Decision

#convention
## Thesis
math-coding's load-bearing claim is that code becomes more
honest when spec precedes impl. Without an explicit principle,
agents and humans default to whichever makes the immediate
commit look plausible — which is the failure mode vibe-coding
already has.
## Antithesis
Adding a "principle" risks ceremony: agents paste the line
about Think-before-Do and then ignore it. The principle must
do work — it must name an ordering that the convention's own
tools can detect when violated.
## Synthesis
Curry-Howard gives the principle teeth: a proof term follows
the proposition it proves. In math-coding this means:
- `decision.md` declares the proposition (P).
- `assumptions.yaml` declares the context (Γ).
- The packet itself is the proof term candidate (π).
- `core/verify.sh` plays the role of type-checker.
- `verdict: VERIFIED` is proof acceptance; `lifecycle: verified`
  is the post-acceptance state.
The convention then enforces two ordering checks:
1. `core/verify.sh` walks `applications[]` and reports drift
   between the application SHA and current HEAD for the listed
   files.
2. A new field on every `packet.yaml` records applications so
   drift is auditable, not inferred.
## What this packet commits to
- A runtime manifest `core/think-before-do.md` that summarises
  the principle for any agent that reads `core/` first.
- A new required `applications:` field on `packet.yaml`.
- An audit field structure validated by `core/verify.sh`.
- Three other packets (`phase-c-harmony-as-packet`,
  `fast-track-as-packet`, and any future spec-change) reference
  this one as their dependency.
## What this packet does NOT commit to
- Semantic diff between packet claims and runtime reality
  (deferred — Phase D).

## Task

# think-before-do — task

#convention
## Problem

math-coding declares that decisions become packets and
packets come before code. This is stated in
`math-coding-birth/refinement.md` and recurs in theory
packets. Yet nothing in the convention made the principle
*enforceable*: there was no field, no runtime manifest, and
no audit of which commit implemented which packet.

## Desired outcome

A convention where:

- Every `packet.yaml` declares `applications[]`, recording the
  commit and files that implement it.
- A runtime manifest under `core/think-before-do.md` makes the
  principle discoverable in a single read.
- `core/verify.sh` validates the *structure* of `applications`
  (sha looks hex, `by` ∈ {agent, human}, files list, notes
  string).
- A future `core/drift-check.sh` can read applications and
  report drift — but that is Phase D.

## Constraints

- New `applications:` field must be Optional-feeling but
  Required-structurally (default `[]` keeps existing packets
  valid).
- No new external dependencies.
- The principle applies to every commit, including cosmetic
  ones (`skip` mode records nothing — `light` records by-line
  rationale; `standard` and `strict` record applications).
- The runtime manifest stays under `core/` so it travels with
  the convention and not with any specific packet.

## Assumptions

```yaml
task_id: think-before-do-as-packet
assumptions:
  - id: A1
    statement: "Curry-Howard equivalence (program ⇔ proof, type ⇔ proposition) generalises beyond type theory to any artifact-with-spec system"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      Curry-Howard is well-established in type theory. The
      generalisation to specs-as-types is informal but used
      in industrial model-checking workflows (TLA+ specs
      play the role of types).
      See: core/theories/curry-howard.md

  - id: A2
    statement: "applications: is the right shape for drift audit (SHA, by, files, notes)"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      SHA anchors to a real commit; by ∈ {agent, human}
      captures authorship; files lists the surface area;
      notes provides a human-readable rationale. The shape
      is small enough to validate in POSIX shell.
      See: core/packet-schema.md#applications-drift-tracking

  - id: A3
    statement: "Spec before impl survives workflow churn: even when agents skip steps, the convention must encode the default ordering"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention claims it is "grounded in mathematics"
      (math-coding-birth, refinement.md §13). The grounding
      is operationalised as spec-before-impl, not as a slogan.
      See: packet:math-coding-birth/refinement.md#13

  - id: A4
    statement: "A dedicated runtime manifest in core/ is clearer than burying the principle inside agents.md"
    status: judgment
    epistemology: judgment
    evidence: |
      Agents.md already at the 50-line cap. A standalone
      core/think-before-do.md is the convention's primary
      principle file — readable in isolation by any agent or
      human.
      See: agents-md-as-packet/refinement.md#invariant

  - id: A5
    statement: "This principle applies to all 4 decision modes (skip / light / standard / strict), but only standard and strict require applications[]"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      `skip` is direct git commit; `light` records rationale
      in the commit message; only `standard` and `strict`
      declare applications. This balances
      non-intrusiveness with audit completeness.
      See: packet:fast-track-as-packet/refinement.md
```

## Refinement

# Refinement: think-before-do

#convention
## State

- **pre**: convention has `AGENTS.md` ≤ 50 lines and 4 OS
  files in `core/`, but no principle manifest. The
  spec-before-impl idea lives dispersed in
  `math-coding-birth/refinement.md` and various theory
  packets.
- **post**: a single runtime manifest
  `core/think-before-do.md`; a required `applications:`
  field on every `packet.yaml`; structural validation in
  `core/verify.sh`.

## Operation

- Create `core/think-before-do.md` (this packet authorises it
  as OS)
- Extend `core/packet-schema.md` with `applications:` as a
  Required field
- Add `applications: []` to `core/init-packet.sh` template
- Add structural validation in `core/verify.sh`
- Append `applications: []` to all 19 existing packets so
  they keep passing the verifier

## Mapping (spec → impl)

| Spec (this packet)           | Impl (artifact)                           |
|------------------------------|--------------------------------------------|
| principle manifest           | `core/think-before-do.md`                |
| required applications field  | `core/packet-schema.md`                  |
| defaulted template           | `core/init-packet.sh`                    |
| structural validation        | `core/verify.sh` (apps check)            |

## Invariant preservation

- `AGENTS.md` stays ≤ 50 lines
- 19 existing packets keep all previous required fields
- `core/verify.sh` returns 0 errors after migration

## Test obligation

- `sh core/verify.sh` returns VERIFIED
- every `packet.yaml` carries an `applications:` key
- `core/think-before-do.md` exists and contains the order
  (Model → Check → Code → Track)

## Runtime check

- After every `standard` or `strict` commit, the agent (or
  human) appends an entry to the relevant packet's
  `applications[]`.
- Phase D will add an automated drift detector that compares
  `applications[].sha` against git history.

## Cross-reference

Canonical spec: this file is the spec. The runtime manifest
`core/think-before-do.md` is the LLM-readable summary.
`core/coverage.yaml:D28` records this packet as the decision
owner.

