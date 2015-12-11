module System where

import CLaSH.Prelude hiding(Word)
import Components.Types
import Components.Esprockell
import Components.DataRAM

sys :: (PC -> Instruction)  -- ROM
    -> Signal Word          -- general Input
    -> Signal (Instruction, Word)
sys prog gpInput = let (wAddr, rAddr, we, wData, pc', gpOut) = unbundle $ esprockell pIn
                       pIn    = bundle (romOut, ramOut, gpInput)
                       ramOut = dataRam wAddr rAddr we wData
                       romOut = prog <$> pc
                       pc     = register 0 $ pc'
                    in bundle (romOut, gpOut)
