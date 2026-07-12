#!/bin/sh
# math-coding-site — sync content from the main math-coding repository.
#
# Source of truth: github.com/11111000000/math-coding (main branch)
# This script is run by CI (.github/workflows/deploy.yml) and locally.
#
# math-coding v0.618 uses a different structure than v1.x:
#   v1.x: core/ + specs/ + theories/ + examples/ (json-based, 7+ files per packet)
#   v0.618: core/ (with theories/ inside) + math/ (4 packets, 5 files each)
#
# Path mappings (v0.618):
#   core/packet-schema.md        -> src/packet-schema.md (markdown table)
#   core/theories/<name>.md      -> src/theory-NN-<name>.md
#   math/<packet>/packet.yaml    -> <referenced, but not directly copied>
#   math/<packet>/decision.md    -> src/packet-NN-<packet>.md
#   math/<packet>/task.md        -> <referenced in packet page>
#   math/<packet>/assumptions.yaml -> <referenced in packet page>
#   math/<packet>/refinement.md   -> <referenced in packet page>
#   README.md                     -> src/introduction.md
#   agents.md                     -> src/agents.md
#   LICENSE                       -> src/license.md
#
# The convention says each math/<packet>/ is one decision. For the
# site, we render each packet as one page that includes all 5 files.
# This keeps the site simple: one page = one decision.
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

# ─── Theory display names (slug → human) ───────────────────
# SUMMARY.md uses these for the Mathematical foundation section.
# Add new entries here as new theories are added.
THEORY_DISPLAY="
fsm|Finite State Machine
ltl|Temporal Logic (LTL)
epistemic|Epistemic State
curry-howard|Curry-Howard
modal|Modal Logic for FSM Lifecycles
"

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
core/theories/predicate.md|theory-01-predicate.md
core/theories/fsm.md|theory-02-fsm.md
core/theories/ltl.md|theory-03-ltl.md
core/theories/refinement.md|theory-04-refinement.md
core/theories/assumption.md|theory-05-assumption.md
core/theories/verdict.md|theory-06-verdict.md
core/theories/epistemic.md|theory-07-epistemic.md
core/theories/deprecation.md|theory-08-deprecation.md
core/theories/curry-howard.md|theory-09-curry-howard.md
core/theories/modal.md|theory-10-modal.md
core/theories/confidence.md|theory-11-confidence.md
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

# ─── Packets: render each math/<packet>/ as one page ─────
echo ""
echo "=== Packets (one page per packet) ==="

# Clean stale src/packet-*.md files from previous syncs. This
# ensures renames and removals in math-coding propagate. Without
# this step, renamed packets leave orphan files in src/.
for stale in "$SRC"/packet-*.md; do
    [ -f "$stale" ] || continue
    rm -f "$stale"
done

# Order packets so the origin (math-coding-birth) is first, then
# packets in alphabetical order. Derived dynamically from ls so
# new packets propagate without editing this script.
#
# Excludes:
#   - *.canvas, *.md files in math/ (dag.canvas, README.md)
#   - README-as-*-as-packet (any README-* in math/)
#   - dag.canvas is a file, not a packet dir
#   - this site-sync-as-packet dir contains both packet AND
#     .opencode subdirs; we filter to dirs only via [ -d ] check

PKG_ORDER=$(ls -1 "$REPO_ROOT/math/" 2>/dev/null | \
    grep -vE '\.(canvas|md)$|^README-as|^[A-Z][A-Z0-9_-]*\.[a-z]+$' | sort -u)

# Special-case: math-coding-birth first if present
if echo "$PKG_ORDER" | grep -q '^math-coding-birth$'; then
    PKG_ORDER=$(printf 'math-coding-birth\n%s\n' "$(echo "$PKG_ORDER" | grep -v '^math-coding-birth$')")
fi

PKG_NUM=0
for pkg_name in $PKG_ORDER; do
    pkg_dir="$REPO_ROOT/math/$pkg_name"
    [ -d "$pkg_dir" ] || continue
    PKG_NUM=$((PKG_NUM + 1))
    target="packet-$(printf '%02d' $PKG_NUM)-${pkg_name}.md"

    # Compose one page from 5 files: decision.md (head) +
    # assumptions.yaml, task.md, refinement.md as sections
    {
        # Title from decision.md H1 if present
        if [ -f "$pkg_dir/decision.md" ]; then
            awk 'NR==1 && /^# / { sub(/^# /, "# "); print; next } { print }' \
                "$pkg_dir/decision.md"
        fi
        echo ""
        echo "## Packet files"
        echo ""
        echo "- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/${pkg_name}/decision.md)"
        echo "- [task.md](https://github.com/11111000000/math-coding/blob/main/math/${pkg_name}/task.md)"
        echo "- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/${pkg_name}/assumptions.yaml)"
        echo "- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/${pkg_name}/refinement.md)"
        echo "- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/${pkg_name}/packet.yaml)"
        echo ""

        if [ -f "$pkg_dir/decision.md" ]; then
            echo "## Decision"
            echo ""
            # Skip the H1 (already at top) and any preamble blank lines
            awk 'NR>1 && !/^$/' "$pkg_dir/decision.md" | head -n -2
            echo ""
        fi

        if [ -f "$pkg_dir/task.md" ]; then
            echo "## Task"
            echo ""
            cat "$pkg_dir/task.md"
            echo ""
        fi

        if [ -f "$pkg_dir/assumptions.yaml" ]; then
            echo "## Assumptions"
            echo ""
            echo '```yaml'
            cat "$pkg_dir/assumptions.yaml"
            echo '```'
            echo ""
        fi

        if [ -f "$pkg_dir/refinement.md" ]; then
            echo "## Refinement"
            echo ""
            cat "$pkg_dir/refinement.md"
            echo ""
        fi
    } > "$SRC/$target"

    echo "  + src/$target"
