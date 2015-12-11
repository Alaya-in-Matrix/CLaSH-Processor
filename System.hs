module System where

import CLaSH.Prelude hiding(Word)
import Components.Types
import Components.Esprockell
import Components.DataRAM

sys :: (PC -> Instruction)  -- ROM
    -> Signal (Bool, Word)  -- general Input
    -> Signal (Bool, Word)  -- general Output   
sys prog gpInput = let (wAddr, rAddr, we, wData, pc', oEn, oData) = unbundle $ esprockell pIn
                       (iEn, iData) = unbundle gpInput
                       pIn          = bundle (romOut, ramOut, iEn, iData)
                       ramOut       = dataRam wAddr rAddr we wData
                       romOut       = prog <$> pc
                       pc           = register 0 pc'
                    in bundle (oEn, oData)
