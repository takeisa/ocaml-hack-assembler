open Core.Std

let assemble file_name =
  let parser = Parser.create file_name in
  let command = Parser.next_command parser in
  match command with
  | Some command -> (printf "Command"; ())
  | None -> (printf "None\n"; ())                 

(* In_channel.with_file file_name ~binary:true ~f:(fun ic -> *)
  (*     let parser = Parser.create ic in *)
  (*     ()) *)

let spec =
  let open Command.Spec in
  empty
  +> anon ("file_name" %: string) 

let command =
  Command.basic
    ~summary:"Hack Assembler"
    ~readme:(fun () -> "More detailed information")
    spec
    (fun file_name () -> assemble file_name)

let () =
  Command.run ~version:"1.0" ~build_info:"Satoshi Takei" command
    
