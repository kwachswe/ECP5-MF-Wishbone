
--    
--    Copyright Ingenieurbuero Gardiner, 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--   
--------------------------------------------------------------------------------
--
-- File ID    : $Id: core_mf8c-e.vhd 83 2021-12-12 22:09:26Z  $
-- Generated  : $LastChangedDate: 2021-12-12 23:09:26 +0100 (Sun, 12 Dec 2021) $
-- Revision   : $LastChangedRevision: 83 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;

Entity core_mf8c is
   Generic (
      g_nr_uarts       : natural := 6;
      g_tech_lib       : string := "ECP5UM"
      );
   Port (
      i_gpio_sw4              : in  std_logic_vector(7 downto 0);
      i_hdinn0                : in  std_logic;
      i_hdinp0                : in  std_logic;
      i_perst_n               : in  std_logic;
      i_refclkn               : in  std_logic;
      i_refclkp               : in  std_logic;
      i_spi_miso              : in  std_logic;
      i_uart_cts              : in  std_logic_vector(g_nr_uarts - 1 downto 0);
      i_uart_rx               : in  std_logic_vector(g_nr_uarts - 1 downto 0);

      o_clk_sys               : out std_logic;
      o_dl_up                 : out std_logic;
      o_gpio_led              : out std_logic_vector(7 downto 0);      
      o_hdoutn0               : out std_logic;
      o_hdoutp0               : out std_logic;
      o_ltssm_state           : out std_logic_vector(3 downto 0);
      o_spi_mosi              : out std_logic;
      o_spi_mosi_en           : out std_logic;
      o_spi_sclk              : out std_logic;
      o_spi_ssel              : out std_logic;            
      o_uart_rts              : out std_logic_vector(g_nr_uarts - 1 downto 0);
      o_uart_tx               : out std_logic_vector(g_nr_uarts - 1 downto 0)
      );
End core_mf8c;
