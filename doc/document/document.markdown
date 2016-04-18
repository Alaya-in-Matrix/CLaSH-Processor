# Processor 设计文档

* Author：lvwenlong_lambda@qq.com
* Last Modified:2015年12月31日 星期四 22时46分08秒 四

[TOC]


# 小组成员与任务分配

* 吕文龙(14210720082)：Processor Haskell代码的编写，以及与JTAG UART的接口模块
* 曲狄(15110720034): Haskell编译后生成的verilog代码的modelsim仿真以及FPGA测试

# 设计简介

本次设计, 基于[CLaSH][clash-homepage]实现了一个简单的Processor, 自定义了Processor的指令集，指令集支持Load、Store、基本算数、逻辑操作以及各种指令跳转(包括条件与无条件跳转，绝对路径以及相对路径跳转)。 

使用CLaSH库写成的Haskell代码，可以被编译为可综合的verilog、VHDL、systemverilog代码，在本次设计中，代码被编译为verilog代码后使用Quartus综合。

汇编语言直接嵌入在Haskell中，作为一门[EDSL][EDSL](Embeded Domain Specific Language)使用，即是说，一段汇编代码，其实是一个Haskell中元素类型为`Instruction`的向量。例如，下面是一段无限循环从通用输入获取数据，计算阶乘并输出到通用输出的汇编代码：
``` haskell
prog :: IRom -- type
prog =  Arith Id iReg 0 r7 -- detect where input is valid
     :> Jump CR 2          -- condition jump, if input is valid, jump to calc 
     :> Jump UR (-2)       -- relative jump, if input is invalid, continue detecting input
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
           facIterRet  = 1
```


为了实现上的简便，没有实现cache与pipeline。不过其实也没有必要，因为工作频率较低(50Mhz), 而且内存使用的是片上内存，因此所有指令的操作，包括memory的读写，都可以在一个时钟周期内实现。

Processor直接实现了与data RAM的接口(write address、read address、write data、write enable、read data), 以及与instruction ROM的接口(PC、instruction), 没有使用avalon总线相连。

Processor实现了16bit的全双工PIO，即16bit的通用输入接口与16bit的通用输出接口。可以通过PIO来连接或控制外设。本次设计的两个展示用例均使用PIO，分别是
* 使用通用输出接口连接QSys中的JTAG UART模块，向host PC发送"hello world"信息
* 通用输入连接DE2板上的switch, 通用输出链接DE2板上的LEDR，计算输入整数的fibonacci函数，在LEDR上显示二进制的输出。

余下内容分为以下几部分:

* 简要介绍一下Haskell中的类型系统，即其代数数据类型以及类型类
* 介绍Processor硬件实现的细节
* 介绍用来展示的两个测试用例

# Haskell 中的类型与类型类

关于Haskell的介绍，在之前FDE的project中，已经有所介绍。想要深入了解Haskell的读者，可以参考[Real World Haskell][RWH]。此处仅简要介绍一下Haskell中的代数数据类型，因为代数数据类型的语法上与对语言的形式化BNF范式描述很相近，因而Haskell很适合用来实现parser，compiler等工具，而本次设计中的汇编指令，就是直接用Haskell中的数据类型实现。

Haskell中内置了诸如整数(`Int`)，浮点数(`Float`, `Double`)等类型，同时，Haskell允许程序员自定义类型，不过，Haskell采用函数式编程的编程范式，因此，其自定义类型系统与一般面向对象语言中的class有所不同，其设计的重点在与不同类型的可组合性(composability)。而不支持子类型(subtype)或者说继承(inherit)。

Haskell的类型系统是代数数据类型，包括**和类型(sum type)**与**积类型(product type)**。

积类型类似其他语言中的struct或record，例如，定义一个三维空间中的点，可以如下定义：
```haskell
data Point = Point Double Double Double
```
或者

```haskell
data Point = Point { x :: Double
                   , y :: Double
                   , z :: Double 
                   }
```
表示一个`Point`由三个`Double`类型成员组成。

和类型可以理解为"或", 类似与其他语言中的Enum或者Union，例如，表示逻辑值的`Bool`可以如此定义

```haskell
data Bool = True | False
```

