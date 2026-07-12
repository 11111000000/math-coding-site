# friction-fill-many — batch + dry-run on convention builder

## Thesis

Each packet today requires 1 LLM call + 1 shell call
to `core/packet-filler.sh`. For developers adding multiple
packets (a new theory set, a brownfield import, a refactor
across N packets), this is N tool round-trips. For a
convention author validating draft spec.yaml files, there's
no preview: the filler creates files immediately.

Two frictions remain after Phase E:

- **N packets = N tool calls.** Could be 1 if all specs
  live in a directory and the filler accepts the directory.
- **No preview.** A typo in spec.yaml creates a junk packet
  (5 files you have to delete by hand).

## Antithesis

Two failure modes:

- **Recursive batch**: `fill-many` calls filler in a loop,
  fill-many becomes a wrapper around filler, no new logic.
- **Implicit dry-run**: `--dry-run` requires every script
  to implement dry-run logic, easy to forget or get wrong.

## Synthesis

`core/fill-many.sh` accepts a directory containing `*.yaml`
spec files. For each spec:

1. Read `title:` from spec.
2. Slugify: lowercase, dashes, strip non-`[a-z0-9-]`.
3. Derive packet-id = slug (`math/<id>/`).
4. Pass to `sh core/packet-filler.sh <id> --from-file <spec>`.

On error, log and continue (don't abort batch).

A new flag `--dry-run` on `core/packet-filler.sh` parses the
spec, computes paths, and **echoes** what *would* happen
without writing files. `fill-many.sh --dry-run <dir>` passes
the flag through.

This means:

- Batch creation: `core/fill-many.sh specs/`
- Preview batch: `core/fill-many.sh --dry-run specs/`
- Single: `core/packet-filler.sh <id> --from-file <spec>`
- Preview single: `core/packet-filler.sh --dry-run <id> --from-file <spec>`

## What this packet commits to

- `core/fill-many.sh` accepts directory of `*.yaml` specs
- `--dry-run` flag on `core/packet-filler.sh` (refactor)
- `core/fill-many.sh --dry-run <dir>` forwards to filler
- Errors in single spec don't abort batch
- Convention's friction from Phase E remains at "1 LLM-call
  per packet" for batch use (the file-write per spec runs
  in 0.3 sec per packet on a typical machine)

## What this packet does NOT commit to

- Parallel batch creation (1 spec at a time, sequential)
- A "live template" generator beyond what filler offers
- Detecting conflicts with existing packets

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/friction-fill-many-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/friction-fill-many-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/friction-fill-many-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/friction-fill-many-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/friction-fill-many-as-packet/packet.yaml)

## Decision

## Thesis
Each packet today requires 1 LLM call + 1 shell call
to `core/packet-filler.sh`. For developers adding multiple
packets (a new theory set, a brownfield import, a refactor
across N packets), this is N tool round-trips. For a
convention author validating draft spec.yaml files, there's
no preview: the filler creates files immediately.
Two frictions remain after Phase E:
- **N packets = N tool calls.** Could be 1 if all specs
  live in a directory and the filler accepts the directory.
- **No preview.** A typo in spec.yaml creates a junk packet
  (5 files you have to delete by hand).
## Antithesis
Two failure modes:
- **Recursive batch**: `fill-many` calls filler in a loop,
  fill-many becomes a wrapper around filler, no new logic.
- **Implicit dry-run**: `--dry-run` requires every script
  to implement dry-run logic, easy to forget or get wrong.
## Synthesis
`core/fill-many.sh` accepts a directory containing `*.yaml`
spec files. For each spec:
1. Read `title:` from spec.
2. Slugify: lowercase, dashes, strip non-`[a-z0-9-]`.
3. Derive packet-id = slug (`math/<id>/`).
4. Pass to `sh core/packet-filler.sh <id> --from-file <spec>`.
On error, log and continue (don't abort batch).
A new flag `--dry-run` on `core/packet-filler.sh` parses the
spec, computes paths, and **echoes** what *would* happen
without writing files. `fill-many.sh --dry-run <dir>` passes
the flag through.
This means:
- Batch creation: `core/fill-many.sh specs/`
- Preview batch: `core/fill-many.sh --dry-run specs/`
- Single: `core/packet-filler.sh <id> --from-file <spec>`
- Preview single: `core/packet-filler.sh --dry-run <id> --from-file <spec>`
## What this packet commits to
- `core/fill-many.sh` accepts directory of `*.yaml` specs
- `--dry-run` flag on `core/packet-filler.sh` (refactor)
- `core/fill-many.sh --dry-run <dir>` forwards to filler
- Errors in single spec don't abort batch
- Convention's friction from Phase E remains at "1 LLM-call
  per packet" for batch use (the file-write per spec runs
  in 0.3 sec per packet on a typical machine)
