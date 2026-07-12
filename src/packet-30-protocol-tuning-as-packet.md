# protocol-tuning — per-repo overrides of the 4×5 mode×role matrix

#convention
## Thesis

The matrix in `core/decision-modes.md` is a sane default for
the convention itself, but every repo that adopts math-coding
has its own mix of roles and a different tolerance for
ceremony. A research repo wants `researcher` → `strict` to
hold; a docs repo wants `tech-writer` → `skip` to be the
floor. Forcing every adopter to fork `core/decision-modes.md`
or to override with `# mode:` on every request is brittle.

## Antithesis

A per-repo config file is the thin edge of the wedge. If
`math/.protocol.yaml` exists, then drift between repo config
and the canonical matrix becomes a new failure mode. Worse,
the file invites projects to skip the protocol entirely
("set my default to skip, I'm just exploring") — which
silently abandons the recursive observability invariant.

## Synthesis

Adopt the file as **opt-in**: `math/.protocol.yaml` may
exist; absence means the canonical matrix applies. Three
constraints keep the wedge from splitting the convention:

1. The file may only **shift defaults**, not redefine modes.
   Modes are a closed enum; adding a 5th mode would fork the
   convention.
2. The file ships with `lifecycle: sketch` in its packet —
   promotion to `working` requires at least one adopter and
   one downstream `core/verify.sh` check.
3. The canonical matrix in `core/decision-modes.md` stays the
   authoritative spec; the file is an override, not a
   replacement.

## What this packet commits to

- A new optional OS file `math/.protocol.yaml` with three
  blocks (`version`, `defaults`, `overrides`).
- A 5-file packet `math/protocol-tuning-as-packet/` that
  documents the file shape, semantics, and the opt-in rule.
- A single `D35` row in `core/coverage.yaml` recording this
  axis as a low-severity roadmap decision.

## What this packet does NOT commit to

- A new decision mode. The 4-mode enum is closed for the
  lifetime of the convention.
- Per-user profiles (out of scope; one user, one repo).
- Validation of `math/.protocol.yaml` in `core/verify.sh`
  during `sketch` lifecycle. The verifier only checks packet
  structure; the protocol file is a runtime concern.
- Cross-repo inheritance (subprojects picking up the parent
  repo's protocol). Deferred until the shape stabilises.

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/protocol-tuning-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/protocol-tuning-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/protocol-tuning-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/protocol-tuning-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/protocol-tuning-as-packet/packet.yaml)

## Decision

#convention
## Thesis
The matrix in `core/decision-modes.md` is a sane default for
the convention itself, but every repo that adopts math-coding
has its own mix of roles and a different tolerance for
ceremony. A research repo wants `researcher` → `strict` to
hold; a docs repo wants `tech-writer` → `skip` to be the
floor. Forcing every adopter to fork `core/decision-modes.md`
or to override with `# mode:` on every request is brittle.
## Antithesis
A per-repo config file is the thin edge of the wedge. If
`math/.protocol.yaml` exists, then drift between repo config
and the canonical matrix becomes a new failure mode. Worse,
the file invites projects to skip the protocol entirely
("set my default to skip, I'm just exploring") — which
silently abandons the recursive observability invariant.
## Synthesis
Adopt the file as **opt-in**: `math/.protocol.yaml` may
exist; absence means the canonical matrix applies. Three
constraints keep the wedge from splitting the convention:
1. The file may only **shift defaults**, not redefine modes.
   Modes are a closed enum; adding a 5th mode would fork the
   convention.
2. The file ships with `lifecycle: sketch` in its packet —
   promotion to `working` requires at least one adopter and
   one downstream `core/verify.sh` check.
3. The canonical matrix in `core/decision-modes.md` stays the
   authoritative spec; the file is an override, not a
   replacement.
## What this packet commits to
- A new optional OS file `math/.protocol.yaml` with three
  blocks (`version`, `defaults`, `overrides`).
- A 5-file packet `math/protocol-tuning-as-packet/` that
  documents the file shape, semantics, and the opt-in rule.
- A single `D35` row in `core/coverage.yaml` recording this
  axis as a low-severity roadmap decision.
## What this packet does NOT commit to
- A new decision mode. The 4-mode enum is closed for the
  lifetime of the convention.
- Per-user profiles (out of scope; one user, one repo).
- Validation of `math/.protocol.yaml` in `core/verify.sh`
  during `sketch` lifecycle. The verifier only checks packet
  structure; the protocol file is a runtime concern.

## Task

# protocol-tuning — task

#convention
## Problem

math-coding ships a single 4×5 mode×role matrix in
`core/decision-modes.md`. A docs-heavy repo and a
formal-methods repo both adopt math-coding, but they need
different defaults: docs prefers `skip`/`light`, formal
methods prefers `strict`. Overriding with `# mode:` on every
request is ceremony; forking `core/decision-modes.md` breaks
the "one source of truth" invariant.

## Desired outcome

A small, optional YAML file at `math/.protocol.yaml` that
shifts the role-to-mode defaults for **one repo**, without
touching the canonical matrix or the packet schema. The file
is opt-in: absence means the canonical matrix applies.

Three concerns are out of scope for this packet:

- Defining a 5th mode.
- Per-user tuning.
- Verifier enforcement of the file contents during `sketch`
  lifecycle.

## Constraints

