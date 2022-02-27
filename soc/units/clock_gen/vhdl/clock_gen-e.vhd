Library IEEE;
Use IEEE.std_logic_1164.all;

Entity clock_gen is
   Generic (
      g_tech_lib     : string := "ECP3"
      );
   Port (
      i_clk_125m     : in  std_logic;
      i_rst_n        : in  std_logic;

      o_clk_pll_out  : out std_logic;
      o_clk_spi      : out std_logic;
      o_pll_lock     : out std_logic;
      o_xclk         : out std_logic
      );
End clock_gen;
