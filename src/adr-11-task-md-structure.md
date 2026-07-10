# ADR — task-md-structure


## Problem

`task.md` is the intent layer of a packet. If its structure is
free-form, agents write 1-word `## Problem` answers, or include
no `## Constraints` at all. Reading the packet later requires
guessing where the constraint or the desired outcome is.

v1.0.0 declared 3 sections. v1.1.0 said "≥10 words" but
neither had a verifying check. v1.2.0 makes both declarative
AND mechanically verified.

## Desired outcome

`task.md` has exactly three sections, in this order:

1. `## Problem` — what problem does this packet address?
2. `## Desired outcome` — what success looks like
3. `## Constraints` — what limits the solution space

**Each section must be ≥10 words.** A 1-line `## Problem` is
rejected — the section is a paragraph, not a header.

Sections are counted by `\b\w+\b` regex (whitespace-separated
tokens). Empty sections and headings without content are rejected.

## Constraints

- Plain markdown
- ≥10 words per `## Problem`, `## Desired outcome`, `## Constraints`
- Same verifier can count words in any markdown flavor
- Optional sections (`## Alternatives`, `## Consequences`,
  `## Cross-references`, etc.) are encouraged but not required

## Alternatives considered

- **Free-form:** rejected — divergent structure, agent confusion
- **1 section (single `## Why`):** rejected — loses distinct
  problem/outcome/constraints semantics
- **5 sections (add `## Alternatives` and `## Consequences`):**
  rejected — those are convention's own descriptive categories,
  not requirements
- **No minimum word count:** rejected — 1-word sections provide
  no information; convention becomes noisy
- **≥5 words (not ≥10):** rejected — too short to be meaningful;
  10 is the empirical minimum for non-trivial intent
- **`## Desired outcome` only (skip Problem/Constraints):** rejected —
  problem framing is what makes a packet a "decision packet"

## Consequences

- `core/verify.sh` checks section presence (declared, not yet
  enforced)
- `specs/self-check/` checks ≥10 words per section (semantic check)
- Authors write meaningful tasks — 1-word answers rejected by CI
- Reading a packet is consistent: same 3 sections, same headings
- Optional prose (alternatives, consequences) can be added
  without breaking the schema
