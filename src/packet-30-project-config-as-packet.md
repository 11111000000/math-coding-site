# project-config — .mathrc convention configuration

## Thesis

math-coding has accumulated ~12 tools and 30+ behavioural
toggles (mode, role, drift threshold, Obsidian interop,
tag policy, excludes). Without a project-level config file,
every change requires editing a script's hardcoded default —
or scattering overrides across tool invocations. That does
not scale.

`.mathrc` makes every convention setting explicit, overridable,
and shared per-project (committed) or per-user (`~/.mathrc`).

## Antithesis

Three failure modes:

- **Hardcoded defaults stay forever.** Tools get inherited
  defaults from the past; updating them means updating scripts.
- **Tool-by-tool override files.** Each tool gets its own
  config (verify.yaml, agent.yaml, obsidian.yaml). Drift between
  them — different modes per tool.
- **Turing-complete config.** Allowing scripts/calls in
  `.mathrc` means users can break the convention from inside
  its own config.

## Synthesis

`.mathrc` is a flat `key: value` file loaded by `core/mathrc.sh`.

- **Project-local** `./.mathrc` is committed, versioned.
- **User-global** `~/.mathrc` provides defaults for any project
  the user touches.
- **Project-local overrides user-global** (last wins).
- **Flat key:value pairs**, with nesting flattened to
  underscore-separated keys (`obsidian.dataview.autogenerate`
  → `OBSIDIAN_DATAVIEW_AUTOGENERATE`).
- **List values comma-separated** (`obsidian_plugins: dataview,mermaid`).
- **Comments start with `#`.** Lines without `:` are ignored.

`core/mathrc.sh` is a POSIX-shell + AWK loader:
- Reads both files
- Outputs `KEY=VALUE` assignments (the standard POSIX-shell
  way to capture via `.` or `eval`)
- Sets defaults if key not present

`core/agent.sh` and `core/verify.sh` source `mathrc.sh` for
their defaults.

## What this packet commits to

- `.mathrc` schema documented in `.mathrc.example`
- Project-local `.mathrc` is shipped with sensible defaults
- `core/mathrc.sh` parses both files correctly
- `core/agent.sh` respects `MODE`/`ROLE` defaults from .mathrc
- `core/verify.sh` reports the loaded configuration in output

## What this packet does NOT commit to

- Turing-complete config (no scripts, no eval)
- Per-tool config files (single .mathrc handles all)
- Auto-detecting user role from prompts
- Live reloading (each script invocation re-reads .mathrc)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/project-config-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/project-config-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/project-config-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/project-config-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/project-config-as-packet/packet.yaml)

## Decision

## Thesis
math-coding has accumulated ~12 tools and 30+ behavioural
toggles (mode, role, drift threshold, Obsidian interop,
tag policy, excludes). Without a project-level config file,
every change requires editing a script's hardcoded default —
or scattering overrides across tool invocations. That does
not scale.
`.mathrc` makes every convention setting explicit, overridable,
and shared per-project (committed) or per-user (`~/.mathrc`).
## Antithesis
Three failure modes:
- **Hardcoded defaults stay forever.** Tools get inherited
  defaults from the past; updating them means updating scripts.
- **Tool-by-tool override files.** Each tool gets its own
  config (verify.yaml, agent.yaml, obsidian.yaml). Drift between
  them — different modes per tool.
- **Turing-complete config.** Allowing scripts/calls in
  `.mathrc` means users can break the convention from inside
  its own config.
## Synthesis
`.mathrc` is a flat `key: value` file loaded by `core/mathrc.sh`.
- **Project-local** `./.mathrc` is committed, versioned.
- **User-global** `~/.mathrc` provides defaults for any project
  the user touches.
- **Project-local overrides user-global** (last wins).
- **Flat key:value pairs**, with nesting flattened to
  underscore-separated keys (`obsidian.dataview.autogenerate`
  → `OBSIDIAN_DATAVIEW_AUTOGENERATE`).
- **List values comma-separated** (`obsidian_plugins: dataview,mermaid`).
- **Comments start with `#`.** Lines without `:` are ignored.
`core/mathrc.sh` is a POSIX-shell + AWK loader:
- Reads both files
- Outputs `KEY=VALUE` assignments (the standard POSIX-shell
  way to capture via `.` or `eval`)
