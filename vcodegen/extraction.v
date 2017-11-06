Require Import ExtrOcamlBasic.
Require Import ExtrOcamlString.
Require Import Ditioconf.
Require Import Ditiospec.
Require Import Ditiotrans.
Require Import Ditioall.
Require Import Ditiodevspecs.
Require Import compcert.common.Errors.

Extraction Blacklist List String Int.

Extraction Inline Errors.bind Errors.bind2.

Extract Constant ident_of_string =>
  "fun s -> Camlcoq.intern_string (Camlcoq.camlstring_of_coqstring s)".

Extract Constant Ditioconf.sizeof_master_iomem_space =>
  "Ditioaux.sizeof_master_iomem_space".

Extract Constant Ditioconf.master_iomem_space_data =>
  "[]".

Extract Constant Ditioconf.sizeof_slave_iomem_space =>
  "Ditioaux.sizeof_slave_iomem_space".

Extract Constant Ditioconf.slave_iomem_space_data =>
  "[]".

Extract Constant Ditioconf.sizeof_regaccess_data =>
  "Ditioaux.sizeof_regaccess_data".

Extract Constant Ditioconf.regaccess_data =>
  "[]".

Extract Constant Ditioconf.ditio_memwords =>
  "Ditioaux.ditio_memwords".

Extract Constant Ditiospec.RET_REJECT  => "Ditioaux.ret_reject".
Extract Constant Ditiospec.RET_ALLOW  => "Ditioaux.ret_allow".

Cd "vcodegen".
Extraction Library Ditioconf.
Extraction Library Ditiospec.
Extraction Library Ditiotrans.
Extraction Library Ditioall.
Extraction Library Ditiodevspecs.
