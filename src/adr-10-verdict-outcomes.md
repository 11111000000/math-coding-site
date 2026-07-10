# ADR — verdict-outcomes


## Problem

A verifier produces a verdict, but "verdict" without a closed
vocabulary leaves the result free-form. Two verifiers can give
the same outcome with different words ("PASS" vs "VERIFIED",
"FAIL" vs "NEEDS_REVISION"). Downstream automation can't reason
about the result.

Also, `UNVERIFIABLE` happens often — tool missing, scope out of
automation's reach, data not yet available. Convention needs to
acknowledge this without making it a "REJECTED" failure.

## Desired outcome

`verifier-output.yaml:verdict` is one of 5 values:

| Verdict | Meaning | When |
|---|---|---|
| `VERIFIED` | Spec ⊨ P proved | verifier proved it |
| `NEEDS_REVISION` | Spec ⊭ P (counterexample) | verifier found violation |
| `UNVERIFIABLE:TOOL_MISSING` | tool unavailable | TLC, jqwik not installed |
| `UNVERIFIABLE:OUT_OF_SCOPE` | not mechanically checkable | human review needed |
| `UNVERIFIABLE:DEFERRED` | data not available | re-attempt when data arrives |

There is **no** `UNVERIFIABLE:REJECTED`. If a problem is
unsolvable in the current state, it is reframed as a smaller
verifiable task.

`verifier-output.yaml` schema:
```yaml
verdict: VERIFIED | NEEDS_REVISION | UNVERIFIABLE:*
errors: 0                        # integer, number of failed checks
verified_at: 2026-07-10T...     # ISO 8601 timestamp
scope:                          # what was verified
  - <check-id-or-area-name>
tool: <verifier-name>           # which script produced this
details: |                      # optional, multi-line
  <human-readable notes>
```

## Constraints

- Required: `verdict`, `errors`, `verified_at`
- `verdict` is one of 5 enumerated values
- `errors` integer ≥ 0
- `verified_at` ISO 8601 UTC timestamp
- `scope` is a list of strings (what was checked)
- `tool` is the verifier name (e.g., `hello-world-verify.sh`)

## Alternatives considered

- **Boolean `pass: true|false`:** rejected — loses nuance
  (UNVERIFIABLE:TOOL_MISSING is not a failure)
- **3 verdicts (PASS/FAIL/UNKNOWN):** rejected — UNVERIFIABLE has
  multiple distinct causes worth distinguishing
- **Free-form verdict string:** rejected — divergent verbiage;
  can't grep
- **Numeric score (0-100):** rejected — discrete states are
  more useful than continuous scores for protocol integration

## Consequences

- Verifier outputs are machine-comparable
- Downstream CI can decide: VERIFIED → merge, NEEDS_REVISION →
  block, UNVERIFIABLE:* → human review
- Re-attempts are tracked via `verified_at` (was this run before?)
- Convention values **honesty about scope**: UNVERIFIABLE is
  a documented state, not a failure
- `core/verify.sh` accepts `UNVERIFIABLE:*` as a valid verdict
  (does not FAIL on it)