done

# Any remaining packets not in PKG_ORDER (alphabetical)
for pkg_dir in "$REPO_ROOT"/math/*/; do
    [ -d "$pkg_dir" ] || continue
    pkg_name=$(basename "$pkg_dir")
    case " $PKG_ORDER " in
        *" $pkg_name "*) continue ;;
    esac
    PKG_NUM=$((PKG_NUM + 1))
    target="packet-$(printf '%02d' $PKG_NUM)-${pkg_name}.md"
    echo "  + src/$target (fallback)"
done

# ─── Root OS files ──────────────────────────────────────
echo ""
echo "=== Root OS files ==="

if [ -f "$REPO_ROOT/README.md" ]; then
    {
        echo "# Introduction"
        echo ""
        # Skip the H1
        awk 'NR>1' "$REPO_ROOT/README.md"
    } > "$SRC/introduction.md"
    echo "  + src/introduction.md"
fi

if [ -f "$REPO_ROOT/agents.md" ]; then
    {
        echo "# Agent protocol"
        echo ""
        awk 'NR>1' "$REPO_ROOT/agents.md"
    } > "$SRC/agents.md"
    echo "  + src/agents.md"
fi

if [ -f "$REPO_ROOT/LICENSE" ]; then
    {
        echo "# License"
        echo ""
        cat "$REPO_ROOT/LICENSE"
    } > "$SRC/license.md"
    echo "  + src/license.md"
fi

if [ -f "$REPO_ROOT/core/packet-schema.md" ]; then
    cp "$REPO_ROOT/core/packet-schema.md" "$SRC/packet-schema.md"
    echo "  + src/packet-schema.md"
fi

# ─── Auto-generate SUMMARY.md ────────────────────────────
# Generated from src/ contents so every packet page is reachable
# from the site navigation. Replaces the previously hardcoded
# src/SUMMARY.md.

echo ""
echo "=== SUMMARY.md ==="
{
    echo "# Summary"
    echo ""
    echo "[Introduction](./introduction.md)"
    echo ""
    echo "---"
    echo ""
    echo "# The convention"
    echo ""
    echo "- [Packet schema](./packet-schema.md)"
    echo "- [Agent protocol](./agents.md)"
    echo "- [License](./license.md)"
    echo ""
    echo "# Mathematical foundation"
    echo ""
    # Theory pages (NN-name)
    for f in $(ls "$SRC"/theory-*.md 2>/dev/null | sort); do
        name=$(basename "$f" .md)
        # Parse "theory-NN-name" → "Theory NN — Name"
        nn=$(echo "$name" | sed -nE 's/^theory-([0-9]+)-.*/\1/p')
        slug=$(echo "$name" | sed -nE 's/^theory-[0-9]+-(.*)$/\1/p')
        # Look up display name from THEORY_DISPLAY; fallback to
        # Title-Case the slug.
        display=$(echo "$THEORY_DISPLAY" | awk -F'|' -v s="$slug" \
            '$1==s { gsub(/^ +| +$/,"",$2); print $2; found=1; exit } END { if (!found) { } }')
        if [ -z "$display" ]; then
            display=$(echo "$slug" | awk -F- '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1' OFS=-)
        fi
        printf -- "- [Theory %s — %s](./%s)\n" "$nn" "$display" "$name.md"
    done
    echo ""
    echo "# Decision packets"
    echo ""
    # Packet pages (packet-NN-name)
    for f in $(ls "$SRC"/packet-*.md 2>/dev/null | sort); do
        name=$(basename "$f" .md)
        # Parse "packet-NN-name" → "Packet NN — Name"
        nn=$(echo "$name" | sed -nE 's/^packet-([0-9]+)-.*/\1/p')
        slug=$(echo "$name" | sed -nE 's/^packet-[0-9]+-(.*)$/\1/p')
        display=$(echo "$slug" | awk -F- '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1' OFS=-)
        printf -- "- [Packet %s — %s](./%s)\n" "$nn" "$display" "$name.md"
    done
} > "$SRC/SUMMARY.md"
echo "  + src/SUMMARY.md (auto-generated, $(grep -c '^- \[' $SRC/SUMMARY.md) entries)"

echo ""
echo "Sync complete. Total files: $(ls $SRC | wc -l)"