- Sets defaults if key not present
`core/agent.sh` and `core/verify.sh` source `mathrc.sh` for
their defaults.
## What this packet commits to
- `.mathrc` schema documented in `.mathrc.example`
- Project-local `.mathrc` is shipped with sensible defaults
- `core/mathrc.sh` parses both files correctly
- `core/agent.sh` respects `MODE`/`ROLE` defaults from .mathrc
- `core/verify.sh` reports the loaded configuration in output
## What this packet does NOT commit to
- Turing-complete config (no scripts, no eval)
- Per-tool config files (single .mathrc handles all)

## Task

# project-config — task

## Problem

math-coding has tools with hardcoded defaults that aren't
overridable without editing scripts. Per-project user
needs (e.g., role=researcher, drift_threshold=30) are easy
to forget or hard to share across sessions.

## Desired outcome

- `.mathrc` (project-local, committed) and `~/.mathrc`
  (user-global, optional) carry ALL convention settings
- Project-local overrides user-global
- `core/mathrc.sh` parses flat `key: value` and outputs
  POSIX-shell `KEY=VALUE` assignments
- `core/agent.sh` and `core/verify.sh` source it and respect
  defaults

## Constraints

- POSIX shell only (no Python, no YAML library)
- `.mathrc` is plain text — easy to read, edit, diff
- Comments with `#`, blank lines ignored
- Defaults if key missing
- No scripts in `.mathrc`

## Assumptions

```yaml
task_id: project-config
assumptions:
  - id: A1
    statement: "Flat key:value schema is sufficient for all current convention settings"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      All current toggles (mode, role, drift threshold,
      obsidian_*, probe_*, tag_policy, excludes) fit the
      flat schema with underscore flattening.

  - id: A2
    statement: "Project-local file is committed; user-global file is not"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      Project-local needs version control + sharing.
      User-global is per-machine, no need for version control.

  - id: A3
    statement: "POSIX shell + AWK is sufficient for parsing"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      `core/mathrc.sh` is ~50 lines of POSIX shell + a
      ~70-line AWK script. Tests run successfully.

  - id: A4
    statement: "No scripts allowed in .mathrc (security + convention-bound)"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      Convention says plain text + git, no frameworks. A
      script-eval-enabled config would let user escape
      the convention's authority.

  - id: A5
    statement: "Defaults in core/mathrc.sh handle missing keys gracefully"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      `[ -z "${KEY:-}" ] && KEY="default"` pattern ensures
      every key has a fallback. Tested: .mathrc deleted →
      defaults apply.
```

## Refinement

# Refinement: project-config

## State

- **pre**: 12 tools, ~30 hardcoded defaults. Changing any
  default requires editing a script and committing.
- **post**: `.mathrc` + `core/mathrc.sh` make all settings
  overridable without code changes.

## Operation

- Created `.mathrc.example` (schema documentation)
- Created `.mathrc` (project-local defaults)
- Created `core/mathrc.sh` (POSIX-shell loader)
- Created `core/mathrc.awk` (AWK parser for .mathrc)
- Updated `core/agent.sh` to source `core/mathrc.sh`
- Updated `core/verify.sh` to source `core/mathrc.sh`

## Mapping (artifact → convention axis)

| Artifact | Axis |
|----------|------|
| `.mathrc` | D50 (new) — convention configuration |
| `core/mathrc.sh` | D50 implementation |
| `core/agent.sh` integration | D7 extended — role/mode defaults |
| `core/verify.sh` integration | Phase B + C extended — config reporting |

## Invariant preservation

- 42 existing packets still pass `core/verify.sh` after changes
- `AGENTS.md` ≤ 75 lines (raised cap documented)
- No new external dependencies

## Test obligation

- `sh core/agent.sh` with no args reads .mathrc defaults
- `sh core/agent.sh --role researcher` overrides .mathrc
- `sh core/verify.sh` reports Configuration: section
- Missing .mathrc → defaults still apply

## Runtime check

- Each `core/*.sh` script that loads .mathrc uses defaults
  if user-global file is absent
- `core/extract-packet.sh`, `core/drift-check.sh`,
  `core/generate-frontmatter.sh` can be extended to load
  .mathrc as user needs grow

## Cross-reference

- `core/obsidian.md` — documents `obsidian_*` keys
- `AGENTS.md` — documents `.mathrc` and key override patterns
- `core/mathrc.sh` — loader implementation
- `core/mathrc.awk` — parser implementation
- `.mathrc.example` — full schema reference

