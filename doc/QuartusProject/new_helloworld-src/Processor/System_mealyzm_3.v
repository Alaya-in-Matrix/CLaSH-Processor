// Automatically generated Verilog-2001
module System_mealyzm_3(eta_i1
                       ,// clock
                       system1000
                       ,// asynchronous reset: active low
                       system1000_rstn
                       ,bodyVar_o);
  input [59:0] eta_i1;
  input system1000;
  input system1000_rstn;
  output [55:0] bodyVar_o;
  wire [55:0] y_0;
  wire [588:0] bodyVar_1;
  wire [588:0] altLet_2;
  wire [26:0] ww_3;
  wire signed [15:0] ww1_4;
  wire [0:0] ww2_5;
  wire signed [15:0] ww3_6;
  wire [532:0] x_7;
  wire [532:0] repANF_8;
  wire [532:0] x_9;
  wire [532:0] tmp_10;
  assign bodyVar_o = y_0;
  
  assign y_0 = bodyVar_1[55:0];
  
  assign bodyVar_1 = altLet_2;
  
  System_esprockellMealy_4 System_esprockellMealy_4_altLet_2
  (.bodyVar_o (altLet_2)
  ,.w_i1 (x_7)
  ,.ww_i2 (ww_3)
  ,.ww1_i3 (ww1_4)
  ,.ww2_i4 (ww2_5)
  ,.ww3_i5 (ww3_6));
  
  assign ww_3 = eta_i1[59:33];
  
  assign ww1_4 = eta_i1[32:17];
  
  assign ww2_5 = eta_i1[16:16];
  
  assign ww3_6 = eta_i1[15:0];
  
  // register begin
  reg [532:0] n_19;
  
  always @(posedge system1000 or negedge system1000_rstn) begin : register_System_mealyzm_3_n_20
    if (~ system1000_rstn) begin
      n_19 <= {{(32) {16'sd0}},1'b0,8'sd0,7'd20,{(1) {5'd0}}};
    end else begin
      n_19 <= repANF_8;
    end
  end
  
  assign tmp_10 = n_19;
  // register end
  
  assign x_7 = tmp_10;
  
  assign repANF_8 = x_9;
  
  assign x_9 = bodyVar_1[588:56];
endmodule
