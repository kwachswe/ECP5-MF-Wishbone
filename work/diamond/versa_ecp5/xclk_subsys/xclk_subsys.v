/* synthesis translate_off*/
`define SBP_SIMULATION
/* synthesis translate_on*/
`ifndef SBP_SIMULATION
`define SBP_SYNTHESIS
`endif

//
// Verific Verilog Description of module xclk_subsys
//
module xclk_subsys (pll_clk_base_CLKI, pll_clk_base_CLKOP, pll_clk_base_CLKOS, 
            pll_clk_base_CLKOS2, pll_clk_base_LOCK, pll_clk_base_RST) /* synthesis sbp_module=true */ ;
    input pll_clk_base_CLKI;
    output pll_clk_base_CLKOP;
    output pll_clk_base_CLKOS;
    output pll_clk_base_CLKOS2;
    output pll_clk_base_LOCK;
    input pll_clk_base_RST;
    
    
    pll_clk_base pll_clk_base_inst (.CLKI(pll_clk_base_CLKI), .CLKOP(pll_clk_base_CLKOP), 
            .CLKOS(pll_clk_base_CLKOS), .CLKOS2(pll_clk_base_CLKOS2), .LOCK(pll_clk_base_LOCK), 
            .RST(pll_clk_base_RST));
    
endmodule

