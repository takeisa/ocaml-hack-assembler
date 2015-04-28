open Core.Std

type t =
  { file_name       : string;
    in_channel      : In_channel.t;
    mutable line_no : int }

let create file_name =
  let in_channel = In_channel.create ~binary:true file_name in
  let line_no = 0 in
  {file_name; in_channel; line_no}

  
let is_ignore_line line =
  let open Re2.Regex in
  let ignore_re = create_exn "^\\s*(?://.*)$" in
  matches ignore_re line

let parse line =
  Hack_command.A_OP

let rec read_command_line t =
  let line = In_channel.input_line t.in_channel in
  t.line_no <- t.line_no + 1;
  match line with
  | Some line -> begin
      if is_ignore_line line then
        (printf "ignore : %s\n" line;
         read_command_line t)
      else
        (printf "command: %s\n" line;
         Some line)
    end
  | None -> None

let next_command t =
  let line = read_command_line t in
  match line with
  | Some line -> Some (parse line)
  | None -> None
  
