
--
--    Copyright Ing. Buero Gardiner 2017 - 2018
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_cfi_spim_pw2n-e.vhd 4774 2019-05-12 09:19:45Z  $
-- Generated   : $LastChangedDate: 2019-05-12 11:19:45 +0200 (Sun, 12 May 2019) $
-- Revision    : $LastChangedRevision: 4774 $
--
--------------------------------------------------------------------------------
--
-- Description :
--       i_clk          : 2x SPI Frequency
--       i_xfer_attrib  : data b"00", cmd b="01", resp b"10", cmd/resp "11"
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Entity tspc_cfi_spim_pw2n is
   Generic (
      g_ssel_hld  : positive := 1;
      g_ssel_su   : positive := 1
      );
   Port (
      i_clk                : in  std_logic;
      i_rst_n              : in  std_logic;
      i_clr                : in  std_logic;
      
      i_mode_cpha          : in  std_logic;
      i_mode_cpol          : in  std_logic;
      i_mode_half_dplx     : in  std_logic;
      i_mode_lsb_first     : in  std_logic;
      i_mode_wr            : in  std_logic;
      i_rx_last            : in  std_logic;
      i_rx_rdy             : in  std_logic;
      i_spi_miso           : in  std_logic;
      i_tx_last            : in  std_logic;
      i_tx_rdy             : in  std_logic;
      i_tx_wdat            : in  std_logic_vector;
      i_xfer_attrib        : in  std_logic_vector;
      i_xfer_en            : in  std_logic;
         
      o_rxdat              : out std_logic_vector;
      o_rxdat_push         : out std_logic;
      o_spi_busy           : out std_logic;
      o_spi_end_ev         : out std_logic;
      o_spi_mosi           : out std_logic;
      o_spi_mosi_en        : out std_logic;
      o_spi_sclk           : out std_logic;
      o_spi_sclk_en        : out std_logic;
      o_spi_ssel           : out std_logic;
      o_txdat_pop          : out std_logic
      );
End tspc_cfi_spim_pw2n;
