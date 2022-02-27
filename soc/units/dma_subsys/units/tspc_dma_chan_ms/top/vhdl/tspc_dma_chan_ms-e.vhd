
--
--    Copyright Ing. Buero Gardiner 2008 - 2012
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_dma_chan_ms-e.vhd 4638 2019-02-17 10:40:54Z  $
-- Generated   : $LastChangedDate: 2019-02-17 11:40:54 +0100 (Sun, 17 Feb 2019) $
-- Revision    : $LastChangedRevision: 4638 $
--
--------------------------------------------------------------------------------
--
-- Description :
--       i_dbuf_words      : Used for computing wrap of o_dbuf_pos
--       i_dma_xfer_words  : Total size of DMA Transfer
--       o_ev_dma_int_xfer : Signalled if i_dma_xfer_int_done is set on command
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use WORK.tspc_dma_chan_ms_types.all;

Entity tspc_dma_chan_ms is
   Generic (
      g_dma_burst_words_rd_hc : positive := 32;
      g_dma_burst_words_rd_lc : positive := 32;
      g_dma_burst_words_wr_hc : positive := 32;
      g_dma_burst_words_wr_lc : positive := 32;
      g_fifo_mem_words_dp     : positive := 512;
      g_fifo_mem_words_hc     : positive := 512;
      g_fifo_mem_words_lc     : positive := 512;
      g_fifo_rd_latency_dp    : positive range 1 to 2 := 2;
      g_fifo_rd_latency_hc    : positive range 1 to 2 := 2;
      g_fifo_rd_latency_lc    : positive range 1 to 2 := 2;
      g_tech_lib              : string := "ECP3"
      );
   Port (
      i_clk                : in  std_logic;
      i_rst_n              : in  std_logic;

      i_dma_chh_adr        : in  std_logic_vector;
      i_dma_chl_adr        : in  std_logic_vector;
      i_dma_ctl            : in  t_tspc_dma_ms_ctl;
      i_dma_xfer_flags     : in  t_tspc_dma_ms_flags;
      i_dma_xfer_sz        : in  std_logic_vector;
      i_tick_timeout       : in  std_logic;
      i_wbmh_ack           : in  std_logic;
      i_wbmh_dat           : in  std_logic_vector;
      i_wbml_ack           : in  std_logic;
      i_wbml_dat           : in  std_logic_vector;

      o_chh_cfifo_count    : out std_logic_vector;
      o_chl_cfifo_count    : out std_logic_vector;
      o_dma_sta            : out t_tspc_dma_ms_sta;
      o_dma_xfer_pos       : out std_logic_vector;
      o_ev_int_req         : out std_logic;
      o_wbmh_adr           : out std_logic_vector;
      o_wbmh_bte           : out std_logic_vector;
      o_wbmh_cti           : out std_logic_vector;
      o_wbmh_cyc           : out std_logic;
      o_wbmh_dat           : out std_logic_vector;
      o_wbmh_sel           : out std_logic_vector;
      o_wbmh_stb           : out std_logic;
      o_wbmh_we            : out std_logic;
      o_wbml_adr           : out std_logic_vector;
      o_wbml_bte           : out std_logic_vector;
      o_wbml_cti           : out std_logic_vector;
      o_wbml_cyc           : out std_logic;
      o_wbml_dat           : out std_logic_vector;
      o_wbml_sel           : out std_logic_vector;
      o_wbml_stb           : out std_logic;
      o_wbml_we            : out std_logic
      );
End tspc_dma_chan_ms;              
