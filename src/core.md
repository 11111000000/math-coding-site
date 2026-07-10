# Core

This is the canonical specification of the math-coding convention. Each rule below cites the formal theory it derives from.

The convention is grounded in mathematical theories that live in [Theory](./SUMMARY.md#mathematical-foundation). Eight basic theories are the foundation; three advanced theories extend it for `rigor: proof+` projects.

The full content of `core/core.md` is sourced from the [main repository](https://github.com/11111000000/math-coding/blob/main/core/core.md) and includes packet structure, structural invariants, the lifecycle FSM, triggered transitions, LTL properties, the five verdict types, the epistemic action protocol, and deprecation cascades.

## What is a packet

A **packet** is a directory that captures intent before code is written. The intent is recorded in plain text files following a fixed structure. A packet may include a formal model, a verifier, and other artifacts. A packet always includes enough information for a human or agent to understand what the intent is and to verify that the resulting code matches it.

A packet is **not** a project. A project contains many packets, many files, many kinds of documentation. A packet is a single decision or change, captured in isolation.

A packet that lacks any of the three required files is **not** a packet**. It is a draft. Complete it or delete it.

## Two modes of application

math-coding can be applied in two modes. The convention is the same; only the topology differs.

**Self-application mode.** The math-coding repository itself uses the convention: every artifact is a packet. Use this mode when building math-coding itself, or teaching it to a new agent.

**External project mode.** When math-coding is applied to a production project, the project's code lives in its own structure. Packets live in a dedicated directory, typically `specs/`, configured via `.mathcodingrc` (in the project root).

## Required files

Every packet has exactly these three files:

| File | Purpose |
|------|---------|
| `packet.yaml` | Manifest (task_id, title, lifecycle, substrate, rigor, decision, created, verifier, depends_on) |
| `task.md` | Intent: Problem, Desired outcome, Constraints (each section ≥10 words) |
| `assumptions.yaml` | Epistemic context: id, statement, status, epistemology, optional confidence |

## Optional files

- `refinement.md` — spec ↔ impl mapping (state mapping, operation mapping, invariant preservation)
- `Model.tla` / `Model.als` / `Model.v` — formal model (when concurrent, distributed, or relational)
- `traceability.json` — links from spec sections to impl locations
- `verifier-output.yaml` — verdict artifact (verdict, errors, scope, tool, verified_at)

## Key fields in `packet.yaml`

- **`lifecycle`** (enum, required): `sketch | working | verified | deprecated | archived | superseded` — 6 values
- **`substrate`** (enum, required): `none | shell | tla | typescript | pbt | alloy | coq | bpmn | pbt-prism` — 9 values
- **`rigor`** (enum, required): `light | property | temporal | proof` — 4 levels
- **`decision`** (enum, required): `needed | made`
- **`verifier`** (null or object): `null` (self-applied) or `{command, verdict_file}`

## Two valid use cases

- **Self-application:** when applying math-coding to the convention itself (every key decision becomes a packet, see `specs/`)
- **External project:** when applying math-coding to a production codebase (the project keeps its own structure, packets live in `specs/` or another configured directory)
