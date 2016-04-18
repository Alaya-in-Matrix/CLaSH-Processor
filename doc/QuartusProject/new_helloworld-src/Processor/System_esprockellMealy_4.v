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
  wire [0:0] altLet_13;
  wire [6:0] altLet_14;
  wire [9:0] subjLet_15;
  wire signed [15:0] altLet_16;
  wire signed [7:0] altLet_17;
  wire signed [15:0] repANF_18;
  wire signed [15:0] repANF_19;
  wire [4:0] fromReg0_20;
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
  wire [511:0] bodyVar_41;
  wire [4:0] ldBuf_42;
  wire signed [7:0] pc_43;
  wire [6:0] sp_44;
  wire [4:0] repANF_45;
  wire signed [15:0] ds11_46;
  wire signed [15:0] aluOut_47;
  wire signed [15:0] repANF_48;
  wire signed [15:0] bodyVar_49;
  wire [4:0] ds12_50;
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
  wire [511:0] repANF_61;
  wire signed [31:0] repANF_62;
  wire [4:0] ds9_63;
  wire signed [7:0] ds7_64;
  wire [6:0] ds7_65;
  wire signed [31:0] repANF_66;
  wire signed [31:0] wild_67;
  wire [511:0] repANF_68;
  wire signed [15:0] repANF_69;
  wire [4:0] ds7_70;
  wire signed [31:0] wild_71;
  wire signed [31:0] repANF_72;
  wire [511:0] repANF_73;
  wire signed [31:0] repANF_74;
  wire signed [31:0] repANF_75;
  wire signed [31:0] repANF_76;
  wire [511:0] ds5_77;
  wire [4:0] ds14_78;
  wire signed [31:0] wild_79;
  wire signed [31:0] repANF_80;
  wire signed [15:0] tmp_81;
  wire [4:0] tmp_89;
  wire [4:0] tmp_dtt_rhs_91;
  wire signed [31:0] tmp_dtt_92;
  wire signed [15:0] tmp_94;
  wire [511:0] tmp_99;
  wire signed [15:0] tmp_105;
  wire [511:0] tmp_110;
  wire signed [15:0] tmp_119;
  wire [511:0] tmp_124;
  wire signed [31:0] tmp_130;
  wire [511:0] tmp_132;
  wire signed [31:0] tmp_140;
  wire [511:0] tmp_141;
  wire signed [31:0] tmp_147;
  wire signed [31:0] tmp_149;
  wire signed [31:0] tmp_151;
  wire signed [31:0] tmp_153;
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
    case(fromReg0_20)
      5'd3 : repANF_2_reg = ww2_i4;
      default : repANF_2_reg = altLet_13;
    endcase
  end
  assign repANF_2 = repANF_2_reg;
  
  assign repANF_3 = altLet_14;
  
  assign repANF_4 = x_30;
  
  assign repANF_5 = ds16_31;
  
  assign repANF_6 = ds17_32;
  
  assign repANF_7 = ds18_33;
  
  assign repANF_8 = altLet_16;
  
  System_oEn_5 System_oEn_5_repANF_9
  (.topLet_o (repANF_9)
  ,.bufLast_i1 (bufLast_22)
  ,.toReg_i2 (toReg_24)
  ,.ldCode_i3 (ldCode_23));
  
  // indexVec begin
  wire signed [15:0] vec_n_82 [0:32-1];
  
  wire [511:0] vecflat_n_83;
  assign vecflat_n_83 = regzm_12;
  genvar n_84;
  generate
  for (n_84=0; n_84 < 32; n_84=n_84+1) begin : array_n_85
    assign vec_n_82[(32-1)-n_84] = vecflat_n_83[n_84*16+:16];
  end
  endgenerate
  
  assign tmp_81 = vec_n_82[32'sd4];
  // indexVec end
  
  assign repANF_10 = tmp_81;
  
  assign pczm_11 = altLet_17;
  
  System_load_6 System_load_6_regzm_12
  (.bodyVar_o (regzm_12)
  ,.w_i1 (ldCode_23)
  ,.w1_i2 (toReg_24)
  ,.ww_i3 (repANF_18)
  ,.ww1_i4 (repANF_19)
  ,.w2_i5 (reg0_21));
  
  reg [0:0] altLet_13_reg;
  always @(*) begin
    case(subjLet_26)
      32'sd1 : altLet_13_reg = ww2_i4;
      default : altLet_13_reg = altLet_27;
    endcase
  end
  assign altLet_13 = altLet_13_reg;
  
  System_updateSp_7 System_updateSp_7_altLet_14
  (.topLet_o (altLet_14)
  ,.ds4_i1 (ds10_28)
  ,.sp_i2 (sp_44));
  
  assign subjLet_15 = repANF_29;
  
  reg signed [15:0] altLet_16_reg;
  always @(*) begin
    case(ds7_34)
      2'b10 : altLet_16_reg = bodyVar_49;
      2'b01 : altLet_16_reg = ds12_35;
      default : altLet_16_reg = 16'sd0;
    endcase
  end
  assign altLet_16 = altLet_16_reg;
  
  System_updatePC_8 System_updatePC_8_altLet_17
  (.topLet_o (altLet_17)
  ,.ww_i1 (ds9_38)
  ,.ww1_i2 (repANF_36)
  ,.ww2_i3 (pc_43)
  ,.ww3_i4 (ds19_39)
  ,.ww4_i5 (repANF_37));
  
  assign repANF_18 = ds11_46;
  
  assign repANF_19 = aluOut_47;
  
  assign fromReg0_20 = ds12_50;
  
  assign reg0_21 = bodyVar_41;
  
  // last begin
  wire [4:0] n_90;
  assign n_90 = ldBuf_42;
  
  assign tmp_89 = n_90[5-1:0];
  // last end
  
  assign bufLast_22 = tmp_89;
  
  assign ldCode_23 = ds5_54;
  
  assign toReg_24 = ds14_55;
  
  System_decode_9 System_decode_9_ds4_25
  (.topLet_o (ds4_25)
  ,.sp_i1 (sp_44)
  ,.instr_i2 (ww_i2));
  
  assign tmp_dtt_rhs_91 = opCode_53;
  
  assign tmp_dtt_92 = $signed(tmp_dtt_rhs_91);
  
  assign subjLet_26 = tmp_dtt_92;
  
  assign altLet_27 = aluOut_56;
  
  assign ds10_28 = ds4_25[71:70];
  
  assign repANF_29 = {repANF_45,ldBuf_42};
  
  assign x_30 = subjLet_15[9:5];
  
  assign ds16_31 = ds4_25[22:16];
  
  assign ds17_32 = ds4_25[15:9];
  
  assign ds18_33 = ds4_25[8:8];
  
  assign ds7_34 = ds4_25[81:80];
  
  assign ds12_35 = ds4_25[53:38];
  
  assign repANF_36 = ds21_58;
  
  // indexVec begin
  wire signed [15:0] vec_n_95 [0:32-1];
  
  wire [511:0] vecflat_n_96;
  assign vecflat_n_96 = regzm_12;
  genvar n_97;
  generate
  for (n_97=0; n_97 < 32; n_97=n_97+1) begin : array_n_98
    assign vec_n_95[(32-1)-n_97] = vecflat_n_96[n_97*16+:16];
  end
  endgenerate
  
  assign tmp_94 = vec_n_95[32'sd1];
  // indexVec end
  
  assign repANF_37 = tmp_94;
  
  assign ds9_38 = ds4_25[74:72];
  
  assign ds19_39 = ds4_25[7:0];
  
  System_alu_10 System_alu_10_ds5_40
  (.bodyVar_o (ds5_40)
  ,.w_i1 (opCode_53)
  ,.ww_i2 (bodyVar_49)
  ,.ww1_i3 (repANF_48));
  
  // replaceVec start
  wire [511:0] vecflat_n_100;
  assign vecflat_n_100 = repANF_51;
  
  reg signed [15:0] vec_n_101 [0:32-1];
  integer n_102;
  always @(*) begin
    for (n_102=0;n_102<32;n_102=n_102+1) begin
      vec_n_101[32-1-n_102] = vecflat_n_100[n_102*16+:16];
    end
    vec_n_101[32'sd2] = repANF_52;
  end
  
  genvar n_103;
  generate
  for (n_103=0;n_103<32;n_103=n_103+1) begin : vec_n_104
    assign tmp_99[n_103*16+:16] = vec_n_101[(32-1)-n_103];
  end
  endgenerate
  // replaceVec end
  
  assign bodyVar_41 = tmp_99;
  
  assign ldBuf_42 = ds9_63;
  
  assign pc_43 = ds7_64;
  
  assign sp_44 = ds7_65;
  
  assign repANF_45 = repANF_57;
  
  assign ds11_46 = ds4_25[69:54];
  
  assign aluOut_47 = ds5_40[16:1];
  
  assign repANF_48 = bodyVar_59;
  
  // indexVec begin
  wire signed [15:0] vec_n_106 [0:32-1];
  
  wire [511:0] vecflat_n_107;
  assign vecflat_n_107 = reg0_21;
  genvar n_108;
  generate
  for (n_108=0; n_108 < 32; n_108=n_108+1) begin : array_n_109
    assign vec_n_106[(32-1)-n_108] = vecflat_n_107[n_108*16+:16];
  end
  endgenerate
  
  assign tmp_105 = vec_n_106[repANF_60];
  // indexVec end
  
  assign bodyVar_49 = tmp_105;
  
  assign ds12_50 = ds4_25[37:33];
  
  // replaceVec start
  wire [511:0] vecflat_n_112;
  assign vecflat_n_112 = repANF_61;
  
  reg signed [15:0] vec_n_113 [0:32-1];
  integer n_114;
  always @(*) begin
    for (n_114=0;n_114<32;n_114=n_114+1) begin
      vec_n_113[32-1-n_114] = vecflat_n_112[n_114*16+:16];
    end
    vec_n_113[32'sd0] = 16'sd0;
  end
  
  genvar n_115;
  generate
  for (n_115=0;n_115<32;n_115=n_115+1) begin : vec_n_116
    assign tmp_110[n_115*16+:16] = vec_n_113[(32-1)-n_115];
  end
  endgenerate
  // replaceVec end
  
  assign repANF_51 = tmp_110;
  
  assign repANF_52 = $signed(repANF_62);
  
  assign opCode_53 = ds7_70;
  
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
  wire signed [15:0] vec_n_120 [0:32-1];
  
  wire [511:0] vecflat_n_121;
  assign vecflat_n_121 = reg0_21;
  genvar n_122;
  generate
  for (n_122=0; n_122 < 32; n_122=n_122+1) begin : array_n_123
    assign vec_n_120[(32-1)-n_122] = vecflat_n_121[n_122*16+:16];
  end
  endgenerate
  
  assign tmp_119 = vec_n_120[repANF_66];
  // indexVec end
  
  assign bodyVar_59 = tmp_119;
  
  assign repANF_60 = wild_67;
  
  // replaceVec start
  wire [511:0] vecflat_n_125;
  assign vecflat_n_125 = repANF_68;
  
  reg signed [15:0] vec_n_126 [0:32-1];
  integer n_127;
  always @(*) begin
    for (n_127=0;n_127<32;n_127=n_127+1) begin
      vec_n_126[32-1-n_127] = vecflat_n_125[n_127*16+:16];
    end
    vec_n_126[32'sd5] = repANF_69;
  end
  
  genvar n_128;
  generate
  for (n_128=0;n_128<32;n_128=n_128+1) begin : vec_n_129
    assign tmp_124[n_128*16+:16] = vec_n_126[(32-1)-n_128];
  end
  endgenerate
  // replaceVec end
  
  assign repANF_61 = tmp_124;
  
  assign tmp_130 = $signed(pc_43);
  
  assign repANF_62 = tmp_130;
  
  assign ds9_63 = w_i1[4:0];
  
  assign ds7_64 = w_i1[19:12];
  
  assign ds7_65 = w_i1[11:5];
  
  assign repANF_66 = wild_71;
  
  assign wild_67 = repANF_72;
  
  // replaceVec start
  wire [511:0] vecflat_n_133;
  assign vecflat_n_133 = repANF_73;
  
  reg signed [15:0] vec_n_134 [0:32-1];
  integer n_135;
  always @(*) begin
    for (n_135=0;n_135<32;n_135=n_135+1) begin
      vec_n_134[32-1-n_135] = vecflat_n_133[n_135*16+:16];
    end
    vec_n_134[32'sd3] = ww3_i5;
  end
  
  genvar n_136;
  generate
  for (n_136=0;n_136<32;n_136=n_136+1) begin : vec_n_137
    assign tmp_132[n_136*16+:16] = vec_n_134[(32-1)-n_136];
  end
  endgenerate
  // replaceVec end
  
  assign repANF_68 = tmp_132;
  
  assign repANF_69 = $signed(repANF_74);
  
  assign ds7_70 = ds4_25[79:75];
  
  assign wild_71 = repANF_75;
  
  assign tmp_140 = $unsigned(fromReg0_20);
  
  assign repANF_72 = tmp_140;
  
  // replaceVec start
  wire [511:0] vecflat_n_142;
  assign vecflat_n_142 = ds5_77;
  
  reg signed [15:0] vec_n_143 [0:32-1];
  integer n_144;
  always @(*) begin
    for (n_144=0;n_144<32;n_144=n_144+1) begin
      vec_n_143[32-1-n_144] = vecflat_n_142[n_144*16+:16];
    end
    vec_n_143[repANF_76] = ww1_i3;
  end
  
  genvar n_145;
  generate
  for (n_145=0;n_145<32;n_145=n_145+1) begin : vec_n_146
    assign tmp_141[n_145*16+:16] = vec_n_143[(32-1)-n_145];
  end
  endgenerate
  // replaceVec end
  
  assign repANF_73 = tmp_141;
  
  assign tmp_147 = $unsigned((1'b0));
  
  assign tmp_149 = $unsigned((1'b1));
  
  reg signed [31:0] repANF_74_reg;
  always @(*) begin
    if(ww2_i4)
      repANF_74_reg = tmp_149;
    else
      repANF_74_reg = tmp_147;
  end
  assign repANF_74 = repANF_74_reg;
  
  assign tmp_151 = $unsigned(ds14_78);
  
  assign repANF_75 = tmp_151;
  
  assign repANF_76 = wild_79;
  
  assign ds5_77 = w_i1[532:21];
  
  assign ds14_78 = ds4_25[32:28];
  
  assign wild_79 = repANF_80;
  
  assign tmp_153 = $unsigned(bufLast_22);
  
  assign repANF_80 = tmp_153;
endmodule
