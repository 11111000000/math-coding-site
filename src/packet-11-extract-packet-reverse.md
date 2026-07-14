# extract-packet-reverse

## Thesis

A packet's five files can be reverse-extracted to a single
YAML spec via one shell call. The agent or tool can ingest
the spec without parsing markdown.

## Antithesis

The five files of a packet are well-structured, but
ingesting them requires parsing five separate files. A
single-spec output is easier to consume in pipelines
(other tools, cross-convention migration, regression
analysis).

## Synthesis

`sh math-coding extract <name>` reads the five files of
`math/<name>/` and emits a single YAML spec to stdout.
The output is in the **same shape** as `create-packet.sh`
input, so:

```
sh math-coding extract cache-ttl > /tmp/spec.yaml
sh math-coding create cache-ttl-renamed --from /tmp/spec.yaml
```

This is the **round-trip**: extract → create produces a
new packet with the same content.

## Surface impact

touches: `core/author/extract-packet.sh` (new script),
`math-coding` dispatcher (new `extract` command)

## Proof

`tests/run.sh` adds a case: extract a packet, then
re-create it, then verify that the re-created packet has
the same 5 files with the same content. axiom Self-Application
holds because probe.sh accepts both packets.

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/extract-packet-reverse/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/extract-packet-reverse/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/extract-packet-reverse/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/extract-packet-reverse/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/extract-packet-reverse/packet.yaml)

## Decision

## Thesis
A packet's five files can be reverse-extracted to a single
YAML spec via one shell call. The agent or tool can ingest
the spec without parsing markdown.
## Antithesis
The five files of a packet are well-structured, but
ingesting them requires parsing five separate files. A
single-spec output is easier to consume in pipelines
(other tools, cross-convention migration, regression
analysis).
## Synthesis
`sh math-coding extract <name>` reads the five files of
`math/<name>/` and emits a single YAML spec to stdout.
The output is in the **same shape** as `create-packet.sh`
input, so:
```
sh math-coding extract cache-ttl > /tmp/spec.yaml
sh math-coding create cache-ttl-renamed --from /tmp/spec.yaml
```
This is the **round-trip**: extract → create produces a
new packet with the same content.
## Surface impact
touches: `core/author/extract-packet.sh` (new script),
`math-coding` dispatcher (new `extract` command)
## Proof
`tests/run.sh` adds a case: extract a packet, then
re-create it, then verify that the re-created packet has

## Task

# extract-packet-reverse

## Problem

Reading a packet's content requires parsing five files.
Cross-tool integration is hard when the convention is
expressed as a directory of files.

## Desired outcome

A single-call extractor that emits a YAML spec
representing the packet. The spec is in the same shape
as `create-packet.sh` input, enabling round-trip.

## Constraints

- POSIX shell only (axiom Material Basis).
- Output must be valid YAML that `create-packet.sh` can
  consume (round-trip).
- No information loss: every field in the 5 files must
  appear in the spec.
## Assumptions

```yaml
task_id: extract-packet-reverse
assumptions:
  - id: A1
    statement: "round-trip preserves all 5 files"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      extract.sh reads each field once; create-packet.sh
      writes each field once. The mapping is a bijection.
  - id: A2
    statement: "YAML spec is sufficient for round-trip"
    status: user-confirmed
    epistemology: fact
    confidence: 0.95
    evidence: |
      The create-packet.sh input is YAML; if extract
      produces the same shape, round-trip is lossless.
  - id: A3
    statement: "extract does not depend on TLA+/Coq"
    status: user-confirmed
    epistemology: judgment
    evidence: |
      extract reads 5 text files and emits YAML. No
      substrate-specific logic.
```

## Refinement

# Refinement: extract-packet-reverse

## State

- pre: 5 files of a packet exist (math/<name>/).
- post: 1 YAML spec on stdout, ready to be ingested by
  create-packet.sh or any other tool.

## Operation

`sh math-coding extract <name>` reads:
  - packet.yaml  → name, mode, lifecycle, etc.
  - decision.md  → Thesis, Antithesis, Synthesis, Surface,
                    Proof (parsed by section header)
  - task.md      → Problem, Desired outcome, Constraints
  - assumptions.yaml → assumptions (parsed as YAML)
  - refinement.md → State pre/post, Operation, Mapping,
                    Invariant, Test, Runtime

Emits to stdout in the same shape as `create-packet.sh`
input.

## Mapping

| source file          | spec field          |
|----------------------|---------------------|
| packet.yaml:task_id  | name                |
| decision.md:## Thesis | thesis              |
| decision.md:## Antithesis | antithesis       |
| decision.md:## Synthesis | synthesis         |
| decision.md:## Surface impact | surface_impact |
| decision.md:## Proof | proof                |
| task.md:## Problem   | problem              |
| task.md:## Desired outcome | outcome         |
| task.md:## Constraints (list) | constraints |
| assumptions.yaml (list) | assumptions       |
| refinement.md:## State pre | state.pre        |
| refinement.md:## State post | state.post      |
| refinement.md:## Operation | operation        |
| refinement.md:## Mapping | mapping            |
| refinement.md:## Invariant preservation | invariant |
| refinement.md:## Test obligation | test_obligation |
| refinement.md:## Runtime check | runtime_check |

## Invariant preservation

- Every field in the 5 files appears in the spec.
- Round-trip (extract → create) produces the same 5 files
  with the same content.
- axiom Self-Application holds for the original and
  re-created packets.

## Test obligation

`tests/run.sh` adds a case: extract a packet, re-create it
with `create-packet.sh`, compare file lists, compare
content hashes, assert equality. Exit 0 iff round-trip is
lossless.

## Runtime check

None. extract is a tool, not a runtime concern.
