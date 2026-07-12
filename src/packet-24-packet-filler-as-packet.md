# packet-filler — collapse the 5-file-per-packet interaction model into 1 call

#convention
## Thesis

Each `math/<name>/` packet requires 5 files
(packet.yaml, decision.md, task.md, assumptions.yaml,
refinement.md). Convention says: maintain this shape.
Practice says: writing 5 files by hand is friction.

The agent-as-runtime model (Phase C, D7) already runs LLM
calls in this very session. The LLM can produce the 5-file
output in one structured response. We need a **passive
deployer** that takes the LLM's spec output and writes it
as 5 files matching the convention.

## Antithesis

Two failure modes:

- **Passive deployer with no LLM** — Agent still produces
  one spec, runs deployer, gets 5 files. Works, but agent
  has to render markdown well.
- **Active LLM caller inside convention** — Convention
  becomes dependent on a specific LLM vendor. Violates D02
  (no frameworks / external deps) and dilutes the
  convention's authority.

The right answer is the boundary: convention has a deployer
that accepts a YAML spec. The agent has the LLM. Neither
crosses into the other.

## Synthesis

`core/packet-filler.sh` is a POSIX shell script that:

1. Reads a YAML spec from stdin (`--from-stdin`) or file
   (`--from-file spec.yaml`)
2. Validates that required sections exist (`decision`,
   `task`, `assumptions`, `refinement`)
3. Writes 5 files into `math/<id>/`
4. Updates `packet.yaml` with lifecycle: sketch, decision:
   needed, created: today, depends_on: []

Usage:

```
# LLM emits spec.yaml in one call
sh core/packet-filler.sh <packet-id> --from-file spec.yaml
```

That's it. **1 LLM call + 1 tool call = 1 packet**.

`core/packet-spec-schema.md` defines the spec.yaml format.
`core/packet-schema.md` gains a "source-of-truth declaration"
section: packet.yaml remains the structured source of truth;
the 4 .md files are derived human/Obsidian-friendly
projections.

## What this packet commits to

- `core/packet-filler.sh` exists, POSIX shell only
- `core/packet-spec-schema.md` defines the spec format
- Spec → 5 files is idempotent (running twice yields same
  files modulo timestamps in packet.yaml)
- Filler refuses to overwrite an existing packet unless
  `--force` is passed
- Filler exits non-zero on YAML parse error or missing
  required sections

## What this packet does NOT commit to

- A round-trip guarantee from 5 .md files back to spec.yaml
  (out of scope; LLM writes spec, filler deploys)
- An LLM API inside the convention (the LLM lives in the
  agent, not the convention)
- Auto-fill of `applications[]` (the agent appends its own
  commit SHA after the packet is committed)
- Verification of semantic accuracy (verifier remains
  structural only; agent reviews its own output before
  filling)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/packet-filler-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/packet-filler-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/packet-filler-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/packet-filler-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/packet-filler-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Each `math/<name>/` packet requires 5 files
(packet.yaml, decision.md, task.md, assumptions.yaml,
refinement.md). Convention says: maintain this shape.
Practice says: writing 5 files by hand is friction.
The agent-as-runtime model (Phase C, D7) already runs LLM
calls in this very session. The LLM can produce the 5-file
output in one structured response. We need a **passive
deployer** that takes the LLM's spec output and writes it
as 5 files matching the convention.
## Antithesis
Two failure modes:
- **Passive deployer with no LLM** — Agent still produces
  one spec, runs deployer, gets 5 files. Works, but agent
  has to render markdown well.
- **Active LLM caller inside convention** — Convention
  becomes dependent on a specific LLM vendor. Violates D02
  (no frameworks / external deps) and dilutes the
  convention's authority.
The right answer is the boundary: convention has a deployer
that accepts a YAML spec. The agent has the LLM. Neither
crosses into the other.
## Synthesis
`core/packet-filler.sh` is a POSIX shell script that:
1. Reads a YAML spec from stdin (`--from-stdin`) or file
   (`--from-file spec.yaml`)
2. Validates that required sections exist (`decision`,
   `task`, `assumptions`, `refinement`)
3. Writes 5 files into `math/<id>/`
4. Updates `packet.yaml` with lifecycle: sketch, decision:
   needed, created: today, depends_on: []
Usage:
```
# LLM emits spec.yaml in one call
sh core/packet-filler.sh <packet-id> --from-file spec.yaml
```
That's it. **1 LLM call + 1 tool call = 1 packet**.
`core/packet-spec-schema.md` defines the spec.yaml format.
`core/packet-schema.md` gains a "source-of-truth declaration"
section: packet.yaml remains the structured source of truth;
the 4 .md files are derived human/Obsidian-friendly
projections.
## What this packet commits to
- `core/packet-filler.sh` exists, POSIX shell only
- `core/packet-spec-schema.md` defines the spec format
- Spec → 5 files is idempotent (running twice yields same
  files modulo timestamps in packet.yaml)
- Filler refuses to overwrite an existing packet unless
  `--force` is passed
- Filler exits non-zero on YAML parse error or missing
  required sections
## What this packet does NOT commit to
- A round-trip guarantee from 5 .md files back to spec.yaml
  (out of scope; LLM writes spec, filler deploys)
- An LLM API inside the convention (the LLM lives in the
  agent, not the convention)
