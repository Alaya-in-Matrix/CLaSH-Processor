module TestCases where

import Esprockell
import CLaSH.Prelude
import qualified Data.List as L


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

progAdd :: [Instruction]
progAdd = [
  Load (RImm 3) r7 
  , Load (RImm 9) r8 
  , Arith Add r7 r8 r9
  , Store (MReg r9) 0
  , EndProg
    ]

-- 为何store后不能马上load?
progLdSt :: [Instruction]
progLdSt = [
    Store (MImm 13) 0
    , Load (RAddr 0) r9
    , Load (RImm 3) r7
    , Load (RImm 4) r8
    , Arith Add r7 r8 r8
    , Arith Add r8 r9 r9 -- r9 == 20
    , Push r9
    , EndProg
    ]
progLdSt2 :: [Instruction]
progLdSt2 = [
    Store (MImm 13) 0
    , Store (MImm 14) 1
    , Load (RAddr 0) r7
    , Load (RAddr 1) r8
    , Load (RImm  3) r9 
    , Arith Add r7 r9 r9 -- r7 is ready, r8 is not ready
    , Arith Add r8 r9 r8 -- r8 is ready
    , Push r8            -- shoule write 30 to memory
    , EndProg
    ]

progStack :: [Instruction]
progStack = [
    Load (RImm 3) r7
    , Push r7
    , Arith Incr r7 r7 r7
    , Push r7

    , Pop r8 -- r8 == 4
    , Pop r9 -- r9 == 3
    , Arith Nop 0 0 0
    , Arith Add r7 r8 r8 -- r8 == 8, r8 is ready, r9 is not ready
    , Arith Add r8 r9 r9 -- r9 == 8 + 3 == 11
    , Push r9
    , EndProg
    ]

progMov :: [Instruction]
progMov = [
    Load (RImm 3) r7 
    , Arith Id r7 zeroreg r8
    , Push r8
    , Pop r9
    , Arith Nop 0 0 0
    , EndProg
    ]

-- progJump :: [ISA]
-- progJump = [
--     Load (RImm 1) r7
--     , Load (RImm 2) r8
--     , Load (RImm 2) r9
--     , Arith Add pcreg r9 jmpreg
--     , Jump UR 3
--     , Debug (DebugReg r9 3)
--     , EndProg

--     , Arith Add r7 r8 r9
--     , Debug (DebugReg jmpreg 5)
--     , Jump Back undefined
--     ]

-- progMax :: [ISA]
-- progMax = [
--     Store (MImm 3) 0
--     , Store (MImm 4) 1
--     , Load  (RAddr 0) r7
--     , Load  (RAddr 1) r8
--     , Load  (RImm  2) r9 -- inc to pc
--     , Arith Add pcreg r9 jmpreg
--     , Jump  UR 3
--     , Debug (DebugReg r8 4)
--     , EndProg
--     , Arith Lt r7 r8 r9
--     , Jump  CR 2
--     , Arith Id r7 r8 r8 -- move r7 to r8
--     , Jump  Back 0
--     ] 

