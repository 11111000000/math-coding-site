# init-packet.sh (the packet creator)

```sh
#!/bin/sh
# init-packet.sh — create a new math-coding packet.
# Usage: sh init-packet.sh <task-id> [dir]
# Creates 3 required files. No more, no less.

set -e

TASK_ID="${1:?usage: init-packet.sh <task-id> [dir]}"
DEST="${2:-./specs/$TASK_ID}"

mkdir -p "$DEST"

cat > "$DEST/packet.yaml" <<EOF
task_id: $TASK_ID
title: $TASK_ID
lifecycle: sketch
substrate: none
rigor: light
decision: needed
created: "$(date +%Y-%m-%d)"
verifier: null
depends_on: []
EOF

cat > "$DEST/task.md" <<EOF
# $TASK_ID

## Problem

What problem does this packet address?

## Desired outcome

What success looks like.

## Constraints

- must be testable
EOF

cat > "$DEST/assumptions.yaml" <<EOF
task_id: $TASK_ID
assumptions:
  - id: A1
    statement: "<state your first assumption>"
    status: agent-inferred
    epistemology: hypothesis
    confidence: 0.5
EOF

echo "Created packet: $DEST"
echo "  - packet.yaml     (manifest)"
echo "  - task.md         (problem, outcome, constraints)"
echo "  - assumptions.yaml (epistemic context)"
echo ""

# Substrate recommendation based on task.md keywords.
# This is a HINT, not a rule. Agent applies judgment.
# Uses -P (perl-regexp) with \b for word-boundary matching
# to catch prefixes like "Authentication" matching "auth",
# while avoiding false positives like "model" matching "testable".
if [ -f "$DEST/task.md" ]; then
    hints=""

    if grep -qiP "\b(concurrent|parallel|race|deadlock|distributed|thread)\b" "$DEST/task.md"; then
        hints="${hints}  - concurrency/distribution detected: consider substrate: tla + Model.tla\n"
    fi

    if grep -qiP "\b(security|crypt|financial|safety|auth|login|password)\b" "$DEST/task.md"; then
        hints="${hints}  - security/financial/safety detected: consider substrate: coq + proof\n"
    fi

    if grep -qiP "\b(schema|database|table|entity|relation|model)\b" "$DEST/task.md"; then
        hints="${hints}  - relational schema detected: consider substrate: alloy + Model.als\n"
    fi

    if grep -qiP "\b(random|probabilistic|failure|monte.carlo|probability)\b" "$DEST/task.md"; then
        hints="${hints}  - probabilistic behavior detected: consider substrate: pbt + Model.prism\n"
    fi

    if grep -qiP "\b(workflow|process|step|approval|flow)\b" "$DEST/task.md"; then
        hints="${hints}  - business process detected: consider substrate: bpmn + Model.bpmn\n"
    fi

    if [ -n "$hints" ]; then
        echo "Substrate hints (from task.md keywords):"
        printf "$hints"
        echo ""
        echo "  See core/packet-schema.md#substrate-decision-tree for full decision logic."
    fi
fi

echo "Next steps:"
echo "  1. Edit the 3 created files (packet.yaml, task.md, assumptions.yaml)"
echo "  2. Choose substrate based on decision complexity (see packet-schema.md)"
echo "  3. Run: sh core/verify.sh"
echo "  4. If concurrency/distributed: write Model.tla"
echo "  5. If security/financial: write proof in Coq"
echo "  6. Write code in src/"
```
