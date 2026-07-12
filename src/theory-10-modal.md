# Theory: Modal Logic

**Rigor:** temporal+

The two modal operators over reachable states:

- □P — necessarily P (P holds in every reachable state)
- ◇P — possibly P (P holds in some reachable state)

Unlike LTL's operators, □ and ◇ quantify over the branching
tree of futures, not over a single linear run.

## math-coding instance

In math-coding, □ and ◇ express packet-lifecycle properties
the FSM alone cannot: "no reachable state escapes archived"
(□archived after verified → archived) and "archived is
reachable from verified" (◇archived). See
[[math/theory-modal-as-packet/refinement.md|the modal property table]] for the
property table.

## Diagram (Mermaid: modal reachability)

```mermaid
flowchart LR
    verified -->|□ archived| archived
    verified -->|◇ archived| archived
    working -->|□ verified| verified
    working -->|◇ working| working
    note[□ = necessary (all reachable states)<br/>◇ = possible (some reachable state)]
```
