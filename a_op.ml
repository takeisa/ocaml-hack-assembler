type t =
  | Number of int
  | Symbol of string

let to_code t =
  match t with
  | Number value -> value
  | Symbol _ -> failwith "Not implement"