类型可以带参数，也可以递归地定义，例如，一个任意类型的链表可以如此定义

```haskell
data List a = Nil | Cons a (List a)
```

在本次设计中，processor的指令集如此定义, 不同类型(load, store, jump...)的指令通过和类型组合在一起，每一种类型的指令又是一个积类型，如`Arith OpCode RegIdx RegIdx RegIdx` 这类指令，表示通过ALU计算的算术指令，`Arith`为constructor，包括四个成员，一个`OpCode`和三个`RegIdx`。而`OpCode`又是一个和类型，是不同ALU操作类型的枚举。而`RegIdx`通过`type RegIdx = Unsigned 5`定义，`type`可以理解为C语言中的`typedef`，`RegIdx`是5位无符号数，用来表示寄存器号，一共有32个寄存器。

``` haskell
data Instruction = Arith OpCode    RegIdx RegIdx RegIdx
                 | Jump  JmpCode   PC                 
                 | Load  LoadFrom  RegIdx
                 | Store StoreFrom DAddr
                 | Push  RegIdx
                 | Pop   RegIdx
                 | EndProg
                 deriving(Eq, Show)

data OpCode    = Nop   | Id  | Incr | Decr | Neg | Not 
               | Add   | Sub | Mul  | Div  | Mod 
               | Eq    | Ne  | Lt   | Gt   | Le  | Ge 
               | And   | Or  | Xor 
               deriving(Eq, Show)
type RegIdx   = Unsigned 5
--- ... other types
```

# Processor 实现

下图是实现的Processor的symbol block：

<center>
![cpu-block](./img/blockgram1.png)
</center>

## 接口说明

对各个接口的说明如下：
* `instruction`，输入，从instruction ROM中读取的指令。
* `memData`，输入，从data RAM（片上内存）中读取的数据。
* `gpIn`，输入，16位通用输入。
* `iEn`，输入, 输入使能信号。
* `system1000`：输入，系统时钟。
* `system1000_rstn`，输入，复位信号，低电平复位。
* `wAddr`，输出，内存写地址，目前内存的容量为128 word(一个word为16bit)，因此地址线为7bit。
* `rAddr`，输出，内存读地址。
* `wEn`， 输出，内存写使能。
* `wData`,  输出，内存写数据。
* `pc`，输出，输入的PC，即instruction ROM的地址。
* `gpOut`，输出，16位通用输出。

## 寄存器模型

下面是寄存器相关的类型定义以及相关常数：
```haskell
type Word     = Signed 16 -- set data width to 16
type RegSize  = 32        -- we have 32 registers
type IMemSize = 128       -- 指令 ROM 的大小
type DMemSize = 128       -- 数据 RAM 的大小
type RegIdx   = Unsigned 5 -- 寄存器号
type PC       = Signed 8 -- PC在用作相对转移时，可能是负数，因此解释为有符号数，比如 Jump UR (-1)
type DAddr    = Unsigned 7 -- 内存地址类型
type Reg      = Vec RegSize  Word -- 寄存器堆

zeroreg = 0  :: RegIdx -- constant zero
jmpreg  = 1  :: RegIdx -- store the return addess when calling a function, usally use "pcreg + 2"
pcreg   = 2  :: RegIdx -- store the current PC
iReg    = 3  :: RegIdx -- for general input
oReg    = 4  :: RegIdx -- for general output
iEn     = 5  :: RegIdx -- whether the gpInput is valid
sp0     = 20 :: DAddr -- stack pointer

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
-- ... other registers
```

寄存器以及memory中存储的数据为`Word`类型，即16 bit整数。内存的容量为128个`Word`，而寄存器有32个，其中，0~5号寄存器在架构中有特殊用途，在编写汇编代码时，不应当将它们用作通用寄存器进行读写，否则程序的结果是难以预料的。

0~5号寄存器的特殊用途：

* register 0: zeroreg，存储常数0，只读
* register 1: jmpreg，存储函数返回地址，在函数调用时，可以先将返回地址存入jmpreg，如此，可以直接调用`Jump Back`指令完成函数返回，如此，对于非递归函数，可以直接返回而不需要进行堆栈操作。
* register 2: pcreg，存储当前PC，常用于计算函数返回地址，以存入jmpreg。
* register 3: iReg，存储通用输入。
* register 4: oReg，其值将输出到通用输出。
* register 5: iEn，存储通用输出使能。

