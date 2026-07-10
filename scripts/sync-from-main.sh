#!/bin/sh
# math-coding-site — sync content from the main math-coding repository.
#
# Source of truth: github.com/11111000000/math-coding (main branch)
# This script is run by CI (.github/workflows/deploy.yml) and locally.
#
# Path mappings:
#   theories/<name>.md       -> src/theory-NN-<name>.md
#   specs/<decision>/task.md -> src/adr-NN-<decision>.md
#   examples/<x>/README.md   -> src/example-<x>.md
#   specs/self-check/task.md -> src/example-self-application.md
#   core/packet-schema.md    -> src/packet-schema.md
#   core/init-packet.sh      -> src/init-packet.sh.md (with .sh extension stripped)
#   core/core.md             -> src/core.md (hand-curated replacement)
#   core/verify.sh           -> src/verify.sh.md
#   README.md                -> src/introduction.md (hand-curated)
#
# The script is idempotent: re-running produces the same state.
# Set MATH_CODING_LOCAL to use a local checkout instead of cloning
# from GitHub (useful for local previews).

set -e

REPO="${MATH_CODING_REPO:-https://github.com/11111000000/math-coding.git}"
BRANCH="${MATH_CODING_BRANCH:-main}"
SITE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$SITE_DIR/src"
TMP="$(mktemp -d)"
trap "rm -rf $TMP" EXIT

# ─── Fetch source ─────────────────────────────────────────
if [ -d "${MATH_CODING_LOCAL:-}" ] && [ -d "${MATH_CODING_LOCAL}/.git" ]; then
    echo "Using local checkout: $MATH_CODING_LOCAL"
    REPO_ROOT="$MATH_CODING_LOCAL"
else
    echo "Cloning $REPO @ $BRANCH..."
    git clone --depth 1 --branch "$BRANCH" "$REPO" "$TMP/repo" --quiet
    REPO_ROOT="$TMP/repo"
fi

# ─── Theory: 11 markdown files (short names) ─────────────
THEORY_MAP="
theories/predicate.md|theory-01-predicate.md
theories/fsm.md|theory-02-fsm.md
theories/ltl.md|theory-03-ltl.md
theories/refinement.md|theory-04-refinement.md
theories/assumption.md|theory-05-assumption.md
theories/verdict.md|theory-06-verdict.md
theories/epistemic.md|theory-07-epistemic.md
theories/deprecation.md|theory-08-deprecation.md
theories/curry-howard.md|theory-09-curry-howard.md
theories/modal.md|theory-10-modal.md
theories/confidence.md|theory-11-confidence.md
"

echo ""
echo "=== Theory (11 files) ==="
echo "$THEORY_MAP" | while IFS='|' read -r src_rel target; do
    [ -z "$src_rel" ] && continue
    src_file="$REPO_ROOT/$src_rel"
    if [ ! -f "$src_file" ]; then
        echo "  ! missing: $src_rel"
        continue
    fi
    # Strip YAML frontmatter (between first --- and second --- at top)
    awk '
        BEGIN { in_fm=0; started=0 }
        /^---$/ && !started { in_fm=1; next }
        in_fm && /^---$/ { in_fm=0; started=1; next }
        !in_fm { print }
    ' "$src_file" > "$SRC/$target"
    echo "  + src/$target"
done

# ─── ADRs: 24 decision-packets (excluding meta-packets) ───
ADR_LIST="
packet-minimum
yaml-format
lifecycle-enum
substrate-enum
rigor-levels
decision-enum
epistemic-markers
assumptions-schema
verifier-field
verdict-outcomes
task-md-structure
supersession-block
theories-as-docs
fractal-property
plain-text-no-deps
theory-layer-foundation
theory-layer-v1.1.0
v1.1.0-substrate-decision
v1.1.0-self-application-decision
coverage
self-check
"

