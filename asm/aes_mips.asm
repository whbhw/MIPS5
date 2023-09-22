.data
input_file: 
#     0          4          8          12
.word 0x3243f6a8,0x885a308d,0x313198a2,0xe0370734	#0~
.word 0x2b7e1516,0x28aed2a6,0xabf71588,0x09cf4f3c	#16~
.word 0x637c777b,0xf26b6fc5,0x3001672b,0xfed7ab76	#32~
.word 0xca82c97d,0xfa5947f0,0xadd4a2af,0x9ca472c0	#48~
.word 0xb7fd9326,0x363ff7cc,0x34a5e5f1,0x71d83115	#64~
.word 0x04c723c3,0x1896059a,0x071280e2,0xeb27b275	#80~
.word 0x09832c1a,0x1b6e5aa0,0x523bd6b3,0x29e32f84	#96~
.word 0x53d100ed,0x20fcb15b,0x6acbbe39,0x4a4c58cf	#112~
.word 0xd0efaafb,0x434d3385,0x45f9027f,0x503c9fa8	#128~
.word 0x51a3408f,0x929d38f5,0xbcb6da21,0x10fff3d2	#144~
.word 0xcd0c13ec,0x5f974417,0xc4a77e3d,0x645d1973	#160~
.word 0x60814fdc,0x222a9088,0x46eeb814,0xde5e0bdb	#176~
.word 0xe0323a0a,0x4906245c,0xc2d3ac62,0x9195e479	#192~
.word 0xe7c8376d,0x8dd54ea9,0x6c56f4ea,0x657aae08	#208~
.word 0xba78252e,0x1ca6b4c6,0xe8dd741f,0x4bbd8b8a	#224~
.word 0x703eb566,0x4803f60e,0x613557b9,0x86c11d9e	#240~
.word 0xe1f89811,0x69d98e94,0x9b1e87e9,0xce5528df	#256~
.word 0x8ca1890d,0xbfe64268,0x41992d0f,0xb054bb16	#272~
.word 0x01000000,0x02000000,0x04000000,0x08000000	#288~
.word 0x10000000,0x20000000,0x40000000,0x80000000	#304~
.word 0x1b000000,0x36000000	

		
.text
la $k0,input_file
lw $s1,0($k0)
lw $s2,4($k0)
lw $s3,8($k0)
lw $s4,12($k0)
or $fp,$zero,$k0
or $t4,$zero,$zero
jal addroundkey
addi $t4,$t4,4
addi $t5,$zero,40
bne_back:jal subbytes
jal shiftrows
jal mixcolumns
jal addroundkey
addi $t4,$t4,4
bne $t5,$t4,bne_back
jal subbytes
jal shiftrows
jal addroundkey
finish:
beq $zero,$zero,finish

subword:or $t1,$t2,$zero
or $a1,$zero,$zero
bne_twothree:addi $a2,$zero,4
ori $a0,$zero,255
andi $at,$t1,3
andi $v0,$t1,252
add $v0,$v0,$k0
lw $v0,32($v0)
or $v1,$zero,$zero
beq $v1,$at,beq_one
addi $v1,$v1,1
beq $v1,$at,beq_two
addi $v1,$v1,1
beq $v1,$at,beq_three
and $v0,$v0,$a0
j j_one
beq_one:sll $a0,$a0,24
and $v0,$v0,$a0
srl $v0,$v0,24
j j_one
beq_two:sll $a0,$a0,16
and $v0,$v0,$a0
srl $v0,$v0,16
j j_one
beq_three:sll $a0,$a0,8
and $v0,$v0,$a0
srl $v0,$v0,8
j_one:addi $a0,$zero,-256
and $t3,$t3,$a0
or $t3,$t3,$v0
addi $a1,$a1,1
srl $a3,$t3,8
sll $t0,$t3,24
or $t3,$a3,$t0
srl $t1,$t1,8
bne $a2,$a1,bne_twothree
jr $ra
gernerate_roundkey:
beq $zero,$t4,beq_four
sll $at,$t8,8
srl $v0,$t8,24
or $t2,$at,$v0
sw $ra,728($fp)
addi $fp,$fp,4
jal subword
addi $fp,$fp,-4
lw $ra,728($fp)
add $t6,$t4,$k0
lw $at,284($t6)
xor $at,$t3,$at
xor $s5,$s5,$at
xor $s6,$s6,$s5
xor $s7,$s7,$s6
xor $t8,$t8,$s7
jr $ra
beq_four:lw $s5,16($k0)
lw $s6,20($k0)
lw $s7,24($k0)
lw $t8,28($k0)
jr $ra
mixonecolumn:or $at,$a2,$zero
and $a3,$zero,$zero
and $t2,$zero,$zero
ori $t3,$zero,4
bne_test:andi $v0,$at,255
andi $v1,$at,65280
srl $v1,$v1,8
xor $v0,$v0,$v1
lui $v1,255
and $v1,$at,$v1
srl $a1,$v1,16
srl $v1,$v1,15
andi $a0,$v1,255
bne $v1,$a0,bne_one
j_three:xor $v1,$v1,$a1
xor $v0,$v0,$v1
lui $v1,65280
and $v1,$at,$v1
srl $v1,$v1,23
andi $a0,$v1,255
bne $v1,$a0,beq_five
j j_two
bne_one:xori $v1,$a0,27
j j_three
beq_five:xori $v1,$a0,27
j_two:xor $v0,$v0,$v1
addi $t2,$t2,1
sll $a3,$a3,8
or $a3,$a3,$v0
sll $t0,$at,8
srl $t1,$at,24
or $at,$t0,$t1
bne $t3,$t2,bne_test
jr $ra
addroundkey:sw $ra,728($fp)
addi $fp,$fp,4
jal gernerate_roundkey
addi $fp,$fp,-4

