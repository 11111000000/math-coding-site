# coverage-dedup

#convention
## Thesis

`core/coverage.yaml` lists every convention decision with a
stable `D-NN` id. Two snapshots of the file had been appended
without coordinating ids, producing collisions: D40, D50, D51,
D52, D53 each appear twice. A stable id is unusable if it has
two meanings — readers cannot cite D51 without disambiguating.

## Antithesis

Three ways to fix:

- **Delete the duplicates**: keep only the original entries
  (line 246 D40; older D50/D51/D52/D53 if they exist).
  Problem: the newer entries (line 327+) carry **finer**
  data — correct packet refs (`friction-*`), precise file
  paths, accurate severity (`medium`). Deleting them loses
  information.
- **Rewrite the older block to match the newer**: merges
  but erases the historical Phase D context for D38–D42.
  Loses the "Phase D axes shipped directly" narrative in
  the file's section header.
- **Renumber the duplicates**: keep both blocks intact,
  give the newer duplicates D55–D60. Preserves both
  contexts, fixes the citation problem.

## Synthesis

Choice: renumber. The newer duplicates (lines 327–347 in
HEAD) become D55 (project-config), D56 (excludes), D57
(fill-many), D58 (append-application), D59 (Coq substrate
reformulation). The block-comment above the renumbered block
gets a one-line note that these are friction-packet refinements
of earlier D-ids. `core/verify.sh` continues to count checks
unchanged because coverage.yaml is not parsed for ids — only
human-readable. The de-duplication is a fix without schema
change.

What this packet commits to:
- core/coverage.yaml has 0 duplicate ids after this commit.
- All renumbered entries preserve packet, location, severity,
  title fields verbatim from the duplicates.
- Section ordering preserved: Phase D block ends at D42,
  then Phase E+ (D43+) continues; renumbered entries sit
  at the tail with their own section header.

What this packet does NOT commit to:
- Adding a JSON Schema for coverage.yaml (deferred).
- Migrating coverage.yaml to a packet of its own kind
  (it remains OS, authorized by `coverage-as-packet`).
- Renaming the originals (D38–D42 stay as-is).

`See: math/coverage-as-packet/decision.md`
`See: core/coverage.yaml`

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/coverage-dedup/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/coverage-dedup/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/coverage-dedup/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/coverage-dedup/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/coverage-dedup/packet.yaml)

## Decision

#convention
## Thesis
`core/coverage.yaml` lists every convention decision with a
stable `D-NN` id. Two snapshots of the file had been appended
without coordinating ids, producing collisions: D40, D50, D51,
D52, D53 each appear twice. A stable id is unusable if it has
two meanings — readers cannot cite D51 without disambiguating.
## Antithesis
Three ways to fix:
- **Delete the duplicates**: keep only the original entries
  (line 246 D40; older D50/D51/D52/D53 if they exist).
  Problem: the newer entries (line 327+) carry **finer**
  data — correct packet refs (`friction-*`), precise file
  paths, accurate severity (`medium`). Deleting them loses
  information.
- **Rewrite the older block to match the newer**: merges
  but erases the historical Phase D context for D38–D42.
  Loses the "Phase D axes shipped directly" narrative in
  the file's section header.
- **Renumber the duplicates**: keep both blocks intact,
  give the newer duplicates D55–D60. Preserves both
  contexts, fixes the citation problem.
## Synthesis
Choice: renumber. The newer duplicates (lines 327–347 in
HEAD) become D55 (project-config), D56 (excludes), D57
(fill-many), D58 (append-application), D59 (Coq substrate
reformulation). The block-comment above the renumbered block
gets a one-line note that these are friction-packet refinements
of earlier D-ids. `core/verify.sh` continues to count checks
unchanged because coverage.yaml is not parsed for ids — only
human-readable. The de-duplication is a fix without schema
change.
What this packet commits to:
- core/coverage.yaml has 0 duplicate ids after this commit.
- All renumbered entries preserve packet, location, severity,
  title fields verbatim from the duplicates.
- Section ordering preserved: Phase D block ends at D42,
  then Phase E+ (D43+) continues; renumbered entries sit
  at the tail with their own section header.
What this packet does NOT commit to:
- Adding a JSON Schema for coverage.yaml (deferred).
- Migrating coverage.yaml to a packet of its own kind
  (it remains OS, authorized by `coverage-as-packet`).
- Renaming the originals (D38–D42 stay as-is).

## Task

# coverage-dedup

#convention
## Problem

`core/coverage.yaml` has duplicate decision-ids. Reading any
`D50`, `D51`, `D52`, `D53`, or `D40` in human-readable docs
leaves the reader guessing which entry applies. This breaks
the convention's own use of coverage as a stable
`See: coverage:D50`-style cross-reference target.

## Desired outcome

- All five duplicate ids (D40, D50, D51, D52, D53) are unique
  in HEAD after this packet.
- The renumbered entries (friction-packets, refined Coq) sit
  at the tail of the file with their own section header, so
  future readers can see what was added when.
- `sh core/verify.sh` returns VERIFIED.
- `summary.by_packet` counts are unchanged or more accurate
  (no decision is lost).

## Constraints

- Mode: `standard` (structural edit on a convention-OS file).
- No content change other than the id column; titles, locations,
  severities, packet refs stay verbatim.
- The original D38–D42 Phase D entries are untouched.
- The Phase E+ section continues uninterrupted by D55+.
- `summary.by_severity` and `summary.by_packet` counts
  re-derived after the renumber.

