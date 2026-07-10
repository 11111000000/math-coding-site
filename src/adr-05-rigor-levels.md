# ADR — rigor-levels


## Problem

math-coding is for projects at all scales — from a 1-line
script to a cryptographic protocol. Forcing every packet through
the same level of formalization (e.g., require a TLA+ model
for every CRUD endpoint) makes the convention unusable for
small projects.

But users want a path: when their project grows in complexity,
how do they know what to add next?

## Desired outcome

A packet's `rigor` field has one of 4 levels:

| Level | Means | Required theories |
|---|---|---|
| `light` | default, no formal apparatus | none required |
| `property` | property-based testing | theories with `epistemics: fact`-marked invariants |
| `temporal` | LTL, modal logic, TLA+ | theories/ltl.md, theories/modal.md |
| `proof` | formal proofs (Coq) | theories/curry-howard.md, theories/refinement.md |

`rigor: light` is the **default**. Agents at light rigor do NOT
need to read `theories/curry-howard.md` or `theories/modal.md` —
they are opt-in by level.

## Constraints

- Enum (string), parsed by `core/verify.sh`
- Default = `light` (init-packet.sh sets this)
- Upgrading rigor is **additive**, not breaking: a `light` packet
  works in a `proof` project (the `proof` toolkit just ignores
  what `light` doesn't use)

## Alternatives considered

- **No rigor field:** rejected — no path to scale; users upgrade
  ad-hoc without convention guidance
- **Free-form rigor:** rejected — agents diverge; rigor becomes
  meaningless
- **More levels (6+, with `minimal`, `partial`, etc.):** rejected —
  cognitive overload; 4 levels already cover the practical spectrum
- **Rigor per-packet AND per-project:** rejected — packet rigor
  is enough; project rigor aggregates from packets
- **Mandatory TLA+ for any non-trivial packet:** rejected — same
  reason as `light` default; agents must be able to start simple

## Consequences

- New users start at `light` and ship something today
- Growing projects opt into `property`/`temporal`/`proof` deliberately
- Theories are tagged by rigor level in `core/core.md#rigor-levels`
  — agents at light skip advanced theories
- Future: a packet going from `light` to `property` may have an
  accompanying `substrate: pbt` or `substrate: alloy` decision
- Convention does not require heavy toolchain upfront
