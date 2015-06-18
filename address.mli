type t =
  | Undefined
  | Address of int

val to_string: t -> string