- Auto-fill of `applications[]` (the agent appends its own
  commit SHA after the packet is committed)
- Verification of semantic accuracy (verifier remains

## Task

# packet-filler — task

#convention
## Problem

Creating a packet today requires: create 5 files via
init-packet.sh (templates), edit each via 4-5 separate
LLM-tool calls. Total: 5-6 tool round-trips per packet.

For a convention of 38+ packets, this friction has already
slowed growth. New contributors hand-write 5 files and
likely skip coverage or wikilinks.

A LLM is sitting in this session. It can produce one
structured YAML output covering all 5 files. Convention
needs a passive deployer that consumes that YAML and writes
the 5 files exactly as convention expects.

## Desired outcome

- `core/packet-filler.sh <packet-id> --from-file spec.yaml`
- Accepts a single YAML describing decision, task,
  assumptions, refinement
- Writes 5 files into `math/<packet-id>/`
- Updates `packet.yaml` with the conventional manifest fields
- Idempotent on rerun (with `--force` if files exist)
- POSIT-shell only, no external deps

## Constraints

- Refuses to overwrite existing packet without `--force`
- Fails (exit 1+) on missing sections or invalid YAML
- `packet.yaml:applications[]` left as `[]` (agent appends
  after committing)
- No new external dependencies
- Filler does NOT call any LLM API — purely passive deployer

## Assumptions

```yaml
task_id: packet-filler
assumptions:
  - id: A1
    statement: "An LLM can produce structured YAML describing all 5 files of a packet in one response"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      LLMs (Claude, GPT, opencode, Ollama) reliably emit
      YAML when prompted with a schema. Schema is small:
      4 sections (decision, task, assumptions, refinement).
      See: core/packet-spec-schema.md

  - id: A2
    statement: "POSIX shell + AWK can parse simple multi-document YAML sections without a YAML library"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      The spec schema is line-oriented: `key: value`,
      indented lists, `|` block scalars. AWK handles
      these without external deps.
      See: core/init-packet.sh (existing sh + AWK patterns)

  - id: A3
    statement: "packet.yaml remains the source of truth even when 5 files coexist"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      packet.yaml holds lifecycle, substrate, rigor, depends_on,
      applications[], verifier — structured fields. The 4
      .md files hold prose. They are projections of
      packet.yaml, not vice versa.
      See: core/packet-schema.md (extended by this packet)

  - id: A4
    statement: "The filler refusing to overwrite without --force prevents accidental data loss"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Convention's edit protocol (D27) forbids in-place
      edits. Filler must enforce the same rule.
      See: math/math-coding-birth/refinement.md#edit-protocol

  - id: A5
    statement: "One LLM-call + one tool-call is achievable with the current agent-runtime setup"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      In this very session, the agent already produces
      multi-file outputs via tool calls. The filler tool
      is one more tool, invoked once after one LLM call.
      See: agent-as-packet/decision.md
```

## Refinement

# Refinement: packet-filler

#convention
## State

- **pre**: each new packet needs 5 manual edits; agent
  authoring is multi-tool-call; friction grows with
  convention size.
- **post**: `core/packet-filler.sh` deploys 5 files from one
  YAML spec; friction drops from 5 tool-calls to 1; the
  convention expands without proportional authoring cost.

## Operation

- Created `core/packet-filler.sh` (POSIX sh + AWK only)
- Created `core/packet-spec-schema.md` (the spec format)
- Updated `core/packet-schema.md` with "source-of-truth
  declaration" section
- Created `math/packet-filler-as-packet/` (5 files matching
  convention)
- Tested end-to-end with a dummy packet

## Mapping (artifact → convention axis)

| Artifact                          | Axis                                  |
|------------------------------------|----------------------------------------|
| `core/packet-filler.sh`           | D10 (multi-packet atomicity, partial)  |
| `core/packet-spec-schema.md`      | D10 schema declaration                |
| `core/packet-schema.md` extension  | D02 (5-file structure, source-of-truth)|
| this packet                       | D10 record                            |

## Invariant preservation

- 38 existing packets still pass `core/verify.sh` after
  commit
- `AGENTS.md` ≤ 60 lines (this packet does not touch it)
- Convention does NOT add LLM API as a dependency

## Test obligation

- `sh core/packet-filler.sh` exits non-zero without args
- `sh core/packet-filler.sh test-friction --from-file
  /tmp/spec.yaml` writes 5 files in `math/test-friction/`
- Filler refuses to overwrite existing packet without
  `--force`
- YAML missing required sections → exit 2
- After running on a test packet, `sh core/verify.sh`
  still returns VERIFIED (1 extra packet, fully conformant)

## Runtime check

- `core/probe.sh` is unchanged; this packet does not need a
  probe
- A convention author can `rm -rf math/test-friction/` after
  testing to keep the repo clean

## Cross-reference

Pairs with:

- `math/agent-as-packet/` (D32) — the agent's runtime; filler
  is its packet-creation tool
- `math/obsidian-visualization-as-packet/` (Phase D+ draft) —
  Deliverable 4 of that draft is now materialized by this
  packet
- `math/convention-agent-as-packet/` — D7's `core/agent.sh`
  now has a packet-creation tool to invoke
- `theory-refinement-as-packet/` — the 5-section refinement
  pattern that the filler preserves

