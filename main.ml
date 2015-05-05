open Core.Std

let assemble_with_symbol symbol_table file_name =
  let parser = Parser.create file_name in
  let output_file_name = (Filename.chop_extension file_name) ^ ".hack" in
  Out_channel.with_file output_file_name ~f:(fun oc ->
      let rec assemble' () =
        let command = Parser.next_command parser in
        match command with
        | Some command' -> begin
            Out_channel.output_string oc
	      (Hack_command.code_to_string (Hack_command.to_code command'));
	    Out_channel.output_string oc "\n";
            assemble' ()
          end
        | None -> () in
      assemble' ()
    )

let create_symbol_table file_name =
  Symbol_table.create ()

let assemble file_name =
  let symbol_table = create_symbol_table file_name in
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
           printf "%s" message;
         end
    )         

let () =
  Command.run ~version:"1.0" ~build_info:"Satoshi Takei" command
    
