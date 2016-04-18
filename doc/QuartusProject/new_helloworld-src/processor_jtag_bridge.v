
    module processor_jtag_bridge(
        input wire[0:0] proc_oEn
        , input wire[15:0] proc_oData
        
        , output wire chipselect
        , output wire address
        , output wire write_n
        , output wire[31:0] writedata
    );
    assign chipselect = proc_oEn;
    assign write_n    = ~proc_oEn;
    assign address    = proc_oData[8];
    assign writedata  = address == 0 ? {24'd0,proc_oData[7:0]} : 32'd2;
    endmodule


