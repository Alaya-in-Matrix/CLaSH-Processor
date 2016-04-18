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
