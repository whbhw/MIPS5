# 模块接口

## IF

### PC

#### 接口

```verilog
module PC (
    output  wire    [31:0]  pc      ,
    output  wire    [31:0]  pc_4    ,
    input   wire    [31:0]  pc_next ,

    input   wire            clk     ,
    input   wire            rst_n
);
```

#### 例化

```verilog
PC xxx (
    .pc         (   ),
    .pc_4       (   ),
    .pc_next    (   ),

    .clk        (   ),
    .rst_n      (   )
);
```

### INSTMEM

#### 接口

```verilog
module INSTMEM (
    input   wire    [8:0]   Address ,
    output  wire    [31:0]  dout    
);
```

#### 例化

```verilog
INSTMEM xxx (
    .Address    (   ),
    .dout       (   )
);
```

## ID

### CTRL

#### 接口

```verilog
module CTRL (
    output  wire            signext ,   // 符号扩展(1符号,0无符号)

    output  wire    [1:0]   aluop   ,   // alu初步控制编码
    output  wire            alusrc  ,   // alu输入来源选择

    output  wire            memread ,   // 数据内存读取控制
    output  wire            memwrite,   // 数据内存写入控制
    output  wire            memtoreg,   // 数据寄存器写入来源选择

    output  wire            regread1,   // 数据寄存器读取1标志
    output  wire            regread2,   // 数据寄存器读取2标志
    output  wire            regwrite,   // 数据寄存器写入控制
    output  wire            regdst  ,   // 数据寄存器写入地址来源选择

    output  wire            branch  ,   // 分支指令标志
    output  wire            branchne,   // bne(1)/beq(0)标志,前提branch有效
    output  wire            jump    ,   // 跳转指令标志
    output  wire            jumpr   ,   // jr标志,前提jump有效
    output  wire            link    ,   // jal标志,前提jump有效

    input   wire    [5:0]   opcode  ,   // 指令opcode部分输入
    input   wire    [5:0]   funct       // 指令funct部分输入
);
```

#### 例化

```verilog
CTRL xxx (
    .signext    (   ),  // 符号扩展(1符号,0无符号)
    
    .aluop      (   ),  // alu初步控制编码
    .alusrc     (   ),  // alu输入来源选择
    
    .memread    (   ),  // 数据内存读取控制
    .memwrite   (   ),  // 数据内存写入控制
    .memtoreg   (   ),  // 数据寄存器写入来源选择
    
    .regread1   (   ),  // 数据寄存器读取1标志
    .regread2   (   ),  // 数据寄存器读取2标志
    .regwrite   (   ),  // 数据寄存器写入控制
    .regdst     (   ),  // 数据寄存器写入地址来源选择
    
    .branch     (   ),  // 分支指令标志
    .branchne   (   ),  // bne(1)/beq(0)标志,前提branch有效
    .jump       (   ),  // 跳转指令标志
    .jumpr      (   ),  // jr标志,前提jump有效
    .link       (   ),  // jal标志,前提jump有效
    
    .opcode     (   ),  // 指令opcode部分输入
    .funct      (   )   // 指令funct部分输入
);
```

#### 真值表

|inst    |opcode  ||signext |aluop   |alusrc  |memread |memwrite    |memtoreg*  |regread1   |regread2   |regwrite|regdst  |branch  |branchne*|jump    |jumpr   |link    |
|:--:|:--:|--|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|lw |23 ||1 |00    |1  |1  |0  |1  |1   |0  |1  |0  |0  |X  |0  |X  |0  |
|sw |2b ||1 |00    |1  |0  |1  |X  |1   |0  |0  |X  |0  |X  |0  |X  |X  |
|beq|04 ||1 |01    |0  |0  |0  |X  |1   |1  |0  |X  |1  |0  |0  |X  |0  |
|bne|05 ||1 |01    |0  |0  |0  |X  |1   |1  |0  |X  |1  |1  |0  |X  |0  |
|j  |02 ||X |11    |0  |0  |0  |X  |0   |0  |0  |X  |0  |X  |1  |0  |0  |
|jal|03 ||X |11    |0  |0  |0  |X  |0   |0  |1  |X  |0  |X  |1  |0  |1  |
|jr*|00*||X |11    |0  |0  |0  |X  |1   |0  |0  |X  |0  |X  |1  |1  |0  |
|R* |00*||X |10    |0  |0  |0  |0  |1   |1  |1  |1  |0  |X  |0  |X  |0  |
|I* |*  ||? |10    |1  |0  |0  |0  |1   |0  |1  |0  |0  |X  |0  |X  |0  |

**注：** jr和R指令须通过funct区分，jr的funct为6'h08

**I型指令表**
|inst    |opcode  ||signext |
|:--:|:--:|--|:--:|
|addi   |08 ||1 |
|addiu  |09 ||1 |
|andi   |0c ||0 |
|ori    |0d ||0 |
|xori   |0e ||0 |
|lui    |0f ||0 |

