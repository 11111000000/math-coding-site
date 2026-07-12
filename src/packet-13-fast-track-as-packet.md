# fast-track — decision modes × role-aware defaults

#convention
## Thesis

A single protocol applied uniformly to every user request is
either too heavy (every typo requires a packet) or too loose
(every architectural change passes through `light` mode). math-coding
needs a small mode dial so agents can pick the lightest
discipline that still preserves the convention's invariants.

## Antithesis

More rules means more confusion. If agents have to choose a
mode on every request, the chosen mode becomes theatre.
Conversely, zero choice means vibe-coding slips back in for
small edits. The dial must be small (4 modes, 5 role
defaults) and explicit (a runtime manifest, not just
instructions).

## Synthesis

The convention adopts:

- **4 decision modes**: `skip`, `light`, `standard`, `strict`.
- **5 role presets**: `developer`, `designer`,
  `product-manager`, `researcher`, `tech-writer`.
- Each role defaults to a mode; users override with
  `# mode: strict` in the request.

This packet authorises `core/decision-modes.md` as the OS
runtime manifest — same pattern as
`core/think-before-do.md` — and surfaces the matrix in both
`agents.md` (terse, ≤50 lines) and the longer `core/decision-modes.md`.

## What this packet commits to

- A 4×5 mode×role matrix that is the convention's
  default decision-policy.
- The runtime manifest `core/decision-modes.md` exists and
  stays in sync with `agents.md`.
- Users can override the role default by writing
  `# mode: <mode>` at the top of any request.

## What this packet does NOT commit to

- Per-repo protocol tuning files (`math/.protocol.yaml`,
  etc.) — covered as a future axis in this packet's
  `refinement.md` and tracked in `core/coverage.yaml` as a
  roadmap item.
- Per-user customisation; one matrix is enough to start.
- Auto-detection of role from prompts (the user names it
  once on first interaction).

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/fast-track-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/fast-track-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/fast-track-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/fast-track-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/fast-track-as-packet/packet.yaml)

## Decision

#convention
## Thesis
A single protocol applied uniformly to every user request is
either too heavy (every typo requires a packet) or too loose
(every architectural change passes through `light` mode). math-coding
needs a small mode dial so agents can pick the lightest
discipline that still preserves the convention's invariants.
## Antithesis
More rules means more confusion. If agents have to choose a
mode on every request, the chosen mode becomes theatre.
Conversely, zero choice means vibe-coding slips back in for
small edits. The dial must be small (4 modes, 5 role
defaults) and explicit (a runtime manifest, not just
instructions).
## Synthesis
The convention adopts:
- **4 decision modes**: `skip`, `light`, `standard`, `strict`.
- **5 role presets**: `developer`, `designer`,
  `product-manager`, `researcher`, `tech-writer`.
- Each role defaults to a mode; users override with
  `# mode: strict` in the request.
This packet authorises `core/decision-modes.md` as the OS
runtime manifest — same pattern as
`core/think-before-do.md` — and surfaces the matrix in both
`agents.md` (terse, ≤50 lines) and the longer `core/decision-modes.md`.
## What this packet commits to
- A 4×5 mode×role matrix that is the convention's
  default decision-policy.
- The runtime manifest `core/decision-modes.md` exists and
  stays in sync with `agents.md`.
- Users can override the role default by writing
  `# mode: <mode>` at the top of any request.
## What this packet does NOT commit to
- Per-repo protocol tuning files (`math/.protocol.yaml`,
  etc.) — covered as a future axis in this packet's
  `refinement.md` and tracked in `core/coverage.yaml` as a
  roadmap item.
- Per-user customisation; one matrix is enough to start.

## Task

# fast-track — task

#convention
## Problem

math-coding's protocol is rich (5 files per packet,
assumption markers, theory references). Applying the full
protocol to every micro-edit slows non-developers and
produces ceremony. Ignoring the protocol for "trivial"
changes loses recursive observability.

## Desired outcome

A two-axis policy:

1. Four decision modes (`skip`, `light`, `standard`, `strict`)
   that select required artifacts.
2. Five role presets that pick a sane default mode per
   requester.

