module InstructionROM where

import CLaSH.Prelude hiding(Word)
import Components.Types

-- romContent :: IRom
-- romContent = repeat EndProg

-- instrRom :: (Enum addr) => addr -> Instruction
instrRom = asyncRom 
