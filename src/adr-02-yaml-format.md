# ADR — yaml-format


## Problem

math-coding-v1 inherits conventions from `MathCodingFractal`,
which used `packet.json` (JSON) for packet manifests. This is a
choice that prioritizes machine-parseability over human- and
LLM-readability. For a convention that wants to be approachable
to new users, JSON's strict quoting, no-comments, and bracket-noise
are friction.

## Desired outcome

All math-coding v1.x packet files use YAML:
- `packet.yaml` — manifest
- `assumptions.yaml` — list of assumptions with epistemic metadata
- `verifier-output.yaml` — verdict artifact
- `coverage.yaml` — inventory (in `specs/coverage/`)

YAML's features used by this convention:
- `#` comments (used in `core/packet-schema.md` examples)
- Block scalar `|` for multi-line strings (rare, but allowed)
- List of maps (for assumptions entries and coverage decisions)

JSON is **not** used anywhere in v1.x packet files.

## Constraints

- Plain text
- LLM-parseable (LLMs understand both, but YAML is more forgiving
  of trailing commas, missing quotes, etc.)
- git-friendly (line-based diffs)
- Permits comments (essential for `core/packet-schema.md` examples)

## Alternatives considered

- **JSON only:** rejected — no comments, strict syntax, hostile to humans
- **TOML:** rejected — smaller ecosystem, less tooling support in shell
- **Mixed (YAML + JSON for different artifacts):** rejected — adds
  cognitive load; convention has only ONE packet file format
- **Plain markdown frontmatter:** rejected — can't represent lists,
  nested structures, multiple assumptions cleanly

## Consequences

- MathCodingFractal users must migrate JSON→YAML
- v1.x examples are YAML
- Tools reading packets should use a YAML parser (`yq`,
  `python -c "import yaml; ..."`, etc.); not JSON parsers
- Hash-of-content checks (if added later) would need to canonicalize
  YAML formatting
