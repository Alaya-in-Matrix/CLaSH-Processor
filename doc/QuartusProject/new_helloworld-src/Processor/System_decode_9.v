// Automatically generated Verilog-2001
module System_decode_9(sp_i1
                      ,instr_i2
                      ,topLet_o);
  input [6:0] sp_i1;
  input [26:0] instr_i2;
  output [83:0] topLet_o;
  wire [83:0] altLet_0;
  wire [6:0] a52_1;
  wire [83:0] altLet_2;
  wire signed [15:0] n_3;
  wire [83:0] altLet_4;
  wire [4:0] r_5;
  wire [83:0] altLet_6;
  wire signed [15:0] n_7;
  wire [6:0] repANF_8;
  wire [83:0] altLet_9;
  wire [4:0] op_10;
  wire [4:0] r0_11;
  wire [4:0] r1_12;
  wire [4:0] r2_13;
  wire [83:0] altLet_14;
  wire [2:0] jType_15;
  wire signed [7:0] jAddr_16;
  wire [83:0] altLet_17;
  wire [16:0] ds4_18;
  wire [4:0] rid_19;
  wire [83:0] altLet_20;
  wire [16:0] ds4_21;
  wire [6:0] a52_22;
  wire [83:0] altLet_23;
  wire [4:0] r_24;
  wire [83:0] altLet_25;
  wire [4:0] r_26;
  assign altLet_0 = {2'd2
                    ,2'd0
                    ,5'd0
                    ,3'd0
                    ,2'd0
                    ,16'sd0
                    ,16'sd0
                    ,5'd0
                    ,5'd0
                    ,rid_19
                    ,7'd0
                    ,a52_1
                    ,1'b0
                    ,8'sd0};
  
  assign a52_1 = ds4_18[15:9];
  
  assign altLet_2 = {2'd1
                    ,2'd0
                    ,5'd0
                    ,3'd0
                    ,2'd0
                    ,n_3
                    ,16'sd0
                    ,5'd0
                    ,5'd0
                    ,rid_19
                    ,7'd0
                    ,7'd0
                    ,1'b0
                    ,8'sd0};
  
  assign n_3 = ds4_18[15:0];
  
  assign altLet_4 = {2'd0
                    ,2'd2
                    ,5'd0
                    ,3'd0
                    ,2'd0
                    ,16'sd0
                    ,16'sd0
                    ,r_5
                    ,5'd0
                    ,5'd0
                    ,a52_22
                    ,7'd0
                    ,1'b1
                    ,8'sd0};
  
  assign r_5 = ds4_21[15:11];
  
  assign altLet_6 = {2'd0
                    ,2'd1
                    ,5'd0
                    ,3'd0
                    ,2'd0
                    ,16'sd0
                    ,n_7
                    ,5'd0
                    ,5'd0
                    ,5'd0
                    ,a52_22
                    ,7'd0
                    ,1'b1
                    ,8'sd0};
  
  assign n_7 = ds4_21[15:0];
  
  assign repANF_8 = sp_i1 + 7'd1;
  
  assign altLet_9 = {2'd3
                    ,2'd0
                    ,op_10
                    ,3'd0
                    ,2'd0
                    ,16'sd0
                    ,16'sd0
                    ,r0_11
                    ,r1_12
                    ,r2_13
                    ,7'd0
                    ,7'd0
                    ,1'b0
                    ,8'sd0};
  
  assign op_10 = instr_i2[23:19];
  
  assign r0_11 = instr_i2[18:14];
  
  assign r1_12 = instr_i2[13:9];
  
  assign r2_13 = instr_i2[8:4];
  
  assign altLet_14 = {2'd0
                     ,2'd0
                     ,5'd0
                     ,jType_15
                     ,2'd0
                     ,16'sd0
                     ,16'sd0
                     ,5'd0
                     ,5'd0
                     ,5'd0
                     ,7'd0
                     ,7'd0
                     ,1'b0
                     ,jAddr_16};
  
  assign jType_15 = instr_i2[23:21];
  
  assign jAddr_16 = instr_i2[20:13];
  
  reg [83:0] altLet_17_reg;
  always @(*) begin
    case(ds4_18[16:16])
      1'b1 : altLet_17_reg = altLet_2;
      default : altLet_17_reg = altLet_0;
    endcase
  end
  assign altLet_17 = altLet_17_reg;
  
  assign ds4_18 = instr_i2[23:7];
  
  assign rid_19 = instr_i2[6:2];
  
  reg [83:0] altLet_20_reg;
  always @(*) begin
    case(ds4_21[16:16])
      1'b1 : altLet_20_reg = altLet_6;
      default : altLet_20_reg = altLet_4;
    endcase
  end
  assign altLet_20 = altLet_20_reg;
  
  assign ds4_21 = instr_i2[23:7];
  
  assign a52_22 = instr_i2[6:0];
  
  assign altLet_23 = {2'd0
                     ,2'd2
                     ,5'd0
                     ,3'd0
                     ,2'd1
                     ,16'sd0
                     ,16'sd0
                     ,r_24
                     ,5'd0
                     ,5'd0
                     ,repANF_8
                     ,7'd0
                     ,1'b1
                     ,8'sd0};
  
  assign r_24 = instr_i2[23:19];
  
  assign altLet_25 = {2'd2
                     ,2'd0
                     ,5'd0
                     ,3'd0
                     ,2'd2
                     ,16'sd0
                     ,16'sd0
                     ,5'd0
                     ,5'd0
                     ,r_26
                     ,7'd0
                     ,sp_i1
                     ,1'b0
                     ,8'sd0};
  
  assign r_26 = instr_i2[23:19];
  
  reg [83:0] topLet_o_reg;
  always @(*) begin
    case(instr_i2[26:24])
      3'b110 : topLet_o_reg = {2'd0
                              ,2'd0
                              ,5'd0
                              ,3'd2
                              ,2'd0
                              ,16'sd0
                              ,16'sd0
                              ,5'd0
                              ,5'd0
                              ,5'd0
                              ,7'd0
                              ,7'd0
                              ,1'b0
                              ,8'sd0};
      3'b101 : topLet_o_reg = altLet_25;
      3'b100 : topLet_o_reg = altLet_23;
      3'b011 : topLet_o_reg = altLet_20;
      3'b010 : topLet_o_reg = altLet_17;
      3'b001 : topLet_o_reg = altLet_14;
      default : topLet_o_reg = altLet_9;
    endcase
  end
  assign topLet_o = topLet_o_reg;
endmodule
