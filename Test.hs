module Test where

import CLaSH.Prelude hiding(Word)
import Esprockell
import qualified Data.List as L

{------------------------------------
| Test esprockell
| not synthesizable
------------------------------------}


r7  = 7  :: RegIdx
r8  = 8  :: RegIdx
r9  = 9  :: RegIdx
r10 = 10 :: RegIdx
r11 = 11 :: RegIdx
r12 = 12 :: RegIdx
r13 = 13 :: RegIdx
r14 = 14 :: RegIdx
r15 = 15 :: RegIdx
r16 = 16 :: RegIdx

progAdd :: [ISA]
progAdd = [
    Load (RImm 3) r7 
  , Load (RImm 4) r8 
  , Arith Id r7 r8 r9
  , Debug (DebugReg r9 3)
  , EndProg
    ]

-- L.foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
-- replace :: (Enum i, KnownNat n) => i -> a -> Vec n a -> Vec n a
createImem :: [ISA] -> IMem
createImem prog = createImem' prog defaultImm
  where createImem' p imm   = L.foldr pushIm imm $ L.zip [0..] p
        pushIm (idx, v) imm = replace idx v imm
        defaultImm = repeat EndProg :: IMem

run :: [ISA] -> Signal (Maybe Word, Bool)
run prog = let imm = createImem prog
             in sprockell imm undefined
samp sampNum prog = mapM_ print $ sampleN sampNum $ run prog

