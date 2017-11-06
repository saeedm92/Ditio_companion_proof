Require Import ExtrOcamlBasic.
Require Import ExtrOcamlString.
Require Import Reginferconf.
Require Import Reginferspec.
Require Import Reginfertrans.
Require Import Reginferall.
Require Import Reginferdevspecs.
Require Import compcert.common.Errors.

Extraction Blacklist List String Int.

Extraction Inline Errors.bind Errors.bind2.

Extract Constant ident_of_string =>
  "fun s -> Camlcoq.intern_string (Camlcoq.camlstring_of_coqstring s)".

(*
Extract Constant Reginferconf.sizeof_iomem_space =>
  "Reginferaux.sizeof_iomem_space".

Extract Constant Reginferconf.iomem_space_data =>
  "[]".
*)

Extract Constant Reginferconf.sizeof_iregaccess_data =>
  "Reginferaux.sizeof_iregaccess_data".

Extract Constant Reginferconf.iregaccess_data =>
  "[]".

Extract Constant Reginferconf.sizeof_oregaccess_data =>
  "Reginferaux.sizeof_oregaccess_data".

Extract Constant Reginferconf.oregaccess_data =>
  "[]".

Extract Constant Reginferconf.reginfer_memwords =>
  "Reginferaux.reginfer_memwords".

Extract Constant Reginferspec.RET_NOINFER  => "Reginferaux.ret_noinfer".
Extract Constant Reginferspec.RET_INFER  => "Reginferaux.ret_infer".

Cd "rcodegen".
Extraction Library Reginferconf.
Extraction Library Reginferspec.
Extraction Library Reginfertrans.
Extraction Library Reginferall.
Extraction Library Reginferdevspecs.
