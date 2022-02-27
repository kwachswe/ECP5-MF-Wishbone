--
--    Copyright Ing. Buero Gardiner 2008 - 2012
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_dma_chan_ms_comps-p.vhd 4939 2019-08-25 23:22:59Z  $
-- Generated   : $LastChangedDate: 2019-08-26 01:22:59 +0200 (Mon, 26 Aug 2019) $
-- Revision    : $LastChangedRevision: 4939 $
--
--------------------------------------------------------------------------------
--
-- Description :
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use WORK.tspc_dma_chan_ms_types.all;
Use WORK.tspc_utils.all;

Package tspc_dma_chan_ms_comps is

   Component tspc_dma_chan_ms_ctl
      Generic (
         g_dma_burst_words_rd : positive := 32;
         g_dma_burst_words_wr : positive := 32;
         g_dma_xfer_atomic    : boolean := true;
         g_fifo_mem_words     : positive;
         g_is_master          : boolean := false;
         g_mode_ms            : boolean := false
         );
      Port (
         i_clk                : in  std_logic;
         i_rst_n              : in  std_logic;

         i_dma_adr            : in  std_logic_vector;
         i_dma_clr            : in  std_logic;
         i_dma_cmd_rdy        : in  std_logic;
         i_dma_int_period     : in  std_logic_vector;
         i_dma_mode_sg        : in  std_logic;
         i_dma_mode_strm      : in  std_logic;
         i_dma_mode_wr        : in  std_logic;
         i_dma_run            : in  std_logic;
         i_dma_xfer_adr_rst   : in  std_logic;
         i_dma_xfer_int_done  : in  std_logic;
         i_dma_xfer_seq_last  : in  std_logic;
         i_dma_xfer_count     : in  std_logic_vector;
         i_fifo_rd_count      : in  std_logic_vector;
         i_fifo_rdat          : in  std_logic_vector;
         i_fifo_wr_free       : in  std_logic_vector;
         i_mem_buf_words      : in  std_logic_vector;
         i_slv_idle           : in  std_logic;
         i_slv_lseq_start     : in  std_logic;
         i_tick_timeout       : in  std_logic;
         i_wbm_ack            : in  std_logic;
         i_wbm_dat            : in  std_logic_vector;

         o_chain_active       : out std_logic;
         o_dma_adr_pop        : out std_logic;
         o_dma_cmd_pop        : out std_logic;
         o_dma_idle           : out std_logic;
         o_dma_wr             : out std_logic;
         o_ev_cmd_fifo_empty  : out std_logic;
         o_ev_dma_cmd_done    : out std_logic;
         o_ev_dma_int_period  : out std_logic;
         o_ev_dma_int_xfer    : out std_logic;
         o_ev_dma_lseq_start  : out std_logic;
         o_ev_dma_seq_done    : out std_logic;
         o_fifo_pop           : out std_logic;
         o_fifo_push          : out std_logic;
         o_fifo_wdat          : out std_logic_vector;
         o_mem_buf_pos        : out std_logic_vector;
         o_slv_push           : out std_logic;
         o_slv_run            : out std_logic;
         o_slv_seq_last       : out std_logic;
         o_slv_wr             : out std_logic;
         o_slv_xfer_count     : out std_logic_vector;
         o_wbm_adr            : out std_logic_vector;
         o_wbm_bte            : out std_logic_vector;
         o_wbm_cti            : out std_logic_vector;
         o_wbm_cyc            : out std_logic;
         o_wbm_dat            : out std_logic_vector;
         o_wbm_sel            : out std_logic_vector;
         o_wbm_stb            : out std_logic;
         o_wbm_we             : out std_logic
         );
   End Component;


   Component tspc_fifo_sync
      Generic (
         g_mem_dmram    : boolean := false;
         g_mem_words    : positive := 256;
         g_rd_latency   : positive range 1 to 2 := 1;
         g_tech_lib     : string := "ECP3"
         );
      Port (
         i_clk          : in  std_logic;
         i_rst_n        : in  std_logic;
         i_clr          : in  std_logic;

         i_rd_pop       : in  std_logic;
         i_wr_din       : in  std_logic_vector;
         i_wr_push      : in  std_logic;

         o_rd_aempty    : out std_logic;
         o_rd_count     : out std_logic_vector(f_vec_msb(g_mem_words) downto 0);
         o_rd_dout      : out std_logic_vector;
         o_rd_empty     : out std_logic;
         o_wr_afull     : out std_logic;
         o_wr_free      : out std_logic_vector(f_vec_msb(g_mem_words) downto 0);
         o_wr_full      : out std_logic
         );
   End Component;

End tspc_dma_chan_ms_comps;
