/* -------------------------------------------------------------------------- */
/*                              CPU_TOP_PIPELINE                              */
/* -------------------------------------------------------------------------- */
module CPU_TOP_PIPELINE(
    input   clk     ,
    input   rst_n   
);

/* --------------------------- instanciation of PC -------------------------- */
wire    [8:0]   IF_pc   ;
wire    [8:0]   IF_pc_4 ;
wire    [8:0]   pc_next ;

PC u_pc (
    .pc         ( IF_pc     ),
    .pc_4       ( IF_pc_4   ),
    .pc_next    ( pc_next   ),

    .clk        ( clk       ),
    .rst_n      ( rst_n     )
);


/* ------------------------ instanciation of INSTMEM ------------------------ */
wire    [31:0]   IF_inst;

INSTMEM u_instmem (
    .Address    ( IF_pc     ),
    .dout       ( IF_inst   )
);


/* ------------------------- instanciation of HZDPU ------------------------- */
wire            pcop    ;
wire    [2:0]   flush   ;
wire            stall   ;

wire            ID_jnjr ;
wire            EX_bjjr ;
wire            hzdlu   ;

HZDPU u_hzdpu (
    .pcop       ( pcop      ),
    .flush      ( flush     ),
    .stall      ( stall     ),
    .ID_jnjr    ( ID_jnjr   ),
    .EX_jjr     ( EX_bjjr    ),
    .hzdlu      ( hzdlu     )
);

/* -------------------------- instaciation of IF_ID ------------------------- */
wire    [8:0]   ID_pc_4 ;
wire    [31:0]  ID_inst ;

wire            stall   ;
wire    [2:0]   flush   ;

IF_ID u_if+id (
    .clk        ( clk       ),
    .rst_n      ( rst_n     ),
    .stall      ( stall     ),
    .flush      ( flush[0]  ),
    .IF_pc_4    ( IF_pc_4   ),
    .IF_inst    ( IF_inst   ),
    .ID_pc_4    ( ID_pc_4   ),
    .ID_inst    ( ID_inst   )
);

/* --------------------------- instanciation of RF --------------------------- */
wire    [31:0]  ID_data1    ;
wire    [31:0]  ID_data2    ;
wire    [31:0]  WB_data     ;

RF u_rf (
    .rd1addr    ( ID_inst[25:21]    ),
    .rd1data    ( ID_data1          ),

    .rd2addr    ( ID_inst[20:16]    ),
    .rd2data    ( ID_data2          ),

    .wraddr     ( WB_ins[15:11]     ),
    .wrdata     ( WB_data           ),
    .wren       ( WB_regwrite       ),

    .clk        ( clk               ),
    .rst_n      ( rst_n             )
);

/* ------------------------- instanciation of EXTEND ------------------------ */
wire    [31:0]  ID_extend   ;

EXTEND u_extend (
    .extend_out ( ID_extend         ),
    .extend_in  ( ID_inst[15:0]     ),
    .signext    ( signext           )
);

/* -------------------------- instanciation of CTRL ------------------------- */
wire            signext ;   // 符号扩展(1符号,0无符号)

wire    [1:0]   aluop   ;   // alu初步控制编码
wire            alusrc  ;   // alu输入来源选择

wire            memread ;   // 数据内存读取控制
wire            memwrite;   // 数据内存写入控制
wire            memtoreg;   // 数据寄存器写入来源选择

wire            regread1;   // 数据寄存器读取1标志
wire            regread2;   // 数据寄存器读取2标志
wire            regwrite;   // 数据寄存器写入控制
wire            regdst  ;   // 数据寄存器写入地址来源选择

wire            branch  ;   // 分支指令标志
wire            branchne;   // bne(1)/beq(0)标志,前提branch有效
wire            jump    ;   // 跳转指令标志
wire            jumpr   ;   // jr标志,前提jump有效
wire            link    ;   // jal标志,前提jump有效

wire    [5:0]   opcode  ;   // 指令opcode部分输入
wire    [5:0]   funct   ;   // 指令funct部分输入

CTRL u_ctrl (
    .signext    (signext    ),  // 符号扩展(1符号,0无符号)

    .aluop      (aluop      ),  // alu初步控制编码
    .alusrc     (alusrc     ),  // alu输入来源选择

    .memread    (memread    ),  // 数据内存读取控制
    .memwrite   (memwrite   ),  // 数据内存写入控制
    .memtoreg   (memtoreg   ),  // 数据寄存器写入来源选择

    .regread1   (regread1   ),  // 数据寄存器读取1标志
    .regread2   (regread2   ),  // 数据寄存器读取2标志
    .regwrite   (regwrite   ),  // 数据寄存器写入控制
    .regdst     (regdst     ),  // 数据寄存器写入地址来源选择

    .branch     (branch     ),  // 分支指令标志
    .branchne   (branchne   ),  // bne(1)/beq(0)标志,前提branch有效
    .jump       (jump       ),  // 跳转指令标志
    .jumpr      (jumpr      ),  // jr标志,前提jump有效
    .link       (link       ),  // jal标志,前提jump有效

    .opcode     (opcode     ),  // 指令opcode部分输入
    .funct      (funct      )   // 指令funct部分输入
);


