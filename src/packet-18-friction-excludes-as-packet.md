# friction-excludes — glob-based packet exclusion via .mathrc

## Thesis

math-coding convention grows. As a developer persona
adds packets, some directories become irrelevant to
formal verification:
- `experiments/**` for prototype code
- `archive/**` for historical research
- `test-fixtures/**` for testing-only artefacts
- `examples/**` for non-conforming examples

Today the verifier checks every `math/<name>/` regardless
of intent. A developer who wants to "ignore experiments
in verifier" has no way to say that — they'd have to
move packets outside `math/`, which breaks the
`./.mathrc`-rule that everything formal lives in `math/`.

## Antithesis

Two failure modes:

- **Hardcoded excludes**. List grows in `core/verify.sh`,
  needs source-of-truth reasoning and updates every time
  a project adds a new category.
- **Wildcard `EXCLUDES=*`**. Tells verifier to skip
  everything, defeating the convention's recursive
  observability (axiom A4).

## Synthesis

`.mathrc` carries `excludes:` as a comma-separated list of
glob patterns (POSIX shell patterns: `*`, `?`, `[abc]`).
`core/verify.sh` reads it via `core/mathrc.sh`, then for
each packet path compares it against each pattern. If
**any** pattern matches the packet's path relative to
`math/`, that packet is **logged as skipped** and not
counted in verifier totals.

Crucially: skipped packets still appear in the output but
with a clear "skipped" marker. Convention's recursive
observability is preserved — verifier still touches every
file, just doesn't fail on excluded ones.

## What this packet commits to

- `EXCLUDES` from `.mathrc` is read by `core/verify.sh`
- Skipped packets are logged
- Convention's axiom A4 (recursive observability) is preserved
- Default `.mathrc` ships with 4 conservative excludes
  (`.git/**`, `.agent-shell/**`, `core/probe-report-*.md`,
  `core/checklists/**`)
- A test packet under `experiments/` can be added to
  `.mathrc:excludes:` and verifier will skip it

## What this packet does NOT commit to

- Recursive self-exclusion (verifier excluding itself)
- Wildcard exclusion for safety
- Different exclusion lists per packager (single .mathrc)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/friction-excludes-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/friction-excludes-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/friction-excludes-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/friction-excludes-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/friction-excludes-as-packet/packet.yaml)

## Decision

## Thesis
math-coding convention grows. As a developer persona
adds packets, some directories become irrelevant to
formal verification:
- `experiments/**` for prototype code
- `archive/**` for historical research
- `test-fixtures/**` for testing-only artefacts
- `examples/**` for non-conforming examples
Today the verifier checks every `math/<name>/` regardless
of intent. A developer who wants to "ignore experiments
in verifier" has no way to say that — they'd have to
move packets outside `math/`, which breaks the
`./.mathrc`-rule that everything formal lives in `math/`.
## Antithesis
Two failure modes:
- **Hardcoded excludes**. List grows in `core/verify.sh`,
  needs source-of-truth reasoning and updates every time
  a project adds a new category.
- **Wildcard `EXCLUDES=*`**. Tells verifier to skip
  everything, defeating the convention's recursive
  observability (axiom A4).
## Synthesis
`.mathrc` carries `excludes:` as a comma-separated list of
glob patterns (POSIX shell patterns: `*`, `?`, `[abc]`).
`core/verify.sh` reads it via `core/mathrc.sh`, then for
each packet path compares it against each pattern. If
**any** pattern matches the packet's path relative to
`math/`, that packet is **logged as skipped** and not
counted in verifier totals.
Crucially: skipped packets still appear in the output but
with a clear "skipped" marker. Convention's recursive
observability is preserved — verifier still touches every
file, just doesn't fail on excluded ones.
## What this packet commits to
- `EXCLUDES` from `.mathrc` is read by `core/verify.sh`
- Skipped packets are logged
- Convention's axiom A4 (recursive observability) is preserved
- Default `.mathrc` ships with 4 conservative excludes
  (`.git/**`, `.agent-shell/**`, `core/probe-report-*.md`,
  `core/checklists/**`)
- A test packet under `experiments/` can be added to
  `.mathrc:excludes:` and verifier will skip it
## What this packet does NOT commit to
- Recursive self-exclusion (verifier excluding itself)

## Task

# friction-excludes — task

## Problem

Verifier checks every `math/<name>/` unconditionally. A
project may have legitimate reasons to skip categories:
- experimental
- archived
- test-only
- examples

