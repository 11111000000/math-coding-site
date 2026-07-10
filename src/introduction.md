# math-coding

**A convention for mathematically grounded software artifacts.**

Plain text + git. No external dependencies.

This site is the rendered version of [the math-coding repository](https://github.com/11111000000/math-coding). The convention is the source of truth; this site is its surface.

## Why

Software development leans on underspecified textual intent. Agents read prose, decide what it means, produce code. The intent itself never appears as an artifact — it lives in chat, in heads, in outdated comments.

math-coding makes mathematical artifacts the development substrate.

- **Every ambiguity becomes an explicit assumption.**
- **Every property has a checkable form.**
- **Every claim about correctness carries evidence.**

## What is a packet

A **packet** is a directory that captures intent before code is written. Three required files:

- `packet.yaml` — manifest
- `task.md` — problem statement (3 sections: Problem, Desired outcome, Constraints)
- `assumptions.yaml` — epistemic context (4 markers: fact, hypothesis, judgment, unknown)

Optional files (per rigor level):
- `refinement.md` — spec → impl mapping
- `Model.tla` / `Model.als` — formal model (when concurrent/distributed/relational)
- `verifier-output.yaml` — verdict artifact (verdict, errors, scope, tool)
- `traceability.json` — links from spec sections to impl

A packet has a **lifecycle** as a finite state machine:

`sketch → working → verified → deprecated → archived → superseded`

The 6th state, `superseded`, marks packets that document a **historical decision** (e.g., "v1.1.0 introduced substrate decision tree, replacing v1.0.0's implicit substrate selection"). Such packets have a `supersession:` block with `supersedes: <id>`, `reason: <text>`, `type: replaced|archived|deprecated`, `deprecated_at: <ISO date>`.

## The recursive property

math-coding has a **fractal property**: every key decision of the convention itself is recorded as a packet in `specs/`. The 21 decision-packets (linked under "Decisions" in the sidebar) document what the convention says and why.

A machine-readable inventory in [`specs/coverage/coverage.yaml`](https://github.com/11111000000/math-coding/blob/main/specs/coverage/coverage.yaml) tracks all 24+ identified decisions, severity-tagged (critical/high/medium/low). The recursive verifier at [`specs/self-check/verify-structural.sh`](https://github.com/11111000000/math-coding/blob/main/specs/self-check/verify-structural.sh) fails CI on any critical gap.

## How to read this site

Start with [Core](./core.md). It defines the convention.

For the mathematical foundation, read [Theory](./SUMMARY.md#mathematical-foundation) (8 basic documents, 3 advanced under `rigor: proof+`).

[Decisions](./SUMMARY.md#decisions-adr-style) (21 ADR-style entries) explain why the convention takes its current shape, with a focus on what was decided in v1.0.0 / v1.1.0 / v1.1.1 / v1.1.2 / v1.2.0.
