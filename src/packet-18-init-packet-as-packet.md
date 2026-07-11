# init-packet-as-packet — convention's packet creation tool

## Thesis

Every convention requires a way to create new packets. Without
init-packet.sh, convention authors must manually write 5 files
with correct structure. This is error-prone.

## Antithesis

A heavy tool (Python CLI, IDE integration) adds external
dependencies. Convention says POSIX shell only. A simple
shell script is sufficient: it creates the 5 files with
templates.

## Synthesis

core/init-packet.sh is a POSIX shell script that:
- Accepts packet-id and optional target directory
- Creates the 5 files with sensible templates
- Sets lifecycle: sketch, substrate: none, etc. (defaults)
- Writes to verifier-output.yaml stub if verifier present

Convention authors run it once per new packet, then edit the
content. The script ensures structural correctness; humans
provide content.

## What this packet commits to

- core/init-packet.sh exists, POSIX-only
- Creates 5 files with correct field structure
- Sets defaults matching convention

## What this packet does NOT commit to

- A complex CLI with multiple subcommands
- External tool integration
- Content generation (humans write content)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/init-packet-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/init-packet-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/init-packet-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/init-packet-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/init-packet-as-packet/packet.yaml)

## Decision

## Thesis
Every convention requires a way to create new packets. Without
init-packet.sh, convention authors must manually write 5 files
with correct structure. This is error-prone.
## Antithesis
A heavy tool (Python CLI, IDE integration) adds external
dependencies. Convention says POSIX shell only. A simple
shell script is sufficient: it creates the 5 files with
templates.
## Synthesis
core/init-packet.sh is a POSIX shell script that:
- Accepts packet-id and optional target directory
- Creates the 5 files with sensible templates
- Sets lifecycle: sketch, substrate: none, etc. (defaults)
- Writes to verifier-output.yaml stub if verifier present
Convention authors run it once per new packet, then edit the
content. The script ensures structural correctness; humans
provide content.
## What this packet commits to
- core/init-packet.sh exists, POSIX-only
- Creates 5 files with correct field structure
- Sets defaults matching convention
## What this packet does NOT commit to
- A complex CLI with multiple subcommands

## Task

# init-packet-as-packet — task

## Problem

Convention authors must manually create 5 files per packet,
ensuring correct structure. Without a tool, drift is likely.

## Desired outcome

core/init-packet.sh creates the 5 files with correct field
structure. Authors only need to fill in content.

## Constraints

- POSIX shell only
- Matches convention's "plain text + git" constraint
- No external dependencies

## Assumptions

```yaml
task_id: init-packet-as-packet
assumptions:
  - id: A1
    statement: "A script can create convention-conformant packet files"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      The packet structure (5 files with required fields) is
      deterministic. A script can reproduce it.
      See: packet:math-coding-birth/refinement.md#packet-structure

  - id: A2
    statement: "POSIX shell is sufficient for file creation"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      cat, mkdir, cat heredocs are POSIX-portable.
      See: convention's "plain text + git" requirement
      in math-coding-birth/decision.md.

  - id: A3
    statement: "init-packet.sh creates templates, not content"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      Convention says packet content is human's
      responsibility. Script fills structural fields only.
      See: agents.md#edit-protocol

  - id: A4
    statement: "Defaults match convention (lifecycle: sketch, etc.)"
    status: judgment
    epistemology: judgment
    evidence: |
      convention says new packets start at sketch.
      See: packet:math-coding-birth/refinement.md#lifecycle

  - id: A5
    statement: "init-packet.sh works without external tools"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      Convention requires no external tools beyond POSIX.
      Script uses sh, cat, mkdir only.
      See: packet:core-as-packet/refinement.md
```

## Refinement

# Refinement: init-packet-as-packet

## State

- Convention repo at this commit
- Packet directory to be created (or empty)

## Operations

- Accept packet-id and optional directory
- Create 5 files with correct field structure
- Set defaults (lifecycle: sketch, etc.)

## Mapping (script inputs → convention structure)

| Input | Output |
|-------|--------|
| packet-id | task_id field, directory name |
| target-dir | where to create 5 files |
| (none) | all other fields have convention defaults |

## Mapping (file → convention)

| File | Convention rule |
|------|----------------|
| packet.yaml | manifest, 9 required fields, 1 conditional (supersession) |
| decision.md | thesis/antithesis/synthesis template |
| task.md | problem/outcome/constraints template |
| assumptions.yaml | 3-entry template with placeholder |
| refinement.md | state/operation/invariant/test/runtime template |

## Invariant preservation

- After init-packet.sh: packet has 5 files with correct structure
- Subsequent edits by author should not break structure
- core/verify.sh (when run) verifies structure integrity

## Mapping to convention axes

- **Axis 2 (Packet structure):** script enforces 5-file rule
- **Axis 10 (Refinement pattern):** refinement.md template
- **Axis 4 (Verdicts):** verifier-output.yaml stub for future verdicts

## Test obligation

- Future core/verify.sh validates script's output
- convention author runs init-packet.sh before manual edits

## Runtime check

- None yet (script is the runtime check itself)
- convention author self-runs init-packet.sh + verify.sh

