{-# language RecordWildCards #-}
module Components.Esprockell where

{-------------------------
| TODO: 
| add error status
| store address in register such pointer could be implemented
-------------------------}
import CLaSH.Prelude hiding(Word)
import Components.Types



decode :: DAddr         -- ^ stack pointer
       -> Instruction   -- ^ current instruction
       -> MachCode      -- ^ target machine code
decode sp instr = case instr of
    Arith op r0 r1 r2  -> def {ldCode = LdAlu, opCode = op, fromReg0 = r0, fromReg1 = r1, toReg = r2}
    Jump  jType jAddr  -> def {jmpCode = jType, jmpNum = jAddr}
    Load (RImm n) rid  -> def {ldCode = LdImm, ldImm = n, toReg = rid}
    Load (RAddr a) rid -> def {ldCode = LdAddr, fromAddr = a, toReg = rid}
    Store (MImm n) a   -> def {stCode = StImm, stImm = n, toAddr = a, we = True}
    Store (MReg r) a   -> def {stCode = StReg, fromReg0 = r, toAddr = a, we = True}
    Push r             -> def {stCode = StReg, fromReg0 = r, toAddr = sp + 1, spCode = Up, we = True}
    Pop r              -> def {ldCode = LdAddr, fromAddr = sp, toReg = r, spCode = Down}
    EndProg            -> def {jmpCode = UR, jmpNum = 0} -- forever loop here


alu :: OpCode       -- operator
    -> (Word, Word) -- to operands
    -> (Word, Bool) -- result and Conditional test resutl
alu op (x, y) =  (opRet, cnd)
    where (opRet, cnd) = (app op x y, testBit opRet 0)
          app op x y   = case op of
            Nop  -> 0 -- 此时，toreg应该是zeroreg
            Id   -> x
            Incr -> x + 1
            Decr -> x - 1
            Neg  -> negate x
            Not  -> complement x
            Add  -> x + y
            Sub  -> x - y
            Mul  -> x * y
            Eq   -> if x == y then 1 else 0
            Ne   -> if x /= y then 1 else 0
            Gt   -> if x > y  then 1 else 0
            Lt   -> if x < y  then 1 else 0
            Le   -> if x <= y then 1 else 0
            Ge   -> if x >= y then 1 else 0
            And  -> x .&. y 
            Or   -> x .|. y
            Xor  -> x `xor` y

load :: LdCode 
     -> RegIdx 
     -> (Word, Word)  -- (immediate-number, aluOut)
     -> Reg
     -> Reg
load ldCode toReg (imm, aluOut) regs = regs <~ (toReg, v)
    where v = case ldCode of
                NoLoad -> 0
                LdImm  -> imm
                LdAlu  -> aluOut 
                LdAddr -> regs !! toReg -- memory-load is delayed


store :: StCode 
      -> (Word, Word) -- (immediate-number, reg-number)
      -> Word
store stCode (imm, regData) = case stCode of
                                NoStore -> 0    -- 此时, we == False
                                StImm   -> imm
                                StReg   -> regData

updatePC :: (JmpCode, Bool) -- (jump code, cnd)
         -> (PC, PC, Word)  -- (current-pc, jump-addr, jmpreg)
         -> PC
updatePC (jmpCode, cnd) (pc, jmpNum, jumpRegV) = case jmpCode of
   NoJmp -> pc + 1
   UA    -> jmpNum
   UR    -> pc + jmpNum
   CA    -> if cnd then jmpNum else pc + 1
   CR    -> if cnd then pc + jmpNum else pc + 1
   Back  -> fromIntegral jumpRegV

updateSp :: SpCode -> DAddr -> DAddr
updateSp None sp = sp
updateSp Up   sp = sp + 1
updateSp Down sp = sp - 1


esprockellMealy :: PState -> PIn -> (PState, POut)
esprockellMealy state (instr, memData) = (state', out)
    where 
        MachCode{..}   = decode sp instr
        PState{..}     = state
        (aluOut, cnd') = alu opCode (x, y)
        state' = PState { reg = reg', cnd = cnd', pc = pc', sp = sp', ldBuf = ldBuf'}
        out    = (toAddr, fromAddr, we, toMem, pc')
        (x, y) = (reg !! fromReg0, reg !! fromReg1)
        ldBuf' = ldReg +>> ldBuf
        ldReg 
          | ldCode == LdAddr = toReg
          | otherwise        = 0
        reg0   = load ldCode toReg (ldImm, aluOut) $ reg <~ (last ldBuf, memData)
        reg'   = reg0 <~ (zeroreg, 0) <~ (pcreg, fromIntegral pc')
        toMem  = store stCode (stImm, x)
        pc'    = updatePC (jmpCode, cnd) (pc, jmpNum, reg' !! jmpreg)
        sp'    = updateSp spCode sp

esprockell :: Signal (Instruction, Word) 
           -> Signal (DAddr, DAddr, Bool, Word, PC)
esprockell = esprockellMealy `mealy` def


-- sys :: IRom
--     -> Signal (Instruction, Word)
-- sys prog = let (wAddr, rAddr, we, wData, pc') = unbundle $ esprockell pIn
--                pIn                            = bundle (romOut, ramOut)
--                ramOut                         = dataRam wAddr rAddr we wData
--                romOut                         = (prog !!) <$> pc
--                pc                             = register 0 $ pc'
--                nop                            = Arith Nop 0 0 0
--                dataRam                        = blockRam (repeat maxBound :: Mem)
--             in bundle (romOut, ramOut) -- instruction, data write to mem, data read from mem

-- topEntity = sys