## Out of scope

- Editing the originals (Phase D + Phase E+ are fine).
- Renaming the project to v0.7 (this packet is mechanical).
- Adding verification for unique ids (deferred to
  `math/coverage-as-packet` Phase F).

## Approach

1. Identify the duplicate block (lines 327–347 in HEAD).
2. Renumber entries in that block:
   - D50 → D55 (project-config)
   - D51 → D56 (excludes)
   - D52 → D57 (fill-many)
   - D53 → D58 (append-application)
   - D40 → D59 (Coq substrate reformulation)
3. Add a section header above them: `# ─── friction-packet
   refinements (D55-D59) ───────`.
4. Re-derive `summary.by_severity` and `summary.by_packet`.
5. Run `sh core/verify.sh`.

## Assumptions

```yaml
task_id: coverage-dedup
assumptions:
  - id: A1
    statement: "coverage.yaml is parsed only for presence by core/verify.sh, not for id uniqueness"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      core/verify.sh checks coverage.yaml exists and is valid YAML
      but does not enforce unique decision-ids. The duplicate-ids
      therefore do not fail the build; they fail humans.
      See: core/verify.sh
      See: packet:coverage-as-packet/refinement.md

  - id: A2
    statement: "The duplicate-block (lines 327-347) was appended without re-numbering"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      Git history shows coverage.yaml grew through multiple
      append cycles: Phase E+ additions, then friction-packet
      additions. The appends reused existing ids because the
      original author was not aware of the high-number tail.
      See: git log -- core/coverage.yaml

  - id: A3
    statement: "Renumbering is preferred over deletion when both entries carry unique information"
    status: judgment
    epistemology: judgment
    evidence: |
      The duplicate-block entries name distinct packets
      (friction-excludes, friction-fill-many, etc.) that did
      not exist when the originals (D50-D53 in the Phase D
      block) were authored. Deleting either side loses a
      documented decision.
      See: packet:coverage-dedup/decision.md#synthesis

  - id: A4
    statement: "Section headers in coverage.yaml do not affect verifier behaviour"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Verified by reading core/verify.sh and core/lint-extract.sh
      routines that touch coverage.yaml — they do not match on
      section comment patterns.
      See: core/verify.sh

  - id: A5
    statement: "summary.by_severity and summary.by_packet counts can be re-derived by counting ids"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      The summary block is read by Dataview + the verifier
      info-level checks, both of which compare counts to
      the ids list. Re-derivation is mechanical: recount
      after renumber.
      See: core/coverage.yaml#summary

  - id: A6
    statement: "D55-D59 are available (none of them currently used in the file)"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      grep on core/coverage.yaml returns no id matching
      ^\s*- id: D5[5-9]\s*$ before the renumber.
      See: core/coverage.yaml
```

## Refinement

# Refinement: coverage-dedup

#convention
## State

- **pre**: `core/coverage.yaml` lists D40, D50, D51, D52, D53
  twice each. Citations like `See: coverage:D51` are
  ambiguous. The Phase E+ block (D43+) and the friction-packet
  append-block (D50/D51/D52/D53 duplicates + D40 reformulation)
  co-exist without coordination.
- **post**: All ids in `coverage.yaml` are unique. The
  friction-packet refinements are renumbered D55–D59 and
  sit in their own section at the tail of the file. Phase D
  block (D38–D42) and Phase E+ block (D43–D54) are unchanged.

## Operation

- Renumber in `core/coverage.yaml`:
  - duplicate block line ~327 `D50` → `D55` (`project-config`)
  - duplicate block line ~332 `D51` → `D56` (`friction-excludes`)
  - duplicate block line ~337 `D52` → `D57` (`friction-fill-many`)
  - duplicate block line ~342 `D53` → `D58` (`friction-append-application`)
  - duplicate block line ~347 `D40` → `D59` (Coq substrate
    reformulation)
- Insert section header above them: 
  `# ─── Friction-packet refinements (D55-D59) ───────────`.
- Re-derive `summary.by_severity` counts (5 entries moved
  between sections, severity unchanged; counts unchanged
  except totals).
- Re-derive `summary.by_packet`: 4 entries leave
  by_packet.os=0 if they were OS, gain `friction-*-as-packet`
  / `project-config-as-packet` / Coq-as-packet in documented.
  Counts shift accordingly.
- Append commit SHA to this packet's `applications[]`.
- Run `sh core/verify.sh`. Expect VERIFIED.

## Invariant

- `coverage.yaml` ids are unique: no `id: <D-NN>` appears
  more than once.
- Phase D block (D38–D42) byte-equal to pre-commit.
- Phase E+ block (D43–D54) byte-equal to pre-commit.
- `summary.by_severity` totals equal pre-commit totals.
- `summary.by_packet.documented` increases by 5; `gap`
  remains 0.

## Test obligation

- `grep -c '^\s*- id: D' core/coverage.yaml` returns 53
  (was 53, no change in count; but uniqueness guarantee now
  holds by inspection).
- `grep -E '^\s*- id: D(40|50|51|52|53)$' core/coverage.yaml`
  returns each id exactly once.
- `sh core/verify.sh` VERIFIED.

## Runtime check

- None: static data integrity fix.
- `core/extract-packet.sh` and `core/lint-extract.sh` should
  continue to round-trip the same packets (no packet was added,
  moved, or removed; only `core/coverage.yaml` bytes).

