# ADR — verifier-field


## Problem

A packet's claim of correctness must be **mechanically checkable**.
Without an explicit `verifier` field, an agent reading
`packet.yaml` cannot run the verifier — they have to guess where
the proof artifacts are.

## Desired outcome

A packet's `verifier` field has one of two shapes:

**Shape 1: `null`**
```yaml
verifier: null
```
Means: the packet is correct by reasoning, no mechanical
verification needed. Used for purely declarative packets
(e.g., convention-decision documentation).

**Shape 2: object**
```yaml
verifier:
  command: "sh verify.sh"     # shell command to run
  verdict_file: verifier-output.yaml  # path to verdict artifact
```
Means: run `command` from the packet directory; it produces
`verdict_file` with a `verdict: VERIFIED|NEEDS_REVISION|...`
field. The verdict is read by humans and by other automation.

`verifier: null` packets must still pass `core/verify.sh` and
`specs/self-check/` (structural checks). They **opt out** of
mechanical **semantic** verification.

## Constraints

- Required field in every `packet.yaml`
- Either `null` or an object with `command` and `verdict_file`
- `command` is a shell-executable string
- `verdict_file` is a relative path from the packet directory
- `verdict_file` content follows `verifier-output.yaml` schema
  (see `specs/verdict-outcomes/`)

## Alternatives considered

- **Optional field:** rejected — every packet claims something,
  and claims need verification (mechanical or reasoning)
- **`command` only (no `verdict_file`):** rejected — ambiguity
  in where the verdict goes; convention would diverge
- **Single shape (no `null` allowed):** rejected — forces every
  decision-packet to have a script, even when not needed
- **Auto-discovery (find any `verify.sh` in the directory):** rejected —
  implicit, unstated, can't be asserted in `packet.yaml`

## Consequences

- Agents and humans reading `packet.yaml` see the verification story
- `core/verify.sh` doesn't run verifier commands; that's
  `specs/self-check/` (or a CI step)
- A `null` verifier is explicit opt-out, not absence
- Convention is honest: every claim has a known verification
  status, mechanical or by-reasoning
