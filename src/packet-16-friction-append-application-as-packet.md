# friction-append-application — automate applications[] maintenance

## Thesis

After a developer makes a commit, the convention expects
each packet's `applications[]` to record the commit SHA.
Today this is manual: open `math/<name>/packet.yaml`,
edit, paste SHA. For 1 packet this is fine. For a burst
of commits across N packets, it's friction.

## Antithesis

Two failure modes:

- **Auto-commit hook** runs after every commit and fills
  `applications[]`. Problem: git hooks are out-of-convention
  scope. Convention says "plain text + git + POSIX shell";
  hooks live in convention's git layer but not its data layer.
- **Probe-time fill** re-derives `applications[]` from git log
  at every probe run. Problem: lose the `by: agent/human`
  metadata that supplements SHA.

## Synthesis

`core/append-application.sh <packet-id> <sha> [files...]`
takes a packet-id and commit SHA, appends a new
`applications[]` entry to the packet's `packet.yaml`. Files
listed after the SHA are recorded as the implementation
files for the commit; if omitted, the script defaults to
listing all `packet.yaml` and the 4 sister files plus
`packet.frontmatter.md`.

A convention author runs it after `git commit`, before
authoring the next commit. The script:

1. Reads `math/<packet-id>/packet.yaml`
2. Validates `<sha>` is 40 hex chars and `by` (defaulting
   to `human` if `--by=agent` not passed)
3. Appends the entry to `applications[]` block, preserving
   the existing block's indentation
4. Wakes up `core/generate-frontmatter.sh` to refresh
   `packet.frontmatter.md` (otherwise drift-check 5 fails)
5. Reports success and exits 0

A typical loop looks like:

```
git commit -m "..."
sh core/append-application.sh <packet-id> HEAD
```

Or batched:

```
sh core/append-application.sh <packet-a> HEAD
sh core/append-application.sh <packet-b> HEAD
git add -A && git commit -m "applications[]: pack a, b"
```

## What this packet commits to

- `core/append-application.sh` exists, POSIX shell only
- Validates sha (40 hex chars)
- Appends an entry preserving YAML formatting
- Regenerates `packet.frontmatter.md` to avoid drift
- Refuses to overwrite existing entries (use `--force`
  to dedupe and replace)

## What this packet does NOT commit to

- Auto-filling on commit (convention does not own git hooks)
- Re-deriving `applications[]` from git log (loss of metadata)
- A `core/probe.sh` extension (probe is read-only)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/friction-append-application-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/friction-append-application-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/friction-append-application-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/friction-append-application-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/friction-append-application-as-packet/packet.yaml)

## Decision

## Thesis
After a developer makes a commit, the convention expects
each packet's `applications[]` to record the commit SHA.
Today this is manual: open `math/<name>/packet.yaml`,
edit, paste SHA. For 1 packet this is fine. For a burst
of commits across N packets, it's friction.
## Antithesis
Two failure modes:
- **Auto-commit hook** runs after every commit and fills
  `applications[]`. Problem: git hooks are out-of-convention
  scope. Convention says "plain text + git + POSIX shell";
  hooks live in convention's git layer but not its data layer.
- **Probe-time fill** re-derives `applications[]` from git log
  at every probe run. Problem: lose the `by: agent/human`
  metadata that supplements SHA.
## Synthesis
`core/append-application.sh <packet-id> <sha> [files...]`
takes a packet-id and commit SHA, appends a new
`applications[]` entry to the packet's `packet.yaml`. Files
listed after the SHA are recorded as the implementation
files for the commit; if omitted, the script defaults to
listing all `packet.yaml` and the 4 sister files plus
`packet.frontmatter.md`.
A convention author runs it after `git commit`, before
authoring the next commit. The script:
1. Reads `math/<packet-id>/packet.yaml`
2. Validates `<sha>` is 40 hex chars and `by` (defaulting
   to `human` if `--by=agent` not passed)
3. Appends the entry to `applications[]` block, preserving
   the existing block's indentation
4. Wakes up `core/generate-frontmatter.sh` to refresh
   `packet.frontmatter.md` (otherwise drift-check 5 fails)
