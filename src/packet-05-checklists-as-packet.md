# checklists — auto-generate per-packet checklists

#convention
## Thesis

Every packet has a `refinement.md:## Test obligation`
section. That section is a list of obligations the
convention author has committed to satisfy. A checklist is
just that list, formatted as checkboxes for humans to tick.
Until now, the obligation lived only in the prose of
refinement.md; humans had to copy it into a separate todo
list to track progress.

## Antithesis

Adding checklists as a new file per packet duplicates the
obligation. If the obligation in refinement.md and the
checklist diverge, the convention has two truths. Drift is
the risk.

## Synthesis

`core/generate-checklist.sh` reads refinement.md, extracts
the Test obligation section, and writes a checklist stub
under `core/checklists/<packet>.md`. The script is idempotent
— running it twice in a row yields the same file modulo
timestamps. The checklist is not a packet; it is an
auto-generated artifact that humans tick. As a result, there
is no drift: the checklist *is* the test obligation; the
script regenerates it on demand.

## What this packet commits to

- `core/generate-checklist.sh` is POSIX shell only
- One checklist per packet under `core/checklists/<packet>.md`
- The script can regenerate any single packet's checklist
- The script is part of the convention (verifier Phase D
  may add a structural check that every packet has a
  matching checklist)

## What this packet does NOT commit to

- Persistent state on the checklist (no checkmarks stored in
  git — humans track locally)
- A web view of checklists (Phase E+)
- Auto-completion of ticked items by the agent
- Linking checklists to lifecycle transitions (verified
  requires all items ticked? — out of scope for now)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/checklists-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/checklists-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/checklists-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/checklists-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/checklists-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Every packet has a `refinement.md:## Test obligation`
section. That section is a list of obligations the
convention author has committed to satisfy. A checklist is
just that list, formatted as checkboxes for humans to tick.
Until now, the obligation lived only in the prose of
refinement.md; humans had to copy it into a separate todo
list to track progress.
## Antithesis
Adding checklists as a new file per packet duplicates the
obligation. If the obligation in refinement.md and the
checklist diverge, the convention has two truths. Drift is
the risk.
## Synthesis
`core/generate-checklist.sh` reads refinement.md, extracts
the Test obligation section, and writes a checklist stub
under `core/checklists/<packet>.md`. The script is idempotent
— running it twice in a row yields the same file modulo
timestamps. The checklist is not a packet; it is an
auto-generated artifact that humans tick. As a result, there
is no drift: the checklist *is* the test obligation; the
script regenerates it on demand.
## What this packet commits to
- `core/generate-checklist.sh` is POSIX shell only
- One checklist per packet under `core/checklists/<packet>.md`
- The script can regenerate any single packet's checklist
- The script is part of the convention (verifier Phase D
  may add a structural check that every packet has a
  matching checklist)
## What this packet does NOT commit to
- Persistent state on the checklist (no checkmarks stored in
  git — humans track locally)
- A web view of checklists (Phase E+)
- Auto-completion of ticked items by the agent

## Task

# checklists — task

#convention
## Problem

Convention authors have a recurring workflow: read a packet,
check what it commits to, satisfy each obligation, mark the
packet verified. There is no machine-readable record of which
obligations have been satisfied so far; humans track this
externally.

## Desired outcome

A shell script that:

1. Walks every `math/<packet>/`
2. Reads `refinement.md`, extracts the `## Test obligation`
   section
3. Writes `core/checklists/<packet>.md` as a checklist stub

## Constraints

- POSIX shell only
- Idempotent (running twice yields same output modulo
  timestamp)
- No commit / no write to packets
- The output file is generated artifact (not part of any
  packet)

## Assumptions

```yaml
task_id: checklists
assumptions:
  - id: A1
    statement: "Every math/*/refinement.md has a '## Test obligation' section"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Convention's 5-section refinement.md template
      requires State / Operation / Mapping / Invariant /
      Test obligation / Runtime. All 32+ packets follow it.
      See: core/init-packet.sh (refinement.md template)

  - id: A2
    statement: "Auto-generation avoids drift; humans cannot mis-edit the checklist"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      If the checklist is regenerated on demand from
      refinement.md, the only source of truth is the
      refinement.md. Human edits are gitignored or
      overwritten next run.
      See: math/phase-c-harmony-as-packet/decision.md

  - id: A3
    statement: "Checklists are not packets — they have no lifecycle, no decisions"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      A checklist is the human's working view of an
      obligation. Treating it as a packet would force it
      through the 5-file convention, multiplying noise.
      See: math/recursive-check-as-packet/decision.md

  - id: A4
    statement: "Generated files are gitignored (or marked intentionally untracked)"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      Otherwise the convention accumulates 32+ checklist
      files per regeneration. Marking them as artifacts
      keeps the repo lean.
      See: .gitignore (forthcoming)

  - id: A5
    statement: "The script is read-only on packets; it only writes core/checklists/"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      The script's purpose is read-then-write-to-cache.
      Modifying packets would cross the line into authoring.
      See: math/self-as-probe-as-packet/refinement.md
```

## Refinement

# Refinement: checklists

#convention
## State

- **pre**: 32 packets each have a Test obligation in
  refinement.md, but no machine-readable checklist.
- **post**: `core/generate-checklist.sh` generates one
  checklist per packet from the existing refinement.md.

## Operation

- Created `core/generate-checklist.sh` (POSIX shell, ~50 lines)
- Created `core/checklists/` directory (output destination)
- Created `math/checklists-as-packet/` with 5 files
- Generated all 32+ checklists to demonstrate

## Mapping (artifact → convention axis)

| Artifact                       | Axis                  |
|--------------------------------|------------------------|
| `core/generate-checklist.sh`   | D8 (lazy checklists)  |
| `core/checklists/<packet>.md` | output artifacts      |
| refinement.md Test obligation  | source of truth       |

## Invariant preservation

- Checklists are generated artifacts, not packets
- The convention's 5-file pattern is unchanged for packets
- `sh core/verify.sh` returns VERIFIED after addition

## Test obligation

- `sh core/generate-checklist.sh` writes 32+ checklists
- Running twice yields the same files modulo timestamp
- `sh core/generate-checklist.sh theory-fsm-as-packet`
  writes one checklist

## Runtime check

- Humans run the script before they start a packet's
  obligations; they tick items locally; the script
  regenerates next time
- Optional: `.gitignore` lists `core/checklists/`

## Cross-reference

Pairs with `theory-refinement-as-packet` (5-section
template). The script reads the convention's own template.

