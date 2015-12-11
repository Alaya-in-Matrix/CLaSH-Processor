module System where

import CLaSH.Prelude hiding(Word)
import Types
import Esprockell
import DataRAM

sys :: (PC -> Instruction) -> Signal (Instruction, Word)
sys prog = let (wAddr, rAddr, we, wData, pc') = unbundle $ esprockell pIn
               pIn    = bundle (romOut, ramOut)
               ramOut = dataRam wAddr rAddr we wData
               romOut = prog <$> pc
               pc     = register 0 $ pc'
            in bundle (romOut, ramOut)
