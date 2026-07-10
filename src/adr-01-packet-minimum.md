# ADR — packet-minimum


## Problem

math-coding claims "every decision with intent is a packet",
but does not specify what makes a directory a packet. Without a
documented minimum, agents can produce packets with arbitrary
file structures — and `core/verify.sh` had hardcoded a 3-file
minimum without documenting why.

This is also a **fractal-property gap**: the convention defines
a rule but does not record *the decision to have that rule* as a
packet.

## Desired outcome

A packet MUST contain exactly three files:
- `packet.yaml` — manifest (8 required fields)
- `task.md` — intent (3 sections: Problem, Desired outcome, Constraints)
- `assumptions.yaml` — epistemic context (≥1 entry)

These three are necessary **and sufficient** for the structural-level
verifier in `core/verify.sh`.

## Constraints

- Plain text (YAML + Markdown), git-friendly
- LLM-parseable: agent and human read the same files
- Optional files (`refinement.md`, `Model.tla`, `verifier-output.yaml`,
  `traceability.json`) add semantic depth without changing
  packet-ness
- A directory without these 3 files is a **draft**, not a packet

## Alternatives considered

- **1 file (single markdown):** rejected — loses machine-parseability
  and forces humans to parse through plain text to extract fields
- **6+ files (full MathCodingFractal layout):** rejected — too much
  overhead for simple CRUD endpoints; violates rigor opt-in
- **Variable per domain:** rejected — agents need predictable structure
  to know where to put their intent

## Consequences

- `core/verify.sh` enforces 3-file minimum (already in v1.0.0)
- More complex packets use `refinement.md` etc. — strictly optional
- `specs/self-check/` extends verification with semantic checks
- New convention users immediately understand "packet = 3 files"
- Each packet directory has the same shape: agents can reason
  about packets without first exploring the convention
