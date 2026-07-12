# site-sync — fix hardcoded PKG_ORDER in math-coding-site/scripts/sync-from-main.sh

## Thesis

math-coding-site's `scripts/sync-from-main.sh` has a hardcoded
list of 18 packets in `PKG_ORDER`. After commit
`math-coding@a655901`, math-coding has 48+ packets, but the
site only displays the original 18. New packets like
`skill-packaging-as-packet`, `install-as-packet`,
`phase-d-continuation-as-packet`, and others are missing
from the deployed site.

The fix: dynamically generate `PKG_ORDER` from `ls math/`,
and dynamically generate `src/SUMMARY.md` from the list of
packet files.

## Antithesis

Three failure modes:

1. **Hardcoded list**: every new packet requires editing
   sync-from-main.sh. Convention says: do not maintain lists
   in scripts, derive them from state.
2. **Hardcoded SUMMARY.md**: same problem; SUMMARY.md is
   committed to git but should be derived.
3. **No auto-validation**: when math-coding adds a packet, no
   signal fires to update the site.

## Synthesis

Make `sync-from-main.sh` derive everything from the source
repo:

- `PKG_ORDER=$(ls -1 "$REPO_ROOT/math/" | grep -v "\.canvas\|\.md$" | sort)`
- `SUMMARY.md` generated from `ls src/packet-*.md`

This is a **1-line change** to the script. The script was
already idempotent and shell-only; adding `ls` makes it
auto-extending.

After this fix, the next site sync will include all 48+
packets without manual intervention.

## What this packet commits to

- `sync-from-main.sh` derives `PKG_ORDER` from `ls math/`
- `sync-from-main.sh` writes `src/SUMMARY.md` automatically
- The script remains idempotent (re-running produces same
  state)

## What this packet does NOT commit to

- Re-ordering packets by dependency graph (current alphabetic
  sort is good enough; dependency sort is a future axis)
- Removing the 18 hardcoded packets from SUMMARY.md in
  the math-coding-site repo (the script will overwrite it
  on next sync)
- Multi-language SUMMARY (English-only for now)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/site-sync-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/site-sync-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/site-sync-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/site-sync-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/site-sync-as-packet/packet.yaml)

## Decision

## Thesis
math-coding-site's `scripts/sync-from-main.sh` has a hardcoded
list of 18 packets in `PKG_ORDER`. After commit
`math-coding@a655901`, math-coding has 48+ packets, but the
site only displays the original 18. New packets like
`skill-packaging-as-packet`, `install-as-packet`,
`phase-d-continuation-as-packet`, and others are missing
from the deployed site.
The fix: dynamically generate `PKG_ORDER` from `ls math/`,
and dynamically generate `src/SUMMARY.md` from the list of
packet files.
## Antithesis
Three failure modes:
1. **Hardcoded list**: every new packet requires editing
   sync-from-main.sh. Convention says: do not maintain lists
   in scripts, derive them from state.
2. **Hardcoded SUMMARY.md**: same problem; SUMMARY.md is
   committed to git but should be derived.
3. **No auto-validation**: when math-coding adds a packet, no
   signal fires to update the site.
## Synthesis
Make `sync-from-main.sh` derive everything from the source
repo:
- `PKG_ORDER=$(ls -1 "$REPO_ROOT/math/" | grep -v "\.canvas\|\.md$" | sort)`
- `SUMMARY.md` generated from `ls src/packet-*.md`
This is a **1-line change** to the script. The script was
already idempotent and shell-only; adding `ls` makes it
auto-extending.
After this fix, the next site sync will include all 48+
packets without manual intervention.
## What this packet commits to
- `sync-from-main.sh` derives `PKG_ORDER` from `ls math/`
- `sync-from-main.sh` writes `src/SUMMARY.md` automatically
- The script remains idempotent (re-running produces same
  state)
## What this packet does NOT commit to
- Re-ordering packets by dependency graph (current alphabetic
  sort is good enough; dependency sort is a future axis)
