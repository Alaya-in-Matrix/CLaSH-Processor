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
  wire [55:0] ds1_2;
  wire [0:0] oEn_3;
  wire signed [15:0] oData_4;
  wire [55:0] repANF_5;
  wire [59:0] bodyVar_6;
  wire signed [15:0] x_7;
  wire [0:0] x_8;
  wire signed [15:0] x_9;
  wire [26:0] bodyVar_10;
  wire signed [31:0] bodyVar_11;
  wire signed [31:0] bodyVar_12;
  wire [0:0] repANF_13;
  wire signed [15:0] repANF_14;
  wire signed [31:0] repANF_15;
  wire signed [31:0] wild_16;
  wire signed [31:0] wild_17;
  wire [0:0] x_18;
  wire signed [15:0] y_19;
  wire signed [31:0] wild_20;
  wire signed [31:0] repANF_21;
  wire signed [31:0] repANF_22;
  wire [0:0] we_23;
  wire signed [15:0] wData_24;
  wire signed [31:0] repANF_25;
  wire [6:0] x_26;
  wire [6:0] x_27;
  wire signed [7:0] x_28;
  wire signed [7:0] repANF_29;
  wire [6:0] wAddr_30;
  wire [6:0] rAddr_31;
  wire signed [7:0] pczm_32;
  wire signed [15:0] tmp_33;
  wire signed [15:0] tmp_43;
  wire [4:0] tmp_44;
  wire signed [15:0] tmp_45;
  wire [4:0] tmp_46;
  wire [4:0] tmp_47;
  wire [4:0] tmp_48;
  wire [4:0] tmp_49;
  wire signed [7:0] tmp_50;
  wire signed [15:0] tmp_51;
  wire [4:0] tmp_52;
  wire [4:0] tmp_53;
  wire [4:0] tmp_54;
  wire [4:0] tmp_55;
  wire signed [7:0] tmp_56;
  wire signed [15:0] tmp_57;
  wire [4:0] tmp_58;
  wire [4:0] tmp_59;
  wire [4:0] tmp_60;
  wire [4:0] tmp_61;
  wire signed [7:0] tmp_62;
  wire signed [15:0] tmp_63;
  wire [4:0] tmp_64;
  wire [4:0] tmp_65;
  wire [4:0] tmp_66;
  wire [4:0] tmp_67;
  wire signed [7:0] tmp_68;
  wire signed [15:0] tmp_69;
  wire [4:0] tmp_70;
  wire [4:0] tmp_71;
  wire [4:0] tmp_72;
  wire [4:0] tmp_73;
  wire signed [7:0] tmp_74;
  wire signed [15:0] tmp_75;
  wire [4:0] tmp_76;
  wire [4:0] tmp_77;
  wire [4:0] tmp_78;
  wire [4:0] tmp_79;
  wire signed [7:0] tmp_80;
  wire signed [15:0] tmp_81;
  wire [4:0] tmp_82;
  wire [4:0] tmp_83;
  wire [4:0] tmp_84;
  wire [4:0] tmp_85;
  wire signed [7:0] tmp_86;
  wire signed [15:0] tmp_87;
  wire [4:0] tmp_88;
  wire [4:0] tmp_89;
  wire [4:0] tmp_90;
  wire [4:0] tmp_91;
  wire signed [7:0] tmp_92;
  wire signed [15:0] tmp_93;
  wire [4:0] tmp_94;
  wire [4:0] tmp_95;
  wire [4:0] tmp_96;
  wire [4:0] tmp_97;
  wire signed [7:0] tmp_98;
  wire signed [15:0] tmp_99;
  wire [4:0] tmp_100;
  wire [4:0] tmp_101;
  wire [4:0] tmp_102;
  wire [4:0] tmp_103;
  wire signed [7:0] tmp_104;
  wire signed [15:0] tmp_105;
  wire [4:0] tmp_106;
  wire [4:0] tmp_107;
  wire [4:0] tmp_108;
  wire [4:0] tmp_109;
  wire signed [7:0] tmp_110;
  wire signed [15:0] tmp_111;
  wire [4:0] tmp_112;
  wire [4:0] tmp_113;
  wire [4:0] tmp_114;
  wire [4:0] tmp_115;
  wire signed [7:0] tmp_116;
  wire signed [15:0] tmp_117;
  wire [4:0] tmp_118;
  wire [4:0] tmp_119;
  wire [4:0] tmp_120;
  wire [4:0] tmp_121;
  wire signed [15:0] tmp_122;
  wire [4:0] tmp_123;
  wire [4:0] tmp_124;
  wire [4:0] tmp_125;
  wire [4:0] tmp_126;
  wire signed [15:0] tmp_127;
  wire [4:0] tmp_128;
  wire [4:0] tmp_129;
  wire [4:0] tmp_130;
  wire [4:0] tmp_131;
  wire signed [7:0] tmp_132;
  wire [26:0] tmp_42;
  wire signed [31:0] tmp_142;
  wire signed [31:0] tmp_143;
  wire signed [31:0] tmp_144;
  wire signed [7:0] tmp_145;
  assign bodyVar_o = {x_0,x_1};
  
  assign x_0 = oEn_3;
  
  assign x_1 = oData_4;
  
  System_a4_2 System_a4_2_ds1_2
  (.topLet_o (ds1_2)
  ,.eta_i1 (repANF_5));
  
  assign oEn_3 = ds1_2[16:16];
  
  assign oData_4 = ds1_2[15:0];
  
  System_mealyzm_3 System_mealyzm_3_repANF_5
  (.bodyVar_o (repANF_5)
  ,.system1000 (system1000)
  ,.system1000_rstn (system1000_rstn)
  ,.eta_i1 (bodyVar_6));
  
  assign bodyVar_6 = {bodyVar_10
                     ,x_7
                     ,x_8
                     ,x_9};
  
  // blockRam begin
  reg signed [15:0] RAM_n_37 [0:128-1];
  reg signed [15:0] dout_n_38;
  
  reg [2047:0] ram_init_n_39;
  integer n_40;
  initial begin
    ram_init_n_39 = ({(128) {({1'b0, {(16-1) {1'b1}}})}});
    for (n_40=0; n_40 < 128; n_40 = n_40 + 1) begin
      RAM_n_37[128-1-n_40] = ram_init_n_39[n_40*16+:16];
    end
  end
  
  always @(posedge system1000) begin : blockRam_System_sys_1_n_41
    if (repANF_13) begin
      RAM_n_37[bodyVar_11] <= repANF_14;
    end
    dout_n_38 <= RAM_n_37[bodyVar_12];
  end
  
  assign tmp_33 = dout_n_38;
  // blockRam end
  
  assign x_7 = tmp_33;
  
  assign x_8 = x_18;
  
  assign x_9 = y_19;
  
  assign tmp_43 = 16'sd2;
  
  assign tmp_44 = 5'd8;
  
  assign tmp_45 = 16'sd72;
  
  assign tmp_46 = 5'd7;
  
  assign tmp_47 = 5'd2;
  
  assign tmp_48 = 5'd8;
  
  assign tmp_49 = 5'd1;
  
  assign tmp_50 = 8'sd38;
  
  assign tmp_51 = 16'sd101;
  
  assign tmp_52 = 5'd7;
  
  assign tmp_53 = 5'd2;
  
  assign tmp_54 = 5'd8;
  
  assign tmp_55 = 5'd1;
  
  assign tmp_56 = 8'sd38;
  
  assign tmp_57 = 16'sd108;
  
  assign tmp_58 = 5'd7;
  
  assign tmp_59 = 5'd2;
  
  assign tmp_60 = 5'd8;
  
  assign tmp_61 = 5'd1;
  
  assign tmp_62 = 8'sd38;
  
  assign tmp_63 = 16'sd108;
  
  assign tmp_64 = 5'd7;
  
  assign tmp_65 = 5'd2;
  
  assign tmp_66 = 5'd8;
  
  assign tmp_67 = 5'd1;
  
  assign tmp_68 = 8'sd38;
  
  assign tmp_69 = 16'sd111;
  
  assign tmp_70 = 5'd7;
  
  assign tmp_71 = 5'd2;
  
  assign tmp_72 = 5'd8;
  
  assign tmp_73 = 5'd1;
  
  assign tmp_74 = 8'sd38;
  
  assign tmp_75 = 16'sd32;
  
  assign tmp_76 = 5'd7;
  
  assign tmp_77 = 5'd2;
  
  assign tmp_78 = 5'd8;
  
  assign tmp_79 = 5'd1;
  
  assign tmp_80 = 8'sd38;
  
  assign tmp_81 = 16'sd87;
  
  assign tmp_82 = 5'd7;
  
  assign tmp_83 = 5'd2;
  
  assign tmp_84 = 5'd8;
  
  assign tmp_85 = 5'd1;
  
  assign tmp_86 = 8'sd38;
  
  assign tmp_87 = 16'sd111;
  
  assign tmp_88 = 5'd7;
  
  assign tmp_89 = 5'd2;
  
  assign tmp_90 = 5'd8;
  
  assign tmp_91 = 5'd1;
  
  assign tmp_92 = 8'sd38;
  
  assign tmp_93 = 16'sd114;
  
  assign tmp_94 = 5'd7;
  
  assign tmp_95 = 5'd2;
  
  assign tmp_96 = 5'd8;
  
  assign tmp_97 = 5'd1;
  
  assign tmp_98 = 8'sd38;
  
  assign tmp_99 = 16'sd108;
  
  assign tmp_100 = 5'd7;
  
  assign tmp_101 = 5'd2;
  
  assign tmp_102 = 5'd8;
  
  assign tmp_103 = 5'd1;
  
  assign tmp_104 = 8'sd38;
  
  assign tmp_105 = 16'sd100;
  
  assign tmp_106 = 5'd7;
  
  assign tmp_107 = 5'd2;
  
  assign tmp_108 = 5'd8;
  
  assign tmp_109 = 5'd1;
  
  assign tmp_110 = 8'sd38;
  
  assign tmp_111 = 16'sd10;
  
  assign tmp_112 = 5'd7;
  
  assign tmp_113 = 5'd2;
  
  assign tmp_114 = 5'd8;
  
  assign tmp_115 = 5'd1;
  
  assign tmp_116 = 8'sd38;
  
  assign tmp_117 = 16'sd255;
  
  assign tmp_118 = 5'd9;
  
  assign tmp_119 = 5'd7;
  
  assign tmp_120 = 5'd9;
  
  assign tmp_121 = 5'd7;
  
  assign tmp_122 = 16'sd0;
  
  assign tmp_123 = 5'd9;
  
  assign tmp_124 = 5'd7;
  
  assign tmp_125 = 5'd9;
  
  assign tmp_126 = 5'd4;
  
  assign tmp_127 = 16'sd65535;
  
  assign tmp_128 = 5'd9;
  
  assign tmp_129 = 5'd9;
  
  assign tmp_130 = 5'd0;
  
  assign tmp_131 = 5'd4;
  
  assign tmp_132 = 8'sd0;
  
  // asyncRom begin
  wire [26:0] ROM_n_135 [0:128-1];
  
  wire [3455:0] romflat_n_136;
  assign romflat_n_136 = {{3'b010,{1'b1,tmp_43},tmp_44,2'b00},{{3'b010,{1'b1,tmp_45},tmp_46,2'b00},{{3'b000,5'd6,tmp_47,tmp_48,tmp_49,4'b0000},{{3'b001,3'd1,tmp_50,13'b0000000000000},{{3'b010,{1'b1,tmp_51},tmp_52,2'b00},{{3'b000,5'd6,tmp_53,tmp_54,tmp_55,4'b0000},{{3'b001,3'd1,tmp_56,13'b0000000000000},{{3'b010,{1'b1,tmp_57},tmp_58,2'b00},{{3'b000,5'd6,tmp_59,tmp_60,tmp_61,4'b0000},{{3'b001,3'd1,tmp_62,13'b0000000000000},{{3'b010,{1'b1,tmp_63},tmp_64,2'b00},{{3'b000,5'd6,tmp_65,tmp_66,tmp_67,4'b0000},{{3'b001,3'd1,tmp_68,13'b0000000000000},{{3'b010,{1'b1,tmp_69},tmp_70,2'b00},{{3'b000,5'd6,tmp_71,tmp_72,tmp_73,4'b0000},{{3'b001,3'd1,tmp_74,13'b0000000000000},{{3'b010,{1'b1,tmp_75},tmp_76,2'b00},{{3'b000,5'd6,tmp_77,tmp_78,tmp_79,4'b0000},{{3'b001,3'd1,tmp_80,13'b0000000000000},{{3'b010,{1'b1,tmp_81},tmp_82,2'b00},{{3'b000,5'd6,tmp_83,tmp_84,tmp_85,4'b0000},{{3'b001,3'd1,tmp_86,13'b0000000000000},{{3'b010,{1'b1,tmp_87},tmp_88,2'b00},{{3'b000,5'd6,tmp_89,tmp_90,tmp_91,4'b0000},{{3'b001,3'd1,tmp_92,13'b0000000000000},{{3'b010,{1'b1,tmp_93},tmp_94,2'b00},{{3'b000,5'd6,tmp_95,tmp_96,tmp_97,4'b0000},{{3'b001,3'd1,tmp_98,13'b0000000000000},{{3'b010,{1'b1,tmp_99},tmp_100,2'b00},{{3'b000,5'd6,tmp_101,tmp_102,tmp_103,4'b0000},{{3'b001,3'd1,tmp_104,13'b0000000000000},{{3'b010,{1'b1,tmp_105},tmp_106,2'b00},{{3'b000,5'd6,tmp_107,tmp_108,tmp_109,4'b0000},{{3'b001,3'd1,tmp_110,13'b0000000000000},{{3'b010,{1'b1,tmp_111},tmp_112,2'b00},{{3'b000,5'd6,tmp_113,tmp_114,tmp_115,4'b0000},{{3'b001,3'd1,tmp_116,13'b0000000000000},{{3'b110,24'b000000000000000000000000},{{3'b010,{1'b1,tmp_117},tmp_118,2'b00},{{3'b000,5'd15,tmp_119,tmp_120,tmp_121,4'b0000},{{3'b010,{1'b1,tmp_122},tmp_123,2'b00},{{3'b000,5'd16,tmp_124,tmp_125,tmp_126,4'b0000},{{3'b010,{1'b1,tmp_127},tmp_128,2'b00},{{3'b000,5'd1,tmp_129,tmp_130,tmp_131,4'b0000},{{3'b001,3'd5,tmp_132,13'b0000000000000},{(83) {{3'b110,24'b000000000000000000000000}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}};
  genvar n_137;
  generate
  for (n_137=0; n_137 < 128; n_137=n_137+1) begin : array_n_138
    assign ROM_n_135[(128-1)-n_137] = romflat_n_136[n_137*27+:27];
  end
  endgenerate
  
  assign tmp_42 = ROM_n_135[repANF_15];
  // asyncRom end
  
  assign bodyVar_10 = tmp_42;
  
  assign bodyVar_11 = wild_16;
  
  assign bodyVar_12 = wild_17;
  
  assign repANF_13 = we_23;
  
  assign repANF_14 = wData_24;
  
  assign repANF_15 = wild_20;
  
  assign wild_16 = repANF_21;
  
  assign wild_17 = repANF_22;
  
  assign x_18 = eta_i1[16:16];
  
  assign y_19 = eta_i1[15:0];
  
  assign wild_20 = repANF_25;
  
  assign tmp_142 = $unsigned(x_26);
  
  assign repANF_21 = tmp_142;
  
  assign tmp_143 = $unsigned(x_27);
  
  assign repANF_22 = tmp_143;
  
  assign we_23 = ds1_2[41:41];
  
  assign wData_24 = ds1_2[40:25];
  
  assign tmp_144 = $signed(x_28);
  
  assign repANF_25 = tmp_144;
  
  assign x_26 = wAddr_30;
  
  assign x_27 = rAddr_31;
  
  // register begin
  reg signed [7:0] n_147;
  
  always @(posedge system1000 or negedge system1000_rstn) begin : register_System_sys_1_n_148
    if (~ system1000_rstn) begin
      n_147 <= 8'sd0;
    end else begin
      n_147 <= repANF_29;
    end
  end
  
  assign tmp_145 = n_147;
  // register end
  
  assign x_28 = tmp_145;
  
  assign repANF_29 = pczm_32;
  
  assign wAddr_30 = ds1_2[55:49];
  
  assign rAddr_31 = ds1_2[48:42];
  
  assign pczm_32 = ds1_2[24:17];
endmodule
