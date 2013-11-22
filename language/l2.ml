(* generated by Ott 0.22 from: l2.ott *)


type text = string

type l = Parse_ast.l

type 'a annot = l * 'a


type x = text (* identifier *)
type ix = text (* infix identifier *)

type 
base_kind_aux =  (* base kind *)
   BK_type (* kind of types *)
 | BK_nat (* kind of natural number size expressions *)
 | BK_order (* kind of vector order specifications *)
 | BK_effects (* kind of effect sets *)


type 
base_kind = 
   BK_aux of base_kind_aux * l


type 
id_aux =  (* Identifier *)
   Id of x
 | DeIid of x (* remove infix status *)


type 
kind_aux =  (* kinds *)
   K_kind of (base_kind) list


type 
id = 
   Id_aux of id_aux * l


type 
kind = 
   K_aux of kind_aux * l


type 
nexp_aux =  (* expression of kind $_$, for vector sizes and origins *)
   Nexp_id of id (* identifier *)
 | Nexp_constant of int (* constant *)
 | Nexp_times of nexp * nexp (* product *)
 | Nexp_sum of nexp * nexp (* sum *)
 | Nexp_exp of nexp (* exponential *)

and nexp = 
   Nexp_aux of nexp_aux * l


type 
kinded_id_aux =  (* optionally kind-annotated identifier *)
   KOpt_none of id (* identifier *)
 | KOpt_kind of kind * id (* kind-annotated variable *)


type 
nexp_constraint_aux =  (* constraint over kind $_$ *)
   NC_fixed of nexp * nexp
 | NC_bounded_ge of nexp * nexp
 | NC_bounded_le of nexp * nexp
 | NC_nat_set_bounded of id * (int) list


type 
efct_aux =  (* effect *)
   Effect_rreg (* read register *)
 | Effect_wreg (* write register *)
 | Effect_rmem (* read memory *)
 | Effect_wmem (* write memory *)
 | Effect_undef (* undefined-instruction exception *)
 | Effect_unspec (* unspecified values *)
 | Effect_nondet (* nondeterminism from intra-instruction parallelism *)


type 
kinded_id = 
   KOpt_aux of kinded_id_aux * l


type 
nexp_constraint = 
   NC_aux of nexp_constraint_aux * l


type 
efct = 
   Effect_aux of efct_aux * l


type 
quant_item_aux =  (* Either a kinded identifier or a nexp constraint for a typquant *)
   QI_id of kinded_id (* An optionally kinded identifier *)
 | QI_const of nexp_constraint (* A constraint for this type *)


type 
effects_aux =  (* effect set, of kind $_$ *)
   Effects_var of id
 | Effects_set of (efct) list (* effect set *)


type 
order_aux =  (* vector order specifications, of kind $_$ *)
   Ord_id of id (* identifier *)
 | Ord_inc (* increasing (little-endian) *)
 | Ord_dec (* decreasing (big-endian) *)


type 
quant_item = 
   QI_aux of quant_item_aux * l


type 
effects = 
   Effects_aux of effects_aux * l


type 
order = 
   Ord_aux of order_aux * l


type 
typquant_aux =  (* type quantifiers and constraints *)
   TypQ_tq of (quant_item) list
 | TypQ_no_forall (* sugar, omitting quantifier and constraints *)


type 
lit_aux =  (* Literal constant *)
   L_unit (* $() : _$ *)
 | L_zero (* $_ : _$ *)
 | L_one (* $_ : _$ *)
 | L_true (* $_ : _$ *)
 | L_false (* $_ : _$ *)
 | L_num of int (* natural number constant *)
 | L_hex of string (* bit vector constant, C-style *)
 | L_bin of string (* bit vector constant, C-style *)
 | L_undef (* constant representing undefined values *)
 | L_string of string (* string constant *)


type 
typ_aux =  (* Type expressions, of kind $_$ *)
   Typ_wild (* Unspecified type *)
 | Typ_var of id (* Type variable *)
 | Typ_fn of typ * typ * effects (* Function type (first-order only in user code) *)
 | Typ_tup of (typ) list (* Tuple type *)
 | Typ_app of id * (typ_arg) list (* type constructor application *)

and typ = 
   Typ_aux of typ_aux * l

and typ_arg_aux =  (* Type constructor arguments of all kinds *)
   Typ_arg_nexp of nexp
 | Typ_arg_typ of typ
 | Typ_arg_order of order
 | Typ_arg_effects of effects

and typ_arg = 
   Typ_arg_aux of typ_arg_aux * l


type 
typquant = 
   TypQ_aux of typquant_aux * l


type 
lit = 
   L_aux of lit_aux * l


type 
typschm_aux =  (* type scheme *)
   TypSchm_ts of typquant * typ


