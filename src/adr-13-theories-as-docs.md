# ADR — theories-as-docs


## Problem

v1.0.0 introduced 11 foundational theories under `theories/`,
one file per theory. v1.1.0 added `theories/formal-tools.md`,
a 12th theory-as-catalog. Each of these files had a stray
`<theory>.md` sibling containing YAML manifest, and the
formal-tools had a `formal-tools.packet.yaml` companion.

The convention's spec says: 3 files = packet. But these files
were **shadow-packets**: a `<name>.md` that contained YAML
(pretending to be a packet) plus a `<name>.body.md` with the
actual markdown. The verifier was happy because there was no
`packet.yaml` to find; but the structure was a lie.

## Desired outcome

`theories/<name>.md` is **pure markdown documentation**. No
YAML frontmatter, no packet manifest, no companion file.

If a theory needs a decision packet (e.g., "we include theory X
because Y"), that packet lives in `specs/theory-layer-*/` —
not as a `<name>.md` sibling.

The pattern documented here is:
- `theories/*.md` — the math (definitions, formulas, examples)
- `specs/<theory-decision>/` — three files documenting the
  decision to include this theory or layer

## Constraints

- Plain markdown, no YAML frontmatter
- No `packet.yaml` ever appears in `theories/`
- `specs/coverage/` lists each theory's decision packet
- Convention readers know: 3 files = packet, .md alone = theory doc

## Alternatives considered

- **Each theory = its own packet:** rejected — too much overhead;
  curated set has 1 decision (the 11 were introduced together)
- **`theories/<theory>.packet.yaml` standalone files:** rejected
  in v1.1.1; decision lives centrally in `specs/`
- **`theories/*.body.md` companion files:** rejected in v1.1.1;
  collapses into one `<name>.md` file
- **Keep YAML frontmatter for LLM-friendly metadata:** rejected —
  doesn't help; LLMs read the file as text either way

## Consequences

- v1.1.0 shadow-packets are gone (12 files removed, 12 created)
- `theories/formal-tools.packet.yaml` removed
- `theories/*.md` files all frontmatter-free now
- `core/packet-schema.md#theory-layer-pattern` documents this
- `core/meta.yaml` lists `theories/*.md` as
  `role: theory-documentation`
- New convention users see clear distinction:
  packet = 3 files in `specs/`, theory = markdown in `theories/`
