module DataRAM where

import CLaSH.Prelude hiding(Word)
import Types

dataRam = blockRam (repeat maxBound :: Mem)
