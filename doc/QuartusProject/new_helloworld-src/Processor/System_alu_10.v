// Automatically generated Verilog-2001
module System_alu_10(w_i1
                    ,ww_i2
                    ,ww1_i3
                    ,bodyVar_o);
  input [4:0] w_i1;
  input signed [15:0] ww_i2;
  input signed [15:0] ww1_i3;
  output [16:0] bodyVar_o;
  wire [15:0] repANF_0;
  wire [0:0] repANF_1;
  wire [0:0] repANF_2;
  wire [0:0] subjLet_3;
  wire [0:0] subjLet_4;
  wire [0:0] subjLet_5;
  wire [0:0] subjLet_6;
  wire [0:0] subjLet_7;
  wire [0:0] subjLet_8;
  wire signed [15:0] altLet_9;
  wire signed [15:0] altLet_10;
  wire signed [15:0] altLet_11;
  wire signed [15:0] altLet_12;
  wire signed [15:0] altLet_13;
  wire signed [15:0] altLet_14;
  wire signed [15:0] altLet_15;
  wire signed [15:0] altLet_16;
  wire signed [15:0] altLet_17;
  wire signed [15:0] altLet_18;
  wire signed [15:0] altLet_19;
  wire signed [15:0] altLet_20;
  wire signed [15:0] altLet_21;
  wire signed [15:0] altLet_22;
  wire signed [15:0] altLet_23;
  wire signed [15:0] altLet_24;
  wire signed [15:0] opRet_25;
  wire [0:0] tmp_27;
  assign repANF_0 = opRet_25;
  
  // indexBit begin
  wire [15:0] vec_n_28;
  assign vec_n_28 = repANF_0;
  
  assign tmp_27 = vec_n_28[32'sd0];
  // indexBit end
  
  assign repANF_1 = tmp_27;
  
  assign repANF_2 = repANF_1 == 1'b1;
  
  assign subjLet_3 = ww_i2 == ww1_i3;
  
  assign subjLet_4 = ww_i2 != ww1_i3;
  
  assign subjLet_5 = ww_i2 < ww1_i3;
  
  assign subjLet_6 = ww_i2 > ww1_i3;
  
  assign subjLet_7 = ww_i2 <= ww1_i3;
  
  assign subjLet_8 = ww_i2 >= ww1_i3;
  
  assign altLet_9 = ww_i2 + 16'sd1;
  
  assign altLet_10 = ww_i2 - 16'sd1;
  
  assign altLet_11 = -ww_i2;
  
  assign altLet_12 = ~ ww_i2;
  
  assign altLet_13 = ww_i2 + ww1_i3;
  
  assign altLet_14 = ww_i2 - ww1_i3;
  
  assign altLet_15 = ww_i2 * ww1_i3;
  
  reg signed [15:0] altLet_16_reg;
  always @(*) begin
    if(subjLet_3)
      altLet_16_reg = 16'sd1;
    else
      altLet_16_reg = 16'sd0;
  end
  assign altLet_16 = altLet_16_reg;
  
  reg signed [15:0] altLet_17_reg;
  always @(*) begin
    if(subjLet_4)
      altLet_17_reg = 16'sd1;
    else
      altLet_17_reg = 16'sd0;
  end
  assign altLet_17 = altLet_17_reg;
  
  reg signed [15:0] altLet_18_reg;
  always @(*) begin
    if(subjLet_5)
      altLet_18_reg = 16'sd1;
    else
      altLet_18_reg = 16'sd0;
  end
  assign altLet_18 = altLet_18_reg;
  
  reg signed [15:0] altLet_19_reg;
  always @(*) begin
    if(subjLet_6)
      altLet_19_reg = 16'sd1;
    else
      altLet_19_reg = 16'sd0;
  end
  assign altLet_19 = altLet_19_reg;
  
  reg signed [15:0] altLet_20_reg;
  always @(*) begin
    if(subjLet_7)
      altLet_20_reg = 16'sd1;
    else
      altLet_20_reg = 16'sd0;
  end
  assign altLet_20 = altLet_20_reg;
  
  reg signed [15:0] altLet_21_reg;
  always @(*) begin
    if(subjLet_8)
      altLet_21_reg = 16'sd1;
    else
      altLet_21_reg = 16'sd0;
  end
  assign altLet_21 = altLet_21_reg;
  
  assign altLet_22 = ww_i2 & ww1_i3;
  
  assign altLet_23 = ww_i2 | ww1_i3;
  
  assign altLet_24 = ww_i2 ^ ww1_i3;
  
  reg signed [15:0] opRet_25_reg;
  always @(*) begin
    case(w_i1)
      5'b10001 : opRet_25_reg = altLet_24;
      5'b10000 : opRet_25_reg = altLet_23;
      5'b01111 : opRet_25_reg = altLet_22;
      5'b01110 : opRet_25_reg = altLet_21;
      5'b01101 : opRet_25_reg = altLet_20;
      5'b01100 : opRet_25_reg = altLet_19;
      5'b01011 : opRet_25_reg = altLet_18;
      5'b01010 : opRet_25_reg = altLet_17;
      5'b01001 : opRet_25_reg = altLet_16;
      5'b01000 : opRet_25_reg = altLet_15;
      5'b00111 : opRet_25_reg = altLet_14;
      5'b00110 : opRet_25_reg = altLet_13;
      5'b00101 : opRet_25_reg = altLet_12;
      5'b00100 : opRet_25_reg = altLet_11;
      5'b00011 : opRet_25_reg = altLet_10;
      5'b00010 : opRet_25_reg = altLet_9;
      5'b00001 : opRet_25_reg = ww_i2;
      default : opRet_25_reg = 16'sd0;
    endcase
  end
  assign opRet_25 = opRet_25_reg;
  
  assign bodyVar_o = {opRet_25
                     ,repANF_2};
endmodule
