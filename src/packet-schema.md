# packet-schema.md — packet field schema (markdown)

This document is the **canonical schema** for `packet.yaml`.
It is OS (operating-system), not a packet. It is authorized
by `math/core-as-packet/` and `math/phase-c-harmony/`.

When the convention grows enough to need machine-readable
schema, a JSON Schema file will be added at `core/schemas/`
and authorized by a packet. For now, this markdown table is
sufficient for the LLM and `core/verify.sh`.

## Source-of-truth declaration

Authorised by `math/packet-filler-as-packet/`:

- `packet.yaml` is the **structured source of truth** for a
  packet. It is the field machine-readable by convention's
  verifier.
- The 4 sister files (`decision.md`, `task.md`,
  `assumptions.yaml`, `refinement.md`) are **derived
  human/Obsidian-friendly projections** of `packet.yaml`'s
  semantic content.
- They are required by convention (5 files per packet) but
  they are not parsed by the verifier for semantic
  correctness. They are parsed for **presence** only.
- Round-trip guarantee (md → packet.yaml) is OUT OF SCOPE.
  The filler writes md from a structured spec; humans/agents
  edit md; from-md re-derivation is by `core/extract-packet.sh`
  (future tool, deferred).

## Required fields

| Field           | Type             | Required | Allowed values |
|-----------------|------------------|----------|----------------|
| `task_id`       | string           | yes      | `^[a-z][a-z0-9-]*$` |
| `title`         | string           | yes      | any human-readable string |
| `lifecycle`     | enum             | yes      | `sketch`, `working`, `verified`, `deprecated`, `archived`, `superseded` |
| `substrate`     | enum             | yes      | `none`, `shell`, `tla`, `typescript`, `pbt`, `alloy`, `coq`, `bpmn`, `pbt-prism` |
| `rigor`         | enum             | yes      | `light`, `property`, `temporal`, `proof` |
| `decision`      | enum             | yes      | `needed`, `made` |
| `created`       | ISO date         | yes      | `YYYY-MM-DD` |
| `verifier`      | null or object   | yes      | `null` or `{command, verdict_file}` |
| `depends_on`    | list             | yes      | list of task_ids, may be empty `[]` |
| `applications`  | list             | yes      | list of `{sha, by, files, notes}`; may be `[]` |

## Conditional fields

`supersession` is present **only** when `lifecycle: superseded`:

| Field                        | Type     | Notes                              |
|------------------------------|----------|------------------------------------|
| `supersession.supersedes`    | task_id  | the packet being replaced          |
| `supersession.reason`        | string   | why the replacement happened       |
| `supersession.type`          | enum     | `replaced`, `archived`, `deprecated` |
| `supersession.deprecated_at` | ISO date | when the replacement happened      |

## applications (drift tracking)

When a commit applies a packet to code (e.g., to
`core/verify.sh`), record the application in
`packet.yaml:applications[]`:

```yaml
applications:
  - sha: a1b2c3d
    by: agent                # agent | human
    files:
      - core/verify.sh
    notes: "Initial verifier implementation"
```

`core/verify.sh` validates only the structure (sha looks like
a hex string, `by` is in {`agent`, `human`}, `files` is a
list, `notes` is a string). It does **not** check the SHA
against the git history in this phase — that audit is left
to convention authors in Phase D.

Detection of drift (file changed since application) is a
manual `git diff <sha>..HEAD -- <files>` until Phase D.

## Defaults

When a packet is created via `init-packet.sh`:

- `lifecycle: sketch`
- `substrate: none`
- `rigor: light`
- `decision: needed`
- `verifier: null`
- `depends_on: []`
- `applications: []`
