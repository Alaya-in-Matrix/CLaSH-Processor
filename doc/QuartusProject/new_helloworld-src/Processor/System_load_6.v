// Automatically generated Verilog-2001
module System_load_6(w_i1
                    ,w1_i2
                    ,ww_i3
                    ,ww1_i4
                    ,w2_i5
                    ,bodyVar_o);
  input [1:0] w_i1;
  input [4:0] w1_i2;
  input signed [15:0] ww_i3;
  input signed [15:0] ww1_i4;
  input [511:0] w2_i5;
  output [511:0] bodyVar_o;
  wire signed [31:0] wild_0;
  wire signed [31:0] repANF_1;
  wire signed [15:0] repANF_2;
  wire signed [15:0] altLet_3;
  wire signed [31:0] repANF_4;
  wire [511:0] tmp_5;
  wire signed [31:0] tmp_12;
  wire signed [15:0] tmp_14;
  // replaceVec start
  wire [511:0] vecflat_n_6;
  assign vecflat_n_6 = w2_i5;
  
  reg signed [15:0] vec_n_7 [0:32-1];
  integer n_8;
  always @(*) begin
    for (n_8=0;n_8<32;n_8=n_8+1) begin
      vec_n_7[32-1-n_8] = vecflat_n_6[n_8*16+:16];
    end
    vec_n_7[repANF_4] = repANF_2;
  end
  
  genvar n_9;
  generate
  for (n_9=0;n_9<32;n_9=n_9+1) begin : vec_n_10
    assign tmp_5[n_9*16+:16] = vec_n_7[(32-1)-n_9];
  end
  endgenerate
  // replaceVec end
  
  assign bodyVar_o = tmp_5;
  
  assign wild_0 = repANF_1;
  
  assign tmp_12 = $unsigned(w1_i2);
  
  assign repANF_1 = tmp_12;
  
  reg signed [15:0] repANF_2_reg;
  always @(*) begin
    case(w_i1)
      2'b11 : repANF_2_reg = ww1_i4;
      2'b10 : repANF_2_reg = altLet_3;
      2'b01 : repANF_2_reg = ww_i3;
      default : repANF_2_reg = 16'sd0;
    endcase
  end
  assign repANF_2 = repANF_2_reg;
  
  // indexVec begin
  wire signed [15:0] vec_n_15 [0:32-1];
  
  wire [511:0] vecflat_n_16;
  assign vecflat_n_16 = w2_i5;
  genvar n_17;
  generate
  for (n_17=0; n_17 < 32; n_17=n_17+1) begin : array_n_18
    assign vec_n_15[(32-1)-n_17] = vecflat_n_16[n_17*16+:16];
  end
  endgenerate
  
  assign tmp_14 = vec_n_15[repANF_4];
  // indexVec end
  
  assign altLet_3 = tmp_14;
  
  assign repANF_4 = wild_0;
endmodule
