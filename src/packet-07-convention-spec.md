# convention-spec — single source of truth

#convention
## Thesis

Conventions drift when the same constants are duplicated
across files. The 5-field lifecycle FSM appears in
`core/packet-schema.md`, `core/coverage.yaml`, every
packet's refinement.md, and `core/verify.sh` enum-check
case. When the FSM gains a 7th state (say, `frozen`), four
files must be edited in lockstep, and any miss creates a
silent verifier that disagrees with the schema.

## Antithesis

Convention drift is small enough to ignore. Each piece of
duplication is a few lines. Editing four files is cheap. A
schema-and-script split is academic.

## Synthesis

A single `core/convention-spec.yaml` holds every enum,
counts, and structural constant. `core/spec.sh` parses it
to POSIX shell variables. `core/verify.sh`, `core/init-packet.sh`,
`core/packet-filler.sh`, and (indirectly) `core/install.sh`
consume the variables. Adding a 7th lifecycle state becomes
`+ - frozen` in one place; verifier and templates follow.

Pairs with:
- `core/verify.sh` — drift-check 4 (epistemic markers) and
  drift-check 6 (coverage.yaml id uniqueness) consume
  `SPEC_EPISTEMIC_MARKERS` and read `core/coverage.yaml`
  respectively.
- `core/install.sh` — already emits nested-YAML `.mathrc`;
  this packet makes `core/spec.sh --mathrc` available as
  the flat-format source for the install heredoc (used in a
  follow-up commit).

## What this packet commits to

- `core/convention-spec.yaml` exists and contains the
  enumeration of: required_packet_files (5 source),
  generated_packet_files (1 frontmatter),
  required_packet_fields (10 incl. `applications`),
  lifecycle_states (6), substrate_values (9),
  rigor_values (4), decision_values (2),
  epistemic_markers (5 incl. `proven`),
  verdict_outcomes (5), phases (5), agent_modes (4),
  agent_roles (5), mathrc_defaults (flat).
- `core/spec.sh` parses that YAML using POSIX shell + awk
  + sed only. Three output modes:
  - default: `SPEC_*` assignments for `eval`
  - `--mathrc`: flat `.mathrc` content
  - `--doc`: human-readable projection
- `core/verify.sh` reads `SPEC_*` enums for its
  lifecycle / substrate / rigor / decision / epistemic
  checks. Adding a marker to `convention-spec.yaml` adds
  it to the verifier with no code edit.
- Drift-check 6 (new): `core/coverage.yaml` has unique
  `id:` values.

## What this packet does NOT commit to

- A JSON Schema for coverage.yaml or packet.yaml.
- Per-project override of convention-spec (e.g., project
  adds its own epistemic marker). Single source, period.
- Wire-up of `core/init-packet.sh` to read
  `SPEC_EPISTEMIC_MARKERS` for its template generator
  (deferred to a follow-up — `init-packet.sh` still
  hardcodes 4 example assumptions).

`See: math/core-as-packet/decision.md`
`See: math/coverage-as-packet/refinement.md`

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/convention-spec/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/convention-spec/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/convention-spec/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/convention-spec/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/convention-spec/packet.yaml)

## Decision

#convention
## Thesis
Conventions drift when the same constants are duplicated
across files. The 5-field lifecycle FSM appears in
`core/packet-schema.md`, `core/coverage.yaml`, every
packet's refinement.md, and `core/verify.sh` enum-check
case. When the FSM gains a 7th state (say, `frozen`), four
files must be edited in lockstep, and any miss creates a
silent verifier that disagrees with the schema.
## Antithesis
Convention drift is small enough to ignore. Each piece of
duplication is a few lines. Editing four files is cheap. A
schema-and-script split is academic.
## Synthesis
A single `core/convention-spec.yaml` holds every enum,
counts, and structural constant. `core/spec.sh` parses it
to POSIX shell variables. `core/verify.sh`, `core/init-packet.sh`,
`core/packet-filler.sh`, and (indirectly) `core/install.sh`
consume the variables. Adding a 7th lifecycle state becomes
`+ - frozen` in one place; verifier and templates follow.
Pairs with:
- `core/verify.sh` — drift-check 4 (epistemic markers) and
  drift-check 6 (coverage.yaml id uniqueness) consume
  `SPEC_EPISTEMIC_MARKERS` and read `core/coverage.yaml`
  respectively.
