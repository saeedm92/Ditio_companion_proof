open Violaconf
open Violaspec
open Violatrans
open Violadevspecs
open AST
open PrintCminor
open Errors
open Printf
open Camlcoq

let print_error oc msg =
  let print_one_error = function
  | Errors.MSG s -> output_string oc (Camlcoq.camlstring_of_coqstring s)
  | Errors.CTX i -> output_string oc (Camlcoq.extern_atom i)
  | Errors.POS i -> fprintf oc "%ld" (Camlcoq.P.to_int32 i)
  in
    List.iter print_one_error msg;
    output_char oc '\n';;

let compile_and_print f =
  let main = Violaconf.main_id in
  let p = { prog_defs = [(main, Gfun (Internal f))]; prog_main = main } in
  match Violatrans.transl_program p with
  | Errors.OK x -> print_program (Format.formatter_of_out_channel stdout) x
  | Errors.Error msg -> print_error stdout msg
    (* using stdout instead of stderr to fully order diagnostic output *)
in List.map compile_and_print [
  { inv = simple_rgb_led_invariant;
    master_dev = gpio02_spec;
    slave_dev = gpio23_spec };
(*
  { inv = { inv_binder = Coq_uni_r;
            inv_master = Integers.Int.repr (Zpos Coq_xH);
            inv_slave = Integers.Int.repr (Zpos Coq_xH)
          };
    master_dev = Z0;
    slave_dev = Zpos (Coq_xO (Coq_xO Coq_xH)) };
*)
(*
  { inv = { inv_binder = Coq_uni_r;
            inv_master = Int.repr (Zpos Coq_xH);
            inv_slave = Int.repr (Zpos Coq_xH)
          };
    master_dev = Z0;
    slave_dev = Zpos Coq_xH };
*)
(*
  [
    Seccomp.Salu_safe (Aaddimm Integers.Int.one);
    Seccomp.Sret_a;
  ];
  [
    Seccomp.Salu_safe (Aaddimm Integers.Int.one);
    Seccomp.Sjmp_ja Integers.Int.zero;
    Seccomp.Sjmp_ja Integers.Int.one;
    Seccomp.Salu_safe (Aaddimm Integers.Int.one);
    Seccomp.Sjmp_ja Integers.Int.one;
    Seccomp.Sret_a;
  ];
  [
    Seccomp.Salu_safe (Aaddimm Integers.Int.one);
    Seccomp.Sjmp_ja Integers.Int.one;
    Seccomp.Salu_safe (Aaddimm Integers.Int.one);
  ];
*)
];;
