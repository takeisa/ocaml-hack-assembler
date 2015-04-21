open Core.Std

let spec =
  let open Command.Spec in
  empty
  +> anon ("filename" %: string) 

let command =
  Command.basic
    ~summary:"Hack Assembler"
    ~readme:(fun () -> "More detailed information")
    spec
    (fun filename () -> print_endline filename)

let () =
  Command.run ~version:"1.0" ~build_info:"Satoshi Takei" command
    
