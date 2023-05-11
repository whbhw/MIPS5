# 模块接口

## IF

### PC

#### 接口

```verilog
module PC (
    output  wire    [31:0]  pc      ,
    input   wire    [31:0]  pc_next ,

    input   wire            clk     ,
    input   wire            rst_n
);
```

#### 例化

```verilog
PC xxx (
    .pc      (   ),
    .pc_next (   ),

    .clk     (   ),
    .rst_n   (   )
);
```

## ID

### CTRL

#### 接口

```verilog
module CTRL (
    output  wire            signext ,

    output  wire    [1:0]   aluop   ,
    output  wire            alusrc  ,

    output  wire            memread ,
    output  wire            memwrite,
    output  wire            memtoreg,

    output  wire            regwrite,
    output  wire            regdst  ,

    output  wire            branch  ,
    output  wire            jump    ,
    output  wire            jumpr   ,
    output  wire            link    ,

    input   wire    [5:0]   opcode  ,
    input   wire    [5:0]   funct   
);
```

#### 例化

```verilog
CTRL xxx (
    .signext (   ),

    .aluop   (   ),
    .alusrc  (   ),

    .memread (   ),
    .memwrite(   ),
    .memtoreg(   ),

    .regwrite(   ),
    .regdst  (   ),

    .branch  (   ),
    .jump    (   ),
    .jumpr   (   ),
    .link    (   ),

    .opcode  (   ),
    .funct   (   )
);
```

#### 真值表

|inst    |opcode  ||signext |aluop   |alusrc  |memread |memwrite|memtoreg|regwrite|regdst  |branch  |jump    |jumpr   |link    |
|:--:|:--:|--|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|lw |23 ||
|sw |2b ||
|beq|04 ||
|bne|05 ||
|j  |02 ||
|jal|03 ||
|R* |00*||
|jr*|00*||

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
    .rd1addr (   ),
    .rd1data (   ),

    .rd2addr (   ),
    .rd2data (   ),

    .wraddr  (   ),
    .wrdata  (   ),
    .wren    (   ),

    .clk     (   ),
    .rst_n   (   )
);
```

## EX

### ALU

#### 接口

```verilog
module ALU (
    output  wire    [31:0]  alu_res ,
    output  wire    [31:0]  zero    ,

    input   wire    [31:0]  data1   ,
    input   wire    [31:0]  data2   ,
    input   wire    [3:0]   alu_ctrl
);
```

#### 例化

```verilog
ALU xxx (
    .alu_res (   ),
    .zero    (   ),

    .data1   (   ),
    .data2   (   ),
    .alu_ctrl(   )
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
module ALUCTRL (
    .alu_ctrl(   ),

    .aluop   (   ),
    .funct   (   )
);
```