## 指令集概览

```haskell
data Instruction = Arith OpCode    RegIdx RegIdx RegIdx
                 | Jump  JmpCode   PC                 
                 | Load  LoadFrom  RegIdx
                 | Store StoreFrom DAddr
                 | Push  RegIdx
                 | Pop   RegIdx
                 | EndProg
                 deriving(Eq, Show)
```

上述代码为processor的指令集定义。processor的指令包括：
* ALU运算
    * 算术运算（加、减、乘……）
    * 逻辑运算（与、或、非、异或……）
    * 条件判断（等于、大于、小于……）
* 跳转指令
    * 条件与无条件跳转
    * 条件与无条件跳转
    * 相对与绝对地址
    * 函数返回跳转
* Load 指令 
    * 加载立即数(Alu运算不支持立即数操作, 必须先load进入寄存器)
    * 从内存加载数据
* Store 指令 
    * 存立即数
    * 存寄存器数据
* 堆栈操作指令
    * Push
    * Pop
* 程序终止指令`EndProg`, 表示程序终止，PC将在此处维持，不增不减。

## ALU运算指令与ALU设计
指令集是不同类型指令的枚举，其中，ALU运算指令的定义为`Arith OpCode    RegIdx RegIdx RegIdx`，从两个寄存器中读取操作数，将ALU运算结果存入第三个寄存器。`Arith`为constructor，`OpCode`为ALU操作类型，其定义为：
```haskell
data OpCode    = Nop | Id  | Incr | Decr | Neg | Not 
               | Add | Sub | Mul  | Div  | Mod 
               | Eq  | Ne  | Lt   | Gt   | Le  | Ge 
               | And | Or  | Xor 
               deriving(Eq, Show)
```
其中，`Nop`表示无操作，输出结果为常数0，`Id`输出结果为第一个操作数，`Id`可以用来实现寄存器之间的数据转移，例如，如果想把`r7`存入`r8`（即实现`mov r7 r8`）, 可以这样使用`Id`指令：
```haskell
Arith Id r7 0 r8
```

其他类型的操作码基本可以从其字面意义推断，不再赘述。

下面介绍ALU的硬件实现, ALU可以同时完成算术、逻辑运算，以及条件判断。ALU接受一个`OpCode`类型的操作码和两个从寄存器读取的`Word`类型的操作数，输出一个`Word`类型的操作结果以及一个`Bool`类型的逻辑判断结果。

在实现上，ALU根据操作码对两个操作数执行相应操作，并将运算结果的**最后一个bit(lsb)**，设为逻辑判断结果。

下面是ALU硬件实现的代码，其类型为`alu :: OpCode -> (Word, Word) -> (Word, Bool)`

```haskell
alu :: OpCode       -- operator
    -> (Word, Word) -- to operands
    -> (Word, Bool) -- result and Conditional test resutl
alu op (x, y) =  (opRet, cnd)
    where (opRet, cnd) = (app op x y, testBit opRet 0)
          app op x y   = case op of
            Nop  -> 0 
            Id   -> x
            Incr -> x + 1
            Decr -> x - 1
            Neg  -> negate x
            Not  -> complement x
            Add  -> x + y
            Sub  -> x - y
            Mul  -> x * y
            Div  -> x `quot` y
            Mod  -> x `rem` y
            Eq   -> if x == y then 1 else 0
            Ne   -> if x /= y then 1 else 0
            Gt   -> if x > y  then 1 else 0
            Lt   -> if x < y  then 1 else 0
            Le   -> if x <= y then 1 else 0
            Ge   -> if x >= y then 1 else 0
            And  -> x .&. y 
            Or   -> x .|. y
            Xor  -> x `xor` y
```

## 跳转指令及其硬件实现

跳转运算指令的定义为`Jump JmpCode PC`，即指令包含一个表示跳转类型的`JmpCode`, 以及一个`PC`类型，注意`PC`其实是`Signed 8`的别名，因此可以为负值。