- The file may only override the **role → default mode** map.
  Modes themselves are closed enum (`skip`, `light`,
  `standard`, `strict`).
- The file ships at `math/.protocol.yaml` (not at the repo
  root) so it stays inside the `math/` packet surface.
- The packet stays at `lifecycle: sketch` until at least one
  adopter uses the file and a downstream `core/verify.sh`
  check is added.
- The canonical matrix in `core/decision-modes.md` remains
  authoritative; the file is an override, not a fork.

## Assumptions

```yaml
task_id: protocol-tuning-as-packet
assumptions:
  - id: A1
    statement: "A per-repo override file is the lightest mechanism that lets adopters shift role defaults without forking core/decision-modes.md"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      Three alternatives were weighed: (a) per-request
      override (`# mode:`), which is per-call ceremony;
      (b) env var (`MATH_CODING_DEFAULT_MODE`), which is
      per-session and per-shell, not per-repo; (c) fork the
      matrix, which violates the single-source-of-truth
      invariant from `core/decision-modes.md`. The YAML file
      wins on locality and auditability.
      See: core/decision-modes.md

  - id: A2
    statement: "Keeping the 4-mode enum closed prevents convention fork via the override file"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      If `math/.protocol.yaml` could add a 5th mode, each
      repo would invent its own dialect and the verifier
      could not reason about mode coverage. Closing the
      enum makes the file an override of defaults, not a
      redefinition of the policy space.
      See: core/packet-schema.md (decision enum)

  - id: A3
    statement: "Opt-in semantics (absence = canonical matrix) keep the file from becoming a load-bearing dependency for the convention itself"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      The convention repo (this repo) does not need the file;
      it ships the canonical matrix. The file is for
      downstream adopters. If `core/verify.sh` required the
      file to exist, the convention would self-block.
      See: core/verify.sh

  - id: A4
    statement: "Packet lifecycle 'sketch' signals that the file shape may evolve before adoption pressure locks it"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      `core/packet-schema.md` lists `sketch` for new packets
      before verification. Promoting to `working` requires
      at least one downstream check, which this packet does
      not yet have.
      See: core/packet-schema.md#defaults

  - id: A5
    statement: "drift_threshold_days: 90 is a reasonable first default — long enough to avoid noise, short enough that drift surfaces within a quarter"
    status: agent-inferred
    epistemology: hypothesis
    confidence: 0.7
    evidence: |
      Conventional drift-detection windows in CI are 30/60/90
      days. 90 days lines up with a quarter, which is the
      smallest unit that still survives a release cycle. The
      field exists in the YAML but no verifier reads it in
      `sketch` lifecycle.
      See: math/think-before-do-as-packet/refinement.md
```

## Refinement

# Refinement: protocol-tuning

#convention
## State

- **pre**: every repo adopting math-coding is bound to the
  one canonical 4×5 matrix in `core/decision-modes.md`.
  Adopters either fork the matrix (breaking single source of
  truth) or override with `# mode:` on every request
  (ceremony).
- **post**: an optional `math/.protocol.yaml` lets a repo
  shift role defaults locally, without forking the matrix.
  Absence means the canonical matrix applies. The packet
  stays at `lifecycle: sketch` until an adopter and a
  verifier check land.

## Operation

- Add `math/.protocol.yaml` as the OS override file (this
  packet authorises it; the file is OS-level protocol
  metadata, not a packet).
- Add `math/protocol-tuning-as-packet/` with the 5 standard
  files (this packet is the canonical doc).
- Append one row `D35` to `core/coverage.yaml` recording
  this axis as a low-severity roadmap decision.

## Mapping (spec → impl)

| Spec                            | Impl                                  |
|---------------------------------|----------------------------------------|
| Optional override file          | `math/.protocol.yaml` (OS)            |
| File shape and semantics        | `math/protocol-tuning-as-packet/`     |
| Mode enum remains closed        | YAML file may only override defaults  |
| Adoption recorded               | `core/coverage.yaml` D35 row          |

## Invariant preservation

- `core/decision-modes.md` is unchanged; it remains the
  authoritative spec.
- `core/verify.sh` does not require the file to exist; it
  checks packet structure only.
- Modes stay a closed enum (`skip`, `light`, `standard`,
  `strict`). The YAML file cannot introduce a 5th mode.
- The packet lifecycle is `sketch`, matching the opt-in
  posture.

## Test obligation

- `math/.protocol.yaml` exists with `version: 1` and the
  three blocks (`defaults`, `overrides`,
  `applications_required_for`).
- The new packet has all 5 files; `core/verify.sh` returns
  VERIFIED.
- `core/coverage.yaml` has the new `D35` row.
- `AGENTS.md` does not need editing (the file is OS, not a
  manifest; mention deferred until promotion out of
  `sketch`).

## Runtime check

- An agent reading `math/.protocol.yaml` may use its
  `defaults.role` and `defaults.mode` as the session
  starting state, falling back to the canonical matrix when
  the field is absent.
- The YAML's `drift_threshold_days` is informational in
  `sketch`; no CI hook reads it yet.
- A request-level `# mode: <mode>` still wins over both the
  YAML and the canonical matrix.

## Cross-reference

Canonical spec: `core/decision-modes.md`. The per-repo
override file is documented here; the convention itself
(this repo) does not ship the file. `core/coverage.yaml:D35`
records this packet as the decision owner.

