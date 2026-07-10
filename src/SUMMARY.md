# Summary

[Introduction](./introduction.md)

---

# The convention

- [Core](./core.md)
- [Packet schema](./packet-schema.md)
- [`init-packet.sh`](./init-packet.sh.md)
- [`verify.sh`](./verify.sh.md)
- [Operating-system manifest (`meta.yaml`)](./meta-yaml.md)

# Mathematical foundation

- [Theory 01 — Predicate](./theory-01-predicate.md)
- [Theory 02 — State Machine (FSM)](./theory-02-fsm.md)
- [Theory 03 — Temporal Logic (LTL)](./theory-03-ltl.md)
- [Theory 04 — Refinement](./theory-04-refinement.md)
- [Theory 05 — Assumption Set](./theory-05-assumption.md)
- [Theory 06 — Verdict](./theory-06-verdict.md)
- [Theory 07 — Epistemic State](./theory-07-epistemic.md)
- [Theory 08 — Deprecation](./theory-08-deprecation.md)

# Advanced theory

- [Theory 09 — Curry-Howard](./theory-09-curry-howard.md)
- [Theory 10 — Modal Logic for FSM Lifecycles](./theory-10-modal.md)
- [Theory 11 — Confidence as Information](./theory-11-confidence.md)

# Decisions (ADR-style)

21 decision-packets from [`specs/`](https://github.com/11111000000/math-coding/tree/main/specs):

- [ADR 01 — packet-minimum (3 required files)](./adr-01-packet-minimum.md)
- [ADR 02 — yaml-format (YAML, not JSON)](./adr-02-yaml-format.md)
- [ADR 03 — lifecycle-enum (6 values)](./adr-03-lifecycle-enum.md)
- [ADR 04 — substrate-enum (9 values)](./adr-04-substrate-enum.md)
- [ADR 05 — rigor-levels (4 levels)](./adr-05-rigor-levels.md)
- [ADR 06 — decision-enum (needed/made)](./adr-06-decision-enum.md)
- [ADR 07 — epistemic-markers (4 markers)](./adr-07-epistemic-markers.md)
- [ADR 08 — assumptions-schema](./adr-08-assumptions-schema.md)
- [ADR 09 — verifier-field (null|{command,verdict_file})](./adr-09-verifier-field.md)
- [ADR 10 — verdict-outcomes (5 outcomes)](./adr-10-verdict-outcomes.md)
- [ADR 11 — task-md-structure (3 sections, ≥10 words)](./adr-11-task-md-structure.md)
- [ADR 12 — supersession-block](./adr-12-supersession-block.md)
- [ADR 13 — theories-as-docs (theory layer pattern)](./adr-13-theories-as-docs.md)
- [ADR 14 — fractal-property (recursive self-application)](./adr-14-fractal-property.md)
- [ADR 15 — plain-text-no-deps (no external tools)](./adr-15-plain-text-no-deps.md)
- [ADR 16 — theory-layer-foundation (v1.0.0)](./adr-16-theory-layer-foundation.md)
- [ADR 17 — theory-layer-v1.1.0 (formal-tools)](./adr-17-theory-layer-v1.1.0.md)
- [ADR 18 — v1.1.0-substrate-decision (decision tree)](./adr-18-v1.1.0-substrate-decision.md)
- [ADR 19 — v1.1.0-self-application-decision (./specs/)](./adr-19-v1.1.0-self-application-decision.md)
- [ADR 20 — coverage (machine-readable inventory)](./adr-20-coverage.md)
- [ADR 21 — self-check (recursive verifier)](./adr-21-self-check.md)

# Examples

- [hello-world (minimal packet, 5 lines sh)](./example-minimal-packet.md)
- [login-feature (external project, bcrypt)](./example-external-project.md)
- [self-application (recursive verifier)](./example-self-application.md)

# For AI agents

- [Notes for agents](./agents.md)
- [Detailed process](./agents-process.md)
- [Rigor tools reference](./agents-rigor.md)

# Integrations

- [GitHub Pull Requests](./integration-github-pr.md)
- [GitHub Actions (CI)](./integration-github-actions.md)
- [Cursor (AI IDE)](./integration-cursor.md)
- [Linear (issue tracker)](./integration-linear.md)

# Reference

- [Glossary](./glossary.md)
- [Onboarding (adopt math-coding in your project)](./onboarding.md)
- [Changelog](https://github.com/11111000000/math-coding/blob/main/CHANGELOG.md)

---

[About this site](./about.md)
