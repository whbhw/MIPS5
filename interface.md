# 模块接口

## IF

### PC

#### 接口

``` verilog
module PC (
    output  wire    [31:0]  pc      ,
    input   wire    [31:0]  pc_next 
);
```

#### 例化

``` verilog
PC xxx (
    .pc      (   ),
    .pc_next (   )
);
```

## ID

### CTRL

#### 接口

``` verilog
module CTRL (
    output  wire            regdst  ,
    output  wire            jump    ,
    output  wire            branch  ,
    output  wire            memread ,
    output  wire            memtoreg,
    output  wire    [1:0]   aluop   ,
    output  wire            memwrite,
    output  wire            alusrc  ,
    output  wire            regwrite,

    input   wire    [31:26] inst    
);
```

#### 例化

``` verilog
CTRL xxx (
    .regdst  (   ),
    .jump    (   ),
    .branch  (   ),
    .memread (   ),
    .memtoreg(   ),
    .aluop   (   ),
    .memwrite(   ),
    .alusrc  (   ),
    .regwrite(   ),

    .inst    (   )
);
```

### RF

#### 接口

``` verilog
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

``` verilog
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

``` verilog
module ALU (
    output  wire    [31:0]  alu_res ,
    output  wire    [31:0]  zero    ,

    input   wire    [31:0]  data1   ,
    input   wire    [31:0]  data2   ,
    input   wire    [3:0]   alu_ctrl
);
```

#### 例化

``` verilog
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

``` verilog
module ALUCTRL (
    output  wire    [3:0]   alu_ctrl,

    input   wire    [1:0]   aluop   ,
    input   wire    [5:0]   inst    
);
```

#### 例化

``` verilog
module ALUCTRL (
    .alu_ctrl(   ),

    .aluop   (   ),
    .inst    (   )
);
```
