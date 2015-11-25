module Esprockell where

import CLaSH.Prelude hiding (Word)

type Word     = Signed 16

type RegSize  = 8
type IMemSize = 128
type DMemSize = 128

type Reg      = Vec RegSize  Word
type IMem     = Vec IMemSize Word
type DMem     = Vec DMemSize Word

type RegIdx   = Unsigned 3
type IAddr    = Unsigned 7
type DAddr    = Unsigned 7

-- value in register
data RegVal = RAddr DAddr  | RImm Word deriving(Eq, Show)
-- value in data memory
data MemVal = MAddr RegIdx | MImm Word deriving(Eq, Show)

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

-- Internal representation of instruction
data MachCode = MachCode {
    ldCode      :: LdCode
    , stCode    :: StCode   -- store code
    , spCode    :: SpCode   -- stack pointer code
    , opCode    :: OpCode   -- arithmetic code
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

data ISA = Arith OpCode  RegIdx RegIdx RegIdx
         | Jump  JmpCode IAddr
         | Load  RegVal  RegIdx
         | Store MemVal  DAddr
         | Push  RegIdx -- what for ?
         | Pop   RegIdx -- what for ?
         | EndProg
         | Debug Word

data PState = PState { reg  :: Reg
                     , dmem :: DMem
                     , cnd  :: Bool
                     , pc   :: IAddr
                     , sp   :: DAddr
                     } deriving (Eq, Show)

instance Default MachCode where
    def = MachCode { ldCode    = NoLoad
                   , stCode    = NoStore
                   , spCode    = None
                   , opCode    = NoOp
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
-- move reg0 reg0 = Compute Id reg0 whatever reg1
-- nop = Jump UR 0

-- {-------------------------------------------------------------
-- | some constants
-- -------------------------------------------------------------}
zeroreg =  0 :: RegIdx
regA    =  1 :: RegIdx
regB    =  2 :: RegIdx
endreg  =  3 :: RegIdx  -- for FOR-loop
stepreg =  4 :: RegIdx  -- ibid
jmpreg  =  5 :: RegIdx  -- for jump instructions
pcreg   =  7 :: RegIdx  -- pc is added at the end of the regbank => regbank0

(<~) :: Reg -> (RegIdx, Word) -> Reg
xs <~ (idx, val) = replace idx val xs

(<~~) :: DMem -> (Bool, DAddr, Word) -> DMem
mem <~~ (we, addr, val) = case we of
                             False -> mem
                             True  -> replace addr val mem

-- decode :: (IAddr, DAddr) -> ISA -> MachCode
-- decode (pc, sp) instr = case instr of
--     Arith op r0 r1 r2  -> def {ldCode  = LdAlu,  opCode    = op,     fromreg0 = r0, fromreg1 = r1, toreg = r2}
--     Jump  jc jn        -> def {jmpCode = jc,     fromreg0  = jmpreg, jumpN    = jn} -- how is jumpreg used?
--     Load  (RImm  n) r  -> def {ldCode  = LdImm,  immvalueR = n,      toreg    = r}  -- load immediate number n to reg r
--     Load  (RAddr a) r  -> def {ldCode  = LdAddr, fromaddr  = a,      toreg    = r}  -- load from memory locates at a to reg r, 
