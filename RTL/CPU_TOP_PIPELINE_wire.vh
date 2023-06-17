//
wire    [31:0]  IF_pc      ;
wire    [31:0]  IF_pc_4    ;
wire    [31:0]  IF_pc_next ;
wire    [31:0]  IF_inst     ;

//
wire    [1:0]   pcop        ;
wire    [2:0]   flush       ;
wire            stall       ;

wire            ID_jnjr     ;
wire            EX_bjjr     ;
wire            hzdlu       ;

//
wire    [8:0]   ID_pc_4     ;
wire    [31:0]  ID_inst     ;

//
wire    [31:0]  ID_data1    ;
wire    [31:0]  ID_data2    ;
wire    [31:0]  WB_data     ;

//
wire    [31:0]  ID_extend   ;

//
wire            ID_signext     ;   // 符号扩展(1符号,0无符号)
wire    [1:0]   ID_aluop       ;   // alu初步控制编码
wire            ID_alusrc      ;   // alu输入来源选择
wire            ID_memread     ;   // 数据内存读取控制
wire            ID_memwrite    ;   // 数据内存写入控制
wire            ID_memtoreg    ;   // 数据寄存器写入来源选择
wire            ID_regread1    ;   // 数据寄存器读取1标志
wire            ID_regread2    ;   // 数据寄存器读取2标志
wire            ID_regwrite    ;   // 数据寄存器写入控制
wire            ID_regdst      ;   // 数据寄存器写入地址来源选择
wire            ID_branch      ;   // 分支指令标志
wire            ID_branchne    ;   // bne(1)/beq(0)标志,前提branch有效
wire            ID_jump        ;   // 跳转指令标志
wire            ID_jumpr       ;   // jr标志,前提jump有效
wire            ID_link        ;   // jal标志,前提jump有效
wire    [5:0]   ID_opcode      ;   // 指令opcode部分输入
wire    [5:0]   ID_funct       ;   // 指令funct部分输入

//
wire    [8:0]   ID_wraddr      ;
wire    [8:0]   EX_wraddr      ;

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

//
wire    [3:0]   alu_ctrl;
wire    [5:0]   alu_input; // the input for alu_ctrl

//
wire    [31:0]  EX_alu_res ;
wire            EX_zero    ;
wire    [31:0]  alu_data1  ;
wire    [31:0]  alu_data2  ; //立即数通道

//
wire    [31:0]  EX_data     ;
wire    [8:0]   EX_address  ;

wire            MEM_memread ; //useless signal
wire            MEM_memwrite;
wire            MEM_memtoreg;
wire            MEM_regwrite;
wire            MEM_regdst  ;
wire            MEM_link    ;
wire    [8:0]   MEM_wraddr  ;
wire    [8:0]   MEM_pc_4    ;
wire    [31:0]  MEM_inst    ;


//
wire    [31:0]  datamem_out ;

//
wire    [31:0]  MEM_data    ;
wire            WB_memtoreg ;
wire            WB_regwrite ;
wire            WB_regdst   ;
wire            WB_link     ;
wire    [8:0]   WB_wraddr   ;
wire    [31:0]  WB_data     ;
wire    [8:0]   WB_pc_4     ;
wire    [31:0]  WB_ins      ;