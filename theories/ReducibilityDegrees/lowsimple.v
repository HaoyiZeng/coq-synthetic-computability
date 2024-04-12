From SyntheticComputability Require Import ArithmeticalHierarchySemantic reductions SemiDec TuringJump OracleComputability Definitions Limit simple.
Require Import SyntheticComputability.Synthetic.DecidabilityFacts.
Require Export SyntheticComputability.Shared.FinitenessFacts.
Require Export SyntheticComputability.Shared.Pigeonhole.
Require Export SyntheticComputability.Shared.ListAutomation.
Require Export SyntheticComputability.ReducibilityDegrees.low_wall.
Require Import Arith.
Require Import Vectors.VectorDef Arith.Compare_dec Lia.
Import Vector.VectorNotations.

Local Notation vec := Vector.t.


(* ########################################################################## *)
(** * Low Simple Set *)
(* ########################################################################## *)

(** This file contains the definition of low simple set and proves the
essential property of low simple, i.e. Low simple as a solution to
Post's Problem in Turing degree. **)

  (* Definition of low *)
  Definition low (P: nat -> Prop) := P´ ⪯ᴛ K.

Section LowFacts.

  Variable vec_to_nat : forall k, vec nat k -> nat.
  Variable nat_to_vec : forall k, nat -> vec nat k.
  Variable vec_nat_inv : forall k v, nat_to_vec k (vec_to_nat v) = v.
  Variable nat_vec_inv : forall k n, vec_to_nat (nat_to_vec k n) = n.

  Variable list_vec_to_nat : forall k, list (vec nat k) -> nat.
  Variable nat_to_list_vec : forall k, nat -> list (vec nat k).
  Variable list_vec_nat_inv : forall k v, nat_to_list_vec k (list_vec_to_nat v) = v.
  Variable nat_list_vec_inv : forall k n, list_vec_to_nat (nat_to_list_vec k n) = n.

  Variable nat_to_list_bool : nat -> list bool.
  Variable list_bool_to_nat : list bool -> nat.
  Variable list_bool_nat_inv : forall l, nat_to_list_bool (list_bool_to_nat l) = l.
  Variable nat_list_bool_inv : forall n, list_bool_to_nat (nat_to_list_bool n) = n.

  Lemma lowness (P: nat -> Prop) :
    low P -> ~ K ⪯ᴛ P.
  Proof.
    intros H IH.
    eapply not_turing_red_J with (Q := P).
    eapply Turing_transitive; [apply H| easy].
  Qed.

  Lemma limit_jump_lowness (A: nat -> Prop) :
    LEM_Σ 1 ->
    definite K ->
    limit_computable (A´) -> ~ K ⪯ᴛ A.
  Proof.
    intros LEM defK H IH.
    apply lowness with (P := A); [|apply IH].
    eapply limit_turing_red_K; eauto. exact 42. 
  Qed.

  Definition low_simple P := low P /\ simple P.

  Definition sol_Post's_problem (P: nat -> Prop) :=
    (~ decidable P) /\ (enumerable P) /\ ~ (K ⪯ᴛ P).

  Fact low_simple_correct:
    forall P, low_simple P -> sol_Post's_problem P.
  Proof.
    intros P [H1 H2]; split; [now apply simple_undecidable|].
    split; [destruct H2 as [H2 _]; eauto| now apply lowness].
  Qed.

    (*** Instance of low simple predicate ***)

  Section LowSimplePredicate.

  Variable η: nat -> nat -> option nat.
  Hypothesis EA: 
    forall P, semi_decidable P -> exists e, forall x, P x <-> exists n, η e n = Some x.
  Hypothesis LEM_Σ_1: LEM_Σ 1.
  Hypothesis def_K: definite K.
  Hypothesis sth: forall (P: nat -> Prop) (k: nat), 
    (forall x, k <= x -> P x) \/ (exists x, k <= x /\ ~ P x).
  Hypothesis DN: forall P, ~ ~ P -> P.
  Hypothesis LEM_Σ_2: 
    forall (P: nat -> nat -> Prop), (forall n m, dec (P n m)) -> dec (exists n, forall m, P n m).

  Theorem a_sol_Post's_problem: exists P, sol_Post's_problem P.
  Proof.
    eexists. eapply low_simple_correct; split.
    - eapply limit_turing_red_K; eauto. exact 42.
      apply jump_P_limit; eauto. 
    - eapply P_simple; eauto. 
  Qed.

  End LowSimplePredicate.

End LowFacts.

