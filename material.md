# 资料

## 指令

|inst   |codehex|codebin|   |inst   |codehex|codebin|
|------:|------:|------:|---|------:|------:|------:|
|lw     |23     |100011 |   |sw     |2b     |101011 |
||
|add    |00/20  |/100000|   |addi   |08     |001000 |
|~~addu*~~|00/21|/100001|   |addiu  |09     |001001 |
|sub    |00/22  |/100010|   |~~slti*~~|0a   |001010 |
|~~subu*~~|00/23|/100011|   |~~sltiu*~~|0b  |001011 |
|and    |00/24  |/100100|   |andi   |0c     |001100 |
|or     |00/25  |/100101|   |ori    |0d     |001101 |
|xor    |00/26  |/100110|   |xori   |0e     |001110 |
|~~nor*~~|00/27 |/100111|   |lui    |0f     |001111 |
|slt    |00/2a  |/101010|
|sll    |00/00  |/000000|
|srl    |00/02  |/000010|
||
|beq    |04     |000100 |   |bne    |05     |000101 |
||
|j      |02     |000010 |
|jal    |03     |000011 |
|jr     |00/08  |/001000|

## 单周期

![png](./设计-单周期.png)
![png](./material/单周期.png)

## 流水线

![png](./material/流水线.png)

## 控制编码

<https://www.elsevier.com/__data/assets/pdf_file/0011/1191377/Appendix-D.PDF>
![png](./material/ALUctrl.png)
![png](./material/ctrl.png)
