Require Export compcert.backend.Cminor.
Require Import compcert.common.AST.
Require Import compcert.common.Globalenvs.
Require Import compcert.common.Memory.
Require Import compcert.common.Smallstep.
Require Import compcert.common.Values.
Require Import compcert.lib.Coqlib.
Require Import compcert.lib.Integers.
Require Export Reginferconf.
Import ListNotations.

Inductive initial_state (p: Cminor.program): Cminor.state -> Prop :=
  | initial_state_intro: forall b fd m0 m1 m2 m3 m4 iregaccess oregaccess,
    let ge := Genv.globalenv p in
    Genv.init_mem p = Some m0 ->
    Genv.find_symbol ge p.(prog_main) = Some b ->
    Genv.find_funct_ptr ge b = Some fd ->
    funsig fd = signature_main ->
    Mem.alloc m0 0 sizeof_iregaccess_data = (m1, iregaccess) ->
    Mem.alloc m1 sizeof_iregaccess_data sizeof_oregaccess_data = (m2, oregaccess) ->
    Mem.storebytes m2 iregaccess 0 (Memdata.inj_bytes iregaccess_data) = Some m3 ->
    Mem.storebytes m3 oregaccess 0 (Memdata.inj_bytes oregaccess_data) = Some m4 ->
    initial_state p (Callstate fd [ Vptr iregaccess Int.zero; Vptr oregaccess Int.zero ] Kstop m4).

Definition semantics (p: Cminor.program) :=
  Semantics Cminor.step (initial_state p) Cminor.final_state (Genv.globalenv p).