type 
'a pat_aux =  (* Pattern *)
   P_lit of lit (* literal constant pattern *)
 | P_wild (* wildcard *)
 | P_as of 'a pat * id (* named pattern *)
 | P_typ of typ * 'a pat (* typed pattern *)
 | P_id of id (* identifier *)
 | P_app of id * ('a pat) list (* union constructor pattern *)
 | P_record of ('a fpat) list * bool (* struct pattern *)
 | P_vector of ('a pat) list (* vector pattern *)
 | P_vector_indexed of ((int * 'a pat)) list (* vector pattern (with explicit indices) *)
 | P_vector_concat of ('a pat) list (* concatenated vector pattern *)
 | P_tup of ('a pat) list (* tuple pattern *)
 | P_list of ('a pat) list (* list pattern *)

and 'a pat = 
   P_aux of 'a pat_aux * 'a annot

and 'a fpat_aux =  (* Field pattern *)
   FP_Fpat of id * 'a pat

and 'a fpat = 
   FP_aux of 'a fpat_aux * 'a annot


type 
typschm = 
   TypSchm_aux of typschm_aux * l


type 
'a letbind_aux =  (* Let binding *)
   LB_val_explicit of typschm * 'a pat * 'a exp (* value binding, explicit type ('a pat must be total) *)
 | LB_val_implicit of 'a pat * 'a exp (* value binding, implicit type ('a pat must be total) *)

and 'a letbind = 
   LB_aux of 'a letbind_aux * 'a annot

and 'a exp_aux =  (* Expression *)
   E_block of ('a exp) list (* block (parsing conflict with structs?) *)
 | E_id of id (* identifier *)
 | E_lit of lit (* literal constant *)
 | E_cast of typ * 'a exp (* cast *)
 | E_app of id * ('a exp) list (* function application *)
 | E_app_infix of 'a exp * id * 'a exp (* infix function application *)
 | E_tuple of ('a exp) list (* tuple *)
 | E_if of 'a exp * 'a exp * 'a exp (* conditional *)
 | E_for of id * 'a exp * 'a exp * 'a exp * 'a exp (* loop *)
 | E_vector of ('a exp) list (* vector (indexed from 0) *)
 | E_vector_indexed of ((int * 'a exp)) list (* vector (indexed consecutively) *)
 | E_vector_access of 'a exp * 'a exp (* vector access *)
 | E_vector_subrange of 'a exp * 'a exp * 'a exp (* subvector extraction *)
 | E_vector_update of 'a exp * 'a exp * 'a exp (* vector functional update *)
 | E_vector_update_subrange of 'a exp * 'a exp * 'a exp * 'a exp (* vector subrange update (with vector) *)
 | E_list of ('a exp) list (* list *)
 | E_cons of 'a exp * 'a exp (* cons *)
 | E_record of 'a fexps (* struct *)
 | E_record_update of 'a exp * 'a fexps (* functional update of struct *)
 | E_field of 'a exp * id (* field projection from struct *)
 | E_case of 'a exp * ('a pexp) list (* pattern matching *)
 | E_let of 'a letbind * 'a exp (* let expression *)
 | E_assign of 'a lexp * 'a exp (* imperative assignment *)

and 'a exp = 
   E_aux of 'a exp_aux * 'a annot

and 'a lexp_aux =  (* lvalue expression *)
   LEXP_id of id (* identifier *)
 | LEXP_memory of id * 'a exp (* memory write via function call *)
 | LEXP_vector of 'a lexp * 'a exp (* vector element *)
 | LEXP_vector_range of 'a lexp * 'a exp * 'a exp (* subvector *)
 | LEXP_field of 'a lexp * id (* struct field *)

and 'a lexp = 
   LEXP_aux of 'a lexp_aux * 'a annot

and 'a fexp_aux =  (* Field-expression *)
   FE_Fexp of id * 'a exp

and 'a fexp = 
   FE_aux of 'a fexp_aux * 'a annot

and 'a fexps_aux =  (* Field-expression list *)
   FES_Fexps of ('a fexp) list * bool

and 'a fexps = 
   FES_aux of 'a fexps_aux * 'a annot

and 'a pexp_aux =  (* Pattern match *)
   Pat_exp of 'a pat * 'a exp

and 'a pexp = 
   Pat_aux of 'a pexp_aux * 'a annot


type 
type_union_aux =  (* Type union constructors *)
   Tu_id of id
 | Tu_ty_id of typ * id


type 
naming_scheme_opt_aux =  (* Optional variable-naming-scheme specification for variables of defined type *)
   Name_sect_none
 | Name_sect_some of string


type 
'a funcl_aux =  (* Function clause *)
   FCL_Funcl of id * 'a pat * 'a exp


type 
rec_opt_aux =  (* Optional recursive annotation for functions *)
   Rec_nonrec (* non-recursive *)
 | Rec_rec (* recursive *)


type 
'a tannot_opt_aux =  (* Optional type annotation for functions *)
   Typ_annot_opt_some of typquant * typ


type 
'a effects_opt_aux =  (* Optional effect annotation for functions *)
   Effects_opt_pure (* sugar for empty effect set *)
 | Effects_opt_effects of effects


type 
index_range_aux =  (* index specification, for bitfields in register types *)
   BF_single of int (* single index *)
 | BF_range of int * int (* index range *)
 | BF_concat of index_range * index_range (* concatenation of index ranges *)

and index_range = 
   BF_aux of index_range_aux * l


type 
type_union = 
   Tu_aux of type_union_aux * l


type 
naming_scheme_opt = 
   Name_sect_aux of naming_scheme_opt_aux * l


type 
'a funcl = 
   FCL_aux of 'a funcl_aux * 'a annot


type 
rec_opt = 
   Rec_aux of rec_opt_aux * l


type 
'a tannot_opt = 
   Typ_annot_opt_aux of 'a tannot_opt_aux * 'a annot


type 
'a effects_opt = 
   Effects_opt_aux of 'a effects_opt_aux * 'a annot


type 
'a val_spec_aux =  (* Value type specification *)
   VS_val_spec of typschm * id
 | VS_extern_no_rename of typschm * id
 | VS_extern_spec of typschm * id * string (* Specify the type and id of a function from Lem, where the string must provide an explicit path to the required function but will not be checked *)


type 
'a type_def_aux =  (* Type definition body *)
   TD_abbrev of id * naming_scheme_opt * typschm (* type abbreviation *)
 | TD_record of id * naming_scheme_opt * typquant * ((typ * id)) list * bool (* struct type definition *)
 | TD_variant of id * naming_scheme_opt * typquant * (type_union) list * bool (* union type definition *)
 | TD_enum of id * naming_scheme_opt * (id) list * bool (* enumeration type definition *)
 | TD_register of id * nexp * nexp * ((index_range * id)) list (* register mutable bitfield type definition *)


type 
'a fundef_aux =  (* Function definition *)
   FD_function of rec_opt * 'a tannot_opt * 'a effects_opt * ('a funcl) list


type 
'a default_typing_spec_aux =  (* Default kinding or typing assumption *)
   DT_kind of base_kind * id
 | DT_typ of typschm * id


type 
'a val_spec = 
   VS_aux of 'a val_spec_aux * 'a annot


type 
'a type_def = 
   TD_aux of 'a type_def_aux * 'a annot


type 
'a fundef = 
   FD_aux of 'a fundef_aux * 'a annot


type 
'a default_typing_spec = 
   DT_aux of 'a default_typing_spec_aux * 'a annot


type 
'a def_aux =  (* Top-level definition *)
   DEF_type of 'a type_def (* type definition *)
 | DEF_fundef of 'a fundef (* function definition *)
 | DEF_val of 'a letbind (* value definition *)
 | DEF_spec of 'a val_spec (* top-level type constraint *)
 | DEF_default of 'a default_typing_spec (* default kind and type assumptions *)
 | DEF_reg_dec of typ * id (* register declaration *)
 | DEF_scattered_function of rec_opt * 'a tannot_opt * 'a effects_opt * id (* scattered function definition header *)
 | DEF_scattered_funcl of 'a funcl (* scattered function definition clause *)
 | DEF_scattered_variant of id * naming_scheme_opt * typquant (* scattered union definition header *)
 | DEF_scattered_unioncl of id * typ * id (* scattered union definition member *)
 | DEF_scattered_end of id (* scattered definition end *)


type 
'a typ_lib_aux =  (* library types and syntactic sugar for them *)
   Typ_lib_unit (* unit type with value $()$ *)
 | Typ_lib_bool (* booleans $_$ and $_$ *)
 | Typ_lib_bit (* pure bit values (not mutable bits) *)
 | Typ_lib_nat (* natural numbers 0,1,2,... *)
 | Typ_lib_string (* UTF8 strings *)
 | Typ_lib_enum of nexp * nexp * order (* natural numbers nexp .. nexp+nexp-1, ordered by order *)
 | Typ_lib_enum1 of nexp (* sugar for \texttt{enum nexp 0 inc} *)
 | Typ_lib_enum2 of nexp * nexp (* sugar for \texttt{enum (nexp'-nexp+1) nexp inc} or \texttt{enum (nexp-nexp'+1) nexp' dec} *)
 | Typ_lib_vector of nexp * nexp * order * typ (* vector of typ, indexed by natural range *)
 | Typ_lib_vector2 of typ * nexp (* sugar for vector indexed by [ nexp ] *)
 | Typ_lib_vector3 of typ * nexp * nexp (* sugar for vector indexed by [ nexp..nexp ] *)
 | Typ_lib_list of typ (* list of typ *)
 | Typ_lib_set of typ (* finite set of typ *)
 | Typ_lib_reg of typ (* mutable register components holding typ *)


type 
'a def = 
   DEF_aux of 'a def_aux * 'a annot


type 
'a typ_lib = 
   Typ_lib_aux of 'a typ_lib_aux * l


type 
'a defs =  (* Definition sequence *)
   Defs of ('a def) list



