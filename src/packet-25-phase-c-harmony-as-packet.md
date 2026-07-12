# phase-c-harmony — bring convention into harmony

#convention
## Thesis

math-coding v0.618 carries 22 unstaged edits from prior
exploration. The edits cover `core/theories/*.md` and
`math/*/assumptions.yaml`, but they introduce cosmetic
duplication rather than enforceable structure. The convention
declares 12 mathematical theories ground it, yet the link
between theory and applying packet is informal. Any agent or
human reading the repo must reconstruct the relationship
between `core/theories/fsm.md` and
`math/theory-fsm-as-packet/refinement.md` by inference.

## Antithesis

Writing more cross-references does not make the convention
more rigorous. It adds prose that agents must read on every
session. Drift between duplicated tables can grow without
detection. A formal drift-detection substrate must live in
the convention itself.

## Synthesis

Phase C makes the theory⇄packet relationship *formal* and
*enforced*:

1. The packet layer is the only authoritative site for the
   *application* of a theory (states, transitions, threshold
   values, operators). Theories stay compact references.
2. `core/coverage.yaml` gains a `theory:` field for D10–D18
   so the theory a decision applies is machine-readable.
3. `core/verify.sh` grows four drift checks: theory↔packet,
   coverage↔theory, FSM-state equality, epistemic-marker
   equality.
4. `applications:` is added to `packet.yaml` (Required) so
   agents record which commits implement each packet.
5. Two new OS runtime manifests appear in `core/`:
   `core/think-before-do.md` and `core/decision-modes.md`,
   with corresponding decision-packets
   `math/think-before-do-as-packet/` and
   `math/fast-track-as-packet/`.
6. `agents.md` is extended with the Think Principle, four
   decision modes, role-aware defaults, and the Track
   protocol.

## What this packet commits to

- 22 prior edits are rolled back; a clean tree moves forward
- 12 theories become compact runtime specifications for an LLM
- 11 theory-packet `assumptions.yaml` use plain `See:` references
- 11 theory-packet `refinement.md` carry the model + a
  cross-reference line back to the theory file
- `theory:` field appears on D10–D18 in coverage.yaml
- `applications:` becomes a Required field in `packet.yaml`
- `core/verify.sh` grows four checks; total errors stay at 0
- Two new OS files: `core/think-before-do.md`,
  `core/decision-modes.md`
- Two new packets: `think-before-do-as-packet`,
  `fast-track-as-packet`
- `agents.md` extends with Think Principle, modes, roles, Track

## What this packet does NOT commit to

- A semantic verifier (claims↔reality) — deferred to Phase D
- TLA+, Coq, Alloy integration protocols — deferred to Phase D
- A new `math/.protocol.yaml` tuning system — covered in
  `fast-track-as-packet/refinement.md` as a future axis

## Mathematical justification

Curry-Howard says a proof term follows the proposition it
proves. Phase C applies this: the *specification* (theory +
packet) precedes any *implementation* (code change). Agents
record the moment of implementation in
`packet.yaml:applications[]`. Drift detection closes the loop.

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/phase-c-harmony-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/phase-c-harmony-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-c-harmony-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/phase-c-harmony-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-c-harmony-as-packet/packet.yaml)

## Decision

#convention
## Thesis
math-coding v0.618 carries 22 unstaged edits from prior
exploration. The edits cover `core/theories/*.md` and
`math/*/assumptions.yaml`, but they introduce cosmetic
duplication rather than enforceable structure. The convention
declares 12 mathematical theories ground it, yet the link
between theory and applying packet is informal. Any agent or
human reading the repo must reconstruct the relationship
between `core/theories/fsm.md` and
`math/theory-fsm-as-packet/refinement.md` by inference.
## Antithesis
Writing more cross-references does not make the convention
more rigorous. It adds prose that agents must read on every
session. Drift between duplicated tables can grow without
detection. A formal drift-detection substrate must live in
the convention itself.
## Synthesis
Phase C makes the theory⇄packet relationship *formal* and
*enforced*:
1. The packet layer is the only authoritative site for the
   *application* of a theory (states, transitions, threshold
   values, operators). Theories stay compact references.
