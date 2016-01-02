{-# language BinaryLiterals #-}
module System where

import CLaSH.Prelude hiding(Word)
import Components.Types
import Components.Esprockell hiding(topEntity)
import Components.DataRAM hiding(topEntity)
import Debug.Trace

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

-- read input from general input
-- calc factorial number
-- output to general output
prog :: IRom
prog =  Arith Id iReg 0 r7
     :> Jump CR 2
     :> Jump UR (-2)
     :> Load (RImm 2)  r8  -- r8 := 2
     :> Arith Add pcreg r8 jmpreg -- jmpreg := pcreg + 2
     :> Jump UA facIterAddr   -- call facIter
     :> Arith Id r8 0 oReg
     :> Jump UA 0 -- infinite loop
     :> EndProg
     :> Load  (RImm 1) r8     -- r8 = 1
     :> Arith Eq       r7 zeroreg r9  
     :> Jump  CA       facIterRet 
     :> Arith Mul      r8 r7 r8
     :> Arith Decr     r7 r7 r7
     :> Jump  UR       (-4)
     :> Jump  Back     0 -- return
     :> (repeat EndProg)
     where facIterAddr = 9
           facIterRet  = 15


showFib :: IRom
showFib =  mainProg ++ fibCalc ++ outputVal ++ (repeat EndProg)
    where mainProg   =  Arith Id iReg 0 r7
                     :> Jump CR 2
                     :> Jump UR (-2)
                     :> Load (RImm 2) r8
                     :> Arith Add pcreg r8 jmpreg
                     :> Jump UA fibAddr
                     :> Arith Id iReg 0 0
                     :> Jump CR (-1) -- need to be changed to (-1)
                     :> Load (RImm 10) r9  -- constant 10
                     :> Load (RImm 0)  r10 -- counter
                     :> Arith Mod r7 r9 r11 -- 
                     :> Arith Div r7 r9 r7
                     :> Push  r11
                     :> Arith Incr r10 r10 r10
                     :> Arith Gt r7 zeroreg zeroreg
                     :> Jump CR (-5)
                     :> Pop r7
                     :> Load (RImm 2) r8
                     :> Arith Add pcreg r8 jmpreg
                     :> Jump UA outputAddr
                     :> Arith Decr r10 r10 r10
                     :> Arith Gt r10 zeroreg zeroreg
                     :> Jump CR (-6)
                     :> Jump UA 0
                     :> EndProg
                     :> Nil
          fibCalc    =  Push r8
                     :> Push r9
                     :> Push r10
                     :> Load (RImm 1) r8 -- r8 := 1
                     :> Load (RImm 0) r9 -- r9 := 0
                     :> Arith Eq r7 zeroreg r10 -- test
                     :> Jump  CR 6
                     :> Arith Decr r7 r7 r7 -- r7 -= 1
                     :> Arith Id  r8  zeroreg r10 -- r10 := r8
                     :> Arith Add r8  r9 r8      -- r8  := r8 + r9
                     :> Arith Id  r10 zeroreg r9 -- r9  := 10
                     :> Jump UR (-6) -- result is in r8
                     :> Arith Id r8 0 r7        -- result is in r7
                     :> Pop r10
                     :> Pop r9
                     :> Pop r8
                     :> Jump Back 0
                     :> Nil
          outputVal  =  Push r7
                     :> Push r9
                     :> Load (RImm 48) r9
                     :> Arith Add r7 r9 r7
                     :> Load (RImm 0b0000000011111111) r9 -- mask,  only the least 8 bit of data is valid
                     :> Arith And r7 r9 r7
                     :> Load (RImm 0b1111111111111111) oReg -- mask,  only the least 8 bit of data is valid
                     :> Load (RImm 0b1111111111111111) oReg -- mask,  only the least 8 bit of data is valid
                     :> Load (RImm 0b1111111111111111) oReg -- mask,  only the least 8 bit of data is valid
                     :> Load (RImm 0b1111111111111111) oReg -- mask,  only the least 8 bit of data is valid
                     :> Arith Id r7 0 oReg
                     :> Load (RImm 0b1111111111111111) oReg -- mask,  only the least 8 bit of data is valid
                     :> Load (RImm 0b1111111111111111) oReg -- mask,  only the least 8 bit of data is valid
                     :> Load (RImm 0b1111111111111111) oReg -- mask,  only the least 8 bit of data is valid
                     :> Load (RImm 0b1111111111111111) oReg -- mask,  only the least 8 bit of data is valid
                     :> Pop r9
                     :> Pop r7
                     :> Jump Back 0
                     :> Nil
          fibAddr    = fromIntegral $ length mainProg
          outputAddr = fibAddr + (fromIntegral $ length fibCalc)


helloWorld :: IRom
helloWorld =  Load (RImm 2) r8
           :> Load (RImm (trans 'H')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans 'e')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans 'l')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans 'l')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans 'o')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans ' ')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans 'W')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans 'o')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans 'r')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans 'l')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans 'd')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> Load (RImm (trans '\n')) r7
           :> Arith Add pcreg r8 jmpreg
           :> Jump UA putCharLabel
           :> EndProg
           :> Load (RImm 0b0000000011111111) r9 -- mask,  only the least 8 bit of data is valid
           :> Arith And r7 r9 r7
           :> Load (RImm 0b0000000000000000) r9 -- mask,  set address, write data
           :> Arith Or r7 r9 oReg
           :> Load (RImm 0b1111111111111111) r9 -- set address = 1, write control
           :> Arith Id r9 0  oReg
           :> Jump Back 0
           :> (repeat EndProg)
           where putCharLabel = 38
                 trans        = fromIntegral . fromEnum



{-# ANN topEntity
  (defTop
    { t_name     = "Processor"
    , t_inputs   = ["iEn", "PIn"]
    , t_outputs  = ["oEn", "POut"]
    }) #-}

topEntity :: Signal (Bool, Word) -> Signal (Bool, Word)
topEntity = sys $ asyncRom prog

testInput :: Signal (Bool, Word)
testInput = register start $ register start $ register start $ register start $ signal (False, 2)
    where start = (True, 4)

ret = topEntity testInput  

test n = mapM_ print $ filter fst $ sampleN n ret
