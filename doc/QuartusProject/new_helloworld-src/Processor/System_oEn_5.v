// Automatically generated Verilog-2001
module System_oEn_5(bufLast_i1
                   ,toReg_i2
                   ,ldCode_i3
                   ,topLet_o);
  input [4:0] bufLast_i1;
  input [4:0] toReg_i2;
  input [1:0] ldCode_i3;
  output [0:0] topLet_o;
  wire [0:0] altLet_0;
  wire [0:0] altLet_1;
  reg [0:0] altLet_0_reg;
  always @(*) begin
    case(ldCode_i3)
      2'b11 : altLet_0_reg = 1'b1;
      2'b01 : altLet_0_reg = 1'b1;
      default : altLet_0_reg = 1'b0;
    endcase
  end
  assign altLet_0 = altLet_0_reg;
  
  reg [0:0] altLet_1_reg;
  always @(*) begin
    case(toReg_i2)
      5'd4 : altLet_1_reg = altLet_0;
      default : altLet_1_reg = 1'b0;
    endcase
  end
  assign altLet_1 = altLet_1_reg;
  
  reg [0:0] topLet_o_reg;
  always @(*) begin
    case(bufLast_i1)
      5'd4 : topLet_o_reg = 1'b1;
      default : topLet_o_reg = altLet_1;
    endcase
  end
  assign topLet_o = topLet_o_reg;
endmodule
