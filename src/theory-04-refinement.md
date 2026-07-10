# Refinement

**Rigor level:** any

A refinement is a function R: S_impl → S_spec such that
for every impl transition, there's a sequence of spec
transitions matching it. R is **stuttering-equivalent**.

**Used in:** `refinement.md` of a packet. State mapping
section maps impl states to spec states.

**Example:** impl has 5 internal states `{init, queue,
process, success, fail}`. Spec has 3 states `{pending,
done, error}`. R maps:
- `init` → `pending`
- `queue` → `pending`
- `process` → `pending`
- `success` → `done`
- `fail` → `error`
