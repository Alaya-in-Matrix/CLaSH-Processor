// Automatically generated Verilog-2001
module System_a4_2(eta_i1
                  ,topLet_o);
  input [55:0] eta_i1;
  output [55:0] topLet_o;
  wire [6:0] repANF_0;
  wire [6:0] repANF_1;
  wire [0:0] repANF_2;
  wire signed [15:0] repANF_3;
  wire signed [7:0] repANF_4;
  wire [0:0] repANF_5;
  wire signed [15:0] repANF_6;
  wire [6:0] x_7;
  wire [6:0] x_8;
  wire [0:0] x_9;
  wire signed [15:0] x_10;
  wire signed [7:0] x_11;
  wire [0:0] x_12;
  wire signed [15:0] x_13;
  assign repANF_0 = x_7;
  
  assign repANF_1 = x_8;
  
  assign repANF_2 = x_9;
  
  assign repANF_3 = x_10;
  
  assign repANF_4 = x_11;
  
  assign repANF_5 = x_12;
  
  assign repANF_6 = x_13;
  
  assign x_7 = eta_i1[55:49];
  
  assign x_8 = eta_i1[48:42];
  
  assign x_9 = eta_i1[41:41];
  
  assign x_10 = eta_i1[40:25];
  
  assign x_11 = eta_i1[24:17];
  
  assign x_12 = eta_i1[16:16];
  
  assign x_13 = eta_i1[15:0];
  
  assign topLet_o = {repANF_0
                    ,repANF_1
                    ,repANF_2
                    ,repANF_3
                    ,repANF_4
                    ,repANF_5
                    ,repANF_6};
endmodule