`JmpCode`的定义如下：
```haskell
data JmpCode   = NoJmp 
               | UA 
               | UR   
               | CA   
               | CR  
               | Back  deriving(Eq, Show)
```
各种跳转类型的解释：
* `NoJump`: 表示不跳转，一般只在译码时使用，如果在汇编代码中使用，等价于`Nop`指令。
* `UA`：无条件、绝对转移，PC即为instruction ROM的地址
* `UR`：无条件、相对转移，PC为偏移量
* `CA`：条件、绝对转移，只有当前的条件判断寄存器（不在寄存器堆中，不对程序员可见，由ALU自动赋值）为True时才转移，一般跟在一条ALU逻辑判断指令之后
* `CR`：条件、相对转移
* `Back`：函数返回指令，此时`Jump JmpCode PC`中的`PC`将被忽略，CPU将从`jmpreg`这个寄存器中取得函数返回地址并跳转。

下面介绍跳转模块的硬件实现，跳转模块的输入参数包括：
* 一个`JmpCode`类型的跳转类型
* 一个`Bool`类型的逻辑判断结果
* 三个不同的PC, 分别为
    * 当前PC
    * 从Jump汇编代码中译码所得的PC或PC偏移量
    * `jmpreg`中的值

跳转模块将根据跳转类型与逻辑判断结果，输出下一条指令的PC，跳转模块的haskell代码实现为：
```haskell
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
```

## Load 指令与硬件实现

`Load`指令加载数据进寄存器，可以加载一个立即数，也可以从内存中加载一个数据，不过目前还不支持从另一个寄存器中读取内存地址并加载（或Store)，因此当前的指令集比较难以实现指针操作，在后续的维护版本中会加入这一功能。

`Load`指令的定义为：`Load  LoadFrom  RegIdx`, 其中，`LoadFrom`表示数据来源的类型，其定义为：
```haskell
data LoadFrom  = RAddr DAddr  -- from memory
               | RImm Word    -- immediate number
               deriving(Eq, Show)

type DAddr = Unsigned 7
```

指令经过译码后，会被翻译成一个`LdCode`类型的值，表示指令在写回阶段时的行为：
```haskell
data LdCode    = NoLoad   
               | LdImm 
               | LdAddr 
               | LdAlu  
               deriving(Eq, Show)
```

其中：
* `NoLoad`表示没有需要写回的寄存器
* `LdImm`表示要加载立即数
* `LdAddr`表示要从内存加载数据
* `LdAlu` 表示要从ALU加载数据，即当前指令为ALU运算指令

load模块的电路实现代码如下，该模块会根据译码而成的`LdCode`数据，以及输入的寄存器号，从立即数和ALU运算结果中选择数据，并输出要写回的值。
```haskell
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
```

注意在`LdCode`为`LdAddr`时，即要从内存加载数据时的行为，`LdAddr -> regs !! toReg`，该代码表示当译码发现要从内存加载数据时，在该周期保持寄存器堆的值不变。这是因为从内存加载数据，是有仿存延迟的，在本设计中，memory使用内置的`blockRom`函数生成，并被综合成为FPGA片上内存，其读操作有一个周期的延迟，即`t`周期发起的读请求，在`t+1`周期才会被读取。因此在译码到内存加载指令时，该时钟周期不进行加载操作，并将目标寄存器号存入一个FIFO(FIFO的长度为仿存延迟周期)。

## Store 指令与硬件实现

`Store`指令向内存写入数据，可以写入一个立即数，也可以写入某一寄存器中的值，其指令定义为`Store StoreFrom DAddr`，`StoreFrom`表示写入的来源：
```haskell
data StoreFrom = MReg RegIdx  -- from register
               | MImm Word    -- immediate number
               deriving(Eq, Show)
```
指令经过译码后，生成`StCode`类型的值，`StCode`类型如下定义：
```haskell
data StCode    = NoStore 
               | StImm 
               | StReg           deriving(Eq, Show)
```
而其硬件实现页十分简单，就是根据`StCode`，从立即数与译码所得的寄存器数据中选择，给出要写入内存的值：
```haskell
store :: StCode 
      -> (Word, Word) -- (immediate-number, reg-number)
      -> Word
store stCode (imm, regData) = case stCode of
                                NoStore -> 0    
                                StImm   -> imm
                                StReg   -> regData
```
`store`模块只负责给出写入内存的值，至于内存接口中的其他输出，如写入地址、写使能等，在译码阶段就可以确定。

