# Agent protocol


You are in a math-coding repository.

## Read first

1. `README.md`
2. `core/think-before-do.md`
3. `core/decision-modes.md`
4. `math/<latest-decision>/decision.md`

## Principle

Think before Do. Model (packet) precedes code. Track every
non-trivial commit in `packet.yaml:applications[]`.
See `core/think-before-do.md`.

## Modes (override with `# mode: <mode>`)

- `skip`     typo — direct commit
- `light`    small bug — commit + 1-line rationale
- `standard` new feature — `math/<name>/` packet + code
- `strict`   architecture — standard + applications + theory

Default role: developer→standard, designer/PM→light,
researcher→strict, tech-writer→skip.

## When you decide something

`sh core/init-packet.sh <name>` creates 5 files in `math/<name>/`:
`packet.yaml` (incl. `applications: []`), `decision.md` (thesis/
antithesis/synthesis), `task.md` (problem/outcome/constraints),
`assumptions.yaml` (3+ entries), `refinement.md`.

## When you change a previous decision

Open a NEW packet with `supersession:` pointing at the old
one. Append the new commit to the new packet's `applications[]`.

## Assumption fields

`id` (`A\d+`), `statement`, `status` (user-confirmed|agent-inferred|
open), `epistemology` (fact|hypothesis|judgment|unknown), `confidence`
(0-1; fact/hypothesis only), `evidence` (+ `See: packet:<path>` or
`See: core/theories/<n>.md`).

## Brownfield

In existing projects, most files are OS. Convention adds
`math/` and `applications[]`-audit; preserves the rest.

## Strict rules

Outside `math/` is OS, authorized by a packet. Names are
descriptive. This protocol grows only when needed.

## Configuration: `.mathrc`

Project-local `./.mathrc` (overrides user-global `~/.mathrc`).
Loaded by `core/mathrc.sh`. Tool behaviour comes from these
keys:

- `mode` (skip|light|standard|strict) — default agent mode
- `role` (developer|designer|product-manager|researcher|tech-writer)
- `drift_threshold_days` — applications[] drift threshold
- `obsidian_*` — Obsidian interop knobs (see `core/obsidian.md`)
- `probe_*` — verifier/probe behaviour
- `tag_policy` — convention | free
- `excludes` — comma-separated glob skips for verifier

Read `.mathrc.example` for the full schema. To change mode
per session: `# mode: <mode>` in request, overrides .mathrc.

