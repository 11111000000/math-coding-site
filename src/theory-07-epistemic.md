# Epistemic State

**Rigor level:** any

A belief state is B: Prop × Agent → [0,1]:
- B(P, a) = 1.0: agent a fully believes P
- B(P, a) = 0.5: agent a is uncertain
- B(P, a) = 0.0: agent a has no belief

Each `assumptions.yaml` entry maps to:

| Marker | Belief interval | Action |
|--------|------------------|--------|
| `fact` | B = 1.0 | verify if possible |
| `hypothesis` | B ∈ (0, 1) | search for evidence |
| `judgment` | B ∈ {0, 1} | respect, don't challenge |
| `unknown` | B = 0 | ask user |

**Action protocol:**
- `judgment` → respect, don't challenge
- `unknown` → ask user, don't proceed
- `fact` → verify if possible
- `hypothesis` → search for evidence

**Used in:** `assumptions.yaml:epistemology`. The protocol is
machine-readable: an agent reading an entry applies the action.
