# coverage-as-packet — convention decisions inventory

#convention
## Thesis

math-coding has 14 axes declared in birth-packet. But how do we
know which axes have packets? Without a coverage inventory,
we can't measure recursive observability.

## Antithesis

Convention authors could read each packet and decide. But
that's manual, error-prone, and doesn't scale. A coverage
inventory in convention OS provides a single source of truth.

## Synthesis

Coverage-as-packet authorizes core/coverage.yaml as
convention OS — a machine-readable list of decisions, each
referencing the packet that documents it. Future verifier
checks coverage: every decision has a packet, every packet
is in coverage.

## What this packet commits to

- core/coverage.yaml exists as machine-readable inventory
- Each entry: id, title, location, severity, packet (or "OS")
- Future verifier-as-packet reads coverage to validate gaps

## What this packet does NOT commit to

- A specific list of decisions (just the schema)
- Coverage threshold (what's "enough")
- Auto-update of coverage.yaml

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/coverage-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/coverage-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/coverage-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/coverage-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/coverage-as-packet/packet.yaml)

## Decision

#convention
## Thesis
math-coding has 14 axes declared in birth-packet. But how do we
know which axes have packets? Without a coverage inventory,
we can't measure recursive observability.
## Antithesis
Convention authors could read each packet and decide. But
that's manual, error-prone, and doesn't scale. A coverage
inventory in convention OS provides a single source of truth.
## Synthesis
Coverage-as-packet authorizes core/coverage.yaml as
convention OS — a machine-readable list of decisions, each
referencing the packet that documents it. Future verifier
checks coverage: every decision has a packet, every packet
is in coverage.
## What this packet commits to
- core/coverage.yaml exists as machine-readable inventory
- Each entry: id, title, location, severity, packet (or "OS")
- Future verifier-as-packet reads coverage to validate gaps
## What this packet does NOT commit to
- A specific list of decisions (just the schema)

## Task

# coverage-as-packet — task

#convention
## Problem

14 axes are declared but how do we measure recursive observability?
We need a coverage inventory.

## Desired outcome

A coverage.yaml file at core/ that lists every decision with:
- id, title, location (where it's encoded)
- severity (critical/high/medium/low)
- packet reference (or "OS" if not a packet)

This file is convention OS, authorized by this packet.

## Constraints

- Plain YAML
- No external tools
- Compatible with future verifier-as-packet

## Assumptions

```yaml
task_id: coverage-as-packet
assumptions:
  - id: A1
    statement: "Coverage inventory is convention OS"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      OS files are authorized by packets but not decision
      packets themselves. coverage.yaml is metadata about
      decisions, not a decision.
      See: packet:core-as-packet/refinement.md

  - id: A2
    statement: "Every convention decision has a coverage entry"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Coverage is the mechanism for recursive observability.
      Without it, decisions are invisible.
      See: packet:math-coding-birth/decision.md#synthesis

  - id: A3
    statement: "Coverage entries have id, title, location, severity, packet"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Standard coverage schema: 5 fields per decision.
      See: packet:math-coding-birth/refinement.md#operating-system

  - id: A4
    statement: "Coverage gaps should be flagged"
    status: judgment
    epistemology: judgment
    evidence: |
      When packet is null in coverage entry, convention has
      a gap. Future verifier flags gaps.
      See: packet:theory-deprecation-as-packet/refinement.md

  - id: A5
    statement: "Coverage is convention's self-knowledge"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      Coverage is the answer to "what has convention decided?"
      Without it, convention is opaque to itself.
      See: packet:math-coding-birth/refinement.md#operating-system
```

## Refinement

# Refinement: coverage-as-packet

#convention
## State

- convention repo at this commit
- D = set of decisions in core/coverage.yaml
- gap = decision d with d.packet = null

## Operations

- Future verifier reads coverage.yaml
- Each entry's packet field → existing math/<packet>/
- Each entry's location field → file path exists
- Each entry's severity → convention-priority

## Mapping (coverage → convention axes)

Each entry maps to one of 14 convention axes from birth:
1. decision artifact
2. packet structure (5 files)
3. epistemics (4 fields)
4. verdicts (5 types)
5. lifecycle FSM (6 states)
6. rigor (4 levels)
7. substrate (9 options)
8. packet kinds (3 types)
9. coverage / recursive observability
10. refinement pattern
11. schema location
12. rendering
13. mathematical theories (11)
14. OS rules

## Invariant preservation

- Every decision has a unique id
- Every entry has 5 fields
- location paths are valid (file exists)
- packet paths are valid math/<name>/ directories

## Mapping to convention axes

- **Axis 9 (Coverage / recursive observability):** this packet
  IS the formalization
- **Axis 14 (OS rules):** coverage.yaml is OS

## Test obligation

- future verifier-as-packet validates coverage.yaml
- convention author maintains coverage when new decisions added

## Runtime check

- None yet (verifier-as-packet deferred to be implemented
  alongside coverage-as-packet)
- convention author self-checks coverage when adding decisions

