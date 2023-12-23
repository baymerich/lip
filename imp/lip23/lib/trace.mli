exception NoRuleApplies
(* raised when an expression or instruction cannot take a further step *)

exception WrongArguments of int * int
(* [WrongArguments (n_act, n_exp)] is raised when the number [n_act] of actual
   arguments a function is called with doesn't match the number [n_exp] of
   formal parameters of its definition *)

type state = Memory.environment * Memory.memory

type conf =
  | St
  (* the result of instruction that cannot be reduced further *)
  | Ret of int
  (* the result of return statements with an expression *)
  | Instr of Ast.instruction
(* the result of computations that can be reduces further *)

val apply_intrinsic : int list -> Ast.intrinsic -> int option
(* [apply_intrinsic vals i] applies the list of values [vals] to the instrinsic
   function of the Robot module matching the constructor [i], and returns
   [Some v] if instrinsic implementation returns a value [v], or None if the
   intrinsic returns unit. *)

val trace1_expr : state -> Ast.expression -> Ast.expression
(* performs one step of small-step semantics for an expression in a certain
   state*)

val trace1_instr : state -> conf -> conf
(* performs one step of small-step semantics for an instruction in a certain
   state*)

val trace_instr : state -> conf -> conf list
(* performs multiple steps of small-step semantics for an instruction,
   recording each step in a list *)

val trace_expr : state -> Ast.expression -> Ast.expression list
(* performs multiple steps of small-step semantics for an instruction,
   recording each step in a list *)
