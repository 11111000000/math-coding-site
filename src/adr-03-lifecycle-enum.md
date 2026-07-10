# ADR — lifecycle-enum


## Problem

Every packet moves through stages: first a sketch, then working
code, then verified, then eventually deprecated or archived.
Without an explicit lifecycle vocabulary, different agents
use different words ("draft", "in-progress", "done", "dead") and
tracking progress across a long-lived convention becomes a chore.

v1.0.0 introduced 5 values (`sketch|working|verified|deprecated|archived`).
v1.1.0 added `superseded` for packets that documented decisions
later replaced — but the rationale was not itself a packet.

## Desired outcome

A packet's `lifecycle` field has exactly one of 6 values:

| Value | Meaning |
|---|---|
| `sketch` | Initial state, before code is written |
| `working` | Code exists; verifier hasn't run or hasn't passed |
| `verified` | Verifier passed; packet ready for use |
| `deprecated` | Superseded by another packet; kept for reference |
| `archived` | Removed from active use; kept for history only |
| `superseded` | Used internally for packets documenting historical decisions |

`superseded` is **distinct from** `deprecated`: a deprecated
packet is replaced by a better one; a superseded packet
documents the **act of changing** a previous decision.

The `superseded` packets have a `supersession:` block with
`supersedes: <id>`, `reason: <text>`, `type: replaced` (or
`archived`/`deprecated`), `deprecated_at: <ISO date>`.

## Constraints

- Plain enum (string), parsed by `core/verify.sh`
- Forward-compatible: new values can be added without breaking
  existing consumers
- Must be valid even when packet is `sketch` (no other fields yet)

## Alternatives considered

- **Free-form string:** rejected — agents diverge; tracking breaks
- **5 values (no superseded):** rejected — can't track decision-history
  packets cleanly; lifecycle collapses two distinct concepts
- **Status enum separate from lifecycle:** rejected — lifecycle
  is a state machine, status is its current position
- **Lifecycle + sub-states (e.g., `working-in-progress`, `working-verified`):**
  rejected — granularity creates 12+ values, cognitive overload

## Consequences

- One state machine vocabulary for all packets
- Decision-history packets (`v1.1.0-substrate-decision`,
  `v1.1.0-self-application-decision`) clearly marked `superseded`
- Convention users can grep `lifecycle: superseded` to find
  historical packets
- `core/verify.sh` validates enum values (added `superseded`
  in v1.1.0)
- Future packets documenting convention changes get the same
  treatment
