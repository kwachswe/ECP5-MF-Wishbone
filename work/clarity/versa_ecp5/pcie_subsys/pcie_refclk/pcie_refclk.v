// Verilog netlist produced by program ASBGen: Ports rev. 2.30, Attr. rev. 2.65
// Netlist written on Sun Feb 27 15:22:35 2022
//
// Verilog Description of module pcie_refclk
//

`timescale 1ns/1ps
module pcie_refclk (refclkp, refclkn, refclko);
    input refclkp;
    input refclkn;
    output refclko;
    
    
    EXTREFB EXTREF0_inst (.REFCLKP(refclkp), .REFCLKN(refclkn), .REFCLKO(refclko)) /* synthesis LOC=EXTREF0 */ ;
    defparam EXTREF0_inst.REFCK_PWDNB = "0b1";
    defparam EXTREF0_inst.REFCK_RTERM = "0b1";
    defparam EXTREF0_inst.REFCK_DCBIAS_EN = "0b0";
    
endmodule

