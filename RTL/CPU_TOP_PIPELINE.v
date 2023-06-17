/* -------------------------------------------------------------------------- */
/*                              CPU_TOP_PIPELINE                              */
/* -------------------------------------------------------------------------- */

// NO imexplicit wire
`default_nettype none

module CPU_TOP_PIPELINE(
    input   wire        clk     ,
    input   wire        rst_n   
);

`include "CPU_TOP_PIPELINE_wire.vh"

/* --------------------------- instanciation of PC -------------------------- */
PC u_pc (
    .pc         ( IF_pc     ),
    .pc_4       ( IF_pc_4   ),
    .pc_next    ( IF_pc_next),

    .clk        ( clk       ),
    .rst_n      ( rst_n     )
);


/* ------------------------ instanciation of INSTMEM ------------------------ */
INSTMEM u_instmem (
    .Address    ( IF_pc     ),
    .dout       ( IF_inst   )
);


/* ------------------------- instanciation of HZDPU ------------------------- */
HZDPU u_hzdpu (
    .pcop       ( pcop      ),
    .flush      ( flush     ),
    .stall      ( stall     ),
    .ID_jnjr    ( ID_jnjr   ),
    .EX_bjjr    ( EX_bjjr   ),
    .hzdlu      ( hzdlu     )
);

/* -------------------------- instaciation of IF_ID ------------------------- */
IF_ID u_if_id (
    .clk        ( clk           ),
    .rst_n      ( rst_n         ),
    .stall      ( stall         ),
    .flush      ( flush[0]      ),
    .IF_pc_4    ( IF_pc_4[10:2] ),
    .IF_inst    ( IF_inst[10:2] ),
    .ID_pc_4    ( ID_pc_4       ),
    .ID_inst    ( ID_inst       )
);

/* --------------------------- instanciation of RF --------------------------- */
RF u_rf (
    .rd1addr    ( ID_inst[25:21]    ),
    .rd1data    ( ID_data1          ),

    .rd2addr    ( ID_inst[20:16]    ),
    .rd2data    ( ID_data2          ),

    .wraddr     ( WB_wraddr         ),
    .wrdata     ( WB_data           ),
    .wren       ( WB_regwrite       ),

    .clk        ( clk               ),
    .rst_n      ( rst_n             )
);

/* ------------------------- instanciation of EXTEND ------------------------ */
EXTEND u_extend (
    .extend_out ( ID_extend         ),
    .extend_in  ( ID_inst[15:0]     ),
    .signext    ( ID_signext        )
);

/* -------------------------- instanciation of CTRL ------------------------- */
CTRL u_ctrl (
    .signext    (ID_signext    ),  // 符号扩展(1符号,0无符号)

    .aluop      (ID_aluop      ),  // alu初步控制编码
    .alusrc     (ID_alusrc     ),  // alu输入来源选择

    .memread    (ID_memread    ),  // 数据内存读取控制
    .memwrite   (ID_memwrite   ),  // 数据内存写入控制
    .memtoreg   (ID_memtoreg   ),  // 数据寄存器写入来源选择

    .regread1   (ID_regread1   ),  // 数据寄存器读取1标志
    .regread2   (ID_regread2   ),  // 数据寄存器读取2标志
    .regwrite   (ID_regwrite   ),  // 数据寄存器写入控制
    .regdst     (ID_regdst     ),  // 数据寄存器写入地址来源选择

    .branch     (ID_branch     ),  // 分支指令标志
    .branchne   (ID_branchne   ),  // bne(1)/beq(0)标志,前提branch有效
    .jump       (ID_jump       ),  // 跳转指令标志
    .jumpr      (ID_jumpr      ),  // jr标志,前提jump有效
    .link       (ID_link       ),  // jal标志,前提jump有效

    .opcode     (ID_opcode     ),  // 指令opcode部分输入
    .funct      (ID_funct      )   // 指令funct部分输入
);


