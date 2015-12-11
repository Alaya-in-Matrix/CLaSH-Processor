module Test where

import CLaSH.Prelude hiding(Word)
import qualified Data.List as L
import Debug.Trace

import Components.Types
import System
import TestCases

{------------------------------------
| Test esprockell
| not synthesizable
------------------------------------}


-- L.foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
-- replace :: (Enum i, KnownNat n) => i -> a -> Vec n a -> Vec n a
createIrom :: [Instruction] -> (PC -> Instruction)
createIrom prog = asyncRom $ createIrom' prog defaultImm
-- createIrom prog = createIrom' prog defaultImm
  where createIrom' p imm   = L.foldr pushIm imm $ L.zip [0..] p
        pushIm (idx, v) imm = replace idx v imm
        defaultImm          = repeat EndProg :: IRom


run :: [Instruction] -> Signal (Bool, Word)
run prog = let progRom = createIrom prog
            in sys progRom $ signal (False, 0)

fuck :: [Instruction] -> Int -> [(Bool, Word)]
fuck prog sampNum = processHead $ sampleN sampNum $ run prog
    where processHead []          = []
          processHead ((i, d):xs) = "\nCaution: First ramOut undefined\n" `trace` (i, maxBound):xs -- 第一个时钟周期的ramOut会是undefined

suck prog sampNum = mapM_ print $ takeUntil ((== True) . fst) $ fuck prog sampNum

takeUntil :: (a -> Bool) -> [a] -> [a]
takeUntil _ [] = []
takeUntil pred (x:xs) 
    | pred x = [x]
    | otherwise = x : takeUntil pred xs
