open Core.Std

let assemble file_name =
  In_channel.with_file file_name ~binary:true ~f:(fun ic ->
      ())

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
    
