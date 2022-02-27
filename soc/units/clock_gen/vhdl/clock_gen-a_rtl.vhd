--------------------------------------------------------------------------------
--
-- File ID     : $Id: clock_gen-a_rtl.vhd 83 2021-12-12 22:09:26Z  $
-- Generated   : $LastChangedDate: 2021-12-12 23:09:26 +0100 (Sun, 12 Dec 2021) $
-- Revision    : $LastChangedRevision: 83 $
--
--------------------------------------------------------------------------------
--
-- Description : Clock generation Unit
--
--------------------------------------------------------------------------------

Library PMI_WORK;
Use PMI_WORK.all;

Architecture Rtl of clock_gen is

   constant c_tie_high  : std_logic := '1';
   constant c_tie_low   : std_logic := '0';

   signal s_rtl_xclk       : std_logic;
   signal s_rtl_rst        : std_logic;
   signal s_u1_clk_spi     : std_logic;
   signal s_u1_xclk_base   : std_logic;
   
   Component pmi_pll_fp
      Generic (
         pmi_freq_clki     : string := "100.0";
         pmi_freq_clkfb    : string := "100.0";
         pmi_freq_clkop    : string := "100.0";
         pmi_freq_clkos    : string := "100.0";
         pmi_freq_clkok    : string := "50.0";
         pmi_family        : string := "EC";
         pmi_phase_adj     : string := "0.0";
         pmi_duty_cycle    : string := "50.0";
         pmi_clkfb_source  : string := "CLKOP";
         pmi_fdel          : string := "off";
         pmi_fdel_val      : integer := 0;
         module_type       : string := "pmi_pll_fp"
         );
      Port (
         CLKI     : in std_logic;
         CLKFB    : in std_logic;
         RESET    : in std_logic;
         CLKOP    : out std_logic;
         CLKOS    : out std_logic;
         CLKOK    : out std_logic;
         CLKOK2   : out std_logic;
         LOCK     : out std_logic
         );
   End Component;

   Component pll_xclk_base
      Port (
         RST      : in  std_logic;
         CLKI     : in  std_logic;
         CLKOP    : out std_logic;
         CLKOS    : out std_logic;
         CLKOS2   : out std_logic;
         LOCK     : out std_logic
         );
   End Component;         

   Component pll_xclk_e3
      Port (
         CLK   : in  std_logic; 
         RESET : in  std_logic; 
         CLKOP : out std_logic; 
         CLKOS : out std_logic; 
         CLKOK : out std_logic; 
         LOCK  : out std_logic
         );
   End Component;      
   
Begin
   o_xclk         <= s_rtl_xclk;
   
   o_clk_pll_out  <= s_u1_xclk_base;
   o_clk_spi      <= s_u1_clk_spi;
   
   s_rtl_rst   <= not i_rst_n;

   
   U1_PLL:
   if g_tech_lib = "ECP3" generate
      PLL_E3:
      pll_xclk_e3
         Port Map (
            CLK      => i_clk_125m, 
            RESET    => s_rtl_rst, 
            CLKOP    => open, 
            CLKOS    => s_u1_xclk_base, 
            CLKOK    => s_u1_clk_spi, 
            LOCK     => o_pll_lock
            );   
            
   else generate
      PLL_E5:
      pll_xclk_base
         Port Map (
            RST      => s_rtl_rst,
            CLKI     => i_clk_125m,
            CLKOP    => open,
            CLKOS    => s_u1_xclk_base,
            CLKOS2   => s_u1_clk_spi,
            LOCK     => o_pll_lock  
            );
   end generate;

   R_MAIN:
   process(i_rst_n, s_u1_xclk_base)
   begin
      if (i_rst_n = '0') then
         s_rtl_xclk  <= '0';
      elsif (rising_edge(s_u1_xclk_base)) then
         s_rtl_xclk  <= not s_rtl_xclk;
      end if;
   end process;
   
-- U1_PLL:
-- pmi_pll_fp
--    Generic Map (
--       pmi_freq_clki     => "125.0",
--       pmi_freq_clkfb    => "100.0",
--       pmi_freq_clkop    => "100.0",
--       pmi_freq_clkos    => "1.851852",
--       pmi_freq_clkok    => "1.851852",
--       pmi_family        => g_tech_lib
--       )
--    Port Map (
--       CLKI     => i_clk_125m,
--       CLKFB    => s_u1_clkop,
--       RESET    => s_rtl_rst,
--       CLKOP    => s_u1_clkop,
--       CLKOS    => s_u1_clkos,
--       CLKOK    => s_u1_clkok,
--       CLKOK2   => open,
--       LOCK     => o_lock_1m85
--       );
End Rtl;
