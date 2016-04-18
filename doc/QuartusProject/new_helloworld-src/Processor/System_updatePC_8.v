// Automatically generated Verilog-2001
module System_updatePC_8(ww_i1
                        ,ww1_i2
                        ,ww2_i3
                        ,ww3_i4
                        ,ww4_i5
                        ,topLet_o);
  input [2:0] ww_i1;
  input [0:0] ww1_i2;
  input signed [7:0] ww2_i3;
  input signed [7:0] ww3_i4;
  input signed [15:0] ww4_i5;
  output signed [7:0] topLet_o;
  wire signed [7:0] altLet_0;
  wire signed [7:0] altLet_1;
  wire signed [7:0] altLet_2;
  wire signed [31:0] repANF_3;
  wire signed [7:0] altLet_4;
  wire signed [7:0] altLet_5;
  wire signed [31:0] tmp_7;
  reg signed [7:0] topLet_o_reg;
  always @(*) begin
    case(ww_i1)
      3'b101 : topLet_o_reg = altLet_0;
      3'b100 : topLet_o_reg = altLet_1;
      3'b011 : topLet_o_reg = altLet_2;
      3'b010 : topLet_o_reg = altLet_4;
      3'b001 : topLet_o_reg = ww3_i4;
      default : topLet_o_reg = altLet_5;
    endcase
  end
  assign topLet_o = topLet_o_reg;
  
  assign altLet_0 = $signed(repANF_3);
  
  reg signed [7:0] altLet_1_reg;
  always @(*) begin
    if(ww1_i2)
      altLet_1_reg = altLet_4;
    else
      altLet_1_reg = altLet_5;
  end
  assign altLet_1 = altLet_1_reg;
  
  reg signed [7:0] altLet_2_reg;
  always @(*) begin
    if(ww1_i2)
      altLet_2_reg = ww3_i4;
    else
      altLet_2_reg = altLet_5;
  end
  assign altLet_2 = altLet_2_reg;
  
  assign tmp_7 = $signed(ww4_i5);
  
  assign repANF_3 = tmp_7;
  
  assign altLet_4 = ww2_i3 + ww3_i4;
  
  assign altLet_5 = ww2_i3 + 8'sd1;
endmodule