- `core/install.sh` — already emits nested-YAML `.mathrc`;
  this packet makes `core/spec.sh --mathrc` available as
  the flat-format source for the install heredoc (used in a
  follow-up commit).
## What this packet commits to
- `core/convention-spec.yaml` exists and contains the
  enumeration of: required_packet_files (5 source),
  generated_packet_files (1 frontmatter),
  required_packet_fields (10 incl. `applications`),
  lifecycle_states (6), substrate_values (9),
  rigor_values (4), decision_values (2),
  epistemic_markers (5 incl. `proven`),
  verdict_outcomes (5), phases (5), agent_modes (4),
  agent_roles (5), mathrc_defaults (flat).
- `core/spec.sh` parses that YAML using POSIX shell + awk
  + sed only. Three output modes:
  - default: `SPEC_*` assignments for `eval`
  - `--mathrc`: flat `.mathrc` content
  - `--doc`: human-readable projection
- `core/verify.sh` reads `SPEC_*` enums for its
  lifecycle / substrate / rigor / decision / epistemic
  checks. Adding a marker to `convention-spec.yaml` adds
  it to the verifier with no code edit.
- Drift-check 6 (new): `core/coverage.yaml` has unique
  `id:` values.
## What this packet does NOT commit to
- A JSON Schema for coverage.yaml or packet.yaml.
- Per-project override of convention-spec (e.g., project
  adds its own epistemic marker). Single source, period.
- Wire-up of `core/init-packet.sh` to read
  `SPEC_EPISTEMIC_MARKERS` for its template generator
  (deferred to a follow-up — `init-packet.sh` still
  hardcodes 4 example assumptions).

## Task

# convention-spec — task

## Problem

Convention constants (packet file list, field list, enum
values, epistemic markers, phases) live in 4+ parallel
locations: `core/packet-schema.md`, `core/coverage.yaml`,
`core/verify.sh` enum cases, `core/packet-spec-schema.md`,
and prose in 30+ packet `refinement.md` files. When one
changes, the others drift silently — visible only to a
human comparing diffs across the repo.

## Desired outcome

A single YAML file is the source of truth. `core/verify.sh`
and `core/init-packet.sh` consume it through `eval`. Adding
a marker, substrate, or lifecycle state is a one-line YAML
edit; every script follows automatically.

## Constraints

- POSIX shell only. No external dependencies beyond
  POSIX-base utilities (`awk`, `sed`, `printf`, `grep`,
  `cut`, `tr`, `mktemp`).
- Existing `core/verify.sh` outputs (check counts,
  error messages) must not regress.
- All existing `sh core/verify.sh` callers must continue
  to pass without changes.
- Backwards-compatibility with previously-valid
  packet.yaml content is **not** required (per session
  decision: dropped).

`See: math/convention-spec/decision.md`

## Assumptions

```yaml
task_id: convention-spec
assumptions:
  - id: A1
    statement: "POSIX-shell + awk can parse a narrow YAML grammar (flat key: value plus indented list items)"
    status: user-confirmed
    epistemology: proven
    confidence: 1.0
    evidence: |
      End-to-end check: `eval "$(sh core/spec.sh)" && [ -n "$SPEC_LIFECYCLE_STATES" ]`
      passes, exporting $SPEC_LIFECYCLE_STATES='sketch working verified deprecated archived superseded'.
      See: core/spec.sh, core/verify.sh
      See: packet:convention-spec/refinement.md#operation

  - id: A2
    statement: "The 5+1 file distinction (5 source, 1 generated) is the right model for packets"
    status: agent-inferred
    epistemology: hypothesis
    confidence: 0.8
    evidence: |
      packet.frontmatter.md is auto-regenerated by generate-frontmatter.sh
      and consumed only by Obsidian's Dataview plugin (not the verifier).
      Pure source files are the structural invariant; generated
      frontmatter is a derived view.
      See: packet:dataview-as-packet/refinement.md

  - id: A3
    statement: "`proven` epistemic marker belongs in SPEC_EPISTEMIC_MARKERS"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      math-coding-birth/assumptions.yaml A4 already uses
      `epistemology: proven`. core/theories/epistemic.md declares 5
      markers. Spec drift until this packet: verifier regex
      `\\b(fact|hypothesis|judgment|unknown)\\b` excluded `proven`.
      See: core/theories/epistemic.md
      See: math/math-coding-birth/assumptions.yaml
```

