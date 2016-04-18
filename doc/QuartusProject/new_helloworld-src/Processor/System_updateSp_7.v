// Automatically generated Verilog-2001
module System_updateSp_7(ds4_i1
                        ,sp_i2
                        ,topLet_o);
  input [1:0] ds4_i1;
  input [6:0] sp_i2;
  output [6:0] topLet_o;
  wire [6:0] altLet_0;
  wire [6:0] altLet_1;
  assign altLet_0 = sp_i2 + 7'd1;
  
  assign altLet_1 = sp_i2 - 7'd1;
  
  reg [6:0] topLet_o_reg;
  always @(*) begin
    case(ds4_i1)
      2'b10 : topLet_o_reg = altLet_1;
      2'b01 : topLet_o_reg = altLet_0;
      default : topLet_o_reg = sp_i2;
    endcase
  end
  assign topLet_o = topLet_o_reg;
endmodule
