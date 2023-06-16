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
|sw |2b ||1 |00    |1  |0  |1  |X  |1   |1  |0  |X  |0  |X  |0  |X  |X  |
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

#### 说明

```verilog
// rs
// default: rs no forward
if (EX_regread1 && (EX_inst[25:21] != 5'd0)) begin
    if (MEM_regwrite && (MEM_wraddr == EX_inst[25:21])) begin
        if (MEM_memread) begin
            // load-use Hazard
        end else begin
            // rs forward MEM
        end
    end else if (WB_regwrite && (WB_wraddr == EX_inst[25:21])) begin
        // rs forward WB
    end
end

// rt
// default: rt no forward
if (EX_regread1 && (EX_inst[20:16] != 5'd0)) begin
    if (MEM_regwrite && (MEM_wraddr == EX_inst[20:16])) begin
        // rt forward MEM
    end else if (WB_regwrite && (WB_wraddr == EX_inst[20:16])) begin
        // rt forward WB
    end
end
```

#### 接口

```verilog
module FWDPU (
    output  reg     [1:0]   fwdrs       ,
    output  reg     [1:0]   fwdrt       ,
    output  reg             hzdlu       ,

    input   wire            EX_regread1 ,
    input   wire            EX_regread2 ,
    input   wire    [31:0]  EX_inst     ,

    input   wire            MEM_regwrite,
    input   wire    [4:0]   MEM_wraddr  ,
    input   wire            MEM_memread ,

    input   wire            WB_regwrite ,
    input   wire    [4:0]   WB_wraddr   
);
```

#### 例化

```verilog
FWDPU xxx (
    .fwdrs          (   ),
    .fwdrt          (   ),
    .hzdlu          (   ),

    .EX_regread1    (   ),
    .EX_regread2    (   ),
    .EX_inst        (   ),

    .MEM_regwrite   (   ),
    .MEM_wraddr     (   ),
    .MEM_memread    (   ),

    .WB_regwrite    (   ),
    .WB_wraddr      (   )
);
```

### HZDPU

#### 说明

优先级从高到低
|Hazard     |段 |处理方式   |
|:-:        |:-:|:-:        |
|hzdlu      |EX |pcop = 3<br/>  stall IF_ID ID_EX<br/>  flush EX_MEM    |
|branch/jr  |EX |pcop = 2<br/>  flush IF_ID ID_EX   |
|jump(!jr)  |ID |pcop = 1<br/>  flush IF_ID |
|none       |-- |pcop = 0   |

#### 接口

```verilog
module HZDPU (
    output  reg     [1:0]   pcop        ,
    output  reg     [2:0]   flush       ,
    output  reg             stall       ,

    input   wire            ID_jnjr     ,
    input   wire            EX_bjjr     ,
    input   wire            hzdlu       
);
```

#### 例化

