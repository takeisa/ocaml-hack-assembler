open Core.Std

type t = (string * int) list

let create () = []

let add t symbol_name address =
  List.Assoc.add t symbol_name address

let find t symbol_name =
  List.Assoc.find t symbol_name

let to_string t =
  List.to_string t ~f:(fun (symbol_name, address) ->
      Printf.sprintf "%s: %4x" symbol_name address)
