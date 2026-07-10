# ADR — epistemic-markers


## Problem

When an agent reads an assumption, it needs to know **how**
to treat it:
- "User is authenticated" → **fact** (assume true, verify the
  system uses it, but don't challenge the claim itself)
- "Latency budget is 100ms" → **hypothesis** (search for evidence,
  measure, refine)
- "Use bcrypt for passwords" → **judgment** (don't challenge —
  respect a human design choice)
- "What about MFA?" → **unknown** (ask, don't proceed)

Without an explicit marker, agents either over-trust or
under-challenge. They can't distinguish "treat as fact" from
"search for evidence" from "ask user".

## Desired outcome

Each `assumptions.yaml` entry has an `epistemology` field with
one of 4 markers:

| Marker | Meaning | Agent action |
|---|---|---|
| `fact` | Taken to be true | verify USAGE, don't challenge the claim |
| `hypothesis` | Conjecture, evidence sought | search, measure, refine |
| `judgment` | Human design choice | respect, don't challenge |
| `unknown` | Open question | ask user, don't proceed |

The action protocol is documented in `theories/epistemic.md` —
agents reading an entry apply the action.

## Constraints

- Enum (string), parsed by `core/verify.sh`
- Required on every `assumptions.yaml` entry (every assumption
  carries an epistemic marker)
- Single marker per entry (compound cases split into multiple
  assumptions)

## Alternatives considered

- **Boolean `verified: true|false`:** rejected — doesn't capture
  the 4 distinct epistemic stances
- **Free-form description:** rejected — agents diverge; can't
  have a fixed action protocol
- **3 markers (drop `unknown`):** rejected — `unknown` is the
  state of "I don't have an opinion"; needs distinct handling
  from `hypothesis` (no data yet vs. partial data)
- **Confidence only (no marker):** rejected — confidence is a
  number, marker is a category; both useful
- **YAGNI: only `fact` and `judgment`:** rejected — agents need
  to express the difference between "I think this" and
  "I have no idea"; both are common states

## Consequences

- Agents know what to do with each assumption
- Convention is LLM-actionable (a fixed marker → fixed action)
- `theories/epistemic.md` provides the formal model
- `theories/confidence.md` complements with `confidence: c` per
  assumption (different axis — certainty, not stance)
- Future: a 5th marker (e.g., `deprecated` for an assumption no
  longer relevant) can be added without breaking
