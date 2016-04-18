// Automatically generated Verilog-2001
module Processor(iEn
                ,PIn
                ,// clock
                system1000
                ,// asynchronous reset: active low
                system1000_rstn
                ,oEn
                ,POut);
  input [0:0] iEn;
  input signed [15:0] PIn;
  input system1000;
  input system1000_rstn;
  output [0:0] oEn;
  output signed [15:0] POut;
  wire [16:0] input_0;
  wire [16:0] output_0;
  assign input_0 = {iEn,PIn};
  
  System_topEntity_0 System_topEntity_0_inst
  (.eta_i1 (input_0)
  ,.system1000 (system1000)
  ,.system1000_rstn (system1000_rstn)
  ,.topLet_o (output_0));
  
  assign oEn = output_0[16:16];
  
  assign POut = output_0[15:0];
endmodule
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
  wire signed [15:0] altLet_25;
  wire signed [15:0] altLet_26;
  wire signed [15:0] opRet_27;
  wire [0:0] tmp_29;
  wire signed [15:0] tmp_48;
  wire signed [15:0] tmp_52;
  assign repANF_0 = opRet_27;
  
  // indexBit begin
  wire [15:0] vec_n_30;
  assign vec_n_30 = repANF_0;
  
  assign tmp_29 = vec_n_30[32'sd0];
  // indexBit end
  
  assign repANF_1 = tmp_29;
  
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
  
  // divInt begin
  wire signed [15:0] n_49;
  wire signed [15:0] n_50;
  wire signed [15:0] n_51;
  
  // divide (rounds towards zero)
  assign n_49 = ww_i2 / ww1_i3;
  
  // round toward minus infinity
  assign n_50 = ww_i2;
  assign n_51 = ww1_i3;
  assign tmp_48 = (n_50[16-1] == n_51[16-1]) ? n_49 : n_49 - 16'sd1;
  // divInt end
  
  assign altLet_16 = tmp_48;
  
  // modSigned begin
  wire signed [15:0] n_53;
  wire signed [15:0] n_54;
  wire signed [15:0] n_55;
  
  // remainder
  assign n_53 = ww_i2 % ww1_i3;
  
  // modulo
  assign n_54 = ww_i2;
  assign n_55 = ww1_i3;
  assign tmp_52 = (n_54[16-1] == n_55[16-1]) ?
                   n_53 :
                   (n_54 == 16'sd0 ? 16'sd0 : n_53 + n_54);
  // modSigned end
  
  assign altLet_17 = tmp_52;
  
  reg signed [15:0] altLet_18_reg;
  always @(*) begin
    if(subjLet_3)
      altLet_18_reg = 16'sd1;
    else
      altLet_18_reg = 16'sd0;
  end
  assign altLet_18 = altLet_18_reg;
  
  reg signed [15:0] altLet_19_reg;
  always @(*) begin
    if(subjLet_4)
      altLet_19_reg = 16'sd1;
    else
      altLet_19_reg = 16'sd0;
  end
  assign altLet_19 = altLet_19_reg;
  
  reg signed [15:0] altLet_20_reg;
  always @(*) begin
    if(subjLet_5)
      altLet_20_reg = 16'sd1;
    else
      altLet_20_reg = 16'sd0;
  end
  assign altLet_20 = altLet_20_reg;
  
  reg signed [15:0] altLet_21_reg;
  always @(*) begin
    if(subjLet_6)
      altLet_21_reg = 16'sd1;
    else
      altLet_21_reg = 16'sd0;
  end
  assign altLet_21 = altLet_21_reg;
  
  reg signed [15:0] altLet_22_reg;
  always @(*) begin
    if(subjLet_7)
      altLet_22_reg = 16'sd1;
    else
      altLet_22_reg = 16'sd0;
  end
  assign altLet_22 = altLet_22_reg;
  
  reg signed [15:0] altLet_23_reg;
  always @(*) begin
    if(subjLet_8)
      altLet_23_reg = 16'sd1;
    else
      altLet_23_reg = 16'sd0;
  end
  assign altLet_23 = altLet_23_reg;
  
  assign altLet_24 = ww_i2 & ww1_i3;
  
  assign altLet_25 = ww_i2 | ww1_i3;
  
  assign altLet_26 = ww_i2 ^ ww1_i3;
  
  reg signed [15:0] opRet_27_reg;
  always @(*) begin
    case(w_i1)
      5'b10011 : opRet_27_reg = altLet_26;
      5'b10010 : opRet_27_reg = altLet_25;
      5'b10001 : opRet_27_reg = altLet_24;
      5'b10000 : opRet_27_reg = altLet_23;
      5'b01111 : opRet_27_reg = altLet_22;
      5'b01110 : opRet_27_reg = altLet_21;
      5'b01101 : opRet_27_reg = altLet_20;
      5'b01100 : opRet_27_reg = altLet_19;
      5'b01011 : opRet_27_reg = altLet_18;
      5'b01010 : opRet_27_reg = altLet_17;
      5'b01001 : opRet_27_reg = altLet_16;
      5'b01000 : opRet_27_reg = altLet_15;
      5'b00111 : opRet_27_reg = altLet_14;
      5'b00110 : opRet_27_reg = altLet_13;
      5'b00101 : opRet_27_reg = altLet_12;
      5'b00100 : opRet_27_reg = altLet_11;
      5'b00011 : opRet_27_reg = altLet_10;
      5'b00010 : opRet_27_reg = altLet_9;
      5'b00001 : opRet_27_reg = ww_i2;
      default : opRet_27_reg = 16'sd0;
    endcase
  end
  assign opRet_27 = opRet_27_reg;
  
  assign bodyVar_o = {opRet_27
                     ,repANF_2};
endmodule
// Automatically generated Verilog-2001
module System_BundleZ2T1_3(eta_i1
                          ,topLet_o);
  input [588:0] eta_i1;
  output [588:0] topLet_o;
  wire [532:0] repANF_0;
  wire [55:0] repANF_1;
  wire [532:0] x_2;
  wire [55:0] y_3;
  assign repANF_0 = x_2;
  
  assign repANF_1 = y_3;
  
  assign x_2 = eta_i1[588:56];
  
  assign y_3 = eta_i1[55:0];
  
  assign topLet_o = {repANF_0
                    ,repANF_1};
endmodule
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
// Automatically generated Verilog-2001
module System_esprockellMealy_4(w_i1
                               ,ww_i2
                               ,ww1_i3
                               ,ww2_i4
                               ,ww3_i5
                               ,bodyVar_o);
  input [532:0] w_i1;
  input [26:0] ww_i2;
  input signed [15:0] ww1_i3;
  input [0:0] ww2_i4;
  input signed [15:0] ww3_i5;
  output [588:0] bodyVar_o;
  wire [532:0] repANF_0;
  wire [55:0] repANF_1;
  wire [0:0] repANF_2;
  wire [6:0] repANF_3;
  wire [4:0] repANF_4;
  wire [6:0] repANF_5;
  wire [6:0] repANF_6;
  wire [0:0] repANF_7;
  wire signed [15:0] repANF_8;
  wire [0:0] repANF_9;
  wire signed [15:0] repANF_10;
  wire signed [7:0] pczm_11;
  wire [511:0] regzm_12;
  wire [0:0] subjLet_13;
  wire [0:0] altLet_14;
  wire [6:0] altLet_15;
  wire [9:0] subjLet_16;
  wire signed [15:0] altLet_17;
  wire signed [7:0] altLet_18;
  wire signed [15:0] repANF_19;
  wire signed [15:0] repANF_20;
  wire [511:0] reg0_21;
  wire [4:0] bufLast_22;
  wire [1:0] ldCode_23;
  wire [4:0] toReg_24;
  wire [83:0] ds4_25;
  wire signed [31:0] subjLet_26;
  wire [0:0] altLet_27;
  wire [1:0] ds10_28;
  wire [9:0] repANF_29;
  wire [4:0] x_30;
  wire [6:0] ds16_31;
  wire [6:0] ds17_32;
  wire [0:0] ds18_33;
  wire [1:0] ds7_34;
  wire signed [15:0] ds12_35;
  wire [0:0] repANF_36;
  wire signed [15:0] repANF_37;
  wire [2:0] ds9_38;
  wire signed [7:0] ds19_39;
  wire [16:0] ds5_40;
  wire [4:0] fromReg0_41;
  wire [511:0] bodyVar_42;
  wire [4:0] ldBuf_43;
  wire signed [7:0] pc_44;
  wire [6:0] sp_45;
  wire [4:0] repANF_46;
  wire signed [15:0] ds11_47;
  wire signed [15:0] aluOut_48;
  wire signed [15:0] repANF_49;
  wire signed [15:0] bodyVar_50;
  wire [511:0] repANF_51;
  wire signed [15:0] repANF_52;
  wire [4:0] opCode_53;
  wire [1:0] ds5_54;
  wire [4:0] ds14_55;
  wire [0:0] aluOut_56;
  wire [4:0] repANF_57;
  wire [0:0] ds21_58;
  wire signed [15:0] bodyVar_59;
  wire signed [31:0] repANF_60;
  wire [4:0] ds12_61;
  wire [511:0] repANF_62;
  wire signed [31:0] repANF_63;
  wire [4:0] ds9_64;
  wire signed [7:0] ds7_65;
  wire [6:0] ds7_66;
  wire signed [31:0] repANF_67;
  wire signed [31:0] wild_68;
  wire [511:0] repANF_69;
  wire signed [15:0] repANF_70;
  wire [4:0] ds7_71;
  wire signed [31:0] wild_72;
  wire signed [31:0] repANF_73;
  wire [511:0] repANF_74;
  wire signed [31:0] repANF_75;
  wire signed [31:0] repANF_76;
  wire signed [31:0] repANF_77;
  wire [511:0] ds5_78;
  wire [4:0] ds14_79;
  wire signed [31:0] wild_80;
  wire signed [31:0] repANF_81;
  wire signed [15:0] tmp_82;
  wire [4:0] tmp_92;
  wire [4:0] tmp_dtt_rhs_94;
  wire signed [31:0] tmp_dtt_95;
  wire signed [15:0] tmp_97;
  wire [511:0] tmp_102;
  wire signed [15:0] tmp_108;
  wire [511:0] tmp_113;
  wire signed [15:0] tmp_122;
  wire [511:0] tmp_127;
  wire signed [31:0] tmp_133;
  wire [511:0] tmp_135;
  wire signed [31:0] tmp_143;
  wire [511:0] tmp_144;
  wire signed [31:0] tmp_150;
  wire signed [31:0] tmp_152;
  wire signed [31:0] tmp_154;
  wire signed [31:0] tmp_156;
  assign bodyVar_o = {repANF_0
                     ,repANF_1};
  
  assign repANF_0 = {regzm_12
                    ,repANF_2
                    ,pczm_11
                    ,repANF_3
                    ,repANF_4};
  
  assign repANF_1 = {repANF_5
                    ,repANF_6
                    ,repANF_7
                    ,repANF_8
                    ,pczm_11
                    ,repANF_9
                    ,repANF_10};
  
  reg [0:0] repANF_2_reg;
  always @(*) begin
    if(subjLet_13)
      repANF_2_reg = ww2_i4;
    else
      repANF_2_reg = altLet_14;
  end
  assign repANF_2 = repANF_2_reg;
  
  assign repANF_3 = altLet_15;
  
  assign repANF_4 = x_30;
  
  assign repANF_5 = ds16_31;
  
  assign repANF_6 = ds17_32;
  
  assign repANF_7 = ds18_33;
  
  assign repANF_8 = altLet_17;
  
  System_oEn_5 System_oEn_5_repANF_9
  (.topLet_o (repANF_9)
  ,.bufLast_i1 (bufLast_22)
  ,.toReg_i2 (toReg_24)
  ,.ldCode_i3 (ldCode_23));
  
  // indexVec begin
  wire signed [15:0] vec_n_83 [0:32-1];
  
  wire [511:0] vecflat_n_84;
  assign vecflat_n_84 = regzm_12;
  genvar n_85;
  generate
  for (n_85=0; n_85 < 32; n_85=n_85+1) begin : array_n_86
    assign vec_n_83[(32-1)-n_85] = vecflat_n_84[n_85*16+:16];
  end
  endgenerate
  
  assign tmp_82 = vec_n_83[32'sd4];
  // indexVec end
  
  assign repANF_10 = tmp_82;
  
  assign pczm_11 = altLet_18;
  
  System_load_6 System_load_6_regzm_12
  (.bodyVar_o (regzm_12)
  ,.w_i1 (ldCode_23)
  ,.w1_i2 (toReg_24)
  ,.ww_i3 (repANF_19)
  ,.ww1_i4 (repANF_20)
  ,.w2_i5 (reg0_21));
  
  assign subjLet_13 = fromReg0_41 == 5'd3;
  
  reg [0:0] altLet_14_reg;
  always @(*) begin
    case(subjLet_26)
      1 : altLet_14_reg = ww2_i4;
      default : altLet_14_reg = altLet_27;
    endcase
  end
  assign altLet_14 = altLet_14_reg;
  
  System_updateSp_7 System_updateSp_7_altLet_15
  (.topLet_o (altLet_15)
  ,.ds4_i1 (ds10_28)
  ,.sp_i2 (sp_45));
  
  assign subjLet_16 = repANF_29;
  
  reg signed [15:0] altLet_17_reg;
  always @(*) begin
    case(ds7_34)
      2'b10 : altLet_17_reg = bodyVar_50;
      2'b01 : altLet_17_reg = ds12_35;
      default : altLet_17_reg = 16'sd0;
    endcase
  end
  assign altLet_17 = altLet_17_reg;
  
  System_updatePC_8 System_updatePC_8_altLet_18
  (.topLet_o (altLet_18)
  ,.ww_i1 (ds9_38)
  ,.ww1_i2 (repANF_36)
  ,.ww2_i3 (pc_44)
  ,.ww3_i4 (ds19_39)
  ,.ww4_i5 (repANF_37));
  
  assign repANF_19 = ds11_47;
  
  assign repANF_20 = aluOut_48;
  
  assign reg0_21 = bodyVar_42;
  
  // last begin
  wire [4:0] n_93;
  assign n_93 = ldBuf_43;
  
  assign tmp_92 = n_93[5-1:0];
  // last end
  
  assign bufLast_22 = tmp_92;
  
  assign ldCode_23 = ds5_54;
  
  assign toReg_24 = ds14_55;
  
  System_decode_9 System_decode_9_ds4_25
  (.topLet_o (ds4_25)
  ,.sp_i1 (sp_45)
  ,.instr_i2 (ww_i2));
  
  assign tmp_dtt_rhs_94 = opCode_53;
  
  assign tmp_dtt_95 = $signed(tmp_dtt_rhs_94);
  
  assign subjLet_26 = tmp_dtt_95;
  
  assign altLet_27 = aluOut_56;
  
  assign ds10_28 = ds4_25[71:70];
  
  assign repANF_29 = {repANF_46,ldBuf_43};
  
  assign x_30 = subjLet_16[9:5];
  
  assign ds16_31 = ds4_25[22:16];
  
  assign ds17_32 = ds4_25[15:9];
  
  assign ds18_33 = ds4_25[8:8];
  
  assign ds7_34 = ds4_25[81:80];
  
  assign ds12_35 = ds4_25[53:38];
  
  assign repANF_36 = ds21_58;
  
  // indexVec begin
  wire signed [15:0] vec_n_98 [0:32-1];
  
  wire [511:0] vecflat_n_99;
  assign vecflat_n_99 = regzm_12;
  genvar n_100;
  generate
  for (n_100=0; n_100 < 32; n_100=n_100+1) begin : array_n_101
    assign vec_n_98[(32-1)-n_100] = vecflat_n_99[n_100*16+:16];
  end
  endgenerate
  
  assign tmp_97 = vec_n_98[32'sd1];
  // indexVec end
  
  assign repANF_37 = tmp_97;
  
  assign ds9_38 = ds4_25[74:72];
  
  assign ds19_39 = ds4_25[7:0];
  
  System_alu_10 System_alu_10_ds5_40
  (.bodyVar_o (ds5_40)
  ,.w_i1 (opCode_53)
  ,.ww_i2 (bodyVar_50)
  ,.ww1_i3 (repANF_49));
  
  assign fromReg0_41 = ds12_61;
  
  // replaceVec start
  wire [511:0] vecflat_n_103;
  assign vecflat_n_103 = repANF_51;
  
  reg signed [15:0] vec_n_104 [0:32-1];
  integer n_105;
  always @(*) begin
    for (n_105=0;n_105<32;n_105=n_105+1) begin
      vec_n_104[32-1-n_105] = vecflat_n_103[n_105*16+:16];
    end
    vec_n_104[32'sd2] = repANF_52;
  end
  
  genvar n_106;
  generate
  for (n_106=0;n_106<32;n_106=n_106+1) begin : vec_n_107
    assign tmp_102[n_106*16+:16] = vec_n_104[(32-1)-n_106];
  end
  endgenerate
  // replaceVec end
  
  assign bodyVar_42 = tmp_102;
  
  assign ldBuf_43 = ds9_64;
  
  assign pc_44 = ds7_65;
  
  assign sp_45 = ds7_66;
  
  assign repANF_46 = repANF_57;
  
  assign ds11_47 = ds4_25[69:54];
  
  assign aluOut_48 = ds5_40[16:1];
  
  assign repANF_49 = bodyVar_59;
  
  // indexVec begin
  wire signed [15:0] vec_n_109 [0:32-1];
  
  wire [511:0] vecflat_n_110;
  assign vecflat_n_110 = reg0_21;
  genvar n_111;
  generate
  for (n_111=0; n_111 < 32; n_111=n_111+1) begin : array_n_112
    assign vec_n_109[(32-1)-n_111] = vecflat_n_110[n_111*16+:16];
  end
  endgenerate
  
  assign tmp_108 = vec_n_109[repANF_60];
  // indexVec end
  
  assign bodyVar_50 = tmp_108;
  
  // replaceVec start
  wire [511:0] vecflat_n_115;
  assign vecflat_n_115 = repANF_62;
  
  reg signed [15:0] vec_n_116 [0:32-1];
  integer n_117;
  always @(*) begin
    for (n_117=0;n_117<32;n_117=n_117+1) begin
      vec_n_116[32-1-n_117] = vecflat_n_115[n_117*16+:16];
    end
    vec_n_116[32'sd0] = 16'sd0;
  end
  
  genvar n_118;
  generate
  for (n_118=0;n_118<32;n_118=n_118+1) begin : vec_n_119
    assign tmp_113[n_118*16+:16] = vec_n_116[(32-1)-n_118];
  end
  endgenerate
  // replaceVec end
  
  assign repANF_51 = tmp_113;
  
  assign repANF_52 = $signed(repANF_63);
  
  assign opCode_53 = ds7_71;
  
  assign ds5_54 = ds4_25[83:82];
  
  assign ds14_55 = ds4_25[27:23];
  
  assign aluOut_56 = ds5_40[0:0];
  
  reg [4:0] repANF_57_reg;
  always @(*) begin
    case(ldCode_23)
      2'b10 : repANF_57_reg = toReg_24;
      default : repANF_57_reg = 5'd0;
    endcase
  end
  assign repANF_57 = repANF_57_reg;
  
  assign ds21_58 = w_i1[20:20];
  
  // indexVec begin
  wire signed [15:0] vec_n_123 [0:32-1];
  
  wire [511:0] vecflat_n_124;
  assign vecflat_n_124 = reg0_21;
  genvar n_125;
  generate
  for (n_125=0; n_125 < 32; n_125=n_125+1) begin : array_n_126
    assign vec_n_123[(32-1)-n_125] = vecflat_n_124[n_125*16+:16];
  end
  endgenerate
  
  assign tmp_122 = vec_n_123[repANF_67];
  // indexVec end
  
  assign bodyVar_59 = tmp_122;
  
  assign repANF_60 = wild_68;
  
  assign ds12_61 = ds4_25[37:33];
  
  // replaceVec start
  wire [511:0] vecflat_n_128;
  assign vecflat_n_128 = repANF_69;
  
  reg signed [15:0] vec_n_129 [0:32-1];
  integer n_130;
  always @(*) begin
    for (n_130=0;n_130<32;n_130=n_130+1) begin
      vec_n_129[32-1-n_130] = vecflat_n_128[n_130*16+:16];
    end
    vec_n_129[32'sd5] = repANF_70;
  end
  
  genvar n_131;
  generate
  for (n_131=0;n_131<32;n_131=n_131+1) begin : vec_n_132
    assign tmp_127[n_131*16+:16] = vec_n_129[(32-1)-n_131];
  end
  endgenerate
  // replaceVec end
  
  assign repANF_62 = tmp_127;
  
  assign tmp_133 = $signed(pc_44);
  
  assign repANF_63 = tmp_133;
  
  assign ds9_64 = w_i1[4:0];
  
  assign ds7_65 = w_i1[19:12];
  
  assign ds7_66 = w_i1[11:5];
  
  assign repANF_67 = wild_72;
  
  assign wild_68 = repANF_73;
  
  // replaceVec start
  wire [511:0] vecflat_n_136;
  assign vecflat_n_136 = repANF_74;
  
  reg signed [15:0] vec_n_137 [0:32-1];
  integer n_138;
  always @(*) begin
    for (n_138=0;n_138<32;n_138=n_138+1) begin
      vec_n_137[32-1-n_138] = vecflat_n_136[n_138*16+:16];
    end
    vec_n_137[32'sd3] = ww3_i5;
  end
  
  genvar n_139;
  generate
  for (n_139=0;n_139<32;n_139=n_139+1) begin : vec_n_140
    assign tmp_135[n_139*16+:16] = vec_n_137[(32-1)-n_139];
  end
  endgenerate
  // replaceVec end
  
  assign repANF_69 = tmp_135;
  
  assign repANF_70 = $signed(repANF_75);
  
  assign ds7_71 = ds4_25[79:75];
  
  assign wild_72 = repANF_76;
  
  assign tmp_143 = $unsigned(fromReg0_41);
  
  assign repANF_73 = tmp_143;
  
  // replaceVec start
  wire [511:0] vecflat_n_145;
  assign vecflat_n_145 = ds5_78;
  
  reg signed [15:0] vec_n_146 [0:32-1];
  integer n_147;
  always @(*) begin
    for (n_147=0;n_147<32;n_147=n_147+1) begin
      vec_n_146[32-1-n_147] = vecflat_n_145[n_147*16+:16];
    end
    vec_n_146[repANF_77] = ww1_i3;
  end
  
  genvar n_148;
  generate
  for (n_148=0;n_148<32;n_148=n_148+1) begin : vec_n_149
    assign tmp_144[n_148*16+:16] = vec_n_146[(32-1)-n_148];
  end
  endgenerate
  // replaceVec end
  
  assign repANF_74 = tmp_144;
  
  assign tmp_150 = $unsigned((1'b0));
  
  assign tmp_152 = $unsigned((1'b1));
  
  reg signed [31:0] repANF_75_reg;
  always @(*) begin
    if(ww2_i4)
      repANF_75_reg = tmp_152;
    else
      repANF_75_reg = tmp_150;
  end
  assign repANF_75 = repANF_75_reg;
  
  assign tmp_154 = $unsigned(ds14_79);
  
  assign repANF_76 = tmp_154;
  
  assign repANF_77 = wild_80;
  
  assign ds5_78 = w_i1[532:21];
  
  assign ds14_79 = ds4_25[32:28];
  
  assign wild_80 = repANF_81;
  
  assign tmp_156 = $unsigned(bufLast_22);
  
  assign repANF_81 = tmp_156;
endmodule
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
// Automatically generated Verilog-2001
module System_mealyzm_2(eta_i1
                       ,// clock
                       system1000
                       ,// asynchronous reset: active low
                       system1000_rstn
                       ,bodyVar_o);
  input [59:0] eta_i1;
  input system1000;
  input system1000_rstn;
  output [55:0] bodyVar_o;
  wire [55:0] o1_0;
  wire [588:0] bodyVar_1;
  wire [588:0] bodyVar_2;
  wire [588:0] altLet_3;
  wire [26:0] ww_4;
  wire signed [15:0] ww1_5;
  wire [0:0] ww2_6;
  wire signed [15:0] ww3_7;
  wire [532:0] caseApp_8;
  wire [532:0] repANF_9;
  wire [532:0] szm_10;
  wire [532:0] tmp_11;
  assign bodyVar_o = o1_0;
  
  assign o1_0 = bodyVar_1[55:0];
  
  System_BundleZ2T1_3 System_BundleZ2T1_3_bodyVar_1
  (.topLet_o (bodyVar_1)
  ,.eta_i1 (bodyVar_2));
  
  assign bodyVar_2 = altLet_3;
  
  System_esprockellMealy_4 System_esprockellMealy_4_altLet_3
  (.bodyVar_o (altLet_3)
  ,.w_i1 (caseApp_8)
  ,.ww_i2 (ww_4)
  ,.ww1_i3 (ww1_5)
  ,.ww2_i4 (ww2_6)
  ,.ww3_i5 (ww3_7));
  
  assign ww_4 = eta_i1[59:33];
  
  assign ww1_5 = eta_i1[32:17];
  
  assign ww2_6 = eta_i1[16:16];
  
  assign ww3_7 = eta_i1[15:0];
  
  // register begin
  reg [532:0] n_20;
  
  always @(posedge system1000 or negedge system1000_rstn) begin : register_System_mealyzm_2_n_21
    if (~ system1000_rstn) begin
      n_20 <= {{(32) {16'sd0}},1'b0,8'sd0,7'd20,{(1) {5'd0}}};
    end else begin
      n_20 <= repANF_9;
    end
  end
  
  assign tmp_11 = n_20;
  // register end
  
  assign caseApp_8 = tmp_11;
  
  assign repANF_9 = szm_10;
  
  assign szm_10 = bodyVar_1[588:56];
endmodule
// Automatically generated Verilog-2001
module System_oEn_5(bufLast_i1
                   ,toReg_i2
                   ,ldCode_i3
                   ,topLet_o);
  input [4:0] bufLast_i1;
  input [4:0] toReg_i2;
  input [1:0] ldCode_i3;
  output [0:0] topLet_o;
  wire [0:0] subjLet_0;
  wire [0:0] altLet_1;
  wire [0:0] subjLet_2;
  wire [0:0] altLet_3;
  assign subjLet_0 = toReg_i2 == 5'd4;
  
  reg [0:0] altLet_1_reg;
  always @(*) begin
    case(ldCode_i3)
      2'b11 : altLet_1_reg = 1'b1;
      2'b01 : altLet_1_reg = 1'b1;
      default : altLet_1_reg = 1'b0;
    endcase
  end
  assign altLet_1 = altLet_1_reg;
  
  assign subjLet_2 = bufLast_i1 == 5'd4;
  
  reg [0:0] altLet_3_reg;
  always @(*) begin
    if(subjLet_0)
      altLet_3_reg = altLet_1;
    else
      altLet_3_reg = 1'b0;
  end
  assign altLet_3 = altLet_3_reg;
  
  reg [0:0] topLet_o_reg;
  always @(*) begin
    if(subjLet_2)
      topLet_o_reg = 1'b1;
    else
      topLet_o_reg = altLet_3;
  end
  assign topLet_o = topLet_o_reg;
endmodule
// Automatically generated Verilog-2001
module System_sys_1(eta_i1
                   ,// clock
                   system1000
                   ,// asynchronous reset: active low
                   system1000_rstn
                   ,bodyVar_o);
  input [16:0] eta_i1;
  input system1000;
  input system1000_rstn;
  output [16:0] bodyVar_o;
  wire [0:0] x_0;
  wire signed [15:0] x_1;
  wire [55:0] w_2;
  wire [0:0] x_3;
  wire signed [15:0] x_4;
  wire [59:0] bodyVar_5;
  wire signed [15:0] x_6;
  wire [0:0] x_7;
  wire signed [15:0] x_8;
  wire [26:0] bodyVar_9;
  wire signed [31:0] bodyVar_10;
  wire signed [31:0] bodyVar_11;
  wire [0:0] repANF_12;
  wire signed [15:0] repANF_13;
  wire signed [31:0] repANF_14;
  wire signed [31:0] wild_15;
  wire signed [31:0] wild_16;
  wire [0:0] x_17;
  wire signed [15:0] y_18;
  wire signed [31:0] wild_19;
  wire signed [31:0] repANF_20;
  wire signed [31:0] repANF_21;
  wire [0:0] x_22;
  wire signed [15:0] x_23;
  wire signed [31:0] repANF_24;
  wire [6:0] x_25;
  wire [6:0] x_26;
  wire signed [7:0] x_27;
  wire signed [7:0] repANF_28;
  wire [6:0] x_29;
  wire [6:0] x_30;
  wire signed [7:0] x_31;
  wire signed [15:0] tmp_32;
  wire [4:0] tmp_42;
  wire [4:0] tmp_43;
  wire [4:0] tmp_44;
  wire signed [7:0] tmp_45;
  wire signed [7:0] tmp_46;
  wire signed [15:0] tmp_48;
  wire [4:0] tmp_49;
  wire [4:0] tmp_50;
  wire [4:0] tmp_51;
  wire [4:0] tmp_52;
  wire signed [7:0] tmp_53;
  wire [4:0] tmp_54;
  wire [4:0] tmp_55;
  wire [4:0] tmp_56;
  wire signed [7:0] tmp_57;
  wire [4:0] tmp_58;
  wire [4:0] tmp_59;
  wire [4:0] tmp_60;
  wire signed [15:0] tmp_61;
  wire [4:0] tmp_62;
  wire signed [15:0] tmp_63;
  wire [4:0] tmp_64;
  wire [4:0] tmp_65;
  wire [4:0] tmp_66;
  wire [4:0] tmp_67;
  wire signed [7:0] tmp_68;
  wire [4:0] tmp_69;
  wire [4:0] tmp_70;
  wire [4:0] tmp_71;
  wire [4:0] tmp_72;
  wire [4:0] tmp_73;
  wire [4:0] tmp_74;
  wire [4:0] tmp_75;
  wire [4:0] tmp_76;
  wire [4:0] tmp_77;
  wire [4:0] tmp_78;
  wire [4:0] tmp_79;
  wire [4:0] tmp_80;
  wire signed [7:0] tmp_81;
  wire [4:0] tmp_83;
  wire [4:0] tmp_84;
  wire [4:0] tmp_85;
  wire [4:0] tmp_86;
  wire [4:0] tmp_87;
  wire [4:0] tmp_88;
  wire signed [7:0] tmp_89;
  wire [26:0] tmp_41;
  wire signed [31:0] tmp_99;
  wire signed [31:0] tmp_100;
  wire signed [31:0] tmp_101;
  wire signed [7:0] tmp_102;
  assign bodyVar_o = {x_0,x_1};
  
  assign x_0 = x_3;
  
  assign x_1 = x_4;
  
  System_mealyzm_2 System_mealyzm_2_w_2
  (.bodyVar_o (w_2)
  ,.system1000 (system1000)
  ,.system1000_rstn (system1000_rstn)
  ,.eta_i1 (bodyVar_5));
  
  assign x_3 = w_2[16:16];
  
  assign x_4 = w_2[15:0];
  
  assign bodyVar_5 = {bodyVar_9
                     ,x_6
                     ,x_7
                     ,x_8};
  
  // blockRam begin
  reg signed [15:0] RAM_n_36 [0:128-1];
  reg signed [15:0] dout_n_37;
  
  reg [2047:0] ram_init_n_38;
  integer n_39;
  initial begin
    ram_init_n_38 = ({(128) {({1'b0, {(16-1) {1'b1}}})}});
    for (n_39=0; n_39 < 128; n_39 = n_39 + 1) begin
      RAM_n_36[128-1-n_39] = ram_init_n_38[n_39*16+:16];
    end
  end
  
  always @(posedge system1000) begin : blockRam_System_sys_1_n_40
    if (repANF_12) begin
      RAM_n_36[bodyVar_10] <= repANF_13;
    end
    dout_n_37 <= RAM_n_36[bodyVar_11];
  end
  
  assign tmp_32 = dout_n_37;
  // blockRam end
  
  assign x_6 = tmp_32;
  
  assign x_7 = x_17;
  
  assign x_8 = y_18;
  
  assign tmp_42 = 5'd3;
  
  assign tmp_43 = 5'd0;
  
  assign tmp_44 = 5'd7;
  
  assign tmp_45 = 8'sd2;
  
  assign tmp_46 = -8'sd2;
  
  assign tmp_48 = 16'sd2;
  
  assign tmp_49 = 5'd8;
  
  assign tmp_50 = 5'd2;
  
  assign tmp_51 = 5'd8;
  
  assign tmp_52 = 5'd1;
  
  assign tmp_53 = 8'sd9;
  
  assign tmp_54 = 5'd7;
  
  assign tmp_55 = 5'd0;
  
  assign tmp_56 = 5'd4;
  
  assign tmp_57 = 8'sd0;
  
  assign tmp_58 = 5'd8;
  
  assign tmp_59 = 5'd9;
  
  assign tmp_60 = 5'd10;
  
  assign tmp_61 = 16'sd1;
  
  assign tmp_62 = 5'd8;
  
  assign tmp_63 = 16'sd0;
  
  assign tmp_64 = 5'd9;
  
  assign tmp_65 = 5'd7;
  
  assign tmp_66 = 5'd0;
  
  assign tmp_67 = 5'd10;
  
  assign tmp_68 = 8'sd6;
  
  assign tmp_69 = 5'd7;
  
  assign tmp_70 = 5'd7;
  
  assign tmp_71 = 5'd7;
  
  assign tmp_72 = 5'd8;
  
  assign tmp_73 = 5'd0;
  
  assign tmp_74 = 5'd10;
  
  assign tmp_75 = 5'd8;
  
  assign tmp_76 = 5'd9;
  
  assign tmp_77 = 5'd8;
  
  assign tmp_78 = 5'd10;
  
  assign tmp_79 = 5'd0;
  
  assign tmp_80 = 5'd9;
  
  assign tmp_81 = -8'sd6;
  
  assign tmp_83 = 5'd8;
  
  assign tmp_84 = 5'd0;
  
  assign tmp_85 = 5'd7;
  
  assign tmp_86 = 5'd10;
  
  assign tmp_87 = 5'd9;
  
  assign tmp_88 = 5'd8;
  
  assign tmp_89 = 8'sd0;
  
  // asyncRom begin
  wire [26:0] ROM_n_92 [0:128-1];
  
  wire [3455:0] romflat_n_93;
  assign romflat_n_93 = {{3'b000,5'd1,tmp_42,tmp_43,tmp_44,4'b0000},{{3'b001,3'd4,tmp_45,13'b0000000000000},{{3'b001,3'd2,tmp_46,13'b0000000000000},{{3'b010,{1'b1,tmp_48},tmp_49,2'b00},{{3'b000,5'd6,tmp_50,tmp_51,tmp_52,4'b0000},{{3'b001,3'd1,tmp_53,13'b0000000000000},{{3'b000,5'd1,tmp_54,tmp_55,tmp_56,4'b0000},{{3'b001,3'd1,tmp_57,13'b0000000000000},{{3'b110,24'b000000000000000000000000},{{3'b100,tmp_58,19'b0000000000000000000},{{3'b100,tmp_59,19'b0000000000000000000},{{3'b100,tmp_60,19'b0000000000000000000},{{3'b010,{1'b1,tmp_61},tmp_62,2'b00},{{3'b010,{1'b1,tmp_63},tmp_64,2'b00},{{3'b000,5'd11,tmp_65,tmp_66,tmp_67,4'b0000},{{3'b001,3'd4,tmp_68,13'b0000000000000},{{3'b000,5'd3,tmp_69,tmp_70,tmp_71,4'b0000},{{3'b000,5'd1,tmp_72,tmp_73,tmp_74,4'b0000},{{3'b000,5'd6,tmp_75,tmp_76,tmp_77,4'b0000},{{3'b000,5'd1,tmp_78,tmp_79,tmp_80,4'b0000},{{3'b001,3'd2,tmp_81,13'b0000000000000},{{3'b000,5'd1,tmp_83,tmp_84,tmp_85,4'b0000},{{3'b101,tmp_86,19'b0000000000000000000},{{3'b101,tmp_87,19'b0000000000000000000},{{3'b101,tmp_88,19'b0000000000000000000},{{3'b001,3'd5,tmp_89,13'b0000000000000},{(102) {{3'b110,24'b000000000000000000000000}}}}}}}}}}}}}}}}}}}}}}}}}}}}};
  genvar n_94;
  generate
  for (n_94=0; n_94 < 128; n_94=n_94+1) begin : array_n_95
    assign ROM_n_92[(128-1)-n_94] = romflat_n_93[n_94*27+:27];
  end
  endgenerate
  
  assign tmp_41 = ROM_n_92[repANF_14];
  // asyncRom end
  
  assign bodyVar_9 = tmp_41;
  
  assign bodyVar_10 = wild_15;
  
  assign bodyVar_11 = wild_16;
  
  assign repANF_12 = x_22;
  
  assign repANF_13 = x_23;
  
  assign repANF_14 = wild_19;
  
  assign wild_15 = repANF_20;
  
  assign wild_16 = repANF_21;
  
  assign x_17 = eta_i1[16:16];
  
  assign y_18 = eta_i1[15:0];
  
  assign wild_19 = repANF_24;
  
  assign tmp_99 = $unsigned(x_25);
  
  assign repANF_20 = tmp_99;
  
  assign tmp_100 = $unsigned(x_26);
  
  assign repANF_21 = tmp_100;
  
  assign x_22 = w_2[41:41];
  
  assign x_23 = w_2[40:25];
  
  assign tmp_101 = $signed(x_27);
  
  assign repANF_24 = tmp_101;
  
  assign x_25 = x_29;
  
  assign x_26 = x_30;
  
  // register begin
  reg signed [7:0] n_104;
  
  always @(posedge system1000 or negedge system1000_rstn) begin : register_System_sys_1_n_105
    if (~ system1000_rstn) begin
      n_104 <= 8'sd0;
    end else begin
      n_104 <= repANF_28;
    end
  end
  
  assign tmp_102 = n_104;
  // register end
  
  assign x_27 = tmp_102;
  
  assign repANF_28 = x_31;
  
  assign x_29 = w_2[55:49];
  
  assign x_30 = w_2[48:42];
  
  assign x_31 = w_2[24:17];
endmodule
// Automatically generated Verilog-2001
module System_topEntity_0(eta_i1
                         ,// clock
                         system1000
                         ,// asynchronous reset: active low
                         system1000_rstn
                         ,topLet_o);
  input [16:0] eta_i1;
  input system1000;
  input system1000_rstn;
  output [16:0] topLet_o;
  System_sys_1 System_sys_1_topLet_o
  (.bodyVar_o (topLet_o)
  ,.system1000 (system1000)
  ,.system1000_rstn (system1000_rstn)
  ,.eta_i1 (eta_i1));
endmodule
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
