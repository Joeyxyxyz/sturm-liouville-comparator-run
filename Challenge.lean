/-
Comparator Challenge file.

Contains the statement of the Sturm-Liouville eigenvalue simplicity
theorem with `:= by sorry`. A solution file must prove the same
statement using only the permitted axioms.

This file is controlled by the verifier (challenger), not the prover.

Imports: only Mathlib.

Pinned environment:
  Lean: leanprover/lean4:v4.24.0
  Mathlib commit: f897ebcf72cd16f89ab4577d0c826cd14afaafc7

The four definitions below are reproduced verbatim from the source
file so that the statement of the capstone theorem is identical here
and in the corresponding Solution file.
-/

import Mathlib

set_option linter.mathlibStandardSet false

open scoped BigOperators
open scoped Real
open scoped Nat
open scoped Classical
open scoped Pointwise

set_option maxHeartbeats 0
set_option maxRecDepth 4000
set_option synthInstance.maxHeartbeats 20000
set_option synthInstance.maxSize 128

set_option relaxedAutoImplicit false
set_option autoImplicit false

noncomputable section

def IsConfiningPotential (V : ℝ → ℝ) : Prop :=
  Continuous V ∧ Filter.Tendsto V (Filter.cocompact ℝ) Filter.atTop

def IsSturmLiouvilleEigenfunction (V : ℝ → ℝ) (eigval : ℝ) (u : ℝ → ℝ) : Prop :=
  Differentiable ℝ u ∧
  Differentiable ℝ (deriv u) ∧
  (∀ x, -(deriv (deriv u) x) + V x * u x = eigval * u x) ∧
  u ≠ 0 ∧
  MeasureTheory.MemLp u 2 MeasureTheory.volume

def wronskian (u v : ℝ → ℝ) (x : ℝ) : ℝ :=
  u x * deriv v x - v x * deriv u x

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
