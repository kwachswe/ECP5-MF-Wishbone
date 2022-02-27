
--
--    Copyright Ingenieurbuero Gardiner, 2013 - 2018
--
--    All Rights Reserved
--
--       This proprietary software may be used only as authorised in a licensing,
--       product development or training agreement.
--
--       Copies may only be made to the extent permitted by such an aforementioned
--       agreement. This entire notice above must be reproduced on
--       all copies.
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: jxb3_spi_dma_tgt-e.vhd 4782 2019-05-12 17:45:37Z  $
-- Generated   : $LastChangedDate: 2019-05-12 19:45:37 +0200 (Sun, 12 May 2019) $
-- Revision    : $LastChangedRevision: 4782 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use WORK.tspc_wbone_types.all;

Entity jxb3_spi_dma_tgt is
   Generic (
      g_spi_adr_sz      : positive := 24
      );
   Port (
      i_clk                : in  std_logic;
      i_rst_n              : in  std_logic;
      i_clr                : in  std_logic;
      
      i_buf_din            : in  std_logic_vector;
      i_buf_rd_empty       : in  std_logic;
      i_buf_rd_last        : in  std_logic;
      i_buf_wr_full        : in  std_logic;
      i_buf_wr_last        : in  std_logic;
      i_dma_en             : in  std_logic;
      i_mbox_rx_din        : in  std_logic_vector;      
      i_mbox_rx_rdy        : in  std_logic;      
      i_mbox_tx_rdy        : in  std_logic;
      i_spi_busy           : in  std_logic;
      i_wb_adr             : in  std_logic_vector;
      i_wb_cti             : in  t_wb_cti;
      i_wb_cyc             : in  std_logic;
      i_wb_dat             : in  std_logic_vector;
      i_wb_sel             : in  std_logic_vector;
      i_wb_stb             : in  std_logic;
      i_wb_we              : in  std_logic;

      o_buf_dout           : out std_logic_vector;
      o_buf_pop            : out std_logic;
      o_buf_push           : out std_logic;    
      o_spi_en             : out std_logic;
      o_spi_rx_last        : out std_logic;
      o_spi_tx_last        : out std_logic;
      o_spi_wr             : out std_logic;
      o_spi_xfer_attribs   : out std_logic_vector;
      o_dma_idle           : out std_logic;
      o_mbox_rx_pop        : out std_logic;
      o_mbox_tx_push       : out std_logic;
      o_mbox_tx_wdat       : out std_logic_vector;
      o_wb_ack             : out std_logic;
      o_wb_dat             : out std_logic_vector    
      );
End jxb3_spi_dma_tgt;
