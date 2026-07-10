# Notes for AI agents

If you are an AI coding agent asked to follow the math-coding
convention, this file tells you the minimum you need to know.
For deeper detail, see [Detailed process](./agents-process.md)
and [Rigor tools](./agents-rigor.md).

## Read first

Read [core/core.md](https://github.com/11111000000/math-coding/blob/main/core/core.md) and [Packet schema](./packet-schema.md) completely before opening a packet. Do not skip. Do not skim. The documents are the single source of truth, grounded in 8 theory documents in `theories/`.

## Five-step process

1. **Decide rigor.** Pick the level that matches the task
   (light / property / temporal / proof). Default: `light`.
   See [Rigor tools](./agents-rigor.md).
2. **Create packet.** Run `sh core/init-packet.sh <id>` from
   the project root. The script creates `specs/<id>/` with the
   three required files.
3. **Fill content.** Write `task.md`, `assumptions.yaml`,
   `packet.yaml`. Apply the epistemic protocol (see below).
4. **Add rigor artifacts.** If rigor > light, write
   `Model.tla` / `Model.als` / `Model.v` and the corresponding
   `verify-*.sh` script.
5. **Run verifier.** Run the structural verifier; promote
   lifecycle only if verdict is VERIFIED.
   - `sh core/verify.sh` (structural)
   - `sh specs/self-check/verify-structural.sh` (recursive, full)

## Epistemics as Action Protocol

When you read an `assumptions.yaml` entry, apply this protocol
based on the `epistemology` field:

| Marker | What you do |
|--------|-------------|
| `judgment` | Respect. Do not propose alternatives without explicit user request. |
| `unknown` | Ask user. Do not proceed. Mark `status: open` if not. |
| `fact` | Verify if possible. Downgrade to `hypothesis` if can't. |
| `hypothesis` | Search for evidence. Upgrade to `fact` on find. Downgrade to `unknown` if contradicted. |

## Lifecycle FSM

Every task lifecycle is one of 6 values:

`sketch → working → verified → deprecated → archived`

Plus the 6th state: `superseded` (a packet documenting a historical decision; carries a `supersession:` block).

## Verifier

Verdict is one of 5 outcomes:

| Verdict | Meaning |
|---------|---------|
| `VERIFIED` | Spec ⊨ P proved |
| `NEEDS_REVISION` | Spec ⊭ P (counterexample) |
| `UNVERIFIABLE:TOOL_MISSING` | tool unavailable |
| `UNVERIFIABLE:OUT_OF_SCOPE` | not mechanically checkable |
| `UNVERIFIABLE:DEFERRED` | data not available |

A packet is **not** `verified` until `verifier-output.yaml`
exists with `verdict: VERIFIED`. There is no
`UNVERIFIABLE:REJECTED`. Reframe as smaller verifiable task.

## Recursive property

math-coding has a **fractal property**: every key decision of
the convention itself is recorded as a packet in
[`specs/`](https://github.com/11111000000/math-coding/tree/main/specs).
A machine-readable inventory in
[`specs/coverage/coverage.yaml`](https://github.com/11111000000/math-coding/blob/main/specs/coverage/coverage.yaml)
tracks all decisions, severity-tagged. The recursive verifier
at [`specs/self-check/verify-structural.sh`](https://github.com/11111000000/math-coding/blob/main/specs/self-check/verify-structural.sh)
fails CI on any critical gap.

When you read a `specs/<decision>/task.md`, treat it as
**canonical documentation**: it is the convention's own
explanation of why the convention is the way it is.

## Rigor and substrate

`rigor` controls how much formal apparatus the packet needs.
`substrate` tells the verifier which formal tool to use (if
any). See [Rigor tools](./agents-rigor.md) for full mapping.