**aluop编码表**
|aluop  |alu    |
|:-----:|:---:|
|00    |add    |
|01    |sub    |
|10    |R(I)   |
|11    |nop    |

### RF

#### 接口

```verilog
module RF (
    input   wire    [4:0]   rd1addr ,
    output  wire    [31:0]  rd1data ,

    input   wire    [4:0]   rd2addr ,
    output  wire    [31:0]  rd2data ,

    input   wire    [4:0]   wraddr  ,
    input   wire    [31:0]  wrdata  ,
    input   wire            wren    ,

    input   wire            clk     ,
    input   wire            rst_n
);
```

#### 例化

```verilog
RF xxx (
    .rd1addr    (   ),
    .rd1data    (   ),

    .rd2addr    (   ),
    .rd2data    (   ),

    .wraddr     (   ),
    .wrdata     (   ),
    .wren       (   ),

    .clk        (   ),
    .rst_n      (   )
);
```

### EXTEND

#### 接口

```verilog
module EXTEND (
    output  wire    [31:0]  extend_out  ,
    input   wire    [15:0]  extend_in   ,
    input   wire            signext     
);
```

#### 例化

```verilog
EXTEND xxx (
    .extend_out (   ),
    .extend_in  (   ),
    .signext    (   )
);
```

## EX

### ALU

#### 功能简介

完成的任务包括（共9种）：ADD、SUB、AND、OR、XOR、LUI、SLT、SLL、SRL、BEQ

#### 接口

```verilog
module ALU (
    output  wire    [31:0]  alu_res ,
    output  wire            zero    ,

    input   wire    [31:0]  data1   ,
    input   wire    [31:0]  data2   , //立即数通道
    input   wire    [5:0]   shamt   ,
    input   wire    [3:0]   alu_ctrl
);
```

#### 例化

```verilog
ALU xxx (
    .alu_res    (   ),
    .zero       (   ),

    .data1      (   ),
    .data2      (   ),
    .shamt      (   ),
    .alu_ctrl   (   )
);
```

### ALUCTRL

#### 接口

```verilog
module ALUCTRL (
    output  wire    [3:0]   alu_ctrl,

    input   wire    [1:0]   aluop   ,
    input   wire    [5:0]   funct   
);
```

#### 例化

```verilog
ALUCTRL xxx (
    .alu_ctrl   (   ),

    .aluop      (   ),
    .funct      (   )
);
```

## MEM

### DATAMEM

#### 接口

```verilog
module DATAMEM (
    input   wire            clk     ,
    input   wire            wen     ,
    input   wire    [8:0]   Address ,
    input   wire    [31:0]  din     ,
    output  wire    [31:0]  dout    
);
```

#### 例化

```verilog
DATAMEM xxx (
    .clk        (   ),
    .wen        (   ),
    .Address    (   ),
    .din        (   ),
    .dout       (   )
);
```

## 流水线相关接口

### FWDPU

#### 接口

```verilog
module FWDPU (
    input   wire            clk     ,
    input   wire            wen     ,
    input   wire    [8:0]   Address ,
    input   wire    [31:0]  din     ,
    output  wire    [31:0]  dout    
);
```

#### 例化

```verilog
FWDPU xxx (
    .clk        (   ),
    .wen        (   ),
    .Address    (   ),
    .din        (   ),
    .dout       (   )
);
```

### 段间寄存器

#### 各段间寄存器存储控制信号

| signal    | IF/ID | ID/EX | EX/MEM    | MEM/WB    | note  |
| :-------: | :---: | :---: | :-------: | :-------: | :---: |
|signext    |       |       |           |           | 符号扩展(1符号,0无符号)   |
|aluop      |       |   1   |           |           | alu初步控制编码           |
|alusrc     |       |   1   |           |           | alu输入来源选择           |
|memread    |       |   1   |     1     |           | 数据内存读取控制          |
|memwrite   |       |   1   |     1     |           | 数据内存写入控制          |
|memtoreg   |       |   1   |     1     |     1     | 数据寄存器写入来源选择    |
|regread1   |       |   1   |           |           | 数据寄存器读取1标志       |
|regread2   |       |   1   |           |           | 数据寄存器读取2标志       |
|regwrite   |       |   1   |     1     |     1     | 数据寄存器写入控制        |
|regdst     |       |   1   |     1     |     1     | 数据寄存器写入地址来源选择|
|branch     |       |   1   |           |           | 分支指令标志              |
|branchne   |       |   1   |           |           | bne(1)/beq(0)标志,前提branch有效  |
|jump       |       |   1   |           |           | 跳转指令标志              |
|jumpr      |       |   1   |           |           | jr标志,前提jump有效       |
|link       |       |   1   |     1     |     1     | jal标志,前提jump有效      |
