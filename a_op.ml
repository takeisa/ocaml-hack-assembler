type t =
  | Number of int
  | Symbol of string

let to_code t table =
  match t with
  | Number value -> value
  | Symbol symbol_name ->
    let addr = Symbol_table.find table symbol_name in
    match addr with
    | Some addr' -> addr'
    | None -> failwith (Printf.sprintf "Symbol(%s) undefined" symbol_name)
