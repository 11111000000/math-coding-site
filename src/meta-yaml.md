# meta.yaml (operating-system manifest)

```yaml
# meta.yaml — operating-system manifest.
# These files serve the convention but are NOT packets.

operating_system:
  - path: README.md
    role: landing-page
    serves: github-visitors
  - path: LICENSE
    role: legal
    serves: all-packets
  - path: CHANGELOG.md
    role: history
    serves: maintainers
  - path: .gitignore
    role: git-config
    serves: all-packets
  - path: .github/workflows/
    role: ci-config
    serves: ci-runner
  - path: core/init-packet.sh
    role: convention-runtime
    serves: packet-creators
  - path: core/verify.sh
    role: convention-runtime
    serves: all-packets

# Theory layer (v1.1.1+): theories/ holds pure documentation.
# The DECISIONS to include each theory live as packets in
# specs/theory-layer-*/. This separates
# "the math" (docs, no intent) from "the decision to use
# the math" (packet, intent-bearing).
  - path: theories/
    role: theory-documentation
    serves: agents-and-readers
    pattern: "*.md"
    excludes:
      - packet.yaml
    notes: |
      Theory documents are operating-system files. Their
      decision-of-inclusion lives at
      specs/theory-layer-{foundation,v1.1.0}/.
      If a theories/*.md file accidentally gains YAML
      frontmatter or packet-like structure, it should be
      promoted to a packet, not kept here.

# Fractal property: applies to DECISIONS, not files.
# A decision with intent = packet.
# A file without intent = operating-system.
# No exceptions needed because scope of "fractal" is bounded
# to "decisions with intent".
```
