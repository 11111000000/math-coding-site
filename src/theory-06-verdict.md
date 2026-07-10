# Verdict

**Rigor level:** any

A verdict is the result of `Spec ⊨ P` (Spec satisfies Property).
Five outcomes:

| Verdict | Meaning | When |
|---------|---------|------|
| `VERIFIED` | Spec ⊨ P proved | verifier proved it |
| `NEEDS_REVISION` | Spec ⊭ P (counterexample) | verifier found violation |
| `UNVERIFIABLE:TOOL_MISSING` | tool unavailable | TLC, jqwik not installed |
| `UNVERIFIABLE:OUT_OF_SCOPE` | not mechanically checkable | human review needed |
| `UNVERIFIABLE:DEFERRED` | data not available | re-attempt when data arrives |

There is **no** `UNVERIFIABLE:REJECTED`. Reframe as smaller
verifiable task.

**Used in:** `verifier-output.yaml:verdict`. The packet's
`verifier: {command, verdict_file}` field specifies how to
produce this.
