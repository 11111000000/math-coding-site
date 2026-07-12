# Theory: Epistemic Logic

**Rigor:** property

A belief state is a function:

    B: Prop × Agent → [0, 1]

The convention recognises **five** epistemic markers, ordered by
confidence:

- fact        — B(P, agent) ≥ 0.95
- hypothesis  — B(P, agent) ∈ (0.5, 0.95)
- judgment    — B(P, agent) ∈ {0, 1}  (no confidence value)
- unknown     — B(P, agent) = 0       (no confidence value)
- **proven**   — claim verified end-to-end by convention's own tools

## math-coding instance

In math-coding, every entry in `assumptions.yaml` carries
exactly one marker plus an optional `confidence` field.
Agents read the marker to decide their next action
(verify / search / respect / ask). The mapping table is
in [[math/theory-epistemic-as-packet/refinement.md#mapping|the epistemic mapping table]].

### The `proven` marker

`proven` is reserved for claims whose evidence chain closes
through convention's own machinery — i.e., the agent's
justification is **the convention running and reporting
success**. The canonical example is axiom A4 in
[[math/math-coding-birth|math-coding-birth]] — "the convention
applies to itself". This is not an axiom in the formal-logic
sense (those are claims that *define* the system, not
descriptions of it), nor is it merely an opinion
(`judgment`) or a high-confidence belief (`fact`). It is a
*verified claim* — `sh core/probe.sh` exits 0 against the
convention's own repository.

The marker has:

- `status: user-confirmed` — a human author takes responsibility
- `epistemology: proven` — evidence is end-to-end verification
- `confidence: 1.0` — verifier exit code is binary

If convention breaks itself (verifier exits non-zero on
main repo), the marker's evidence becomes stale. The
verifier's drift-check 1 does not fail on this directly, but
`sh core/probe.sh` exit code is observable; until it returns
non-zero, the claim stays `proven`.

A claim can be demoted from `proven` to `fact` if the
end-to-end check becomes partial, or to `judgment` if it is
disputed. The status reflects current epistemic standing,
not a permanent claim about reality.