/* ------------------------- instanciation of ID_EX ------------------------- */
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

    .ID_signext (ID_signext    ),
    .ID_aluop   (ID_aluop      ),
    .ID_alusrc  (ID_alusrc     ),
    .ID_memread (ID_memread    ),
    .ID_memwrite(ID_memwrite   ),
    .ID_memtoreg(ID_memtoreg   ),
    .ID_regread1(ID_regread1   ),
    .ID_regread2(ID_regread2   ),
    .ID_regwrite(ID_regwrite   ),
    .ID_regdst  (ID_regdst     ),
    .ID_branch  (ID_branch     ),
    .ID_branchne(ID_branchne   ),
    .ID_jump    (ID_jump       ),
    .ID_jumpr   (ID_jumpr      ),
    .ID_link    (ID_link       ),
    .ID_wraddr  (ID_wraddr     ),
    
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
    .EX_wraddr  (EX_wraddr  ),
    .EX_pc_4    (EX_pc_4    ),
    .EX_inst    (EX_inst    )
);

/* ------------------------ instanciation of ALU_CTRL ----------------------- */
ALUCTRL u_aluctrl (
    .alu_ctrl   (alu_ctrl   ),
    .aluop      (EX_aluop   ),
    .funct      (alu_input  )
);

/* -------------------------- instanciation of ALU -------------------------- */
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
EX_MEM u_ex_mem(
    .clk            (clk            ),
    .rst_n          (rst_n          ),
    .stall          (stall          ),
    .flush          (flush[2]       ),
    .EX_pc_4        (EX_pc_4        ),
    .EX_inst        (EX_inst        ),
    .EX_memread     (EX_memread     ),
    .EX_memwrite    (EX_memwrite    ),
    .EX_memtoreg    (EX_memtoreg    ),
    .EX_regwrite    (EX_regwrite    ),
    .EX_regdst      (EX_regdst      ),
    .EX_link        (EX_link        ),
    .EX_data        (EX_data        ),
    .EX_address     (EX_address     ),
    .EX_wraddr      (EX_wraddr      ),
    .MEM_memread    (MEM_memread    ),
    .MEM_memwrite   (MEM_memwrite   ),
    .MEM_memtoreg   (MEM_memtoreg   ),
    .MEM_regwrite   (MEM_regwrite   ),
    .MEM_regdst     (MEM_regdst     ),
    .MEM_link       (MEM_link       ),
    .MEM_wraddr     (MEM_wraddr     ),
    .MEM_pc_4       (MEM_pc_4       ),
    .MEM_inst       (MEM_inst       )
);
endmodule

/* ------------------------ instanciation of DATAMEM ------------------------ */
DATAMEM u_datamem (
    .clk        (rst_n          ),
    .wen        (MEM_memwrite   ),
    .Address    (EX_address     ),
    .din        (EX_data        ),
    .dout       (datamem_out    )
);

/* ------------------------- instanciation of MEM_WB ------------------------ */
MEM_WB u_mwm_wb(
    .clk            (clk            ),
    .rst_n          (rst_n          ),
    .stall          (stall          ),
    .MEM_pc_4       (MEM_pc_4       ),
    .MEM_inst       (MEM_inst       ),
    .MEM_memtoreg   (MEM_memtoreg   ),
    .MEM_regwrite   (MEM_regwrite   ),
    .MEM_regdst     (MEM_regdst     ),
    .MEM_link       (MEM_link       ),
    .MEM_data       (MEM_data       ),
    .MEM_wraddr     (MEM_wraddr     ),
    .WB_memtoreg    (WB_memtoreg    ),
    .WB_regwrite    (WB_regwrite    ),
    .WB_regdst      (WB_regdst      ),
    .WB_link        (WB_link        ),
    .WB_data        (WB_data        ),
    .WB_wraddr      (WB_wraddr      ),
    .WB_pc_4        (WB_pc_4        ),
    .WB_ins         (WB_ins         ),
);


// recover imexplicit wire
`default_nettype wire