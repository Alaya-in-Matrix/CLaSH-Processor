module InstructionROM where

import CLaSH.Prelude hiding(Word)
import Components.Types

-- romContent :: IRom
-- romContent = repeat EndProg

instrRom :: IRom -> PC -> Instruction
instrRom prog = asyncRom prog 

-- topEntity :: PC -> Instruction
-- topEntity = instrRom $ repeat (Arith Incr zeroreg zeroreg oReg)
