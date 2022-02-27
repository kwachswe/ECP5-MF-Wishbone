
--
--    Copyright Ing. Buero Gardiner 2017 - 2018
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_spi_mst_cfi-e.vhd 4583 2019-02-02 16:37:55Z  $
-- Generated   : $LastChangedDate: 2019-02-02 17:37:55 +0100 (Sat, 02 Feb 2019) $
-- Revision    : $LastChangedRevision: 4583 $
--
--------------------------------------------------------------------------------
--
-- Description :
--    cpol  : Clock polarity. 1 => Clock Idle is High
--    cpha  : Clock Phase.    1 => Transmit on leading edge, sample on trailing
--
--    If i_mode_xfer_sz is zero, the repetitive shift counter size is taken 
--    from the width of i_cmd_in (e.g. byte). The controller will shift data
--    units until i_rx_rdy, i_tx_rdy or i_xmit_en are false. 
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Entity tspc_spi_mst_cfi is
   Generic (
      g_ssel_hld  : positive := 1;
      g_ssel_su   : positive := 1
      );
   Port (
      i_clk                : in  std_logic;
      i_rst_n              : in  std_logic;
      i_clr                : in  std_logic;
      
      i_adr_in             : in  std_logic_vector;
      i_adr_rdy            : in  std_logic;      
      i_cmd_in             : in  std_logic_vector;
      i_cmd_rdy            : in  std_logic;
      i_has_pload          : in  std_logic;
      i_mode_cpha          : in  std_logic;
      i_mode_cpol          : in  std_logic;
      i_mode_lsb_first     : in  std_logic;
      i_mode_wr            : in  std_logic;
      i_mode_xfer_sz       : in  std_logic_vector;
      i_rx_last            : in  std_logic;
      i_rx_rdy             : in  std_logic;
      i_spi_en             : in  std_logic;
      i_spi_miso           : in  std_logic;
      i_tx_rdy             : in  std_logic;
      i_tx_wdat            : in  std_logic_vector;
      
      o_adr_out            : out std_logic_vector;
      o_adr_pop            : out std_logic;
      o_adr_push           : out std_logic;
      o_cmd_pop            : out std_logic;
      o_rxdat              : out std_logic_vector;
      o_rxdat_push         : out std_logic;
      o_spi_adr_phase      : out std_logic;      
      o_spi_busy           : out std_logic;
      o_spi_cmd_phase      : out std_logic;
      o_spi_end_ev         : out std_logic;
      o_spi_mosi           : out std_logic;
      o_spi_mosi_en        : out std_logic;
      o_spi_sclk           : out std_logic;
      o_spi_sclk_en        : out std_logic;
      o_spi_ssel           : out std_logic;
      o_sta_out            : out std_logic_vector;
      o_sta_valid          : out std_logic;
      o_txdat_pop          : out std_logic
      );
End tspc_spi_mst_cfi;
