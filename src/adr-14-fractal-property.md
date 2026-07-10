# ADR — fractal-property


## Problem

math-coding says: "every decision with intent is a packet".
This is its **fractal property** — every layer of the convention
must itself be a packet, recursively.

But until v1.2.0, the convention had:
- 5 packets documenting specific decisions (substrate tree,
  self-application, theory layer ×2)
- **at least 24** implicit decisions in `core/` and `theories/`
  without packets (lifecycle enum, substrate enum, rigor levels,
  epistemic markers, verifier field, etc.)

This is **partial self-application**: the convention says one
thing and does another. v0.1 had a more complete fractal
property (TLA+ self-spec, 11-theory curated set with
dedicated self-spec packet) — v0.x sacrificed recursion for
simplicity.

## Desired outcome

The convention MUST satisfy its fractal property:
- Every key decision encoded in `core/` or `theories/` MUST
  have a corresponding packet in `specs/<decision>/`
- The correspondence is tracked in `specs/coverage/coverage.yaml`
- A decision packet with `severity: critical` and `packet: null`
  FAILS `specs/self-check/verify-structural.sh` (CI block)

This packet itself is **one of the per-decision packets** that
satisfies the fractal property — it documents the
meta-decision that math-coding is recursive.

## Constraints

- All 24+ key decisions documented (in v1.2.0)
- `specs/coverage/` is the single inventory of these decisions
- `specs/self-check/` is the recursive verifier
- Convention documentation (README, core/core.md, theories/*.md)
  enforces the property explicitly

## Alternatives considered

- **Continue with partial self-application (v1.1.x):** rejected —
  convention's own claim was inconsistent with its structure
- **Re-implement v0.1 with TLA+ self-spec:** rejected — breaks
  plain-text + git mandate (no Java toolchain)
- **Single self-spec packet that lists everything (not per-decision):**
  rejected — too coarse; per-decision packets enable
  independent evolution
- **No recursive verifier, manual audit:** rejected — conventions
  without enforcement tools drift; agents and humans both forget

## Consequences

- Convention is **fully recursive**: every key decision has a packet
- Adding a new convention-level decision requires either a packet
  OR an explicit downdate in `coverage.yaml`
- CI prevents structural drift (critical gaps fail build)
- Convention becomes the canonical example of its own principles
- Future versions (v2.0.0+) will recursively document their
  changes via the same pattern
