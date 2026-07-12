# core-as-packet — core/ is operating-system

#convention
## Thesis

math-coding has multiple OS-level foundations that are NOT
decisions themselves: the packet schema (field types and
constraints), 11 mathematical theory docs, and the LICENSE.
These files must exist somewhere in the repository, but making
each of them a separate decision-packet would create noise:
not every file documents a decision.

## Antithesis

Treating every file as a decision-packet produces overhead.
In brownfield mode (existing project), most files are OS files
(no packet needed, per birth-пакет A3). The convention must
distinguish decision-packets (in math/) from operating-system
files (anywhere else).

## Synthesis

The `core/` directory holds two kinds of OS files:
- `packet-schema.md` — the canonical packet field schema
- `theories/*.md` — 11 mathematical theory docs

This packet authorizes those files as convention-OS. It is
itself a decision-packet (a decision about what OS files
exist) but the files it authorizes are not packets.

## What this packet commits to

- `core/packet-schema.md` is the canonical schema for
  `packet.yaml` fields (markdown table).
- `core/theories/*.md` are 11 mathematical theory docs (OS).
- This packet authorizes these OS files; no future packet
  may modify them without opening a new supersession.

## What this packet does NOT commit to

- A JSON Schema variant (deferred — markdown suffices for now).
- Additional theory files beyond the 11 currently listed.
- A separate `core/`-as-packet schema (this IS the schema).

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/core-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/core-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/core-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/core-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/core-as-packet/packet.yaml)

## Decision

#convention
## Thesis
math-coding has multiple OS-level foundations that are NOT
decisions themselves: the packet schema (field types and
constraints), 11 mathematical theory docs, and the LICENSE.
These files must exist somewhere in the repository, but making
each of them a separate decision-packet would create noise:
not every file documents a decision.
## Antithesis
Treating every file as a decision-packet produces overhead.
In brownfield mode (existing project), most files are OS files
(no packet needed, per birth-пакет A3). The convention must
distinguish decision-packets (in math/) from operating-system
files (anywhere else).
## Synthesis
The `core/` directory holds two kinds of OS files:
- `packet-schema.md` — the canonical packet field schema
- `theories/*.md` — 11 mathematical theory docs
This packet authorizes those files as convention-OS. It is
itself a decision-packet (a decision about what OS files
exist) but the files it authorizes are not packets.
## What this packet commits to
- `core/packet-schema.md` is the canonical schema for
  `packet.yaml` fields (markdown table).
- `core/theories/*.md` are 11 mathematical theory docs (OS).
- This packet authorizes these OS files; no future packet
  may modify them without opening a new supersession.
## What this packet does NOT commit to
- A JSON Schema variant (deferred — markdown suffices for now).

## Task

# core-as-packet — task

#convention
## Problem

The `core/` directory contains 12 OS files (1 schema + 11
theories). These files document the convention's foundation.
They must exist, but treating them as separate decision-packets
would create artificial decisions where no real decision exists.

## Desired outcome

A single decision-packet (`core-as-packet`) that authorizes
the existence of `core/` as convention-OS, and lists the 12 OS
files it contains. The packet itself has 5 files (standard
structure), and references the OS files it authorizes.

## Constraints

- The packet must be self-consistent at this commit.
- The 12 OS files in core/ already exist; this packet only
  authorizes them.
- No new files in core/ are added by this commit.
- The packet's `depends_on:` references `math-coding-birth` (it
  extends the seed).

## Assumptions

```yaml
task_id: core-as-packet
assumptions:
  - id: A1
    statement: "OS files (non-packet convention artifacts) need explicit authorization by a packet"
    status: judgment
    epistemology: judgment
    evidence: |
      Without a packet authorizing core/, the convention would
      have an unjustified OS directory. Recursive observability
      requires that every directory or file has either a packet
      decision or an explicit OS exception.
      See: packet:math-coding-birth/refinement.md#operating-system

  - id: A2
    statement: "core/packet-schema.md is the canonical schema for packet fields"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      The schema lists 9 required fields and 1 conditional
      field (supersession). This matches the 5-file packet
      structure declared in math-coding-birth.
      See: core/packet-schema.md (the file itself)

  - id: A3
    statement: "11 theory files in core/theories/ are the mathematical foundation of the convention"
    status: judgment
    epistemology: judgment
    evidence: |
      math-coding-birth/decision.md says convention is grounded
      in math. The 12 theories are the explicit grounding.
      See: packet:math-coding-birth/decision.md#synthesis

  - id: A4
    statement: "OS files don't need their own packets"
    status: judgment
    epistemology: judgment
    evidence: |
      Brownfield mode (per agents.md) treats most existing files
      as OS. The same principle applies here: core/ OS files
      don't need their own packets.
      See: packet:math-coding-birth/refinement.md#brownfield-mode

  - id: A5
    statement: "core/ contains no packets; it is convention-OS only"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/ has no packet.yaml files. All files are .md
      documentation. This is verified by find core/ -name packet.yaml
      returning empty.
      See: packet:math-coding-birth/refinement.md#operating-system
```

## Refinement

# Refinement: core-as-packet

#convention
## State

- **pre**: math-coding has 12 OS files in core/ but no packet
  authorizes them
- **post**: core/ is authorized by core-as-packet

## Operation

- This packet exists as the decision-record for core/
- It does NOT modify any file in core/
- The 12 OS files remain unchanged after this commit

## Invariant

- core/ has exactly 12 OS files (1 schema + 12 theories)
- This packet is in math/, not core/
- This packet has 5 files (matching convention)
- This packet has depends_on: [math-coding-birth] (recursive)

## OS files authorized (12)

1. `core/packet-schema.md` — packet field schema
2-12. `core/theories/{predicate,fsm,ltl,refinement,assumption,
verdict,epistemic,deprecation,curry-howard,modal,confidence}.md`

## Convention axes affected

- **OS rule (refinement.md §14):** "outside math/ files are OS,
  must be authorized by a packet" — this packet authorizes
  core/. Future OS files (like LICENSE added in commit 1.5)
  will need their own authorization.

## Test obligation

- `find core/ -name packet.yaml` returns empty (no packets in core/)
- `find core/ -type f | wc -l` returns 12
- This packet is in math/core-as-packet/ with 5 files

## Runtime check

- None required yet (no code to verify)