## What this packet does NOT commit to
- Parallel batch creation (1 spec at a time, sequential)

## Task

# friction-fill-many — task

## Problem

Creating N packets today costs N LLM-calls + N tool-calls.
Previewing a single spec before committing doesn't exist.

## Desired outcome

- `core/fill-many.sh specs-dir/`: walks `specs-dir/*.yaml`,
  derives packet-id from `title:`, runs `core/packet-filler.sh`
  for each. Reports `created:` / `skipped (exists):` /
  `error:` per packet.
- `core/fill-many.sh --dry-run specs-dir/`: dry-run mode,
  forwards to filler's `--dry-run`.
- `core/packet-filler.sh --dry-run <id> --from-file <spec>`:
  parses spec, computes target paths, **echoes** what would
  happen, exits 0 without writing.

## Constraints

- POSIX shell only
- Batch continues on per-spec errors (don't abort on 1/20
  fail)
- `--dry-run` must NOT write any files
- Packet-id derived from spec title via POSIX-substitution
  (lowercase, dashes, no spaces)

## Assumptions

```yaml
task_id: friction-fill-many
assumptions:
  - id: A1
    statement: "Slug from `title:` is unambiguous if titles are unique within a batch"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      Slug algorithm: lowercase, [a-z0-9-] only, collapse
      spaces to dashes, strip leading/trailing dashes. Two
      distinct titles can produce same slug; in that case the
      second packet fails with "exists" error from filler.

  - id: A2
    statement: "--dry-run captures enough info to verify a batch before commit"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Dry-run echoes target paths (math/<id>/packet.yaml etc.)
      per packet. Author confirms paths match expectations.

  - id: A3
    statement: "POSIX shell can slugify without external tools"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      `printf '%s' "$x" | tr 'A-Z' 'a-z' | sed 's/[^a-z0-9]/-/g'` is
      standard POSIX.

  - id: A4
    statement: "Batch continues on per-spec error"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      Convention says epistemic honesty: don't hide errors.
      A failing packet should be visible in batch output.
      Continue so other packets still get created.

  - id: A5
    statement: "fill-many does NOT call the LLM (passive deployer)"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Mirror core/packet-filler.sh boundary: LLM lives in
      the agent; convention stays passive deployer.
```

## Refinement

# Refinement: friction-fill-many

## State

- **pre**: 1 packet = 1 LLM-call + 1 tool-call; no batch
  mode; no dry-run preview.
- **post**: `core/fill-many.sh specs/` runs N filler calls
  sequentially; `--dry-run` on filler previews 1 packet;
  `fill-many --dry-run` previews the batch.

## Operation

- Created `math/friction-fill-many-as-packet/` (5 files)
- Created `core/fill-many.sh` (~60 lines)
- Modified `core/packet-filler.sh`: add `--dry-run` flag

## Mapping (artifact → convention axis)

| Artifact | Axis |
|----------|------|
| `core/fill-many.sh` | D52 (this packet) |
| `core/packet-filler.sh --dry-run` | D52 implementation |
| `math/friction-fill-many-as-packet/` | D52 owner packet |

## Invariant preservation

- 45 existing packets pass `core/verify.sh` after addition
- `core/packet-filler.sh` retains its existing interface
  when `--dry-run` is not passed
- No new external dependencies

## Test obligation

- `sh core/packet-filler.sh --dry-run <id> --from-file spec.yaml`
  prints `Plan: 6 files in math/<id>/...` and exits 0 without
  writing
- `sh core/fill-many.sh <dir>/` creates N packets in order
- A broken `*.yaml` in dir/ logs and continues
- `sh core/fill-many.sh --dry-run <dir>/` echoes plan lines
  for each and exits 0

## Runtime check

- For large batches (>10), each packet creation is
  ~0.3s; a 20-packet batch is ~6 seconds
- After batch, `core/verify.sh` confirms all 5-file
  structure

## Cross-reference

- `core/packet-filler.sh` (D10) — the underlying tool
- `math/packet-filler-as-packet/` — owner of the filler
- `math/friction-excludes-as-packet/` — sibling friction-axis

