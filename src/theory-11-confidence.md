# Theory: Confidence (Shannon)

**Rigor:** any

For a Bernoulli belief with confidence c ∈ [0, 1], the
information content in bits is:

    I(c) = -c·log₂(c) - (1-c)·log₂(1-c)

I(c) reaches its maximum of 1 bit at c = 0.5 and is 0 at
c ∈ {0, 1}.

## math-coding instance

math-coding uses I(c) as the *readiness signal* of a packet.
`Total_I = Σ I(c)` over the assumption set is compared to
the threshold of 2 bits — a packet is ready for verification
when Total_I ≤ 2.

The threshold and the four-marker reading are decided in
[[math/math-coding-birth/decision.md#synthesis|the math-coding-birth synthesis]].