Both axes live in `core/decision-modes.md` (OS) and a
compressed version lives in `agents.md`. Override with
`# mode: <mode>` in the request.

## Constraints

- `agents.md` stays ≤ 50 lines; the full matrix fits in
  `core/decision-modes.md`.
- The default per role is set by the user on first
  interaction; agents may ask once.
- Override mode sticks for the rest of the session unless
  re-declared.
- Roles are not enforced — they are defaults. A `developer`
  may explicitly ask for `light`.

## Assumptions

```yaml
task_id: fast-track-as-packet
assumptions:
  - id: A1
    statement: "Four discrete modes cover the spectrum from no-claim edits to architectural decisions without leaving gaps"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      The spectrum is: no claim → small claim → claim with
      packet → claim with packet + theory reference. Four
      modes line up with three boundaries (no artifact, 1-line
      rationale, packet, packet + applications + theory).
      See: core/decision-modes.md

  - id: A2
    statement: "Five role defaults sample the use-cases (dev, design, PM, research, writing) without fragmenting the matrix"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      Five covers the common roles without combinatorial
      explosion. Adding more roles later is a small extension.
      See: core/decision-modes.md

  - id: A3
    statement: "Explicit override (# mode: <mode>) is preferable to silent inference at the cost of one extra line per request"
    status: judgment
    epistemology: judgment
    evidence: |
      Inference from prompts is brittle; one explicit line
      per request is cheap. The cost aligns with the
      principle "be epistemically honest" (epistemic-as-packet).
      See: packet:theory-epistemic-as-packet/refinement.md

  - id: A4
    statement: "Mode choice is per-request; the session does not chain defaults silently"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      Without re-declaration, the previous mode would carry
      over, hiding user's intent from the agent. Re-declare
      on each request that needs a different mode.
      See: agents.md (the runtime README, forthcoming section)

  - id: A5
    statement: "think-before-do principle still applies in skip and light modes (no claim → no packet needed; small claim → packet optional)"
    status: judgment
    epistemology: judgment
    evidence: |
      Think before Do is the load-bearing principle, not the
      packet protocol. Even a `skip` commit honours it — it
      simply represents a claim-free edit.
      See: packet:think-before-do-as-packet/decision.md
```

## Refinement

# Refinement: fast-track

#convention
## State

- **pre**: every user request is funnelled into the full
  packet protocol. Agents slow down on small edits; users
  learn to skip the protocol for trivial changes, losing
  observability.
- **post**: a 4×5 mode×role matrix lives in
  `core/decision-modes.md`; `AGENTS.md` mentions the modes;
  requests can override with `# mode: <mode>`.

## Operation

- Create `core/decision-modes.md` (this packet authorises it
  as OS)
- Add a "Modes" section to `AGENTS.md` (terse)
- Update `agents-md-as-packet/refinement.md` to mention the
  new manifest

## Mapping (spec → impl)

| Spec                            | Impl                                  |
|---------------------------------|----------------------------------------|
| 4 modes × 5 role defaults       | `core/decision-modes.md`              |
| terse mention                   | `AGENTS.md` "Modes" section          |
| request override syntax         | `# mode: <mode>` line in user prompt  |

## Invariant preservation

- `AGENTS.md` stays ≤ 50 lines (counted with the new modes)
- `core/verify.sh` does not need changes for this packet
- mode choice is observable in the git commit message (the
  `# mode:` line is preserved by convention authors)

## Test obligation

- `wc -l AGENTS.md` ≤ 50
- `core/decision-modes.md` exists with all 4 modes and 5
  roles
- The full matrix renders without row/column overlap

## Runtime check

- The agent logs the chosen mode at the start of each
  response (one short line)
- Convention authors may set `MATH_CODING_DEFAULT_MODE` to
  override the role default for a session (Phase D+)

## Future axis (recorded, not implemented)

`math/.protocol.yaml` — a per-repo tuning file — would let
projects shift role defaults. Deferred to Phase D; tracked
here so the convention's roadmap is visible in one read.

## Cross-reference

Canonical spec: `core/decision-modes.md`. The matrix is the
authoritative policy table; `AGENTS.md` is a summary.
`core/coverage.yaml:D30` and `D31` record this packet as the
decision owner.

