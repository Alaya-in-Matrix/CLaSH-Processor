# README

* Author: lvwenlong_lambda@qq.com
* Last Modified:2015/12/31 17:48:35 周四

## 文件结构说明

* new_helloworld-src: 使用processor控制JTAG UART输出hello world的verilog代码。
    * jtag_uart_verilog/：QSys中 JTAG_UART模块生成的verilog。
    * Processor/: 使用CLaSH编写的processor编译生成的verilog代码。
    * processor_jtag_bridge.v: Processor的PIO到JTAG_UART的接口。
    * hello_world.bdf: 使用block symbol将上述三个模块连接起来的描述文件。
* fib_led: 使用processor的指令集编写的fibonacci函数的Quartus Procect。
    * Proc.v: 使用CLaSH编写的processor编译生成的verilog代码
    * fib_led.bdf: block symbol描述文件
    * fibonacci.csv: 管教分配文件

## Quartus 测试环境说明

* Quartus 版本: Quartus 15.1 Lite版本
* 测试开发板：DE2-115开发板
