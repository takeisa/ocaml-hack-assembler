open Core.Std

type t

val create: unit -> t

val add: t -> string -> Address.t -> t

val find: t -> string -> Address.t option

val exists: t -> string -> bool

val defined_symbol_exists: t -> string -> bool

val to_list: t -> (string * Address.t) list

val of_list: (string * Address.t) list -> t

val to_string: t -> string