## 堆栈操作指令与硬件实现
CPU内部状态有一个对程序员不可见的寄存器sp，指向栈顶，初始值为20，`Push`时`sp`加一，`Pop`时`sp`减一
* `Push regN`: 把 regN寄存器中的数据压栈
* `Pop regN`: 把栈顶的数据pop出并存入regN寄存器

`Push`与`Pop`操作，可以用于实现递归函数。它们其实是特殊的`Load`/`Store`指令，经过译码后，也会有对应的`LdCode`与`StCode`，同时会有`SpCode`类型，用于更新栈顶指针`sp`
```haskell
data SpCode    = None    
               | Up     -- push
               | Down   -- pop  
               deriving(Eq, Show)
```

堆栈操作模块电路其实就是简单的更新`sp`, 其余访存操作都经过译码后由`load`或`store`模块完成:
```haskell
updateSp :: SpCode -> DAddr -> DAddr
updateSp None sp = sp
updateSp Up   sp = sp + 1
updateSp Down sp = sp - 1
```
## 通用输入输出
可以通过`iReg`，`oReg`来像普通寄存器一样操作PIO。

每个时钟周期，processor的输入使能信号会存入iEn寄存器，通用输入信号会存入iReg寄存器, 当对`iReg`使用ALU中的`Id`指令（即进行mov操作）时，最终的逻辑判断与普通`Id`操作不同，`Id`会返回`iEn`中的数据作为逻辑判断输出，而不是像其它ALU操作那样返回结果最后一个bit。

向oReg寄存器写数据，会把数据输出到通用输出，并使输出使能置一。
```haskell
-- 当向oReg寄存器写数据
-- 不管是通过ALU还是Load指令
-- 都把输出使能置一
oEn :: RegIdx -> RegIdx -> LdCode -> Bool
oEn bufLast toReg ldCode = memLoad || aluImm
    where memLoad = bufLast == oReg
          aluImm  = toReg   == oReg && (ldCode == LdImm || ldCode == LdAlu)
```

## 译码器与内部机器码

内部机器码用如下类型实现:
```haskell
data MachCode = MachCode {
    ldCode     :: LdCode
    , stCode   :: StCode
    , opCode   :: OpCode
    , jmpCode  :: JmpCode
    , spCode   :: SpCode
    , ldImm    :: Word   -- immediate number to load into register
    , stImm    :: Word   -- immediate number to store into memory
    , fromReg0 :: RegIdx -- oprand 0
    , fromReg1 :: RegIdx -- oprand 1
    , toReg    :: RegIdx -- write back register
    , toAddr   :: DAddr  -- write address
    , fromAddr :: DAddr  -- read address
    , we       :: Bool
    , jmpNum   :: PC
    } deriving(Eq, Show)
```
`MachCode`类型实现了`Default`类型类，即有多态的`def::MachCode`常量，表示其默认值：
```haskell
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
```

输入的指令，会先经过译码之后，被翻译成`MachCode`类型的值：

```haskell
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
```

例如, `EndProg`被翻译成一条死循环指令, 即`jmpCode = UR`，表示无条件相对转移，而译码后`jmpNum` = 0`，即无条件转移的偏移量为0。
## 内部状态与米利模型状态机

上面讲了processor中各个功能模块, 都是**组合逻辑**, 最终的processor采用米利模型实现, processor的内部状态，以及默认值定义如下:

```haskell
data PState    = PState { reg :: Reg
                        , cnd :: Bool
                        , pc :: PC
                        , sp :: DAddr
                        , ldBuf :: Vec LoadDelay RegIdx 
                        } 
                        deriving(Eq, Show)
instance Default PState where
    def = PState { reg = repeat 0
                 , cnd = False
                 , pc  = 0
                 , ldBuf = repeat 0
                 , sp    = sp0 
                 }
