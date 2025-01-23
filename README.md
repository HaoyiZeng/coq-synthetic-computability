# Post's Problem in Constructive Mathematics

This project is based on the repository: 
[**Synthetic Computability Theory in Coq**](https://github.com/uds-psl/coq-synthetic-computability)

## Description
All the proofs for the paper *Post's Problem in Constructive Mathematics* are in `theories/PostsProblem`.

- Our construction of approximative step-indexed execution and use functions are in `PostsProblem/step_indexing.v`
- The limit lemma (Ch. IV) in `PostsProblem/limit_computability.v`
- The construction of simple set (Ch. V) in `PostsProblem/the_priority_method.v` and `PostsProblem/simpleness.v`
- The construction of low simple set (Ch. VI) in `PostsProblem/lowness.v`
- The solutions for Post's problem (Ch. VII) are summarized in `PostsProblem/low_simple_predicates.v`

## Installation

```sh
opam switch create coq-synthetic-computability --packages=ocaml-variants.4.14.0+options,ocaml-option-flambda
eval $(opam env)
opam repo add coq-released https://coq.inria.fr/opam/released
opam install coq.8.17.0 coq-equations.1.3+8.17 coq-stdpp.1.8.0
cd theories
make
```
