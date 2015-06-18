open Core.Std

type t

val create: unit -> t

val add: t -> string -> Address.t -> t

val find: t -> string -> Address.t option

val exists: t -> string -> bool

val defined_symbol_exists: t -> string -> bool

val to_array: t -> (string * Address.t) list

val to_string: t -> string
