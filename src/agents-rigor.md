# Rigor tools reference

math-coding supports **4 rigor levels**, each detected automatically by file presence:

| Rigor | Required files | When to use |
|-------|----------------|-------------|
| `light` | `verify.sh` (default — any packet with a verifier has at least this) | Every packet. The floor. |
| `property` | `verify-property.sh` (in addition to `verify.sh`) | Pure functions, parsers, validators. |
| `temporal` | `Model.tla` + `verify-tlc.sh` | Distributed systems, concurrent code, protocols. |
| `proof` | `Model.v` + `verify-coq.sh` | Cryptographic, financial, safety-critical code. |

If multiple rigor levels are present (e.g., both `Model.tla` and `Model.v`), the **highest** rigor applies.

## When to use which rigor

### `light` (default)

- **What it gives you**: structural checks only (required files, valid YAML, FSM transitions, epistemics markers, lifecycle consistency).
- **When to use**: every packet. This is the floor.
- **Tooling**: `core/verify.sh` + `specs/self-check/verify-structural.sh` (POSIX sh).
- **Time cost**: ~1 second per packet.
- **Limitation**: no behavioral verification. The packet can have correct structure and still encode wrong intent.

### `property`

- **What it gives you**: random-input testing against invariants. Catches bugs that structural checks miss but does not prove absence of bugs.
- **When to use**: pure functions, parsers, validators, anything with clear input/output.
- **Tooling**: `jqwik` (Java/Kotlin), `fast-check` (JS/TS), Hypothesis (Python), QuickCheck (Haskell).
- **Time cost**: 1-30 seconds per property.
- **Limitation**: not exhaustive. Coverage depends on shrinking and generator quality.

### `temporal`

- **What it gives you**: exhaustive model checking of state machines and protocols. Can prove safety and liveness properties over all reachable states.
- **When to use**: distributed systems, concurrent code, protocols, anything with non-trivial state transitions.
- **Tooling**: TLA+ Toolbox, TLC model checker, Apalache (symbolic).
- **Time cost**: 1-60 minutes per model (state-space dependent).
- **Limitation**: requires writing a TLA+ model separately from the implementation. Refinement map (`refinement.md`) must show the model maps to code.

### `proof`

- **What it gives you**: machine-checked formal proofs of correctness.
- **When to use**: cryptographic, financial, safety-critical code where bugs are unacceptable.
- **Tooling**: Coq, Lean, Isabelle.
- **Time cost**: days to months per proof.
- **Limitation**: requires deep expertise; proofs are not interchangeable with tests.

## Substrate mapping

`substrate` in `packet.yaml` tells the verifier which formal tool to use:

| Substrate | Tool | Rigor |
|-----------|------|-------|
| `none` | no formal tool | light |
| `shell` | POSIX sh + tests | light |
| `tla` | TLA+ + TLC | temporal |
| `typescript` | TypeScript types | light |
| `pbt` | jqwik / fast-check (property-based) | property |
| `alloy` | Alloy Analyzer | property |
| `coq` | Coq | proof |
| `bpmn` | BPMN | light |
| `pbt-prism` | PRISM | property |

## Selection decision tree

When creating a packet:
1. **Default** to `substrate: none` (light rigor)
2. If your code is concurrent/distributed → `tla` (temporal)
3. If your code is security/financial/safety-critical → `coq` (proof)
4. If your code is pure functions with invariants → `pbt` (property)
5. If your code has relational schema → `alloy` (property)

See the [substrate decision tree](https://github.com/11111000000/math-coding/blob/main/core/packet-schema.md#substrate-decision-tree) in `core/packet-schema.md`.
