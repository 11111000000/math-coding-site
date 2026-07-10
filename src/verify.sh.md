# verify.sh (the structural verifier)

```sh
#!/bin/sh
# verify.sh — structural verification of math-coding packets.
# Recursively finds every packet.yaml and checks required files.
# Stage 1: structural only.

set -e

errors=0
while IFS= read -r f; do
    dir=$(dirname "$f")
    name=$(basename "$dir")

    # Required files
    for required in packet.yaml task.md assumptions.yaml; do
        [ -f "$dir/$required" ] || {
            echo "FAIL: $name missing $required"
            errors=$((errors + 1))
        }
    done

    # packet.yaml required fields
    for field in task_id title lifecycle substrate decision created; do
        grep -qE "^${field}:" "$dir/packet.yaml" || {
            echo "FAIL: $name packet.yaml missing $field"
            errors=$((errors + 1))
        }
    done

    # Lifecycle enum
    lc=$(grep "^lifecycle:" "$dir/packet.yaml" | sed 's/.*lifecycle: *//')
    case "$lc" in
        sketch|working|verified|deprecated|archived|superseded) ;;
        *) echo "FAIL: $name invalid lifecycle '$lc'"; errors=$((errors + 1)) ;;
    esac

    # Substrate enum
    sub=$(grep "^substrate:" "$dir/packet.yaml" | sed 's/.*substrate: *//')
    case "$sub" in
        none|shell|tla|typescript|pbt|alloy|coq|bpmn) ;;
        *) echo "FAIL: $name invalid substrate '$sub'"; errors=$((errors + 1)) ;;
    esac

    # Rigor enum
    rig=$(grep "^rigor:" "$dir/packet.yaml" | sed 's/.*rigor: *//')
    case "$rig" in
        light|property|temporal|proof) ;;
        *) echo "FAIL: $name invalid rigor '$rig'"; errors=$((errors + 1)) ;;
    esac

    # Decision enum
    dec=$(grep "^decision:" "$dir/packet.yaml" | sed 's/.*decision: *//')
    case "$dec" in
        needed|made) ;;
        *) echo "FAIL: $name invalid decision '$dec'"; errors=$((errors + 1)) ;;
    esac

    # assumptions.yaml
    if ! grep -qE "^task_id:" "$dir/assumptions.yaml"; then
        echo "FAIL: $name assumptions.yaml missing task_id"
        errors=$((errors + 1))
    fi
    if ! grep -qE "^  - id: A[0-9]+" "$dir/assumptions.yaml"; then
        echo "FAIL: $name assumptions.yaml has no A<n>-format ids"
        errors=$((errors + 1))
    fi
    for s in $(grep "^  - status:" "$dir/assumptions.yaml" | sed 's/.*status: *//'); do
        case "$s" in
            user-confirmed|agent-inferred|open) ;;
            *) echo "FAIL: $name invalid status '$s'"; errors=$((errors + 1)) ;;
        esac
    done
    for e in $(grep "^  - epistemology:" "$dir/assumptions.yaml" | sed 's/.*epistemology: *//'); do
        case "$e" in
            fact|hypothesis|judgment|unknown) ;;
            *) echo "FAIL: $name invalid epistemology '$e'"; errors=$((errors + 1)) ;;
        esac
    done
done < <(find . -name "packet.yaml" -not -path "./.git/*")

if [ $errors -eq 0 ]; then
    echo "OK: all packets follow conventions"
fi
exit $errors
```
