type t

val create: string -> t

val next_command: t -> Hack_command.t option
  
