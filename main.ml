open Core.Std

let range i j =
  let rec range' i j acc =
    if i > j then acc
    else range' i (j - 1) (j :: acc) in
  range' i (j - 1) []

let reserved_symbols =
  let reserved_register_symbols =
    List.map (range 0 16)
      ~f:(fun n -> ((Printf.sprintf "R%02d" n), n)) in
  [("SP",   0x0000);
   ("LCL",  0x0001);
   ("ARG",  0x0002);
   ("THIS", 0x0003);
   ("THAT", 0x0004)]
  @ reserved_register_symbols (* R0-R15 *)
  @ [("SCREEN", 0x4000);
     ("KBD",    0x6000)]

let create_symbol_table file_name =
  let table = 
    List.fold reserved_symbols
      ~init:(Symbol_table.create ())
      ~f:(fun table (symbol_name, address) ->
          Symbol_table.add table symbol_name address) in
  let parser = Parser.create file_name in
  let rec assemble' table address =
    let command = Parser.next_command parser in
    match command with
    | Some command' -> begin
        match command' with
        | Hack_command.A_OP a_op -> begin
            match a_op with
            | A_op.Symbol symbol_name -> begin
                assemble'
                  (Symbol_table.add table symbol_name address)
                  (address + 1)
              end
            | A_op.Number _ -> assemble' table (address + 1)
          end
        | _ -> assemble' table (address + 1)
      end
    | None -> table in
  assemble' table 0

let assemble_with_symbol symbol_table file_name =
  let parser = Parser.create file_name in
  let output_file_name = (Filename.chop_extension file_name) ^ ".hack" in
  Out_channel.with_file output_file_name ~f:(fun oc ->
      let rec assemble' () =
        let command = Parser.next_command parser in
        match command with
        | Some command' -> begin
            Out_channel.output_string oc
	      (Hack_command.code_to_string (Hack_command.to_code command' symbol_table));
	    Out_channel.output_string oc "\n";
            assemble' ()
          end
        | None -> () in
      assemble' ()
    )

let assemble file_name =
  let symbol_table = create_symbol_table file_name in
  printf "symbol_table=%s\n" (Symbol_table.to_string symbol_table);
  assemble_with_symbol symbol_table file_name

let spec =
  let open Command.Spec in
  empty
  +> anon ("file_name" %: string) 

let command =
  Command.basic
    ~summary:"Hack Assembler"
    ~readme:(fun () -> "More detailed information")
    spec
    (fun file_name () ->
       try assemble file_name with
       | Parser.Parse_error (parser, message) -> begin
           printf "File %s, line %d:\n" file_name (Parser.line_no parser);
           printf "%s\n" message;
         end
    )         

let () =
  Command.run ~version:"1.0" ~build_info:"Satoshi Takei" command
    
