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
  , Debug (DebugReg r7 3)
  , Debug (DebugReg r8 4)
  , Arith Add r7 r8 r9
  , Debug (DebugReg r9 7)
  , EndProg
    ]

progStack :: [ISA]
progStack = [
    Load (RImm 3) r7
    , Push r7
    , Arith Incr r7 r7 r7
    , Push r7
    , Debug (DebugMem (sp0+1) 3)
    , Debug (DebugMem (sp0+2) 4)
    , Pop r8
    , Debug (DebugReg r8 4)
    , Pop r8
    , Debug (DebugReg r8 3)
    , EndProg
    ]

progMov :: [ISA]
progMov = [
    Load (RImm 3) r7 
    , Arith Id r7 zeroreg r8
    , Debug (DebugReg r8 3)
    , EndProg
    ]

progJump :: [ISA]
progJump = [
    Load (RImm 1) r7
    , Load (RImm 2) r8
    , Load (RImm 2) r9
    , Arith Add pcreg r9 jmpreg
    , Jump UR 3
    , Debug (DebugReg r9 3)
    , EndProg

    , Arith Add r7 r8 r9
    , Debug (DebugReg jmpreg 5)
    , Jump Back undefined
    ]

progMax :: [ISA]
progMax = [
    Store (MImm 3) 0
    , Store (MImm 4) 1
    , Load  (RAddr 0) r7
    , Load  (RAddr 1) r8
    , Load  (RImm  2) r9 -- inc to pc
    , Arith Add pcreg r9 jmpreg
    , Jump  UR 3
    , Debug (DebugReg r8 4)
    , EndProg
    , Arith Lt r7 r8 r9
    , Jump  CR 2
    , Arith Id r7 r8 r8 -- move r7 to r8
    , Jump  Back 0
    ] 

-- progFib :: [ISA]
-- progFib = [
--     Load (RImm 0) r7 -- calc fib(3)
--     , Arith Id pcreg zeroreg jmpreg
--     , Jump UR 3
--     , Debug (DebugReg r8 1)
--     , EndProg
--     , Load (RImm 2) r8
--     , Arith Lt r7 r8 r8
--     , Jump CR 9 -- back
--     , Push jmpreg
--     , Arith Decr r7 r7 r7
--     , Jump UR (-5) -- call fib(n-1)
--     , Arith Id r8 zeroreg r9
--     , Arith Decr r7 r7 r7
--     , Jump UR (-8) -- call fib(n-2)
--     , Arith Add r8 r9 r8
--     , Pop jmpreg
--     , Jump Back 0
--     ]
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

fuck prog sampNum = sampleN sampNum $ run prog

suck prog sampNum = (mapM_ print) $ fuck prog sampNum
duck prog sampNum = mapM_ print $ filter ((/= Nothing).fst) $ fuck prog sampNum