-- -- define recursive fib function
-- progFibRecr :: [ISA]
-- progFibRecr = [
--     Store (MImm 7) 0
--     , Load  (RAddr 0) r7
--     , Load  (RImm 2) r8
--     , Arith Add pcreg r8 jmpreg
--     , Jump  UA fibAbsAddr
--     , Debug (DebugReg r8 21)
--     , EndProg

--     , Load (RImm 2) r8
--     , Arith Lt r7 r8 r8    -- whether input < 2
--     , Jump CA recursionOut -- Conditional Absolute jump

--     , Push jmpreg   -- fib (n-1)
--     , Push r7
--     , Arith Decr r7 zeroreg r7 -- r7 - 1
--     , Load (RImm 2) r8
--     , Arith Add pcreg r8 jmpreg
--     , Jump UA fibAbsAddr
--     , Pop r7
--     , Pop jmpreg
--     , Arith Id r8 zeroreg r9 -- move r8 to r9
--     , Push jmpreg -- fib (n-2)
--     , Push r7
--     , Push r9
--     , Load (RImm 2) r8
--     , Arith Sub r7 r8 r7 -- r7 - 2
--     , Arith Add pcreg r8 jmpreg
--     , Jump UA fibAbsAddr    -- unconditional Absolute jump
--     , Pop r9
--     , Pop r7
--     , Pop jmpreg

--     , Arith Add r8 r9 r8 -- fib (n-1） + fib (n-2)
--     , Jump UR 2         -- unconditional relative jump
--     , Load (RImm 1) r8  -- recursionOut fib 0 or fib 1
--     , Jump Back 0
--     ] 
--     where (fibAbsAddr, recursionOut) = (7, fromIntegral $ L.length progFibRecr - 2)

-- progFibIter = [
--     Store (MImm 7) 0 -- mem[0] := 7

--     , Load (RAddr 0) r7 -- r7 := mem[0]
--     , Load (RImm 2)  r8 -- r8 := 2
--     , Arith Add pcreg r8 jmpreg -- jmpreg := pcreg + r8
--     , Jump UA fibIterAddr -- call fibIter
--     , Debug (DebugReg r8 21) -- print result
--     , EndProg

--     , Load (RImm 1) r8 -- r8 := 1
--     , Load (RImm 0) r9 -- r9 := 1
--     , Arith Eq r7 zeroreg r10 -- test
--     , Jump CA fibIterRet
--     , Arith Decr r7 r7 r7 -- r7 -= 1
--     , Arith Id r8 zeroreg r10 -- r10 := r8
--     , Arith Add r8 r9 r8      -- r8  := r8 + r9
--     , Arith Id r10 zeroreg r9 -- r9  := 10
--     , Jump UR fibIterTestZero

--     , Jump Back 0
--     ] 
--     where fibIterAddr     = 7
--           fibIterRet      = fromIntegral $ L.length progFibIter - 1
--           fibIterTestZero = (-6)

-- progFacIter = [
--     Store (MImm 6) 0    -- mem[0] := 8
    
--     , Load (RAddr 0) r7  -- r7 := mem[0]
--     , Load (RImm 2)  r8  -- r8 := 2
--     , Arith Add pcreg r8 jmpreg -- jmpreg := pcreg + 2
--     , Jump UA facIterAddr   -- call facIter
--     , Debug (DebugReg r8 720) -- assert(facIter 7 == 5040)
--     , EndProg
    
--     , Load  (RImm 1) r8     -- r8 = 1
--     , Arith Eq       r7 zeroreg r9  
--     , Jump  CA       facIterRet 
--     , Arith Mul      r8 r7 r8
--     , Arith Decr     r7 r7 r7
--     , Jump  UR       (-4)
--     , Jump  Back     0 -- return
--     ]
--     where facIterRet  = fromIntegral $ L.length progFacIter - 1
--           facIterAddr = 7

-- progFacRecr = [
--     Store (MImm input) 0
--     , Load  (RAddr 0) r7
--     , Load  (RImm  2) r8
--     , Arith Add       pcreg r8 jmpreg
--     , Jump  UA        facRecrAddr
--     , Debug (DebugReg r8 validation)
--     , EndProg

--     , Arith Eq r7 zeroreg r8
--     , Jump CA facRecrRet

--     , Push jmpreg
--     , Push r7
--     , Load (RImm 2) r8
--     , Arith Decr r7 r7 r7
--     , Arith Add pcreg r8 jmpreg
--     , Jump UA facRecrAddr
--     , Pop  r7
--     , Pop  jmpreg
--     , Arith Mul r7 r8 r8

--     , Jump Back 0
--     ]
--     where facRecrAddr = 7
--           facRecrRet  = fromIntegral $ L.length progFacRecr - 1
--           input       = 7
--           validation  = product [1..input]