## Refinement

# Refinement: convention-spec

#convention
## State

- **pre**: 50 packets, 12 theories, ~5 hardcoded enum
  duplicates in `core/verify.sh` and 4 hardcoded
  duplicates in `core/packet-schema.md`. Verifier
  silently excludes `proven` from epistemic check
  (`core/verify.sh:339`).
- **post**: 51 packets; one source-of-truth
  (`core/convention-spec.yaml`); verifier reads
  `SPEC_*` variables for all enum checks; drift-check 6
  enforces coverage.yaml id uniqueness.

## Operation

- `core/convention-spec.yaml` written: 12 sections
  (counts, packet structure, required fields, 4 enum
  sets, epistemic markers, verdicts, agent contracts,
  phases, mathrc_defaults).
- `core/spec.sh`: POSIX-shell + awk parser. Three
  output modes:
  - `eval "$(sh core/spec.sh)"` → SPEC_* variables
  - `sh core/spec.sh --mathrc` → flat `.mathrc` content
  - `sh core/spec.sh --doc` → markdown projection
- `core/verify.sh` modified:
  - `set -e` retained; load `core/spec.sh` first
    (defensive defaults for SPEC_* in case spec.sh fails)
  - required files/fields loop replaced with
    `for x in $SPEC_REQUIRED_PACKET_FILES`
  - lifecycle/substrate/rigor/decision checks converted
    from `case` to `grep -q` over space-separated list
  - drift-check 4 (epistemic) regex expanded via
    `SPEC_EPISTEMIC_MARKERS`
  - drift-check 6 (new): unique `id:` in coverage.yaml
- This packet (`math/convention-spec/`) created with
  5 files, lifecycle: working, decision: made,
  verifier: null. depends_on: math-coding-birth,
  core-as-packet, coverage-as-packet,
  project-config-as-packet, install-as-packet.

## Invariant preservation

- All `math/*/packet.yaml` files still parse: 1325
  pre-existing checks still pass (now 1385 after drift-check 6
  adds a unique-id check).
- `core/verify.sh` exit code behavior unchanged: 0 on
  VERIFIED, non-zero on NEEDS_REVISION.
- `core/spec.sh` exits 0 even if SPEC_FILE is missing
  (defensive defaults in `core/verify.sh`).
- `core/probe.sh` and `core/lint-extract.sh` are not
  modified; they consume `verify.sh` output indirectly.
- axiom A4 (`convention applies to itself`) remains
  candidate `proven`: this packet either closes drift-check 4
  honestly or surfaces an explicit NEEDS_REVISION
  verdict (current state: NEEDS_REVISION because
  `theory-epistemic-as-packet/refinement.md` does not
  mention `proven` while `epistemic.md` does — this is
  a real drift, not a verifier bug).

## Test obligation

- `sh core/spec.sh` exits 0; `eval "$(sh core/spec.sh)"`
  exports SPEC_* with non-empty values for every
  declared key.
- `sh core/spec.sh --mathrc` outputs flat `.mathrc`
  content that `core/mathrc.sh` parses (round-trip).
- `sh core/verify.sh` shows drift-check 4 surfacing
  the package/theory drift that was previously
  invisible.
- After this commit, `core/coverage.yaml` has 0
  duplicate ids once the existing D55/D56 duplicates
  are renumbered (deferred to a follow-up packet or
  housekeeping commit).

## Runtime check

None: static data + script change. After installing
in another project, `sh .math-coding/core/verify.sh`
on the target project reads the same `convention-spec.yaml`.

## Cross-reference

- `core/coverage.yaml:D09` ("12 mathematical theories")
  is wrong by 1 — now 12 theories (agent theory added
  in phase d). Listed for follow-up cleanup, not fixed
  in this commit (keeps the packet surgical).
- `core/install.sh` continues to emit nested-YAML
  `.mathrc` (this is a known bug, see
  `math/install-as-packet/`). The fix is in a follow-up
  packet; this packet only adds the **source** of
  flat defaults in `convention-spec.yaml`.

`See: math/convention-spec/decision.md`

