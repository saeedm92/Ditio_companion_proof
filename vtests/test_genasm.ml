open Ditiospec
open Ditioconf
open Ditioall
open Ditiodevspecs
open AST
open PrintCminor
open Errors
open Printf
open Camlcoq
open Buffer

let print_error oc msg =
  let print_one_error = function
  | Errors.MSG s -> output_string oc (Camlcoq.camlstring_of_coqstring s)
  | Errors.CTX i -> output_string oc (Camlcoq.extern_atom i)
  | Errors.POS i -> fprintf oc "%ld" (Camlcoq.P.to_int32 i)
  in
    List.iter print_one_error msg;
    output_char oc '\n';;

let gen_file f =
  let main = Ditioconf.main_id in
  let p = { prog_defs = [(main, Gfun (Internal f))]; prog_main = main } in
  match Ditioall.ditio_to_asm p with
  | Errors.OK asm -> ( PrintAsm.print_program stdout asm; exit 0 )
  | Errors.Error msg -> ( print_error stdout msg; exit 1 )
;;

List.map gen_file [ [n5_cam_check] ];;
(* List.map gen_file [ [n5_cam_vib_invariant] ];; *)

(*
  { inv = omap5432_mic_led_invariant;
    master_dev = twl6040_spec;
    slave_dev = gpio_spec };
*)
(*
  { inv = simple_rgb_led_invariant;
    master_dev = gpio02_spec;
    slave_dev = gpio23_spec };
*)
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
];;
*)

(*
let main () =
  let argc = Array.length Sys.argv in
  if argc < 2 then
    (Format.printf "Usage: %s <FILE>\n" Sys.executable_name; exit 1)
  else
    gen_file Sys.argv.(1)
;;

main ()
*)
