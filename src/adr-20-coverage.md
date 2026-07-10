# ADR — coverage


## Problem

The math-coding convention has a **fractal property**: every
decision with intent should be a packet. But until v1.2.0,
only 4 decisions about the convention itself were documented
as packets — out of at least 24 decisions that the convention's
own schemas (in `core/packet-schema.md`, `theories/*.md`, and
`core/core.md`) implicitly encode.

This is **partial self-application**: the convention says one
thing and does another. The recursive property is not enforced.

## Desired outcome

A **machine-readable inventory** of every key decision in
math-coding, with:
- unique decision id
- severity (how much a missing packet hurts the convention)
- location (where in `core/` or `theories/` the decision is encoded)
- packet path (the packet documenting the decision; `null` means gap)

The inventory is consumed by `specs/self-check/` — a verifier
that **fails** when any decision has `severity: critical` and
`packet: null`.

## Constraints

- must be plain YAML (machine-parseable)
- must NOT duplicate content — `coverage.yaml` is data, not prose
- must grow over time (add D25, D26, ... as convention evolves)
- must be readable by humans despite being machine-consumed

## Coverage status (after v1.2.0)

24 decisions identified:
- **4** documented in v1.0.0/v1.1.0 (existing packets)
- **20** documented in v1.2.0 (new packets in `specs/<name>/`)
- **0** open gaps (by definition, since v1.2.0 fills them)

Future additions: any new decision encoded in `core/` or
`theories/` MUST either get a packet OR be added to this
inventory with explicit `severity: low` and rationale.

## Conventions

- `D-NN` ids are stable (do not renumber when adding new ones)
- `severity` values: `critical` (CI-fail), `high` (CI-warn),
  `medium` (CI-info), `low` (informational)
- `packet: null` → GAP for that decision (verify.sh fails
  on critical; warns on high; reports on medium)
- `packet: <path>` → relative path from repo root to the packet
- `superseded_by` (if present) → newer packet replaces this one

## Consequences

- v1.2.0 introduces **fully recursive** self-application:
  convention specifies its own rules, those rules are documented
  as packets, and a verifier enforces the documentation is current
- Adding a new convention-level decision without a packet now
  requires explicit downdate in `coverage.yaml` (or it fails CI)
- The convention is **self-enforcing**: structural drift is caught
