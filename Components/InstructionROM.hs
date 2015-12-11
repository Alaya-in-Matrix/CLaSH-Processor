module InstructionROM where

import CLaSH.Prelude hiding(Word)
import Components.Types

-- romContent :: IRom
-- romContent = repeat EndProg

instrRom :: PC -> Instruction
instrRom = asyncRom 
