# ADR — supersession-block


## Problem

A packet with `lifecycle: superseded` documents an act of changing
a previous decision. Without a structured `supersession` block,
readers cannot tell:
- **what** was replaced (the old decision's id)
- **why** it was replaced (a reason)
- **how** it was replaced (replaced vs archived vs deprecated)
- **when** it was replaced (the deprecated_at date)

Without this metadata, decision-history packets become
incomprehensible. v1.1.0 introduced this block, v1.1.1 uses it
in 2 packets, but the block's structure wasn't itself a packet.

## Desired outcome

A packet with `lifecycle: superseded` MUST include a
`supersession:` block with 4 fields:

```yaml
supersession:
  supersedes: <task_id>      # the replaced packet's task_id
  reason: "<text>"           # why the replacement
  type: replaced|archived|deprecated  # how it's replaced
  deprecated_at: "2026-07-04"  # ISO date when the change happened
```

`supersedes` should point to an existing or historical packet
(or be a virtual decision id if no packet ever documented the
replaced state, e.g., `v1.0.0-substrate-implicit`).

`type` distinguishes:
- `replaced` — the new packet supersedes (preferred for partial changes)
- `archived` — the old packet is kept for history but not replaced-by-name
- `deprecated` — the old packet is still valid but discouraged

## Constraints

- All 4 fields required when `lifecycle: superseded`
- `supersedes` is a task_id (string) or marked-as-virtual
- `reason` is non-empty
- `type` is one of 3 values
- `deprecated_at` is ISO 8601 date

## Alternatives considered

- **Implicit (no block, just lifecycle: superseded):** rejected —
  readers can't tell what was replaced or why
- **Single field `supersedes` only:** rejected — `reason` and
  `type` carry distinct information that grep for `supersedes`
  alone can't recover
- **Free-form string:** rejected — divergent verbiage, no
  machine-checkable structure
- **3 fields without `type`:** rejected — `replaced` vs
  `archived` vs `deprecated` are distinct relationships
  between the new and old packets

## Consequences

- Decision-history packets are readable: "what changed, why,
  when, how"
- Grep `supersedes: <id>` finds the packet that replaced it
- Convention can audit its own evolution
- `core/verify.sh` checks 4 fields are present when
  `lifecycle: superseded`
- `specs/self-check/` validates `supersedes` value exists
  (when not marked virtual)