```
内部状态包括
* 一个寄存器堆，对程序员可见
* 一个`Bool`类型的寄存器，ALU的逻辑判断结果被存储在这里
* `PC`类型的寄存器，记录当前指令的PC，即上一条指令计算出的PC, 会在每个周期存入寄存器堆中的`pcreg`，从而对程序员可见。
* 堆栈顶部指针`sp`
* 用于处理load访存延迟的FIFO

而其米利模型状态机如下实现：
```haskell
esprockellMealy :: PState -> PIn -> (PState, POut)
esprockellMealy state (instr, memData, gpInEn, gpInput) = (state', out)
    where 
        MachCode{..}   = decode sp instr
        PState{..}     = state
        (aluOut, aluCnd) = alu opCode (x, y)
        cnd' = if fromReg0 == iReg || opCode == Id then gpInEn else aluCnd
        state'  = PState { reg = reg', cnd = cnd', pc = pc', sp = sp', ldBuf = ldBuf'}
        out     = (toAddr, fromAddr, we, toMem, pc', gpOutEn, gpOut)
        gpOut   = reg' !! oReg
        gpOutEn = oEn bufLast toReg ldCode
        (x, y)  = (reg0 !! fromReg0, reg0 !! fromReg1)
        ldBuf'  = ldReg +>> ldBuf
        bufLast = last ldBuf
        ldReg 
          | ldCode == LdAddr = toReg
          | otherwise        = 0
        reg0 = reg  <~ (bufLast, memData)
                    <~ (iReg, gpInput) 
                    <~ (iEn, fromIntegral $ pack gpInEn)
                    <~ (zeroreg, 0)         -- r0
                    <~ (pcreg, fromIntegral pc) -- pc of next clock
        reg' = load ldCode toReg (ldImm, aluOut) reg0
        -- reg0   = load ldCode toReg (ldImm, aluOut) $ reg <~ (last ldBuf, memData)
        -- reg'   = reg0 <~ (zeroreg, 0) <~ (pcreg, fromIntegral pc')
        toMem  = store stCode (stImm, x)
        pc'    = updatePC (jmpCode, cnd) (pc, jmpNum, reg' !! jmpreg)
        sp'    = updateSp spCode sp
```
上面的代码其实就是将之前的各个模块组合起来，在此不一一展开，主要关注两点，一是函数的类型：

```haskell
esprockellMealy :: PState -> PIn -> (PState, POut)
```

这是典型的米利模型，即当前状态与输入，决定输出与下一状态。如果想要使用摩尔模型，就需要提供`PState -> POut`与`PState -> PIn -> PState`两个函数。

第二点是processor对于寄存器堆的更新逻辑：

```haskell
reg0 = reg  <~ (bufLast, memData)
            <~ (iReg, gpInput) 
            <~ (iEn, fromIntegral $ pack gpInEn)
            <~ (zeroreg, 0)         -- r0
            <~ (pcreg, fromIntegral pc) -- pc of next clock
reg' = load ldCode toReg (ldImm, aluOut) reg0
```
即processor会先从FIFO中读取寄存器号，以处理上一条周期的load访存行为（如果上一周期没有访存，则FIFO给出的寄存器号会是0，会被之后的0号寄存器清零行为覆盖掉），再为各个特殊寄存器（`iReg`, `iEn`, `zeroreg`, `pcreg`）赋值，然后处理当前指令的`load`与`alu`结果写回行为。后处理的行为会覆盖掉先处理的行为。

## JTAG UARG控制
本次设计通过PIO生成相应波形，模拟avalon总线的master行为，控制JTAG UARG模块：

* 实例化qsys中生成的jtag_uart模块，复制synthesis文件夹中的verilog代码
* 根据avalon总线波形，手写了一个processor的POut到jtag_uart的接口
* 输出使能做avalon slave接口中`chipselect`与`write_n`信号
* 通用输出前8位做writedata，第9位做address

## Memory与系统搭建

使用CLaSH内置的`blockRam`函数与`asyncRom`函数，来实现data RAM与instruction ROM。并将processor、RAM、ROM搭成一个系统打包：
```haskell
dataRam :: Signal DAddr  -- write address
        -> Signal DAddr  -- read address
        -> Signal Bool   -- write enable
        -> Signal Word   -- write data
        -> Signal Word   -- read data
