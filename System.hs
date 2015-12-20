{-# language BinaryLiterals #-}
module System where

import CLaSH.Prelude hiding(Word)
import Components.Types
import Components.Esprockell hiding(topEntity)
import Components.DataRAM hiding(topEntity)

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


-- prog :: IRom
-- prog =  Arith Id iReg zeroreg oReg
--      :> Jump UR (-1)
--      :> (repeat EndProg)

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

trans :: Char -> Word
trans = fromIntegral . fromEnum

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



{-# ANN topEntity
  (defTop
    { t_name     = "Processor"
    , t_inputs   = ["iEn", "PIn"]
    , t_outputs  = ["oEn", "POut"]
    }) #-}

topEntity :: Signal (Bool, Word) -> Signal (Bool, Word)
topEntity = sys $ asyncRom helloWorld

testInput :: Signal (Bool, Word)
testInput = signal (True, 2)

ret = topEntity testInput  
