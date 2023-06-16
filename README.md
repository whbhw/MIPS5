# MIPS5

## 描述

THU Computer Organization and Design Project

## 注意事项

未实现所有MIPS指令，所支持指令共21条，见./material.md
所实现的跳转和分支指令，均不要求编译器在其后添加slot
jal指令由于没有slot，返回时到达下一条指令（PC+4），而非下两条指令（PC+8）

复位时寄存器堆RF全部自动归零，指令PC从地址0x00400000开始

## 分工

### whb

| 设计 | 验证 |
| ---- | ---- |
| CTRL | ALU, ALUCTRL |
| RF, EXTEND |
| 单周期结构框图 | CPU_TOP_SINGLE调试 |
| FWDPU, HZDPU |
| 流水线结构框图 | CPU_TOP调试 |

### dyy

| 设计 | 验证 |
| ---- | ---- |
| ALU, ALUCTRL | CTRL |
| PC |
| CPU_TOP_SINGLE |
| 段间寄存器 |
| CPU_TOP |
