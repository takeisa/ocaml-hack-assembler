open Core.Std

type t

val create: unit -> t

val add: t -> string -> int -> t

val find: t -> string -> int option

val to_string: t -> string
