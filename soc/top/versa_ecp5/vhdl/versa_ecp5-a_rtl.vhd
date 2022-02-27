
--    
--    Copyright Ingenieurbuero Gardiner, 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--   
--------------------------------------------------------------------------------
--
-- File ID    : $Id: versa_ecp5-a_rtl.vhd 111 2022-01-17 23:03:43Z  $
-- Generated  : $LastChangedDate: 2022-01-18 00:03:43 +0100 (Tue, 18 Jan 2022) $
-- Revision   : $LastChangedRevision: 111 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------
Library ECP5UM;
Library IEEE;

Use ECP5UM.all;
Use IEEE.numeric_std.all;
Use WORK.core_mf8c_exports.all;
Use WORK.versa_ecp5_comps.all;
Use WORK.tspc_utils.all;

Architecture Rtl of versa_ecp5 is
   constant c_tech_lib        : string := "ECP5UM";

   constant c_cdc_sz_u3       : natural := 2;
   constant c_nr_uarts        : natural := 5;

   constant c_tie_high        : std_logic := '1';
   constant c_tie_low         : std_logic := '0';

   signal s_rtl_gpio_sw4      : std_logic_vector(7 downto 0);
   signal s_rtl_rst_n         : std_logic;
   signal s_rtl_spi_clk_ts    : std_logic;
   signal s_rtl_spi_miso      : std_logic;
   signal s_rtl_uart_cts      : std_logic_vector(c_nr_uarts - 1 downto 0);
   signal s_rtl_uart_rx       : std_logic_vector(c_nr_uarts - 1 downto 0);
   signal s_rtl_u3_cdc_in     : std_logic_vector(c_cdc_sz_u3 - 1 downto 0);
   signal s_u1_clk_sys        : std_logic;
   signal s_u1_dl_up          : std_logic;
   signal s_u1_gpio_led       : std_logic_vector(7 downto 0);
   signal s_u1_ltssm_state    : std_logic_vector(3 downto 0);
   signal s_u1_spi_mosi       : std_logic;
   signal s_u1_spi_mosi_en    : std_logic;
   signal s_u1_spi_sclk       : std_logic;
   signal s_u1_spi_ssel       : std_logic;
   signal s_u1_uart_tx        : std_logic_vector(c_nr_uarts - 1 downto 0);
   signal s_u3_cdc_out        : std_logic_vector(c_cdc_sz_u3 - 1 downto 0);
   
   Component USRMCLK
      Port (
         USRMCLKI    : in  std_logic;
         USRMCLKTS   : in  std_logic
         );
   End Component;

   attribute syn_black_box             : boolean;
   attribute syn_noprune               : boolean;
   
   attribute syn_black_box of USRMCLK  : Component is true;
   attribute syn_noprune of USRMCLK    : Component is true;
   
Begin
   DL_UP          <= not s_u1_dl_up;
   
   GPIO_LED_0     <= s_u1_gpio_led(0);
   GPIO_LED_1     <= s_u1_gpio_led(1);
   GPIO_LED_2     <= not s_u1_gpio_led(2);

   LTSSM_0        <= not s_u1_ltssm_state(0);
   LTSSM_1        <= not s_u1_ltssm_state(1);
   LTSSM_2        <= not s_u1_ltssm_state(2);
   LTSSM_3        <= not s_u1_ltssm_state(3);

   SEGL_A         <= c_tie_high;
   SEGL_B         <= not s_u1_dl_up;
   SEGL_C         <= c_tie_low;
   SEGL_D         <= c_tie_high;
   SEGL_E         <= c_tie_high;
   SEGL_K         <= c_tie_high;
   SEGL_P         <= c_tie_high;
   SEGL_DP        <= not s_u1_dl_up;

   SF_CS_N        <= s_u3_cdc_out(1);
   SF_MOSI        <= s_u1_spi_mosi when (s_u1_spi_mosi_en = '1') else 'Z';
   
   UART_TX_0      <= s_u1_uart_tx(0);
   UART_TX_1      <= s_u1_uart_tx(1);
   UART_TX_2      <= s_u1_uart_tx(2);
   UART_TX_3      <= s_u1_uart_tx(3);
   UART_TX_4      <= s_u1_uart_tx(4);

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_rtl_gpio_sw4    <= (0 => GPIO_SW4_1, 1 => GPIO_SW4_2, others => '0');
   s_rtl_rst_n       <= to_x01(PERST_N);
   s_rtl_spi_clk_ts  <= s_u3_cdc_out(0);
   s_rtl_spi_miso    <= to_x01(SF_MISO);
   s_rtl_uart_cts    <= (others => c_tie_high);

   s_rtl_uart_rx     <= UART_RX_4 & UART_RX_3 & UART_RX_2 & UART_RX_1 & UART_RX_0;

   s_rtl_u3_cdc_in   <= (not s_u1_spi_ssel) & (not s_u1_spi_ssel);
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U1_CORE:
   core_mf8c
      Generic Map (
         g_nr_uarts      => c_nr_uarts,
         g_tech_lib      => c_tech_lib
         )
      Port Map (
         i_gpio_sw4              => s_rtl_gpio_sw4,
         i_hdinn0                => HDIN0_N,
         i_hdinp0                => HDIN0_P,
         i_perst_n               => s_rtl_rst_n,
         i_refclkn               => REFCLK_N,
         i_refclkp               => REFCLK_P,
         i_spi_miso              => s_rtl_spi_miso,
         i_uart_cts              => s_rtl_uart_cts,
         i_uart_rx               => s_rtl_uart_rx,

         o_clk_sys               => s_u1_clk_sys,
         o_dl_up                 => s_u1_dl_up,
         o_gpio_led              => s_u1_gpio_led,
         o_hdoutn0               => HDOUT0_N,
         o_hdoutp0               => HDOUT0_P,
         o_ltssm_state           => s_u1_ltssm_state,
         o_spi_mosi              => s_u1_spi_mosi,
         o_spi_mosi_en           => s_u1_spi_mosi_en,
         o_spi_sclk              => s_u1_spi_sclk,
         o_spi_ssel              => s_u1_spi_ssel,              
         o_uart_rts              => open,
         o_uart_tx               => s_u1_uart_tx
         );
         
   U2_MCLK:
   USRMCLK 
      Port MAP (
         USRMCLKI    => s_u1_spi_sclk,
         USRMCLKTS   => s_rtl_spi_clk_ts
         );
         
   U3_SYNC:
   tspc_cdc_vec
      Port Map ( 
         i_clk          => s_u1_clk_sys,
         i_rst_n        => s_rtl_rst_n,
         
         i_cdc_in       => s_rtl_u3_cdc_in,
         
         o_cdc_out      => s_u3_cdc_out
         );         
End Rtl;
