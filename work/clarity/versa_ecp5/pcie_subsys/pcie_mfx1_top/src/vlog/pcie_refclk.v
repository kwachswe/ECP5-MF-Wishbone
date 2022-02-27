// Verilog netlist produced by program ASBGen: Ports rev. 2.23, Attr. rev. 2.29
// Netlist written on Sun May 11 14:42:21 2014
//
// Verilog Description of module ext_refclk_buf
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

