onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_CPU_TOP_SINGLE_/clk
add wave -noupdate /TB_CPU_TOP_SINGLE_/rst_n
add wave -noupdate -radix hexadecimal -childformat {{{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[0]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[1]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[2]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[3]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[4]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[5]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[6]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[7]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[8]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[9]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[10]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[11]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[12]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[13]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[14]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[15]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[16]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[17]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[18]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[19]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[20]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[21]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[22]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[23]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[24]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[25]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[26]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[27]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[28]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[29]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[30]} -radix hexadecimal} {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[31]} -radix hexadecimal}} -subitemconfig {{/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[0]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[1]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[2]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[3]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[4]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[5]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[6]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[7]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[8]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[9]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[10]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[11]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[12]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[13]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[14]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[15]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[16]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[17]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[18]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[19]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[20]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[21]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[22]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[23]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[24]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[25]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[26]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[27]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[28]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[29]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[30]} {-height 15 -radix hexadecimal} {/TB_CPU_TOP_SINGLE_/uut/u_rf/regfile[31]} {-height 15 -radix hexadecimal}} /TB_CPU_TOP_SINGLE_/uut/u_rf/regfile
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/pc
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/pc_4
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/pc_next
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/address
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/inst
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/signext
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/aluop
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/alusrc
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/memread
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/memwrite
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/memtoreg
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/regwrite
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/regdst
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/branch
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/branchne
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/jump
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/jumpr
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/link
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/opcode
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/funct
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/rd1addr
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/rd1data
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/rd2addr
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/rd2data
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/wraddr
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/wrdata
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/wren_rf
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/extend_out
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/extend_in
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/alu_ctrl
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/alu_input
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/alu_res
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/zero
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/data1
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/data2
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/shamt
add wave -noupdate /TB_CPU_TOP_SINGLE_/uut/wen
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/address_mem
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/din_mem
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/dout_mem
add wave -noupdate -radix hexadecimal /TB_CPU_TOP_SINGLE_/uut/pc_combine
add wave -noupdate -radix decimal /TB_CPU_TOP_SINGLE_/uut/add_2_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {956147 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 255
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {761463 ps} {1127582 ps}
