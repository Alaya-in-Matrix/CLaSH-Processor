module Components.DataRAM where

import CLaSH.Prelude hiding(Word)
import Components.Types

dataRam :: Signal DAddr 
        -> Signal DAddr 
        -> Signal Bool 
        -> Signal Word 
        -> Signal Word
dataRam = blockRam (repeat maxBound :: Mem)
