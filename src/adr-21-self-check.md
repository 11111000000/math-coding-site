# ADR — self-check


## Problem

`core/verify.sh` validates packet structure (3 required files,
required fields, valid enum values) for 17 packets. But it does
NOT verify:
- cross-packet integrity (task_id uniqueness, depends_on DAG,
  verifier paths exist)
- semantic invariants (task.md sections ≥10 words, assumptions
  confidence ∈ [0,1], id pattern `^A\d+$`)
- recursive coverage (every key decision has a packet)

Without these checks, conventions drift: someone adds a packet
with a duplicated task_id, or a `lifecycle:superseded` without a
`supersession` block, or a new convention-level decision without
documenting it.

## Desired outcome

`specs/self-check/verify-structural.sh` extends verification with
three phases:

### Phase 1: schema checks (extends `core/verify.sh`)
- All required fields in `packet.yaml`, `task.md`, `assumptions.yaml`
- task.md sections ≥10 words each
- assumptions.yaml: `id` pattern `^A\d+$`, `status` enum,
  `epistemology` enum, `confidence ∈ [0,1]`
- `lifecycle:superseded` ⇒ `supersession` block with 4 fields

### Phase 2: cross-packet integrity
- `task_id` unique across all packets
- `depends_on: [...]` ⇒ all referenced packets exist
- `depends_on` form a DAG (no cycles)
- `verifier.command` paths exist or are abstract (e.g., `core/verify.sh`)

### Phase 3: recursive coverage
- Reads `specs/coverage/coverage.yaml`
- For each decision with `severity: critical` and `packet: null`
  ⇒ **CI FAIL** (`exit 1`)
- For `severity: high` and `packet: null` ⇒ **WARN** (printed, doesn't fail)
- For `severity: medium` and `packet: null` ⇒ **INFO** (printed)
- For `severity: low` and `packet: null` ⇒ silent (coverage may
  legitimately have low-severity gaps)

The verifier is **plain POSIX shell** — no Python, no Java, no
dependencies. Extends `core/verify.sh` rather than replacing it.

## Constraints

- POSIX shell only
- Pure read-only operations on `coverage.yaml` and packet files
- Exit 0 iff no critical violations
- Exit 1 iff any critical violation
- Print all warnings/info before deciding exit code

## Alternatives considered

- **Python verifier (MathCodingFractal had `bin/verify.py`):**
  rejected — adds Python dependency; breaks plain-text + git
- **Single `verify.sh` extending current structural checks:** rejected
  — separate phase makes the recursive coverage role explicit
- **External tools (yamllint, actionlint, etc.):** rejected — adds
  dependency; convention must run anywhere
- **Verifier inside `core/`:** rejected — `core/` is the convention
  itself, not its own verifier; separation keeps roles clear

## Consequences

- Every convention change requires verification to also pass
- `core/verify.sh` stays (structural-only) — historical compat
- `specs/self-check/verify-structural.sh` is the new full verifier
- CI runs both (or self-check alone)
- Convention can't drift silently
- Bug-fixes to the verifier are themselves packets (the
  verifier's `task.md` documents its own purpose)
