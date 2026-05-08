# Sturm–Liouville Eigenvalue Simplicity — Comparator-Ready Package

A single-entry-point package for verifying the Sturm–Liouville
eigenvalue simplicity proof against a Lean kernel using the
[comparator framework](https://github.com/leanprover/comparator).

## What's in here

```
.
├── Challenge.lean      ← statement of the theorem, with := by sorry
├── Solution.lean       ← the actual proof (~760 lines, all lemmas inline)
├── config.json         ← comparator configuration
├── lakefile.toml       ← Mathlib pinned to v4.28.0
├── lean-toolchain      ← Lean version pin
├── LICENSE             ← MIT
└── README.md           ← this file
```

## The theorem

```lean
theorem sturm_liouville_simple_eigenvalues (V : ℝ → ℝ)
    (hV : IsConfiningPotential V) (eigval : ℝ) :
    IsSimpleEigenvalue V eigval
```

In English: for a continuous potential V : ℝ → ℝ that tends to +∞ as
|x| → ∞, every eigenvalue of L = -d²/dx² + V is simple — any two L²
eigenfunctions for the same eigenvalue are scalar multiples of each
other.

The proof composes three classical components:

1. The Wronskian is constant on shared-eigenvalue solution pairs.
2. Both u(x) and u'(x) decay to 0 along `Filter.cocompact ℝ` for L²
   eigenfunctions of confining potentials.
3. Two solutions of a second-order linear ODE whose Wronskian
   vanishes identically are linearly dependent.

The capstone follows by composition.

## Pinned environment

| Component | Version |
| --- | --- |
| Lean | `leanprover/lean4:v4.28.0` |
| Mathlib | tag `v4.28.0` |

(Earlier development was carried out against Lean `v4.24.0` and
Mathlib commit `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. Toolchain
bumped to `v4.28.0` for compatibility with the comparator framework.
If the bump surfaces deprecation warnings or small API changes that
need addressing in `Solution.lean`, those will be resolved here.)

## How comparator works on this package

Comparator (<https://github.com/leanprover/comparator>) is the trusted
verification framework for Lean proofs. Given a Challenge file with
a sorry'd theorem and a Solution file with the proof, comparator:

1. Sandbox-builds `Challenge.lean`
2. Sandbox-builds `Solution.lean`
3. Verifies the theorem signature in Solution matches Challenge exactly
4. Verifies the proof uses only the permitted axioms
5. Replays the proof through Lean's kernel
6. Exits 0 on success

The permitted axioms in `config.json` are the three Mathlib standards:
`propext`, `Quot.sound`, `Classical.choice`. No custom axioms are
permitted.

## Running comparator

Comparator runs on Linux. From the repository root:

```bash
# Optional but recommended: fetch Mathlib cache
lake exe cache get

# Run comparator (replace path with your local comparator binary)
lake env /path/to/comparator/binary config.json
```

Prerequisites (all from <https://github.com/leanprover/comparator>):
- `landrun` (Linux sandboxing — Linux 5.13+ kernel)
- `lean4export` (kernel export tool, version-matched to Lean 4.28.0)
- comparator binary itself

## Honest status

**I have not personally run comparator on this package.**
I'm on Windows and don't currently have a Linux environment with
`landrun` available. The package is structured to be comparator-ready,
and `Solution.lean` compiles zero-`sorry` against the originally
pinned Mathlib commit (`f897ebcf`, Lean 4.24.0) in my own development
environment.

**Pinned versions were bumped on 2026-05-07** from Lean 4.24.0 /
Mathlib `f897ebcf` to Lean v4.28.0 / Mathlib tag `v4.28.0` after Kim
Morrison noted that comparator targets v4.28.0+. If the bump
surfaces deprecation warnings or small API changes in `Solution.lean`
against newer Mathlib, those will be addressed here directly. Issues
filed on this repo are very welcome.

If anyone with comparator already set up wants to run this and report
the result, I'd appreciate it.

## How `Solution.lean` was developed

The proof in `Solution.lean` was developed iteratively against Lean's
elaborator, not generated wholesale by an LLM. Aristotle
(Harmonic, <https://aristotle.harmonic.fun>), a Lean-specific
neural-guided automated theorem prover, was used to fill in some of
the smaller proof gaps — these appear in the source as
`exact?`-generated terms that the Lean kernel resolves at elaboration
time. Conversational LLMs (Claude, Grok) were used during development
for discussion, debugging type errors, and pressure-testing approaches,
not for autonomous proof generation.

The mathematics is standard textbook Sturm–Liouville theory
(Coddington–Levinson, Reed–Simon Vol. IV), formalized into Lean.

## Related artifact

The full broader development this is excerpted from is at
<https://github.com/Joeyxyxyz/MessinaNullificationFramework_RH_AFM>
with Zenodo DOI [10.5281/zenodo.19969029](https://doi.org/10.5281/zenodo.19969029).
This package is the focused, comparator-ready isolation of one
specific theorem from that broader work.

## Acknowledgments

- Lean and Mathlib communities for the underlying formalization
  infrastructure
- The comparator team (Henrik Böving, Kim Morrison, Joachim Breitner,
  Sebastian Ullrich) for the verification framework
- Aristotle (Harmonic) for proof completion assistance
- AXLE (Axiom, Ken Ono) for earlier independent kernel verification
  of related theorems

## License

MIT — see `LICENSE`.

## Contact

Joseph Messina — Independent Researcher — Silver Springs, NV, USA
GitHub: [@Joeyxyxyz](https://github.com/Joeyxyxyz)
