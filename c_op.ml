type dest =
  | Null
  | M
  | D
  | MD
  | A
  | AM
  | AD
  | AMD

type comp =
  | C_0_0
  | C_0_1
  | C_0_Minus1
  | C_0_D
  | C_0_A
  | C_0_NotD
  | C_0_NotA
  | C_0_MinusD
  | C_0_MinusA
  | C_0_DPlus1
  | C_0_APlus1
  | C_0_DMinus1
  | C_0_AMinus1
  | C_0_DPlusA
  | C_0_DMinusA
  | C_0_AMinusD
  | C_0_DAndA
  | C_0_DOrA
  | C_1_M
  | C_1_NotM
  | C_1_MinusM
  | C_1_MPlus1
  | C_1_MMinus1
  | C_1_DPlusM
  | C_1_DMinusM
  | C_1_MMinusD
  | C_1_DAndM
  | C_1_DOrM

type jump =
  | Null
  | JGT
  | JEQ
  | JGE
  | JLT
  | JNE
  | JLE
  | JMP
  
type t =
  { dest : dest;
    comp : comp;
    jump : jump; }
