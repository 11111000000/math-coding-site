# Packet schema (machine-readable)

# Packet schema (machine-readable)

## Required files

### `packet.yaml`

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `task_id` | string | yes | unique, no spaces |
| `title` | string | yes | human-readable |
| `lifecycle` | enum | yes | `sketch\|working\|verified\|deprecated\|archived\|superseded` |
| `substrate` | enum | yes | `none|shell|tla|typescript|pbt|alloy|coq|bpmn` |
| `rigor` | enum | yes | `light|property|temporal|proof` |
| `decision` | enum | yes | `needed|made` |
| `created` | string | yes | ISO date `YYYY-MM-DD` |
| `verifier` | null\|object | yes | null = self-applied; object = `{command, verdict_file}` |

### `task.md`

Three sections, each ≥10 words:
- `## Problem`
- `## Desired outcome`
- `## Constraints`

### `assumptions.yaml`

- `task_id`: same as `packet.yaml`
- `assumptions`: list, ≥1 entry

Each entry:
| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `id` | string | yes | pattern `A\d+` |
| `statement` | string | yes | the assumption text |
| `status` | enum | yes | `user-confirmed\|agent-inferred\|open` |
| `epistemology` | enum | yes | `fact\|hypothesis\|judgment\|unknown` |
| `confidence` | number | no | 0.0-1.0, optional but recommended for `hypothesis` |

## Optional files

- `refinement.md` — state mapping (Spec → Impl). Add when
  implementation involves FSM or layered abstractions.
- `Model.tla` / `Model.als` / `Model.v` — formal model. Add
  when concurrency, distribution, or contracts are non-trivial.
- `traceability.json` — links from spec sections to impl
  locations. Add when project has multiple impl sites.
- `verifier-output.yaml` — verification verdict. Add when a
  verifier (TLC, jqwik, custom) has been run.

## Operating-system files (NOT packets)

- `LICENSE` — legal
- `.gitignore` — git config
- `README.md` — landing
- `CHANGELOG.md` — history
- `.github/workflows/` — CI config
- `tools/` — convention runtime

These are listed in `core/meta.yaml`. The fractal property
applies to **decisions with intent**, not to **every file**.

## Substrate decision tree

When to choose which substrate. This is a **guide, not a
rule** — agents apply judgment. See
`theories/formal-tools.md` for the full catalog.

```yaml
substrate_selection:
  - if: "decision involves <3 states, no concurrency, <100 lines of code"
    recommend: "none or shell"
    reason: "Formal model is overhead; bash or sh is enough."

  - if: "decision involves 3-10 states, sequential"
    recommend: "shell + refinement.md"
    reason: "State mapping in refinement.md captures the FSM; no formal model needed."

  - if: "decision involves >10 states OR concurrent OR distributed"
    recommend: "tla + Model.tla"
    reason: "Concurrency/distribution is hard to reason about without model checking."

  - if: "decision involves security-critical, financial, or safety-critical code"
    recommend: "coq + proof"
    reason: "Correctness is provable, not just testable."

  - if: "decision involves >5 entity types with relational constraints"
    recommend: "alloy + Model.als"
    reason: "Alloy is designed for relational schema validation."

  - if: "decision involves probabilistic behavior (random sampling, failure rates)"
    recommend: "pbt + Model.prism"
    reason: "PRISM is designed for probabilistic model checking."

  - if: "decision involves business process, multi-step workflow"
    recommend: "bpmn + Model.bpmn"
    reason: "BPMN is the OMG standard for business processes."

when_not_to_formalize:
  - "decision has 1-2 outcomes, deterministic"
  - "decision is throwaway or replaced soon"
  - "decision is research/experiment, not production"
  - "you don't have time to learn the formalism"
  - "decision is trivial CRUD endpoint"
```

## Decision matrix

| Decision characteristics | Substrate | When |
|--------------------------|-----------|------|
| <3 states, deterministic | `none` or `shell` | any |
| 3-10 states, sequential | `shell` + refinement.md | any |
| >10 states, no concurrency | `shell` + refinement.md | property+ |
| Concurrent, <10 states | `tla` + Model.tla | temporal+ |
| Distributed | `tla` + Model.tla | property+ |
| Security-critical | `coq` + Proof.v | proof+ |
| >5 entity types | `alloy` + Model.als | property+ |
| Probabilistic | `pbt` + Model.prism | property+ |
| Business process | `bpmn` + Model.bpmn | any |

## Theory layer pattern (v1.1.1+)

A **theory** in `theories/` is **documentation, not a packet**.
The decision to include a theory (or a whole theory layer) IS
a packet, and lives in `specs/`. This separates
"the math" (knowledge, intent-free) from "the decision to use
the math" (intent-bearing).

```
theories/<name>.md                   ← pure markdown documentation
specs/.../                           ← packet documenting the decision
    packet.yaml                       to include this theory or layer
    task.md
    assumptions.yaml
```

### When to use this pattern

- **Theory content** (definitions, formulas, examples): put in
  `theories/<name>.md`. Pure markdown, no YAML frontmatter.
- **Decision to include a theory in the convention**: put as a
  packet in `specs/`. Three required files
  (`packet.yaml` + `task.md` + `assumptions.yaml`).
- **Decision to change the layer** (add/remove a theory):
  either a new packet referencing the previous one via
  `depends_on`, or a `supersedes` field if replacing it.

### Why this pattern

The 11 foundational theories (predicate, fsm, ltl, modal,
refinement, assumption, verdict, epistemic, deprecation,
curry-howard, confidence) were introduced as one curated set
in v1.0.0 — single packet at
`specs/theory-layer-foundation/`. v1.1.0
added `theories/formal-tools.md` — documented in
`specs/theory-layer-v1.1.0/`. Future theory
additions or removals get their own packets in
`specs/`.

### What is NOT in this pattern

- **`theories/<name>.packet.yaml`** files: removed in v1.1.1.
  A theory has no standalone packet; the decision lives
  centrally in `specs/`.
- **`theories/<name>.body.md`** files: removed in v1.1.1.
  Each theory is a single `theories/<name>.md` with no YAML
  frontmatter.
- **Per-theory decision packets for every theory**: rejected
  for v1.0.0/1.1.0. The 11 theories were a curated set; if
  future additions warrant per-theory rationale, document
  it inside each `theories/<name>.md` rather than create
  a packet per theory.

### Verifier impact

`core/verify.sh` does **not** scan `theories/*.md` for
packets — there are no `packet.yaml` files there by design.
Theory documents are listed in `core/meta.yaml` as
operating-system files (`role: theory-documentation`).
