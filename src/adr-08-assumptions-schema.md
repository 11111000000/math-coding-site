# ADR — assumptions-schema


## Problem

A packet's epistemic context — what it assumes to be true — is
central to its reproducibility. Without a fixed schema, agents
write assumptions inconsistently:
- fields named `note`, `comment`, `desc`, `text` (not `statement`)
- confidence written as `prob`, `p`, `0.5` (not `confidence: 0.5`)
- some assumptions carry epistemic markers, others don't

## Desired outcome

`assumptions.yaml` is a YAML document with a fixed shape:

```yaml
task_id: <id>           # same as packet.yaml
assumptions:
  - id: A1               # pattern ^A\d+$, unique within file
    statement: "<text>"  # the assumption itself
    status: user-confirmed | agent-inferred | open
    epistemology: fact | hypothesis | judgment | unknown
    confidence: 0.0-1.0  # optional, recommended for hypothesis
```

Each `assumptions.yaml` has at least 1 entry.

`status` tells the agent **who** set the assumption:
- `user-confirmed` — explicitly validated by a human
- `agent-inferred` — proposed by the writing agent
- `open` — pending clarification

`confidence` is the agent's calibration of how likely the
assumption is to be true. Used by `theories/confidence.md` to
compute uncertainty.

## Constraints

- All 4 required fields per entry (status + epistemology + id + statement)
- `id` matches `^A\d+$`
- `task_id` matches `packet.yaml:task_id`
- Confidence ∈ [0, 1]
- Length of `statement` ≥ 1 word

## Alternatives considered

- **Free-form:** rejected — verifier can't validate
- **5 fields per entry:** rejected — cognitive overload
- **No `status`:** rejected — can't distinguish user-confirmed
  from agent-inferred; affects what agents do with the assumption
- **Mandatory confidence:** rejected — confidence is meaningless
  for `fact` entries; only `hypothesis` benefits
- **Confidence as enum (low/mid/high):** rejected — number is more
  useful for downstream math (information content)

## Consequences

- Verifier can mechanically check field presence and enum values
- Agents reading assumptions.yaml know the structure
- `core/verify.sh` validates enums; `specs/self-check/` validates
  schema shape (id pattern, confidence range)
- Convention is unambiguous: every reader knows where each piece
  of epistemic metadata lives
