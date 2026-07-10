# ADR — plain-text-no-deps


## Problem

Other convention methodologies (e.g., MathCodingFractal) bundle
formal verification toolchains: TLA+ Toolbox, Java, Isabelle,
Python, etc. These tools:
- Make the convention heavy (90MB+ downloads)
- Require users to install non-trivial dependencies
- Make convention-repo slow to clone and update
- Are often unavailable in restricted environments (e.g.,
  air-gapped networks)
- Force a commit to a specific tool vendor/version

## Desired outcome

math-coding v1.x is **plain text + git**:
- All artifacts are YAML, Markdown, or POSIX shell
- `core/verify.sh`, `core/init-packet.sh`, `examples/*/verify.sh`:
  pure POSIX shell (no bashisms, no Python, no Java)
- No bundling of formal verification tools
- External tools (TLA+, Coq, Alloy, PRISM, BPMN) are referenced
  but not included — convention is a **layer**, not a tooling
  stack
- The convention itself runs anywhere git + POSIX sh work
  (Linux, macOS, BSD, Alpine, WSL, etc.)

Optional substrate (`packet.yaml:substrate: tla|coq|alloy|...`)
is a *recommendation*, not a *requirement*. A convention user
can stay at `substrate: none` or `shell` for the entire lifetime
of their project.

## Constraints

- POSIX shell only (no GNU bash extensions, no `[[ ]]`, no arrays)
- YAML + Markdown only (no TOML, no JSON, no custom formats)
- No build step required
- No npm/pip/cargo/dependencies
- No external services
- Works offline
- Works on a fresh `git clone` (no bootstrap script beyond
  `core/verify.sh` itself)

## Alternatives considered

- **Bundle TLA+ / Coq / Alloys tools:** rejected (see problem)
- **Python verifier (MathCodingFractal had `bin/verify.py`):** rejected
  — adds Python dependency; convention becomes "git + Python"
- **Multi-language (shell for shell, Python for property tests):**
  rejected — convention has one toolchain (POSIX sh), easy to learn
- **Web-based verifier:** rejected — needs server, network, browser
- **No verifier at all:** rejected — convention can't enforce rules

## Consequences

- Convention is the lightest possible: just text + git
- New users can start in 30 seconds (clone, edit, commit)
- External projects don't need to install the convention's tooling
- Convention is auditable by reading `core/verify.sh` directly
- Substrate choices (TLA+, Coq) are open: users pick their own
- v0.x's heavy stack is rejected; v1.x is "the smallest useful
  convention"