dataRam = blockRam (repeat maxBound :: Mem)

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

topEntity :: Signal (Bool, Word) -> Signal (Bool, Word)
topEntity = sys rom 
    where rom = asyncRom showFib
```
# 汇编代码实例

下面以一些例子来说明汇编代码使用。

本次涉及中的汇编代码其实是嵌入在Haskell中的`Instruction`类型的列表或者向量。

这段代码向`r7`寄存器写入立即数3，然后将`r7`的值赋给`r8`寄存器，然后将`r8`的压栈，然后将刚刚压入的栈顶元素pop给`oReg`也就是通用输出。这段代码展示了ALU、Load以及PIO的使用。

```haskell
progMov :: [Instruction]
progMov = [
    Load (RImm 3) r7 
    , Arith Id r7 zeroreg r8
    , Push r8
    , Pop oReg
    , EndProg
    ]
```
下面这段代码展示如果使用函数调用，计算`r7`与`r8`两个寄存器中的最大值，并存入`r8`
```haskell
progMax :: [Instruction]
progMax = [
    Store (MImm 3) 0
    , Store (MImm 4) 1
    , Load  (RAddr 0) r7
    , Load  (RAddr 1) r8
    , Load  (RImm  2) r9 -- inc to pc
    , Arith Add pcreg r9 jmpreg
    , Jump  UR 3
    , Arith Id r8 0 oReg
    , EndProg

    , Arith Lt r7 r8 r9
    , Jump  CR 2
    , Arith Id r7 r8 r8 -- move r7 to r8
    , Jump  Back 0
    ] 
```

下面的代码展示递归函数的使用，通过将`jmpreg`的值压栈、出栈，实现递归函数，注意目前的汇编代码不支持label，因此**跳转语句的地址还需要手动计算**。
```haskell
progFacRecr = [
    Store (MImm 6) 0
    , Load  (RAddr 0) r7
    , Load  (RImm  2) r8
    , Arith Add       pcreg r8 jmpreg
    , Jump  UA        facRecrAddr
    , Arith Id r8 0 oReg
    , EndProg

    , Arith Eq r7 zeroreg r8
    , Jump CA facRecrRet

    , Push jmpreg
    , Push r7
    , Load (RImm 2) r8
    , Arith Decr r7 r7 r7
    , Arith Add pcreg r8 jmpreg
    , Jump UA facRecrAddr
    , Pop  r7
    , Pop  jmpreg
    , Arith Mul r7 r8 r8

    , Jump Back 0
    ]
    where facRecrAddr = 1 + (fromIntegral $ L.length $ L.takeWhile (/= EndProg) progFacRecr)
          facRecrRet  = fromIntegral $ L.length progFacRecr - 1
```

progInput = register (False, 0) $ register (False, 0) $ register (True, 3) $ register (True, 4) $ register (True, 5) $ signal (False, 0)

# 展示用例

使用两个例子做展示，第一个控制JTAG UARG，与Host PC通信，向 host PC发送 "hello world"，另一个从DE2板上的SWITCH获取二进制数据，计算其fibonacci函数，并输出二进制数据到LEDR。读者可以去"vedio"中查看相关视频

Hello Word程序的汇编代码如下：
```haskell
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
```

计算fionacci函数的汇编代码如下
```haskell
prog :: IRom
prog =  Arith Id iReg 0 r7
     :> Jump CR 2
     :> Jump UR (-2)
     :> Load (RImm 2)  r8  -- r8 := 2
     :> Arith Add pcreg r8 jmpreg -- jmpreg := pcreg + 2
     :> Jump UA fibIterAddr   -- call facIter
     :> Arith Id r8 0 oReg
     :> Jump UA 0 -- infinite loop
     :> EndProg
     :> Push r8
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
     :> (repeat EndProg)
     where fibIterAddr = 9
```

[clash-homepage]: http://www.clash-lang.org/
[EDSL]: https://en.wikipedia.org/wiki/Domain-specific_language#/Usage_patterns
[RWH]: http://book.realworldhaskell.org/


