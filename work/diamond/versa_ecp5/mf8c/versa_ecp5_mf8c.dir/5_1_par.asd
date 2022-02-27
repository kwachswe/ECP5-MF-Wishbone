[ActiveSupport PAR]
; Global primary clocks
GLOBAL_PRIMARY_USED = 10;
; Global primary clock #0
GLOBAL_PRIMARY_0_SIGNALNAME = s_u1_clk_sys;
GLOBAL_PRIMARY_0_DRIVERTYPE = PCSCLKDIV;
GLOBAL_PRIMARY_0_LOADNUM = 5985;
; Global primary clock #1
GLOBAL_PRIMARY_1_SIGNALNAME = U1_CORE/U1_PCIE.U1_E5/s_u2_pclk;
GLOBAL_PRIMARY_1_DRIVERTYPE = PCSCLKDIV;
GLOBAL_PRIMARY_1_LOADNUM = 235;
; Global primary clock #2
GLOBAL_PRIMARY_2_SIGNALNAME = U1_CORE/U3_CLK/U1_PLL.PLL_E5/CLKOP;
GLOBAL_PRIMARY_2_DRIVERTYPE = PLL;
GLOBAL_PRIMARY_2_LOADNUM = 1;
; Global primary clock #3
GLOBAL_PRIMARY_3_SIGNALNAME = U1_CORE/U1_PCIE.U1_E5/s_u3_refclk;
GLOBAL_PRIMARY_3_DRIVERTYPE = EXTREF;
GLOBAL_PRIMARY_3_LOADNUM = 113;
; Global primary clock #4
GLOBAL_PRIMARY_4_SIGNALNAME = U1_CORE/U1_PCIE.U1_E5/U2_PHY/tx_pclk;
GLOBAL_PRIMARY_4_DRIVERTYPE = DCU;
GLOBAL_PRIMARY_4_LOADNUM = 31;
; Global primary clock #5
GLOBAL_PRIMARY_5_SIGNALNAME = U1_CORE/U1_PCIE.U1_E5/U2_PHY/ff_rx_fclk_0;
GLOBAL_PRIMARY_5_DRIVERTYPE = DCU;
GLOBAL_PRIMARY_5_LOADNUM = 74;
; Global primary clock #6
GLOBAL_PRIMARY_6_SIGNALNAME = U1_CORE/U3_CLK/o_clk_pll_out;
GLOBAL_PRIMARY_6_DRIVERTYPE = PLL;
GLOBAL_PRIMARY_6_LOADNUM = 1;
; Global primary clock #7
GLOBAL_PRIMARY_7_SIGNALNAME = U1_CORE/s_u3_xclk;
GLOBAL_PRIMARY_7_DRIVERTYPE = SLICE;
GLOBAL_PRIMARY_7_LOADNUM = 528;
; Global primary clock #8
GLOBAL_PRIMARY_8_SIGNALNAME = U1_CORE/s_u3_clk_spi;
GLOBAL_PRIMARY_8_DRIVERTYPE = PLL;
GLOBAL_PRIMARY_8_LOADNUM = 39;
; Global primary clock #9
GLOBAL_PRIMARY_9_SIGNALNAME = U1_CORE/s_u1_rst_n;
GLOBAL_PRIMARY_9_DRIVERTYPE = SLICE;
GLOBAL_PRIMARY_9_LOADNUM = 0;
; # of global secondary clocks
GLOBAL_SECONDARY_USED = 0;
; I/O Bank 0 Usage
BANK_0_USED = 2;
BANK_0_AVAIL = 27;
BANK_0_VCCIO = 3.3V;
BANK_0_VREF1 = NA;
BANK_0_VREF2 = NA;
; I/O Bank 1 Usage
BANK_1_USED = 2;
BANK_1_AVAIL = 33;
BANK_1_VCCIO = 2.5V;
BANK_1_VREF1 = NA;
BANK_1_VREF2 = NA;
; I/O Bank 2 Usage
BANK_2_USED = 10;
BANK_2_AVAIL = 32;
BANK_2_VCCIO = 2.5V;
BANK_2_VREF1 = NA;
BANK_2_VREF2 = NA;
; I/O Bank 3 Usage
BANK_3_USED = 9;
BANK_3_AVAIL = 33;
BANK_3_VCCIO = 2.5V;
BANK_3_VREF1 = NA;
BANK_3_VREF2 = NA;
; I/O Bank 6 Usage
BANK_6_USED = 0;
BANK_6_AVAIL = 33;
BANK_6_VCCIO = NA;
BANK_6_VREF1 = NA;
BANK_6_VREF2 = NA;
; I/O Bank 7 Usage
BANK_7_USED = 3;
BANK_7_AVAIL = 32;
BANK_7_VCCIO = 2.5V;
BANK_7_VREF1 = NA;
BANK_7_VREF2 = NA;
; I/O Bank 8 Usage
BANK_8_USED = 4;
BANK_8_AVAIL = 13;
BANK_8_VCCIO = 3.3V;
BANK_8_VREF1 = NA;
BANK_8_VREF2 = NA;