echo ""
echo "=== ADRs (21 decision-packets) ==="
ADR_NUM=0
for spec_name in $ADR_LIST; do
    spec_dir="$REPO_ROOT/specs/$spec_name"
    task_file="$spec_dir/task.md"
    if [ ! -f "$task_file" ]; then
        echo "  ! missing: specs/$spec_name/task.md"
        continue
    fi
    ADR_NUM=$((ADR_NUM + 1))
    target="adr-$(printf '%02d' $ADR_NUM)-${spec_name}.md"
    # Extract title from H1, replace with clean title
    {
        echo "# ADR — $spec_name"
        echo ""
        # Skip first H1, take rest
        awk '!/^# /' "$task_file"
    } > "$SRC/$target"
    echo "  + src/$target"
done

# ─── Examples: 3 pages ────────────────────────────────────
echo ""
echo "=== Examples (3 files) ==="

# 1. minimal-packet (hello-world)
if [ -f "$REPO_ROOT/examples/minimal-packet/README.md" ]; then
    {
        echo "# Example: hello-world (minimal packet)"
        echo ""
        cat "$REPO_ROOT/examples/minimal-packet/README.md"
    } > "$SRC/example-minimal-packet.md"
    echo "  + src/example-minimal-packet.md"
fi

# 2. external-project (login-feature)
if [ -f "$REPO_ROOT/examples/external-project/README.md" ]; then
    {
        echo "# Example: login-feature (external project)"
        echo ""
        cat "$REPO_ROOT/examples/external-project/README.md"
    } > "$SRC/example-external-project.md"
    echo "  + src/example-external-project.md"
fi

# 3. self-application (recursive verifier)
if [ -f "$REPO_ROOT/specs/self-check/task.md" ]; then
    {
        echo "# Example: self-application (recursive verifier)"
        echo ""
        cat "$REPO_ROOT/specs/self-check/task.md"
    } > "$SRC/example-self-application.md"
    echo "  + src/example-self-application.md"
fi

# ─── Schema and tools (hand-curated from core/) ─────────
echo ""
echo "=== Schema and tools (hand-curated) ==="

if [ -f "$REPO_ROOT/core/packet-schema.md" ]; then
    {
        echo "# Packet schema (machine-readable)"
        echo ""
        cat "$REPO_ROOT/core/packet-schema.md"
    } > "$SRC/packet-schema.md"
    echo "  + src/packet-schema.md"
fi

if [ -f "$REPO_ROOT/core/init-packet.sh" ]; then
    {
        echo "# init-packet.sh (the packet creator)"
        echo ""
        echo '```sh'
        cat "$REPO_ROOT/core/init-packet.sh"
        echo '```'
    } > "$SRC/init-packet.sh.md"
    echo "  + src/init-packet.sh.md"
fi

if [ -f "$REPO_ROOT/core/verify.sh" ]; then
    {
        echo "# verify.sh (the structural verifier)"
        echo ""
        echo '```sh'
        cat "$REPO_ROOT/core/verify.sh"
        echo '```'
    } > "$SRC/verify.sh.md"
    echo "  + src/verify.sh.md"
fi

if [ -f "$REPO_ROOT/core/meta.yaml" ]; then
    {
        echo "# meta.yaml (operating-system manifest)"
        echo ""
        echo '```yaml'
        cat "$REPO_ROOT/core/meta.yaml"
        echo '```'
    } > "$SRC/meta-yaml.md"
    echo "  + src/meta-yaml.md"
fi

# ─── Introduction (hand-curated from README.md) ───────────
if [ -f "$REPO_ROOT/README.md" ]; then
    {
        echo "# math-coding"
        echo ""
        echo "**A convention for mathematically grounded software artifacts.**"
        echo ""
        echo "Plain text + git. No external dependencies."
        echo ""
        cat "$REPO_ROOT/README.md"
    } > "$SRC/introduction.md"
    echo "  + src/introduction.md"
fi

echo ""
echo "Sync complete. Generated files in $SRC/:"
ls "$SRC" | sort | sed 's/^/  /'
