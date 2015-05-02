open Core.Std

type t =
    A_OP of A_op.t
  | C_OP of C_op.t
    
let to_string t = match t with
  | A_OP _ -> "A_OP"
  | C_OP _ -> "C_OP"

let to_code t = match t with
  | A_OP op -> A_op.to_code op
  | C_OP op -> C_op.to_code op

(* TODO refactoring *)
let code_to_string code =
  let rec cons_bit code n chars =
    if n = 0 then chars
    else 
      let bit = if (code land 1) = 1 then '1' else '0' in
      cons_bit (code lsr 1) (n - 1) (bit :: chars) in
  let bit_length = 16 in
  let chars = cons_bit code bit_length [] in
  let buffer = List.fold chars ~init:(Buffer.create bit_length) ~f:(fun buf c ->
      (Buffer.add_char buf c; buf)) in
  Buffer.contents buffer
      
    