/* ------------------------- instanciation of ID_EX ------------------------- */
wire            EX_signext ;
wire            EX_aluop   ;
wire            EX_alusrc  ;
wire            EX_memread ;
wire            EX_memwrite;
wire            EX_memtoreg;
wire            EX_regread1;
wire            EX_regread2;
wire            EX_regwrite;
wire            EX_regdst  ;
wire            EX_branch  ;
wire            EX_branchne;
wire            EX_jump    ;
wire            EX_jumpr   ;
wire            EX_link    ;
wire    [8:0]   EX_pc_4    ;
wire    [31:0]  EX_inst    ;

ID_EX u_id_ex (
    .clk        (clk        ),
    .rst_n      (rst_n      ),
    .stall      (stall      ),
    .flush      (flush[0]   ),
    .ID_pc_4    (IF_pc_4    ),
    .ID_inst    (IF_inst    ),
    .ID_data1   (ID_data1   ),
    .ID_data2   (ID_data2   ),
    .ID_extend  (ID_extend  ),

    .ID_signext (signext    ),
    .ID_aluop   (aluop      ),
    .ID_alusrc  (alusrc     ),
    .ID_memread (memread    ),
    .ID_memwrite(memwrite   ),
    .ID_memtoreg(memtoreg   ),
    .ID_regread1(regread1   ),
    .ID_regread2(regread2   ),
    .ID_regwrite(regwrite   ),
    .ID_regdst  (regdst     ),
    .ID_branch  (branch     ),
    .ID_branchne(branchne   ),
    .ID_jump    (jump       ),
    .ID_jumpr   (jumpr      ),
    .ID_link    (link       ),
    
    .EX_signext (EX_signext ),
    .EX_aluop   (EX_aluop   ),
    .EX_alusrc  (EX_alusrc  ),
    .EX_memread (EX_memread ),
    .EX_memwrite(EX_memwrite),
    .EX_memtoreg(EX_memtoreg),
    .EX_regread1(EX_regread1),
    .EX_regread2(EX_regread2),    
    .EX_regwrite(EX_regwrite),
    .EX_regdst  (EX_regdst  ),
    .EX_branch  (EX_branch  ),
    .EX_branchne(EX_branchne),
    .EX_jump    (EX_jump    ),
    .EX_jumpr   (EX_jumpr   ),
    .EX_link    (EX_link    ),
    .EX_pc_4    (EX_pc_4    ),
    .EX_inst    (EX_inst    )
);

/* ------------------------ instanciation of ALU_CTRL ----------------------- */
wire    [3:0]   alu_ctrl;
wire    [5:0]   alu_input; // the input for alu_ctrl

ALUCTRL u_aluctrl (
    .alu_ctrl   (alu_ctrl   ),
    .aluop      (EX_aluop   ),
    .funct      (alu_input  )
);

/* -------------------------- instanciation of ALU -------------------------- */
wire    [31:0]  EX_alu_res ;
wire            EX_zero    ;
wire    [31:0]  alu_data1  ;
wire    [31:0]  alu_data2  ; //立即数通道

ALU u_alu (
    .alu_res    (EX_alu_res     ),
    .zero       (EX_zero        ),
    .data1      (alu_data1      ),
    .data2      (alu_data2      ),
    .shamt      (EX_inst[10:6]  ),
    .alu_ctrl   (alu_ctrl       )
);

/* ------------------------- instanciation of FWDPU ------------------------- */
FWDPU u_fwdpu (
    .fwdrs          (fwdrs  ),
    .fwdrt          (fwdrt  ),
    .hzdlu          (hzdlu  ),

    .EX_regread1    (EX_inst[25:21] ),
    .EX_regread2    (EX_inst[20:16] ),
    .EX_inst        (EX_inst        ),

    .MEM_regwrite   (MEM_regwrite   ),
    .MEM_wraddr     (MEM_wraddr     ),
    .MEM_memread    (MEM_memread    ),

    .WB_regwrite    (WB_regwrite    ),
    .WB_wraddr      (WB_wraddr      )
);


/* ------------------------- instanciation of EX_MEM ------------------------ */


endmodule