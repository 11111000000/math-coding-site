# convention-agent — turn the LLM-as-runtime into a script

#convention
## Thesis

Phase C made the LLM the convention's interpreter. The
question is: how does an LLM agent *start* a session? Until
now, the answer was "read agents.md, then improvise." A
convention-agent first-class step replaces improvisation with
a single command: `sh core/agent.sh --role <role>`. The
output is a manifest the agent and human both read to align
on the working session.

## Antithesis

Without `core/agent.sh`, every session requires the agent to
re-read agents.md, decide which mode, count packets, find the
latest decision commit. This is repetitive and error-prone,
especially for new agents. Convention says: if a step
repeats, name it.

## Synthesis

`core/agent.sh` is a POSIX shell orchestrator:

- Reads `--role` (5 presets) and `--mode` (4 modes); defaults
  to developer/standard
- Resolves role → mode default via the matrix in
  core/decision-modes.md
- Outputs a session manifest with: role, mode, latest_commit,
  head_sha, packet_count, and read-first list
- Exit 0 always (informational)

After running, the agent reads the manifest and proceeds.

## What this packet commits to

- `core/agent.sh` exists, POSIX only, no external deps
- `core/agent.sh --help` shows usage
- The 5×2 (5 roles × 2 modes) default matrix is encoded
- Output reads `git rev-parse HEAD` for the head SHA

## What this packet does NOT commit to

- A multi-agent orchestrator (Phase E+)
- A session log persisted across invocations (this is
  stateless — that's the point)
- Auto-detection of role from user prompts (the user names it)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/convention-agent-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/convention-agent-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/convention-agent-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/convention-agent-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/convention-agent-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Phase C made the LLM the convention's interpreter. The
question is: how does an LLM agent *start* a session? Until
now, the answer was "read agents.md, then improvise." A
convention-agent first-class step replaces improvisation with
a single command: `sh core/agent.sh --role <role>`. The
output is a manifest the agent and human both read to align
on the working session.
## Antithesis
Without `core/agent.sh`, every session requires the agent to
re-read agents.md, decide which mode, count packets, find the
latest decision commit. This is repetitive and error-prone,
especially for new agents. Convention says: if a step
repeats, name it.
## Synthesis
`core/agent.sh` is a POSIX shell orchestrator:
- Reads `--role` (5 presets) and `--mode` (4 modes); defaults
  to developer/standard
- Resolves role → mode default via the matrix in
  core/decision-modes.md
- Outputs a session manifest with: role, mode, latest_commit,
  head_sha, packet_count, and read-first list
- Exit 0 always (informational)
After running, the agent reads the manifest and proceeds.
## What this packet commits to
- `core/agent.sh` exists, POSIX only, no external deps
- `core/agent.sh --help` shows usage
- The 5×2 (5 roles × 2 modes) default matrix is encoded
- Output reads `git rev-parse HEAD` for the head SHA
## What this packet does NOT commit to
- A multi-agent orchestrator (Phase E+)
- A session log persisted across invocations (this is

## Task

# convention-agent — task

#convention
## Problem

LLM agents need a small, repeatable startup ritual. Without
one, each agent re-invents what to read first, which mode to
adopt, which packet is the latest decision, and what the
verifier status is. The cost compounds: a 100-session project
sees 100× the same improvisation.

## Desired outcome

A script (`core/agent.sh`) that emits a session manifest:

```
role: <one of 5>
mode: <one of 4>
latest_commit: <git log subject>
head_sha: <git rev-parse HEAD>
packet_count: <find math -mindepth 1 -maxdepth 1 -type d | wc -l>
read_first: agents.md → core/think-before-do.md → core/decision-modes.md
```

## Constraints

- POSIX shell only
- Exit 0 on success, exit 2 on invalid mode
- Read role default from a static map (no DB)
- No state between invocations (stateless by design)

## Assumptions

```yaml
task_id: convention-agent
assumptions:
  - id: A1
    statement: "LLM agents benefit from a small, deterministic startup ritual that they (and humans) can re-read"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      agents.md already says 'Read first' but does not name the
      current commit, packet count, or role default. Adding
      core/agent.sh makes the ritual self-describing.
      See: agents-md-as-packet/refinement.md#invariant

  - id: A2
    statement: "Role × mode mapping is a static lookup, not a runtime inference"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Inference from prompts is brittle and violates
      epistemic honesty. A static map inside the script
      encodes the convention's intention explicitly.
      See: packet:fast-track-as-packet/refinement.md

  - id: A3
    statement: "core/agent.sh is stateless; no session log is persisted across invocations"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      State would create an implicit DB the convention does
      not have. The script's value is precisely that it
      reconstructs state from git on every run.
      See: math/agent-as-packet/refinement.md#runtime

  - id: A4
    statement: "Output is plain markdown so the manifest is human-readable AND machine-parseable"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Markdown with simple "field: value" lines is parseable
      by convention's grep-based tooling while remaining
      human-readable in any text editor.
      See: core/coverage.yaml#version

  - id: A5
    statement: "5×2 = 10 role-mode combinations cover the convention's current matrix"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/decision-modes.md defines exactly 4 modes and 5
      roles. Total 5 default mappings; user override per
      request adds the rest.
      See: core/decision-modes.md
```

## Refinement

# Refinement: convention-agent

#convention
## State

- **pre**: every LLM agent session re-derives the convention's
  baseline (latest commit, role default, mode, packet count)
  by re-reading multiple files.
- **post**: `core/agent.sh` emits a single-session manifest
  capturing the baseline in one shell call.

## Operation

- Created `core/agent.sh` (POSIX shell, ~75 lines)
- Created `math/convention-agent-as-packet/` with 5 files
- `applications[]` declares the placeholder SHA, which the
  bundle commit fills

## Mapping (artifact → convention axis)

| Artifact                       | Axis                          |
|--------------------------------|--------------------------------|
| `core/agent.sh`                | D7 (convention-agent)          |
| `math/convention-agent-as-packet/` | decision-record for the script |
| `core/decision-modes.md` source | role-mode matrix              |

## Invariant preservation

- `sh core/verify.sh` returns VERIFIED after addition
- `AGENTS.md` ≤ 60 lines (this packet does not touch it)

## Test obligation

- `sh core/agent.sh --role researcher` exits 0 and prints
  manifest with mode=strict
- `sh core/agent.sh --mode strict --role designer` exits 0
  with role=designer (mode override wins over default)
- Invalid mode exits 2

## Runtime check

- Every agent session starts with `sh core/agent.sh` output
- The manifest is the first thing the agent reads

## Cross-reference

Pairs with `agent-as-packet` (the LLM theory). This packet
turns the theory into a script.