2. `core/coverage.yaml` gains a `theory:` field for D10–D18
   so the theory a decision applies is machine-readable.
3. `core/verify.sh` grows four drift checks: theory↔packet,
   coverage↔theory, FSM-state equality, epistemic-marker
   equality.
4. `applications:` is added to `packet.yaml` (Required) so
   agents record which commits implement each packet.
5. Two new OS runtime manifests appear in `core/`:
   `core/think-before-do.md` and `core/decision-modes.md`,
   with corresponding decision-packets
   `math/think-before-do-as-packet/` and
   `math/fast-track-as-packet/`.
6. `agents.md` is extended with the Think Principle, four
   decision modes, role-aware defaults, and the Track
   protocol.
## What this packet commits to
- 22 prior edits are rolled back; a clean tree moves forward
- 12 theories become compact runtime specifications for an LLM
- 11 theory-packet `assumptions.yaml` use plain `See:` references
- 11 theory-packet `refinement.md` carry the model + a
  cross-reference line back to the theory file
- `theory:` field appears on D10–D18 in coverage.yaml
- `applications:` becomes a Required field in `packet.yaml`
- `core/verify.sh` grows four checks; total errors stay at 0
- Two new OS files: `core/think-before-do.md`,
  `core/decision-modes.md`
- Two new packets: `think-before-do-as-packet`,
  `fast-track-as-packet`
- `agents.md` extends with Think Principle, modes, roles, Track
## What this packet does NOT commit to
- A semantic verifier (claims↔reality) — deferred to Phase D
- TLA+, Coq, Alloy integration protocols — deferred to Phase D
- A new `math/.protocol.yaml` tuning system — covered in
  `fast-track-as-packet/refinement.md` as a future axis
## Mathematical justification
Curry-Howard says a proof term follows the proposition it
proves. Phase C applies this: the *specification* (theory +
packet) precedes any *implementation* (code change). Agents

## Task

# phase-c-harmony — task

#convention
## Problem

math-coding v0.618 already commits to 11 mathematical
theories, recursive observability, and "grounded in
mathematics" (math-coding-birth/refinement.md §13). Yet the
concrete files implementing the convention carry 22 unstaged
edits that name "Grounded by" or "Grounded in" without
enforcing the relationship; coverage.yaml D09–D18 reference
packets and not the underlying theories; and there is no way
for an agent to record *which commit applies a packet to
which file*, so spec↔code drift is invisible.

## Desired outcome

A math-coding repo where:

1. The set of theories in `core/theories/` stays compact,
   machine-parseable, free of consumer-specific cross-refs
2. `core/coverage.yaml` is a formal bridge between each
   mathematical theory and the packet that applies it
3. `core/verify.sh` checks theory⇄packet, FSM-state
   consistency, epistemic-marker consistency, and
   `applications:` validity — all in POSIX shell
4. Every `packet.yaml` records `applications:` so drift is
   auditable
5. `agents.md` reads in under 50 lines and explicitly directs
   agents to first run "Think before Do" with decision-mode
   defaults per role
6. `sh core/verify.sh` returns 0 errors and ≥ 500 checks

## Constraints

- POSIX shell only (no python, jq, yq, or external deps)
- `agents.md` stays ≤ 50 lines
- No semantic verifier in this phase
- No TLA+, Coq, Alloy substrate examples in this phase
- Backwards-compatible: existing 18 packets must keep passing
  `core/verify.sh`
- One git commit named "Phase C: …"

## Assumptions