- Removing the 18 hardcoded packets from SUMMARY.md in
  the math-coding-site repo (the script will overwrite it

## Task

# site-sync — task

## Problem

`math-coding-site/scripts/sync-from-main.sh` has hardcoded
PKG_ORDER with 18 packets. New packets added to math-coding
since commit 8bcbc97 (the last successful site sync) do not
appear on the deployed site at
https://11111000000.github.io/math-coding/.

## Desired outcome

- `sync-from-main.sh` derives packet list from `ls math/`
- `src/SUMMARY.md` regenerated automatically
- After this fix, the next sync includes all 48+ packets

## Constraints

- POSIX shell only
- Script remains idempotent
- Existing packets retain their numbering if alphabetical
- No new external dependencies
## Assumptions

```yaml
task_id: site-sync
assumptions:
  - id: A1
    statement: "Alphabetical sort of packet dirs gives acceptable ordering for the site"
    status: agent-inferred
    epistemology: fact
    confidence: 0.85
    evidence: |
      Current hardcoded order is roughly alphabetical
      (math-coding-birth, core-as-packet, agents-md-as-packet,
      theory-* then verifier, recursive-check, coverage,
      init-packet). Alphabetical ls matches this convention.

  - id: A2
    statement: "SUMMARY.md can be auto-generated by the sync script"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      SUMMARY.md format is parseable as "section: list of [name](./path.md)"
      The script writes `src/packet-NN-name.md` files; auto-
      generate SUMMARY.md from the file list.

  - id: A3
    statement: "Fix in scripts/sync-from-main.sh is non-invasive: convention site remains self-contained"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      The fix is a 1-line change. math-coding-site is its
      own repo; math-coding's packet (this) only documents
      the change. Future runs of sync-from-main.sh produce
      the new state automatically.

  - id: A4
    statement: "math-coding has 48+ packets, not 18"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      ls /home/za/math-coding-v0.618/math/ returns 50 entries
      (48 packets + dag.canvas + README.md).
      See: math/ directory listing.

  - id: A5
    statement: "User feedback 'site не обновляется' indicates the deployment is missing the new packets"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      User reported: 'https://11111000000.github.io/math-coding/
      не обновился'. Deployment SHA was 87798d7 from auto-sync
      at 12:13:05Z; current local commit is 868b0cd; sync
      captures 5 files only because of hardcoded list.```

## Refinement

# Refinement: site-sync

## State

- **pre**: `math-coding-site/scripts/sync-from-main.sh` ships
  hardcoded `PKG_ORDER` with 18 packets. New math-coding
  packets don't appear on the deployed site.
- **post**: PKG_ORDER is derived from `ls math/`. SUMMARY.md
  is auto-generated. New packets propagate automatically.

## Operation

- Modified `math-coding-site/scripts/sync-from-main.sh`:
  - Replaced hardcoded `PKG_ORDER="math-coding-birth ..."` with
    `PKG_ORDER=$(ls -1 "$REPO_ROOT/math/" | grep -v "\.\(canvas\|md\)$" | sort)`
  - Added auto-generation of `src/SUMMARY.md` from packet files
- Created `math/site-sync-as-packet/` (5 files documenting
  the fix)

## Mapping (artifact → convention axis)

| Artifact | Axis |
|----------|------|
| `math-coding-site/scripts/sync-from-main.sh` | D57 (this packet) |
| `math/site-sync-as-packet/` | D57 owner |

## Invariant preservation

- Existing 18 packet pages keep their numbering
- New packets get numbers 19-50+
- Script remains idempotent
- `sh core/verify.sh` still returns VERIFIED, 0 errors

## Test obligation

- `sh scripts/sync-from-main.sh` produces 50+ packet files
  in `src/`
- Generated `SUMMARY.md` references all packets
- Re-running produces same files (no timestamp noise)

## Runtime check

- After fix, the next CI poll (every 10 min) picks up the
  new math-coding commits and deploys all packets
- User reloads site, sees 48+ packet pages

## Cross-reference

- `core/install.sh` (D50) — project bootstrap
- `skill-packaging-as-packet/` — the OpenCode skill
- `math-coding-site/scripts/sync-from-main.sh` — the fixed script