lw $ra,728($fp)
xor $s1,$s1,$s5
xor $s2,$s2,$s6
xor $s3,$s3,$s7
xor $s4,$s4,$t8
jr $ra
subbytes:or $t2,$zero,$s1
sw $ra,728($fp)
addi $fp,$fp,4
jal subword
addi $fp,$fp,-4
lw $ra,728($fp)
or $s1,$zero,$t3
or $t2,$zero,$s2
sw $ra,728($fp)
addi $fp,$fp,4
jal subword
addi $fp,$fp,-4
lw $ra,728($fp)
or $s2,$zero,$t3
or $t2,$zero,$s3
sw $ra,728($fp)
addi $fp,$fp,4
jal subword
addi $fp,$fp,-4
lw $ra,728($fp)
or $s3,$zero,$t3
or $t2,$zero,$s4
sw $ra,728($fp)
addi $fp,$fp,4
jal subword
addi $fp,$fp,-4
lw $ra,728($fp)
or $s4,$zero,$t3
jr $ra
mixcolumns:or $a2,$zero,$s1
sw $ra,728($fp)
addi $fp,$fp,4
jal mixonecolumn
addi $fp,$fp,-4
lw $ra,728($fp)
or $s1,$zero,$a3
or $a2,$zero,$s2
sw $ra,728($fp)
addi $fp,$fp,4
jal mixonecolumn
addi $fp,$fp,-4
lw $ra,728($fp)
or $s2,$zero,$a3
or $a2,$zero,$s3
sw $ra,728($fp)
addi $fp,$fp,4
jal mixonecolumn
addi $fp,$fp,-4
lw $ra,728($fp)
or $s3,$zero,$a3
or $a2,$zero,$s4
sw $ra,728($fp)
addi $fp,$fp,4
jal mixonecolumn
addi $fp,$fp,-4
lw $ra,728($fp)
or $s4,$zero,$a3
jr $ra
shiftrows:lui $a2,255
lui $a3,65280
ori $a3,$a3,65535
ori $t0,$zero,65280
lui $t1,65535
ori $t1,$t1,255
ori $t2,$zero,255
lui $t3,65535
ori $t3,$t3,65280
and $a1,$s2,$a2
and $at,$s1,$a3
or $at,$at,$a1
and $a1,$s3,$t0
and $at,$at,$t1
or $at,$at,$a1
and $a1,$s4,$t2
and $at,$at,$t3
or $at,$at,$a1
and $a1,$s3,$a2
and $v0,$s2,$a3
or $v0,$v0,$a1
and $a1,$s4,$t0
and $v0,$v0,$t1
or $v0,$v0,$a1
and $a1,$s1,$t2
and $v0,$v0,$t3
or $v0,$v0,$a1
and $a1,$s4,$a2
and $v1,$s3,$a3
or $v1,$v1,$a1
and $a1,$s1,$t0
and $v1,$v1,$t1
or $v1,$v1,$a1
and $a1,$s2,$t2
and $v1,$v1,$t3
or $v1,$v1,$a1
and $a1,$s1,$a2
and $a0,$s4,$a3
or $a0,$a0,$a1
and $a1,$s2,$t0
and $a0,$a0,$t1
or $a0,$a0,$a1
and $a1,$s3,$t2
and $a0,$a0,$t3
or $a0,$a0,$a1
or $s1,$at,$zero
or $s2,$v0,$zero
or $s3,$v1,$zero
or $s4,$a0,$zero
jr $ra