```yaml
task_id: phase-c-harmony
assumptions:
  - id: A1
    statement: "Each mathematical theory in core/theories/ is best authored as a compact, self-sufficient runtime spec for an LLM"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Convention's LLM-as-interpreter stance (LLM reads
      text, treats it as code). Compact specs reduce reading
      cost; consumer-specific cross-refs in theory files
      drift.
      See: math-coding-birth/refinement.md#13

  - id: A2
    statement: "coverage.yaml gains a `theory:` field; every D referencing a math theory resolves to a real core/theories/X.md"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      D10–D18 already map to theories (theory-predicate through
      theory-confidence). Adding the field is mechanical and
      checkable.
      See: core/coverage.yaml

  - id: A3
    statement: "applications: is required in packet.yaml; existing 18 packets default to applications: []"
    status: judgment
    epistemology: judgment
    evidence: |
      Required-conditional was the user's choice. Default of
      [] keeps existing packets valid; new and retrofitted
      packets opt-in by listing actual applications.
      See: agents-md-as-packet/refinement.md#edit-protocol

  - id: A4
    statement: "4 decision modes (skip / light / standard / strict) and 5 role presets cover non-developer scenarios without obligating a packet for every micro-edit"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      User explicitly chose both `agents.md` and
      `core/decision-modes.md` for the modes; chose a separate
      `fast-track-as-packet` packet for justification.
      See: packet:fast-track-as-packet (forthcoming)

  - id: A5
    statement: "Think-before-Do (Curry-Howard inverse: proposition before proof term) earns its own packet and OS file"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      User explicitly chose both `core/think-before-do.md`
      and `math/think-before-do-as-packet`. The principle is
      foundational to Phase C's spec-before-code ordering.
      See: packet:think-before-do-as-packet (forthcoming)
```

## Refinement

# Refinement: phase-c-harmony

#convention
## State

- **pre**: convention carries 22 unstaged edits adding "Grounded
  by/in" cross-refs but no enforced link between `core/`
  theories and the packets applying them. coverage.yaml D10–D18
  point at packets, not theories.
- **post**: theory⇄packet relationship is formal and enforced
  through `coverage.yaml:theory:` field, four new
  `core/verify.sh` drift checks, and an `applications:` log
  on every packet.

## Operation

- Roll back 22 prior edits (`git restore .`)
- Rewrite 11 `core/theories/*.md` files as compact runtime
  references — no consumer-specific cross-references in
  theory prose
- Rewrite 11 `math/*/assumptions.yaml` to use plain
  `See: core/theories/X.md` in evidence
- Rewrite 11 `math/*/refinement.md` to keep the model and
  add a one-line cross-reference back to the theory file
- Add `theory:` to D10–D18 in `core/coverage.yaml`
- Add new decisions: D28 (Think principle runtime input),
  D29 (applications tracking), D30 (decision modes)
- Update `core/packet-schema.md` — add `applications`
  Required field
- Update `core/init-packet.sh` template — emit
  `applications: []` in new packets
- Extend `core/verify.sh` with 4 new drift checks
- Create `core/think-before-do.md` (OS runtime manifest)
- Create `core/decision-modes.md` (OS runtime manifest)
- Create `math/think-before-do-as-packet/` (Curry-Howard
  justification, 5 files)
- Create `math/fast-track-as-packet/` (decision modes +
  role-aware defaults, 5 files)
- Extend `AGENTS.md` ≤ 50 lines

## Mapping (spec → impl)

| Spec (this packet)              | Impl (artifacts)                                |
|---------------------------------|-------------------------------------------------|
| Rollback 22 prior edits         | `git restore .` then a clean re-do             |
| theory⇄packet enforcement       | `core/coverage.yaml:theory:` + verify.sh       |
| applications Required           | `core/packet-schema.md` + init-packet.sh       |
| Decision modes × 5 roles        | `core/decision-modes.md` + `AGENTS.md`         |
| Think principle                 | `core/think-before-do.md` + think-before-do-as |
| Compact LLM specs               | `core/theories/*.md` rewritten                 |

## Invariant preservation

- `AGENTS.md` line count stays ≤ 50 (birth-packet invariant)
- `core/verify.sh` returns 0 errors and ≥ 500 checks
- 18 existing packets keep lifecycle values
- 12 theories preserve their names, intended rigor, and
  cross-reference IDs (`core/theories/predicate.md` etc.)
- `core/theories/*.md` no longer contains
  `**Grounded by:**` or "this packet grounds" prose

## Test obligation

- `sh core/verify.sh` returns 0
- `wc -l AGENTS.md` ≤ 50
- `wc -l core/coverage.yaml` increased but well-formed
- `git diff --stat` shows expected file set: 22 untouched
  reverts plus Phase C additions

## Runtime check

- After any commit, `git log -1 --format=%H` is recorded in
  every packet's `applications[]` if the commit
  implements/applies that packet
- Convention author manually adds the entry; verify.sh
  validates structure, not content of applications

