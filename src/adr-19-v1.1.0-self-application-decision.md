# ADR — v1.1.0-self-application-decision


## Problem

In v1.0.0, the convention-repo applied math-coding to itself
through `core/`, `theories/`, `examples/` — but **did not
record its own architectural decisions as packets**. This is
**partial self-application**: the convention is used, but the
**process of using it is not documented**.

Fractal property states: "Every decision with intent is a
packet." But the **decisions about the convention itself** were
not captured as packets — they lived only in commit messages
and CHANGELOG.md.

## Desired outcome

Introduce `self-application/specs/<topic>/` — a directory for
**architectural decision records** of the convention itself.
Each subdirectory is a packet documenting **why** a particular
design choice was made.

## Constraints

- must not **duplicate** content in `core/` (which is the
  current canonical state)
- must be **forward-compatible** with v1.0.0 (no breaking
  changes)
- must **demonstrate** fractal property: convention uses
  convention to describe itself

## Alternatives considered

- **ADRs in `docs/adr/`:** rejected, ADRs are for **architectural
  decisions of external projects**, not for the convention's
  own evolution
- **Section in CHANGELOG.md:** rejected, CHANGELOG is a **list
  of versions**, not a **journal of decisions**
- **No self-application record:** rejected, violates the
  convention's own claim of fractal property

## Consequences

- v1.1.0+ convention-repo has a **self-application journal**
- Future decisions (v1.2.0, v2.0.0) can be recorded as packets
- The convention is **fully self-documenting**
- New users can study how the convention evolved, not just
  what it is now