5. Reports success and exits 0
A typical loop looks like:
```
git commit -m "..."
sh core/append-application.sh <packet-id> HEAD
```
Or batched:
```
sh core/append-application.sh <packet-a> HEAD
sh core/append-application.sh <packet-b> HEAD
git add -A && git commit -m "applications[]: pack a, b"
```
## What this packet commits to
- `core/append-application.sh` exists, POSIX shell only
- Validates sha (40 hex chars)
- Appends an entry preserving YAML formatting
- Regenerates `packet.frontmatter.md` to avoid drift
- Refuses to overwrite existing entries (use `--force`
  to dedupe and replace)
## What this packet does NOT commit to
- Auto-filling on commit (convention does not own git hooks)

## Task

# friction-append-application — task

## Problem

`packet.yaml:applications[]` records commit SHAs that
implement each packet. Today this is hand-edited after
every commit that adds a packet or fills it out. For
developers who batch-commit, the friction compounds: a
20-packet batch means 20 manual edits.

## Desired outcome

- `sh core/append-application.sh <packet-id> <sha> [files...]
  [--by=agent|human]` appends an `applications[]` entry
  with valid sha and optional file list
- `core/generate-frontmatter.sh` is re-run automatically
  so verifier's drift-check 5 passes
- Existing entries are preserved unless `--force` is passed
  (in which case duplicate SHAs are deduped)

## Constraints

- POSIX shell only
- Accepts 40-char hex sha (with or without `0...0` placeholder
  already converted by the agent)
- Default `by: agent` if not specified
- Single-file semantic: edit one packet.yaml, regenerate
  one packet.frontmatter.md, leave others alone

## Assumptions

```yaml
task_id: friction-append-application
assumptions:
  - id: A1
    statement: "applications[] can be safely appended to by a script"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      packet.yaml is plain YAML. Appending a new list entry
      preserves existing entries; verify.sh's structural
      checks don't depend on entry order or count.

  - id: A2
    statement: "Generating packet.frontmatter.md after appending keeps verifier happy"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      verify.sh drift-check 5 calls core/generate-frontmatter.sh
      --check. The check passes iff frontmatter matches packet.yaml.
      If only the YAML is changed, calling generate-frontmatter
      resyncs frontmatter and re-passes the check.

  - id: A3
    statement: "Deduplication by --force is conservative"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      When --force replaces an existing entry, the replacement
      keeps the original placeholders or fills in more detail.
      Convention authors self-inspect.

  - id: A4
    statement: "appender is single-file deterministic"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Operates only on `math/<id>/packet.yaml` and the
      frontmatter file. Other packets untouched.

  - id: A5
    statement: "appender does NOT auto-commit"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      Convention does not own git. Author runs `git add -A
      && git commit` separately, with the appender just
      staging changes.
```

## Refinement

# Refinement: friction-append-application

## State

- **pre**: After `git commit`, developer manually edits
  `packet.yaml:applications[]`, regenerates `packet.frontmatter.md`,
  runs `core/verify.sh` to confirm. ~3 manual steps per
  packet-change commit.
- **post**: `core/append-application.sh` does all three steps.
  1 shell call replaces 3 manual steps. Drift-check passes
  on first run.

## Operation

- Created `math/friction-append-application-as-packet/` (5 files)
- Created `core/append-application.sh` (~70 lines)

## Mapping (artifact → convention axis)

| Artifact | Axis |
|----------|------|
| `core/append-application.sh` | D53 (this packet) |
| this packet | D53 owner |

## Invariant preservation

- 45 existing packets unchanged
- `core/verify.sh` structure unchanged
- The script is **read-then-write** to one packet.yaml
  at a time, no global mutation

## Test obligation

- `sh core/append-application.sh <id> HEAD --by=agent` adds
  one entry, preserves existing entries, regenerates
  `packet.frontmatter.md`
- `sh core/append-application.sh --force <id> <sha>` replaces
  a duplicate-sha entry instead of appending
- An invalid sha (e.g., 39 chars) exits non-zero

## Runtime check

- After `git commit <msg>`, run `sh core/append-application.sh
  <id> HEAD` once. The next `sh core/verify.sh` reports 0
  errors and the packet's applications[] reflects the
  commit.

## Cross-reference

- `core/packet-filler.sh` (D10) — packet factory
- `core/extract-packet.sh` — round-trip
- `core/generate-frontmatter.sh` — frontmatter sync
- `core/verify.sh` — drift-check 5
- `core/coverage.yaml` — D53 row

