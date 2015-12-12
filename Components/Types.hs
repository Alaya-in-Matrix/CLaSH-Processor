module Components.Types where 

import CLaSH.Prelude hiding(Word)

type Word     = Signed 16 -- set data width to 16
type RegSize  = 32        -- we have 32 registers
type IMemSize = 128
type DMemSize = 128
type RegIdx   = Unsigned 5
type PC       = Signed 8 -- PC 可能会是负数，比如 Jump UR (-1)
type DAddr    = Unsigned 7
type Reg      = Vec RegSize  Word
type Mem      = Vec DMemSize Word
type IRom     = Vec IMemSize Instruction

data Instruction = Arith OpCode    RegIdx RegIdx RegIdx
                 | Jump  JmpCode   PC                 
                 | Load  LoadFrom  RegIdx
                 | Store StoreFrom DAddr
                 | Push  RegIdx
                 | Pop   RegIdx
                 | EndProg
                 deriving(Eq, Show)
data OpCode    = Nop   | Id | Incr | Decr | Neg | Not | Add | Sub | Mul  | Eq | Ne | Lt | Gt | Le | Ge | And | Or  | Xor deriving(Eq, Show)
data JmpCode   = NoJmp | UA | UR   | CA   | CR  | Back  deriving(Eq, Show)
data LoadFrom  = RAddr DAddr | RImm Word deriving(Eq, Show)
data StoreFrom = MReg RegIdx | MImm Word deriving(Eq, Show)
data LdCode    = NoLoad  | LdImm | LdAddr | LdAlu  deriving(Eq, Show)
data StCode    = NoStore | StImm | StReg           deriving(Eq, Show)
data SpCode    = None    | Up    | Down            deriving(Eq, Show)

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
                   , jmpNum   = 0
                   }

type PIn       = (Instruction, Word, Bool, Word) -- (instr, memData, gpInEn, gpInData)
type POut      = (DAddr, DAddr, Bool, Word, PC, Bool, Word) -- (wAddr, rAddr, wEn, wData, PC, gpOutEn, gpOutData)
type LoadDelay = 1
data PState    = PState { reg :: Reg, cnd :: Bool, pc :: PC, sp :: DAddr, ldBuf :: Vec LoadDelay RegIdx } deriving(Eq, Show)
instance Default PState where
    def = PState { reg = repeat 0, cnd = False, pc  = 0, ldBuf = repeat 0, sp    = sp0 }


-- some special registers
-- the special usage of these registers is just "should-be"
-- user is still able to use these registers as normal registers, but that is highly unrecommended
zeroreg = 0  :: RegIdx -- constant zero
jmpreg  = 1  :: RegIdx -- store the return addess when calling a function, usally use "pcreg + 2"
pcreg   = 2  :: RegIdx -- store the current PC
iReg    = 3  :: RegIdx -- for general input
oReg    = 4  :: RegIdx -- for general output
iEn     = 5  :: RegIdx -- whether the gpInput is valid
sp0     = 20 :: DAddr -- stack pointer
regs <~ (idx, val) = replace idx val regs -- no bound-violation check


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
