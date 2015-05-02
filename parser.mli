type t

val line_no: t -> int

exception Parse_error of t * string

val create: string -> t

val next_command: t -> Hack_command.t option
  