```verilog
HZDPU xxx (
    .pcop       (   ),
    .flush      (   ),
    .stall      (   ),

    .ID_jnjr    (   ),
    .EX_bjjr    (   ),
    .hzdlu      (   )
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

#### IF/ID寄存器

存储的数据：pc+4、inst

##### 接口

```verilog
module IF_ID (
    input   wire            clk     ,
    input   wire            rst_n   ,
    input   wire            stall   ,
    input   wire            flush   ,

    input   wire    [8:0]   IF_pc_4 ,
    input   wire    [31:0]  IF_inst,
    
    output  wire    [8:0]   ID_pc_4 ,
    output  wire    [31:0]  ID_inst      
);
```

##### 例化

```verilog
IF_ID xxx (
    .clk        (  ),
    .rst_n      (  ),
    .stall      (  ),
    .flush      (  ),
    .IF_pc_4    (  ),
    .IF_inst    (  ),
    .ID_pc_4    (  ),
    .ID_inst    (  )
);
```

#### ID/EX寄存器

存储的数据：pc+4、inst、signext 、aluop、alusrc、memread、memwrite、memtoreg、regwrite、regdst、branch、branchne、jump、jumpr、link

##### 接口

```verilog
module ID_EX (
    input   wire            clk         ,
    input   wire            rst_n       ,
    input   wire            stall       ,
    input   wire            flush       ,

    input   wire    [8:0]   ID_pc_4     ,
    input   wire    [31:0]  ID_inst     ,

    input   wire            ID_signext  ,
    input   wire            ID_aluop    ,
    input   wire            ID_alusrc   ,
    input   wire            ID_memread  ,
    input   wire            ID_memwrite ,
    input   wire            ID_memtoreg ,
    input   wire            ID_regread1 ,
    input   wire            ID_regread2 ,    
    input   wire            ID_regwrite ,
    input   wire            ID_regdst   ,
    input   wire            ID_branch   ,
    input   wire            ID_branchne ,
    input   wire            ID_jump     ,
    input   wire            ID_jumpr    ,
    input   wire            ID_link     ,

    output  wire            EX_signext  ,
    output  wire            EX_aluop    ,
    output  wire            EX_alusrc   ,
    output  wire            EX_memread  ,
    output  wire            EX_memwrite ,
    output  wire            EX_memtoreg ,
    output  wire            EX_regread1 ,
    output  wire            EX_regread2 ,
    output  wire            EX_regwrite ,
    output  wire            EX_regdst   ,
    output  wire            EX_branch   ,
    output  wire            EX_branchne ,
    output  wire            EX_jump     ,
    output  wire            EX_jumpr    ,
    output  wire            EX_link     ,
    
    output  wire    [8:0]   EX_pc_4     ,
    output  wire    [31:0]  EX_inst      
);
```

##### 例化

```verilog
ID_EX xxx (
    .clk        (   ),
    .rst_n      (   ),
    .stall      (   ),
    .flush      (   ),
    .ID_pc_4    (   ),
    .ID_inst    (   ),
    .ID_signext (   ),
    .ID_aluop   (   ),
    .ID_alusrc  (   ),
    .ID_memread (   ),
    .ID_memwrite(   ),
    .ID_memtoreg(   ),
    .ID_regread1(   ),
    .ID_regread2(   ),
    .ID_regwrite(   ),
    .ID_regdst  (   ),
    .ID_branch  (   ),
    .ID_branchne(   ),
    .ID_jump    (   ),
    .ID_jumpr   (   ),
    .ID_link    (   ),
    .EX_signext (   ),
    .EX_aluop   (   ),
    .EX_alusrc  (   ),
    .EX_memread (   ),
    .EX_memwrite(   ),
    .EX_memtoreg(   ),
    .EX_regread1(   ),
    .EX_regread2(   ),    
    .EX_regwrite(   ),
    .EX_regdst  (   ),
    .EX_branch  (   ),
    .EX_branchne(   ),
    .EX_jump    (   ),
    .EX_jumpr   (   ),
    .EX_link    (   ),
    .EX_pc_4    (   ),
    .EX_inst    (   )
);
```

#### EX/MEM寄存器

存储的数据：pc+4、inst、memread、memwrite、memtoreg、regwrite、regdst、link

##### 接口

```verilog
module EX_MEM (
    input   wire            clk             ,
    input   wire            rst_n           ,
    input   wire            stall           ,
    input   wire            flush           ,

    input   wire    [8:0]   EX_pc_4         ,
    input   wire    [31:0]  EX_inst         ,

    input   wire            EX_memread      ,
    input   wire            EX_memwrite     ,
    input   wire            EX_memtoreg     ,
    input   wire            EX_regwrite     ,
    input   wire            EX_regdst       ,
    input   wire            EX_link         ,

    output  wire            MEM_memread     ,
    output  wire            MEM_memwrite    ,
    output  wire            MEM_memtoreg    ,
    output  wire            MEM_regwrite    ,
    output  wire            MEM_regdst      ,
    output  wire            MEM_link        ,
    
    output  wire    [8:0]   MEM_pc_4        ,
    output  wire    [31:0]  MEM_inst      
);
```

##### 例化

```verilog
EX_MEM xxx(
    .clk            (   ),
    .rst_n          (   ),
    .stall          (   ),
    .flush          (   ),
    .EX_pc_4        (   ),
    .EX_inst        (   ),
    .EX_memread     (   ),
    .EX_memwrite    (   ),
    .EX_memtoreg    (   ),
    .EX_regwrite    (   ),
    .EX_regdst      (   ),
    .EX_link        (   ),
    .MEM_memread    (   ),
    .MEM_memwrite   (   ),
    .MEM_memtoreg   (   ),
    .MEM_regwrite   (   ),
    .MEM_regdst     (   ),
    .MEM_link       (   ),
    .MEM_pc_4       (   ),
    .MEM_inst       (   )
);
```

#### MEM_WB寄存器

##### 接口

```verilog
module EX_MEM (
    input   wire            clk         ,
    input   wire            rst_n       ,
    input   wire            stall       ,
    input   wire            flush       ,

    input   wire    [8:0]   MEM_pc_4    ,
    input   wire    [31:0]  MEM_inst    ,

    input   wire            MEM_memtoreg,
    input   wire            MEM_regwrite,
    input   wire            MEM_regdst  ,  
    input   wire            MEM_link    ,

    output  wire            WB_memtoreg ,
    output  wire            WB_regwrite ,
    output  wire            WB_regdst   ,  
    output  wire            WB_link     ,

    output  wire    [8:0]   WB_pc_4     ,
    output  wire    [31:0]  WB_ins
);
```

##### 例化

```verilog
MEM_WB xxx(
    .clk            (   ),
    .rst_n          (   ),
    .stall          (   ),
    .flush          (   ),
    .MEM_pc_4       (   ),
    .MEM_inst       (   ),
    .MEM_memtoreg   (   ),
    .MEM_regwrite   (   ),
    .MEM_regdst     (   ),
    .MEM_link       (   ),
    .WB_memtoreg    (   ),
    .WB_regwrite    (   ),
    .WB_regdst      (   ),
    .WB_link        (   ),
    .WB_pc_4        (   ),
    .WB_ins         (   ),
);
```
