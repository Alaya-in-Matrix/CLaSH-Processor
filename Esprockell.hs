{-# language RecordWildCards #-}
module Esprockell where

import CLaSH.Prelude hiding(Word)
import Debug.Trace
import qualified Data.List as L

type Word     = Signed 16 -- set data width to 16
type RegSize  = 32        -- we have 16 registers
type IMemSize = 128
type DMemSize = 128
type RegIdx   = Unsigned 5
type PC       = Signed 8 -- PC 可能会是负数，比如 Jump UR (-1)
type DAddr    = Unsigned 7

type Reg  = Vec RegSize  Word
type Mem  = Vec DMemSize Word
type IRom = Vec IMemSize Instruction

(+~+) = (L.++)



-- some special registers
-- the special usage of these registers is just "should-be"
-- user is still able to use these registers as normal registers, but that is highly unrecommended
zeroreg = 0  :: RegIdx -- constant zero
jmpreg  = 1  :: RegIdx -- store the return addess when calling a function, usally use "pcreg + 2"
pcreg   = 2  :: RegIdx -- store the current PC

sp0     = 20 :: DAddr -- stack pointer

regs <~ (idx, val) = replace idx val regs -- no bound-violation check

vec !? idx  | fromEnum idx < length vec = Just $ vec !! idx
            | otherwise                 = Nothing

data Instruction = Arith OpCode    RegIdx RegIdx RegIdx
                 | Jump  JmpCode   PC                 
                 | Load  LoadFrom  RegIdx
                 | Store StoreFrom DAddr
                 | Push  RegIdx
                 | Pop   RegIdx
                 | EndProg
                 deriving(Eq, Show)

data OpCode  = Nop | Id  | Incr | Decr 
             | Neg | Not
             | Add | Sub | Mul  | Eq | Ne | Lt | Gt | Le | Ge 
             | And | Or  | Xor
             deriving(Eq, Show)
data JmpCode = NoJmp -- No jump
             | UA    -- UnConditional Absolute jump
             | UR    -- UnConditional Relative jump
             | CA    -- Conditional   Absolute jump
             | CR    -- Conditional   Relative jump
             | Back  -- return from function
             deriving(Eq, Show)
-- where does the data to load into register come from, from memory or use immediate number
data LoadFrom = RAddr DAddr 
              | RImm Word
              deriving(Eq, Show)

-- where dose the data to store in memory come from, from register or use immediate number
data StoreFrom = MReg RegIdx
               | MImm Word
               deriving(Eq, Show)


data LdCode   = NoLoad  | LdImm | LdAddr | LdAlu  deriving(Eq, Show)
data StCode   = NoStore | StImm | StReg           deriving(Eq, Show)
data SpCode   = None    | Up    | Down            deriving(Eq, Show)
data MachCode = MachCode {
    ldCode     :: LdCode
    , stCode   :: StCode
    , opCode   :: OpCode
    , jmpCode  :: JmpCode
    , spCode   :: SpCode
    , ldImm    :: Word
    , stImm    :: Word
    , fromReg0 :: RegIdx -- oprand 0
    , fromReg1 :: RegIdx -- oprand 1
    , toReg    :: RegIdx -- write back register
    , toAddr   :: DAddr  -- write address
    , fromAddr :: DAddr  -- read address
    , we       :: Bool
    , jmpNum   :: PC
    } deriving(Eq, Show)

instance Default MachCode where
    def = MachCode { ldCode   = NoLoad
                   , stCode   = NoStore
                   , opCode   = Nop
                   , jmpCode  = NoJmp
                   , spCode   = None
                   , ldImm    = 0
                   , stImm    = 0
                   , fromReg0 = zeroreg
                   , fromReg1 = zeroreg
                   , toReg    = zeroreg
                   , toAddr   = 0
                   , fromAddr = 0
                   , we       = False
                   , jmpNum  = 0
                   }

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

type PIn       = (Instruction, Word) -- instruction and data from memory
type POut      = (DAddr, DAddr, Bool, Word, PC) -- write addr, read addr, write enable, data out, PC
type LoadDelay = 2
data PState = PState { reg   :: Reg
                     , cnd   :: Bool
                     , pc    :: PC
                     , sp    :: DAddr
                     , ldBuf :: Vec LoadDelay RegIdx
                     } deriving(Eq, Show)

instance Default PState where
    def = PState { reg   = repeat 0
                 , cnd   = False
                 , pc    = 0
                 , ldBuf = repeat 0
                 , sp    = sp0 }

traceEspro i s s' o = show i +~+ "\n" +~+ show s +~+ "\n" +~+ show s' +~+ "\n" +~+ show o +~+ "\n"
esprockellMealy :: PState -> PIn -> (PState, POut)
esprockellMealy state (instr, memData) = traceEspro instr state state' out `trace` (state', out)
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
        reg'   = reg0 <~ (zeroreg, 0) <~ (pcreg, fromIntegral pc)
        toMem  = store stCode (stImm, x)
        pc'    = updatePC (jmpCode, cnd') (pc, jmpNum, reg' !! jmpreg)
        sp'    = updateSp spCode sp

esprockell :: Signal (Instruction, Word) 
           -> Signal (DAddr, DAddr, Bool, Word, PC)
esprockell = esprockellMealy `mealy` def


sys :: IRom
    -> Signal (Instruction, Word)
sys prog = let (wAddr, rAddr, we, wData, pc) = unbundle $ esprockell pIn
               pIn                           = register (nop, 0) $ bundle (romOut, ramOut)
               ramOut                        = dataRam wAddr rAddr we wData
               romOut                        = (prog !!) <$> (pc-1) 
               nop                           = Arith Nop 0 0 0
               dataRam = blockRam (repeat maxBound :: Mem)
            in bundle (romOut, ramOut) -- instruction, data write to mem, data read from mem
