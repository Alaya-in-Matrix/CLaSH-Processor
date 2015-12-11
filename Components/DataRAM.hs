module Components.DataRAM where

import CLaSH.Prelude hiding(Word)
import Components.Types

dataRam = blockRam (repeat maxBound :: Mem)