Without a `.mathrc`-driven exclude mechanism, users must
either patch `core/verify.sh` (forbidden by convention) or
move packets outside `math/` (breaks D02).

## Desired outcome

- `.mathrc` declares an `excludes:` line with comma-separated
  POSIX glob patterns (e.g. `experiments/**,test-fixtures/**`).
- `core/verify.sh` reads `EXCLUDES` via `core/mathrc.sh`.
- For each packet, path is matched against each pattern
  (POSIX shell pattern, not regex).
- On match: log `SKIP: <packet> (matches <pattern>)`, skip
  all per-packet checks, but continue the main loop.
- Skipped packets are NOT counted as PASS or FAIL.
- Default `.mathrc` ships with 4 conservative excludes
  (already configured).

## Constraints

- POSIX shell + AWK only
- Pattern matcher: POSIX shell `case` patterns
  (`*`, `?`, `[...]`, no regex)
- Glob semantics: relative to `math/`, paths like `experiments/foo`
  match `experiments/**` and `experiments/*` and `*` etc.
- No file deletion of excluded packets (skip ≠ remove)
- Single .mathrc key `excludes:` is the only knob

## Assumptions

```yaml
task_id: friction-excludes
assumptions:
  - id: A1
    statement: "POSIX shell pattern matching (case fnmatch) covers ≥99% of practical excludes use-cases"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      POSIX shell `case` patterns support * ? [...] and
      cover typical directory hierarchies. Real
      regex-heavy users can split excludes into finer
      patterns.

  - id: A2
    statement: "Skip is informational, not silent: verifier still logs skipped packets"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      Convention says axiom A4 (recursive observability).
      Silent skip would hide packets from the verifier's
      view, breaking observability. Logged skip preserves
      it.

  - id: A3
    statement: "Comma-separated globs in .mathrc parse correctly through core/mathrc.sh"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/mathrc.sh treats list values as comma-separated
      strings. EXCLUDES is read as a literal string, split
      by verifier at use-site.

  - id: A4
    statement: "Skipped packets are not deleted (verifier read-only)"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Convention says verifier is read-only. Skip is a
      verification concern, not a filesystem cleanup.

  - id: A5
    statement: "Default EXCLUDES covers agent-shell, generated reports, and checks — i.e., convention's own artifacts"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      .agent-shell/** is convention's transcript dir.
      core/probe-report-*.md and core/checklists/** are
      auto-generated artifacts. None is a packet — they
      live outside math/.
```

## Refinement

# Refinement: friction-excludes

## State

- **pre**: verifier walks every `math/<name>/`, no escape
  hatch for experiments or test categories.
- **post**: verifier honours `EXCLUDES` from `.mathrc`,
  logs and skips matched packets, counts only non-skipped
  in totals.

## Operation

- Created `math/friction-excludes-as-packet/` (5 files)
- Extended `core/verify.sh`:
  - Read `EXCLUDES` from `core/mathrc.sh`
  - For each packet, check if `math/<name>` matches any pattern
  - If match: log `skip: <name> (matches <pattern>)`, continue
- Tests:
  - Created dummy packet `test-excludes-pkt/` to verify skip
  - Confirmed verifier skip output

## Mapping (artifact → convention axis)

| Artifact | Axis |
|----------|------|
| `math/friction-excludes-as-packet/` | D51 (this packet) |
| `core/verify.sh` extension | D51 implementation |
| `.mathrc:excludes:` | D51 config knob |

## Invariant preservation

- 43 existing packets still pass `core/verify.sh`
- No packet data is deleted
- Existing default `EXCLUDES` in `.mathrc` (from D50) is
  honoured

## Test obligation

- `sh core/verify.sh` returns 0 errors
- A packet in `experiments/` is skipped when `experiments/**`
  is in `.mathrc:excludes:`
- The skipped count appears in verifier output

## Runtime check

- After every `git commit` that adds a packet, the agent
  checks whether the new packet is excluded
- If excluded: convention author decides whether to:
  - remove the exclude (treat the packet as canonical)
  - keep the exclude (the packet is intentional scratch)
- The decision is recorded in commit message

## Cross-reference

- `core/mathrc.sh` — load `EXCLUDES` from `.mathrc`
- `.mathrc.example` — documents `excludes:` schema
- `core/coverage.yaml` — D51 row added
- `math/project-config-as-packet/` — `.mathrc` parent

