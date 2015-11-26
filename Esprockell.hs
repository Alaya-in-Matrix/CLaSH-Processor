{-# language RecordWildCards #-}
module Esprockell where

import CLaSH.Prelude hiding (Word)

{-------------------------------------------------------------
| Esprockell: Expanded Simple PROCessor in hasKELL 
-------------------------------------------------------------}

(!?) :: (Enum i, KnownNat n) => Vec n a -> i -> Maybe a
vec !? idx 
  | fromEnum idx < length vec = Just $ vec !! idx
  | otherwise                 = Nothing

type Word     = Signed 16

type RegSize  = 16
type IMemSize = 128
type DMemSize = 128

type Reg      = Vec RegSize  Word
type IMem     = Vec IMemSize ISA
type DMem     = Vec DMemSize Word

type RegIdx   = Unsigned 4
type IAddr    = Unsigned 7
type DAddr    = Unsigned 7

-- value in register
data RegVal = RAddr DAddr  | RImm Word deriving(Eq, Show)
-- value in data memory
data MemVal = MAddr RegIdx | MImm Word deriving(Eq, Show)

-- {-------------------------------------------------------------
-- | some constants
-- -------------------------------------------------------------}
zeroreg = 0 :: RegIdx
regA    = 1 :: RegIdx
regB    = 2 :: RegIdx
endreg  = 3 :: RegIdx  -- for FOR-loop
stepreg = 4 :: RegIdx  -- ibid
jmpreg  = 5 :: RegIdx  -- for jump instructions
pcreg   = 6 :: RegIdx  -- pc is added at the end of the regbank => regbank0
sp0     = 20 :: DAddr

(<~) :: Reg -> (RegIdx, Word) -> Reg
xs <~ (idx, val) = replace idx val xs

(<~~) :: DMem -> (Bool, DAddr, Word) -> DMem
mem <~~ (we, addr, val) = if we then replace addr val mem else mem

data LdCode  = NoLoad  | LdImm | LdAddr | LdAlu  deriving(Eq, Show)
data StCode  = NoStore | StImm | StReg           deriving(Eq, Show)
data SpCode  = None    | Up    | Down            deriving(Eq, Show)
data JmpCode = NoJump  -- No jump
             | UA      -- UnConditional Absolute
             | UR      -- UnConditional Relative
             | CA      -- Conditional   Absolute
             | CR      -- Conditional   Relative
             | Back    -- Back from subroutine
             deriving(Eq, Show)
data OpCode = NoOp | Id  | Incr | Decr
            | Neg  | Not
            | Add  | Sub | Mul  | Eq | Neq | Gt | Lt | And | Or
            deriving(Eq, Show)

data DebugCode = DebugReg RegIdx -- show value of reg regIdx
               | DebugMem DAddr  -- show data in memory whose address is addr
               | NoDebug
               deriving (Eq, Show)

-- Internal representation of instruction
data MachCode = MachCode {
    ldCode      :: LdCode
    , stCode    :: StCode   -- store code
    , spCode    :: SpCode   -- stack pointer code
    , opCode    :: OpCode   -- arithmetic code
    , dbCode    :: DebugCode
    , immvalueR :: Word     -- value from immediate to register
    , immvalueS :: Word     -- value from immediate to store
    , fromreg0  :: RegIdx   -- first oprand to compute
    , fromreg1  :: RegIdx   -- second oprand to compute
    , fromaddr  :: DAddr
    , toreg     :: RegIdx   
    , toaddr    :: DAddr
    , we        :: Bool     -- Write Enable
    , jmpCode   :: JmpCode  -- where to jump
    , jumpN     :: IAddr    -- where to fetch instruction
    } deriving(Eq, Show)

instance Default MachCode where
    def = MachCode { ldCode    = NoLoad
                   , stCode    = NoStore
                   , spCode    = None
                   , opCode    = NoOp
                   , dbCode    = NoDebug
                   , immvalueR = 0
                   , immvalueS = 0
                   , fromreg0  = 0
                   , fromreg1  = 0
                   , fromaddr  = 0
                   , toreg     = 0
                   , toaddr    = 0
                   , we        = False
                   , jmpCode   = NoJump
                   , jumpN     = 0
                   }

data ISA = Arith OpCode  RegIdx RegIdx RegIdx
         | Jump  JmpCode IAddr
         | Load  RegVal  RegIdx
         | Store MemVal  DAddr
         | Push  RegIdx -- what for ?
         | Pop   RegIdx -- what for ?
         | Debug DebugCode
         | EndProg
         deriving(Eq, Show)

prog :: [ISA]
prog = [ EndProg ]

-- move reg0 reg0 = Compute Id reg0 whatever reg1
-- nop = Jump UR 0

decode :: (IAddr, DAddr) -> ISA -> MachCode
decode (pc, sp) instr = case instr of
    Arith op r0 r1 r2  -> def {ldCode  = LdAlu,  opCode    = op,     fromreg0 = r0, fromreg1 = r1, toreg = r2}
    Jump  jc jn        -> def {jmpCode = jc,     fromreg0  = jmpreg, jumpN    = jn} -- how is jumpreg used?
    Load  (RImm  n) r  -> def {ldCode  = LdImm,  immvalueR = n,      toreg    = r}  -- load immediate number n to reg r
    Load  (RAddr a) r  -> def {ldCode  = LdAddr, fromaddr  = a,      toreg    = r}  -- load from memory locates at a to reg r,
    Store (MImm  n) a  -> def {stCode  = StImm,  immvalueS = n,      toaddr   = a, we = True}
    Store (MAddr i) j  -> def {stCode  = StReg,  fromreg0  = i,      toaddr   = j, we = True}
    Push r             -> def {stCode  = StReg,  fromreg0  = r,      toaddr   = sp + 1, spCode = Up, we = True}
    Pop r              -> def {ldCode  = LdAddr, fromaddr  = sp,     toreg    = r,  spCode = Down}
    Debug debugCode    -> def {dbCode  = debugCode}
    EndProg            -> def

alu :: OpCode -> (Word, Word) -> (Word, Bool)
alu opCode (x, y) = (z, cnd)
  where (z, cnd) = (app opCode x y, testBit z 0)
        app opCode x y = case opCode of
            Id -> x
            Incr -> x + 1
            Decr -> x - 1
            Neg  -> negate x
            Add  -> x + y
            Sub  -> x - y
            Mul  -> x * y
            Eq   -> if x == y then 1 else 0
            Neq  -> if x /= y then 1 else 0
            Gt   -> if x >  y then 1 else 0
            Lt   -> if x <  y then 1 else 0
            And  -> x .&. y
            Or   -> x .|. y
            Not  -> complement x
            NoOp -> 0

load :: Reg -> LdCode -> RegIdx -> (Word, Word, Word) -> Reg
load regs ldCode toReg (immV, memV, aluV) = regs <~ (toReg, v)
  where v = case ldCode of
              NoLoad -> 0 -- Why ? -- 是不是默认情况下，toReg是指向一个恒零寄存器？
              LdImm  -> immV
              LdAddr -> memV
              LdAlu  -> aluV

store :: DMem -> StCode -> (Bool, DAddr) -> (Word, Word) -> DMem
store dmem stCode (we, addr) (immV, regV) = dmem <~~ (we, addr, v)
  where v = case stCode of
              NoStore -> 0
              StImm   -> immV
              StReg   -> regV

updatePC :: (JmpCode, Bool) -> (IAddr, IAddr, Word) -> IAddr
updatePC (jmpCode, cnd) (pc, jumpN, jmpRegV) = pc'
  where pc' = case jmpCode of
                NoJump -> pc + 1
                UA     -> jumpN
                UR     -> pc + jumpN
                CA     -> if cnd then jumpN else pc + 1
                CR     -> if cnd then pc + jumpN else pc + 1
                Back   -> fromIntegral jmpRegV -- return value should has been written into jmpreg

updateSp :: SpCode -> DAddr -> DAddr
updateSp spCode sp = case spCode of
    Up   -> sp + 1
    Down -> sp - 1
    None -> sp


data PState = PState { reg  :: Reg
                     , dmem :: DMem
                     , cnd  :: Bool
                     , pc   :: IAddr
                     , sp   :: DAddr
                     } deriving (Eq, Show)

instance Default PState where
    def = PState { reg = repeat 0
                 , dmem = repeat 0
                 , cnd = False
                 , pc = 0
                 , sp = sp0 }

debug :: (DMem, Reg) -> DebugCode -> Maybe Word
debug (mem, regs) debugCode = case debugCode of
    NoDebug       -> Nothing
    DebugReg ridx -> regs !? ridx
    DebugMem addr -> mem  !? addr

sprockellMealy :: IMem -> PState -> Bit -> (PState, Maybe Word)
sprockellMealy prog state inp = (PState {dmem = dmem', reg = reg', cnd = cnd', pc = pc', sp = sp'}, outp)
   where
     PState{..}   = state
     MachCode{..} = decode (pc, sp) (prog !! pc)
     reg0         = replace pcreg (fromIntegral pc) reg
     (x, y)       = (reg0 !! fromreg0, reg0 !! fromreg1)
     mval         = dmem !! fromaddr
     (z, cnd')    = alu opCode (x, y)
     reg'         = load reg ldCode toreg (immvalueR, mval, z)
     dmem'        = store dmem stCode (we, toaddr) (immvalueS, x)
     pc'          = updatePC (jmpCode, cnd) (pc, jumpN, x)
     sp'          = updateSp spCode sp
     outp         = debug (dmem, reg) dbCode

sprockell imem = sprockellMealy imem `mealy` def
