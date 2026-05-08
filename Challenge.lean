/-
Comparator Challenge file.

Contains the statement of the Sturm-Liouville eigenvalue simplicity
theorem with `:= by sorry`. A solution file must prove the same
statement using only the permitted axioms.

This file is controlled by the verifier (challenger), not the prover.

Imports: only Mathlib.

Pinned environment:
  Lean: leanprover/lean4:v4.28.0
  Mathlib: tag v4.28.0

The three definitions below state the predicates appearing in the
capstone theorem: a confining potential, an L^2 Sturm-Liouville
eigenfunction, and a simple eigenvalue. The Wronskian is needed for
the proof but not for the statement, so it lives only in Solution.lean.
-/

import Mathlib

open scoped Classical

noncomputable section

def IsConfiningPotential (V : ℝ → ℝ) : Prop :=
  Continuous V ∧ Filter.Tendsto V (Filter.cocompact ℝ) Filter.atTop

def IsSturmLiouvilleEigenfunction (V : ℝ → ℝ) (eigval : ℝ) (u : ℝ → ℝ) : Prop :=
  Differentiable ℝ u ∧
  Differentiable ℝ (deriv u) ∧
  (∀ x, -(deriv (deriv u) x) + V x * u x = eigval * u x) ∧
  u ≠ 0 ∧
  MeasureTheory.MemLp u 2 MeasureTheory.volume

def IsSimpleEigenvalue (V : ℝ → ℝ) (eigval : ℝ) : Prop :=
  ∀ u v : ℝ → ℝ,
    IsSturmLiouvilleEigenfunction V eigval u →
    IsSturmLiouvilleEigenfunction V eigval v →
    ∃ c : ℝ, ∀ x, v x = c * u x

theorem sturm_liouville_simple_eigenvalues (V : ℝ → ℝ)
    (hV : IsConfiningPotential V) (eigval : ℝ) :
    IsSimpleEigenvalue V eigval := by
  sorry

end
