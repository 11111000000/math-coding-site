# Predicate

**Rigor level:** any (foundational, used in every packet)

A predicate over a state space S is a function:
I: S → B

A state s satisfies I iff I(s) = true.

**Used in:** every `assumptions.yaml` entry is a proposition
about state. Use `epistemology: hypothesis` for conjectures,
`epistemology: fact` for verified claims.

**Example:**
- `I(s) = (s.user.role = "admin")` — predicate on user state
- `I(s) = (s.balance >= 0)` — invariant on account state
