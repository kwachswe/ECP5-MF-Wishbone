
--
--    Copyright Ing. Buero Gardiner 2008 - 2012
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_dma_chan_ms-a_rtl.vhd 4939 2019-08-25 23:22:59Z  $
-- Generated   : $LastChangedDate: 2019-08-26 01:22:59 +0200 (Mon, 26 Aug 2019) $
-- Revision    : $LastChangedRevision: 4939 $
--
--------------------------------------------------------------------------------
--
-- Description :
--       i_dbuf_words      : Used for computing wrap of o_dbuf_pos
--       i_dma_xfer_words  : Total size of DMA Transfer
--       o_ev_dma_int_xfer : Signalled if i_dma_xfer_int_done is set on command
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.numeric_std.all;

Use WORK.tspc_dma_chan_ms_comps.all;
Use WORK.tspc_dma_chan_ms_types.all;
USe WORK.tspc_utils.all;

Architecture Rtl of tspc_dma_chan_ms is
   constant c_chh_cmd_sz         : positive := f_get_packed_cmd_sz(i_dma_chh_adr'length, i_dma_xfer_sz'length);
   constant c_chh_fifo_count_msb : positive := f_vec_msb(g_fifo_mem_words_hc);
   constant c_chl_fifo_count_msb : positive := f_vec_msb(g_fifo_mem_words_lc);
   constant c_dpf_fifo_count_msb : positive := f_vec_msb(g_fifo_mem_words_dp);
   constant c_dword_shr          : positive := f_vec_size((i_wbmh_dat'length / 8) - 1);
   
   signal s_chh_u1_adr           : std_logic_vector(i_dma_chh_adr'length - 1 downto 0);
   signal s_chh_u1_cmd_rdy       : std_logic;
   signal s_chh_u1_flags         : t_tspc_dma_ms_flags;
   signal s_chh_u1_xfer_size     : std_logic_vector(i_dma_xfer_sz'length - 1 downto 0);
   signal s_chl_cmd_rdy          : std_logic;
   signal s_rtl_chh_cmd_din      : std_logic_vector(c_chh_cmd_sz - 1 downto 0);
   signal s_rtl_chh_cmd_push     : std_logic;
   signal s_rtl_chl_cmd_push     : std_logic;
   signal s_rtl_dpf_din          : std_logic_vector(i_wbmh_dat'length - 1 downto 0);
   signal s_rtl_dpf_pop          : std_logic;
   signal s_rtl_dpf_push         : std_logic;
   signal s_rtl_slv_xfer_din     : std_logic_vector(i_dma_xfer_sz'length downto 0);
   signal s_rtl_u2_cmd_rdy       : std_logic;
   signal s_rtl_u4_cmd_rdy       : std_logic;
   signal s_u1_fifo_dout         : std_logic_vector(c_chh_cmd_sz - 1 downto 0);  
   signal s_u1_rd_count          : std_logic_vector(c_chh_fifo_count_msb downto 0);
   signal s_u1_rd_empty          : std_logic;
   signal s_u1_wr_full           : std_logic;
   signal s_u2_fifo_dout         : std_logic_vector(i_dma_chl_adr'length -1 downto 0);
   signal s_u2_rd_count          : std_logic_vector(c_chl_fifo_count_msb downto 0);
   signal s_u2_rd_empty          : std_logic;
   signal s_u2_wr_full           : std_logic;
   signal s_u3_fifo_dout         : std_logic_vector(i_wbmh_dat'length - 1 downto 0);
   signal s_u3_rd_count          : std_logic_vector(c_dpf_fifo_count_msb downto 0);
   signal s_u3_rd_empty          : std_logic;
   signal s_u3_wr_free           : std_logic_vector(c_dpf_fifo_count_msb downto 0);
   signal s_u4_fifo_dout         : std_logic_vector(i_dma_xfer_sz'length downto 0);
   signal s_u4_rd_empty          : std_logic;
   signal s_u5_cmd_pop           : std_logic;
   signal s_u5_dma_idle          : std_logic;
   signal s_u5_ev_cmd_fifo_empty : std_logic;
   signal s_u5_ev_dma_seq_done   : std_logic;
   signal s_u5_fifo_pop          : std_logic;
   signal s_u5_fifo_push         : std_logic;
   signal s_u5_fifo_wdat         : std_logic_vector(i_wbmh_dat'length - 1 downto 0);
   signal s_u5_mem_buf_pos       : std_logic_vector(31 downto 0);
   signal s_u5_slv_push          : std_logic;
   signal s_u5_slv_run           : std_logic;
   signal s_u5_slv_seq_last      : std_logic;
   signal s_u5_slv_wr            : std_logic;
   signal s_u5_slv_xfer_words    : std_logic_vector(i_dma_xfer_sz'length - 1 downto 0);
   signal s_u6_adr_pop           : std_logic;
   signal s_u6_chain_active      : std_logic;
   signal s_u6_cmd_pop           : std_logic;   
   signal s_u6_dma_idle          : std_logic;
   signal s_u6_ev_cmd_fifo_empty : std_logic;
   signal s_u6_fifo_pop          : std_logic;
   signal s_u6_fifo_push         : std_logic;
   signal s_u6_fifo_wdat         : std_logic_vector(i_wbmh_dat'length - 1 downto 0);
   signal s_u6_lseq_start        : std_logic;
   signal s_u6_mem_buf_pos       : std_logic_vector(31 downto 0);
   signal s_u6_slv_xfer_count    : std_logic_vector(i_dma_xfer_sz'length - 1 downto 0);

Begin
   o_chh_cfifo_count <= std_logic_vector(resize(unsigned(s_u1_rd_count), o_chh_cfifo_count'length ));
   o_chl_cfifo_count <= std_logic_vector(resize(unsigned(s_u2_rd_count), o_chl_cfifo_count'length ));
      
   o_dma_sta         <= (lcfifo_empty  => s_u2_rd_empty,
                         hcfifo_empty  => s_u1_rd_empty,
                         dma_wait      => '0',
                         dma_idle      => s_u5_dma_idle,
                         dfifo_empty   => s_u3_rd_empty);
                         
   o_dma_xfer_pos    <= std_logic_vector(resize(unsigned(s_u5_mem_buf_pos), o_dma_xfer_pos'length ));

   o_ev_int_req      <= s_u5_ev_dma_seq_done or (s_u5_ev_cmd_fifo_empty and not i_dma_ctl.int_dis_hfe)
                                             or (s_u6_ev_cmd_fifo_empty and not i_dma_ctl.int_dis_lfe);
                                             
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_chh_u1_adr         <= f_get_adr(s_u1_fifo_dout, s_chh_u1_adr'length);
   s_chh_u1_cmd_rdy     <= not s_u1_rd_empty;
   s_chh_u1_flags       <= f_get_flags(s_u1_fifo_dout, s_chh_u1_adr'length);
   s_chh_u1_xfer_size   <= f_get_xfer_sz(s_u1_fifo_dout, s_chh_u1_xfer_size'length );
  
   s_chl_cmd_rdy        <= (s_rtl_u4_cmd_rdy and not s_u6_dma_idle) or (s_u6_dma_idle and s_rtl_u2_cmd_rdy and s_rtl_u4_cmd_rdy);

   s_rtl_dpf_din        <= s_u5_fifo_wdat when (s_u5_slv_wr = '1') else s_u6_fifo_wdat;

   s_rtl_dpf_pop        <= s_u6_fifo_pop when (s_u5_slv_wr = '1') else s_u5_fifo_pop;

   s_rtl_dpf_push       <= s_u5_fifo_push when (s_u5_slv_wr = '1') else s_u6_fifo_push;

   s_rtl_chh_cmd_din    <= f_pack(i_dma_chh_adr, i_dma_xfer_flags, i_dma_xfer_sz);
   s_rtl_chh_cmd_push   <= i_dma_ctl.cmd_push_mst and not s_u1_wr_full;

   s_rtl_chl_cmd_push   <= i_dma_ctl.cmd_push_slv and not s_u2_wr_full;
         
   s_rtl_u2_cmd_rdy     <= not s_u2_rd_empty;
   
   s_rtl_u4_cmd_rdy     <= not s_u4_rd_empty;

   s_rtl_slv_xfer_din   <= s_u5_slv_seq_last & s_u5_slv_xfer_words;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U1_HCMD_FIFO:
   tspc_fifo_sync
      Generic Map (
         g_mem_words    => g_fifo_mem_words_hc,
         g_rd_latency   => g_fifo_rd_latency_hc,
         g_tech_lib     => g_tech_lib
         )
      Port Map (
         i_clk          => i_clk,
         i_rst_n        => i_rst_n,
         i_clr          => i_dma_ctl.dma_clr,
         
         i_rd_pop       => s_u5_cmd_pop,
         i_wr_din       => s_rtl_chh_cmd_din,
         i_wr_push      => s_rtl_chh_cmd_push,

         o_rd_aempty    => open,
         o_rd_count     => s_u1_rd_count,
         o_rd_dout      => s_u1_fifo_dout,
         o_rd_empty     => s_u1_rd_empty,
         o_wr_afull     => open,
         o_wr_free      => open,
         o_wr_full      => s_u1_wr_full
         );

   U2_LCMD_FIFO:
      -- Holds the address of the Local Bus access
   tspc_fifo_sync
      Generic Map (
         g_mem_words    => g_fifo_mem_words_lc,
         g_rd_latency   => g_fifo_rd_latency_lc,
         g_tech_lib     => g_tech_lib
         )
      Port Map (
         i_clk          => i_clk,
         i_rst_n        => i_rst_n,
         i_clr          => i_dma_ctl.dma_clr,

         i_rd_pop       => s_u6_adr_pop,
         i_wr_din       => i_dma_chl_adr,
         i_wr_push      => s_rtl_chl_cmd_push,

         o_rd_aempty    => open,
         o_rd_count     => s_u2_rd_count,
         o_rd_dout      => s_u2_fifo_dout,
         o_rd_empty     => s_u2_rd_empty,
         o_wr_afull     => open,
         o_wr_free      => open,
         o_wr_full      => s_u2_wr_full
         );

   U3_DP_FIFO:
   tspc_fifo_sync
      Generic Map (
         g_mem_words    => g_fifo_mem_words_dp,
         g_rd_latency   => g_fifo_rd_latency_dp,
         g_tech_lib     => g_tech_lib
         )
      Port Map (
         i_clk          => i_clk,
         i_rst_n        => i_rst_n,
         i_clr          => i_dma_ctl.dma_clr,

         i_rd_pop       => s_rtl_dpf_pop,
         i_wr_din       => s_rtl_dpf_din,
         i_wr_push      => s_rtl_dpf_push,

         o_rd_aempty    => open,
         o_rd_count     => s_u3_rd_count,
         o_rd_dout      => s_u3_fifo_dout,
         o_rd_empty     => s_u3_rd_empty,
         o_wr_afull     => open,
         o_wr_free      => s_u3_wr_free,
         o_wr_full      => open
         );

   U4_LCMD_FIFO:
      -- Holds the length and EOP flag of a local-bus segment
   tspc_fifo_sync
      Generic Map (
         g_mem_dmram    => false, --true,
         g_mem_words    => 4,
         g_rd_latency   => g_fifo_rd_latency_lc,
         g_tech_lib     => g_tech_lib
         )
      Port Map (
         i_clk          => i_clk,
         i_rst_n        => i_rst_n,
         i_clr          => i_dma_ctl.dma_clr,
         
         i_rd_pop       => s_u6_cmd_pop,
         i_wr_din       => s_rtl_slv_xfer_din,
         i_wr_push      => s_u5_slv_push,

         o_rd_aempty    => open,
         o_rd_count     => open,
         o_rd_dout      => s_u4_fifo_dout,
         o_rd_empty     => s_u4_rd_empty,
         o_wr_afull     => open,
         o_wr_free      => open,
         o_wr_full      => open
         );

   U5_CHN_MST:
   tspc_dma_chan_ms_ctl
      Generic Map (
         g_dma_burst_words_rd => g_dma_burst_words_rd_hc,
         g_dma_burst_words_wr => g_dma_burst_words_wr_hc,
         g_fifo_mem_words     => g_fifo_mem_words_hc,
         g_is_master          => true,
         g_mode_ms            => true
         )
      Port Map(
         i_clk                => i_clk,
         i_rst_n              => i_rst_n,

         i_dma_adr            => s_chh_u1_adr,
         i_dma_clr            => i_dma_ctl.dma_clr,
         i_dma_cmd_rdy        => s_chh_u1_cmd_rdy,
         i_dma_int_period     => c_tie_low_dword,
         i_dma_mode_sg        => c_tie_high,
         i_dma_mode_strm      => c_tie_low,
         i_dma_mode_wr        => s_chh_u1_flags.dma_wr,
         i_dma_run            => i_dma_ctl.dma_en,
         i_dma_xfer_adr_rst   => s_chh_u1_flags.adr_rst,
         i_dma_xfer_int_done  => s_chh_u1_flags.int_req,
         i_dma_xfer_seq_last  => s_chh_u1_flags.dma_last,
         i_dma_xfer_count     => s_chh_u1_xfer_size ,
         i_fifo_rd_count      => s_u3_rd_count,
         i_fifo_rdat          => s_u3_fifo_dout,
         i_fifo_wr_free       => s_u3_wr_free,
         i_mem_buf_words      => c_tie_low_dword,         
         i_slv_idle           => s_u6_dma_idle,
         i_slv_lseq_start     => s_u6_lseq_start,
         i_tick_timeout       => i_tick_timeout,
         i_wbm_ack            => i_wbmh_ack,
         i_wbm_dat            => i_wbmh_dat,

         o_chain_active       => open,
         o_dma_adr_pop        => open,
         o_dma_cmd_pop        => s_u5_cmd_pop,
         o_dma_idle           => s_u5_dma_idle,
         o_dma_wr             => open,
         o_ev_cmd_fifo_empty  => s_u5_ev_cmd_fifo_empty,
         o_ev_dma_cmd_done    => open,
         o_ev_dma_int_period  => open,
         o_ev_dma_int_xfer    => open,
         o_ev_dma_lseq_start  => open,
         o_ev_dma_seq_done    => s_u5_ev_dma_seq_done,
         o_fifo_pop           => s_u5_fifo_pop,
         o_fifo_push          => s_u5_fifo_push,
         o_fifo_wdat          => s_u5_fifo_wdat,
         o_mem_buf_pos        => s_u5_mem_buf_pos,         
         o_slv_push           => s_u5_slv_push,
         o_slv_run            => s_u5_slv_run,
         o_slv_seq_last       => s_u5_slv_seq_last,
         o_slv_wr             => s_u5_slv_wr,
         o_slv_xfer_count     => s_u5_slv_xfer_words,
         o_wbm_adr            => o_wbmh_adr,
         o_wbm_bte            => o_wbmh_bte,
         o_wbm_cti            => o_wbmh_cti,
         o_wbm_cyc            => o_wbmh_cyc,
         o_wbm_dat            => o_wbmh_dat,
         o_wbm_sel            => o_wbmh_sel,
         o_wbm_stb            => o_wbmh_stb,
         o_wbm_we             => o_wbmh_we
         );

   U6_CHN_SLV:
   tspc_dma_chan_ms_ctl
      Generic Map (
         g_dma_burst_words_rd => g_dma_burst_words_rd_lc,
         g_dma_burst_words_wr => g_dma_burst_words_wr_lc,
         g_fifo_mem_words     => g_fifo_mem_words_lc,
         g_is_master          => false,
         g_mode_ms            => true
         )
      Port Map(
         i_clk                => i_clk,
         i_rst_n              => i_rst_n,

         i_dma_adr            => s_u2_fifo_dout,
         i_dma_clr            => i_dma_ctl.dma_clr,
         i_dma_cmd_rdy        => s_chl_cmd_rdy,
         i_dma_int_period     => c_tie_low_dword,
         i_dma_mode_sg        => c_tie_low,
         i_dma_mode_strm      => c_tie_low,
         i_dma_mode_wr        => s_u5_slv_wr,
         i_dma_run            => s_u5_slv_run,
         i_dma_xfer_adr_rst   => c_tie_low,
         i_dma_xfer_int_done  => c_tie_low,
         i_dma_xfer_seq_last  => s_u4_fifo_dout(s_u4_fifo_dout'left),
         i_dma_xfer_count     => s_u4_fifo_dout(s_u4_fifo_dout'length - 2 downto 0),
         i_fifo_rd_count      => s_u3_rd_count,
         i_fifo_rdat          => s_u3_fifo_dout,
         i_fifo_wr_free       => s_u3_wr_free,
         i_mem_buf_words      => c_tie_low_dword,         
         i_slv_idle           => c_tie_low,
         i_slv_lseq_start     => c_tie_low,
         i_tick_timeout       => i_tick_timeout,
         i_wbm_ack            => i_wbml_ack,
         i_wbm_dat            => i_wbml_dat,

         o_chain_active       => s_u6_chain_active,
         o_dma_adr_pop        => s_u6_adr_pop,
         o_dma_cmd_pop        => s_u6_cmd_pop,
         o_dma_idle           => s_u6_dma_idle,
         o_dma_wr             => open,
         o_ev_cmd_fifo_empty  => s_u6_ev_cmd_fifo_empty,
         o_ev_dma_cmd_done    => open,
         o_ev_dma_int_period  => open,
         o_ev_dma_int_xfer    => open,
         o_ev_dma_lseq_start  => s_u6_lseq_start,
         o_ev_dma_seq_done    => open,
         o_fifo_pop           => s_u6_fifo_pop,
         o_fifo_push          => s_u6_fifo_push,
         o_fifo_wdat          => s_u6_fifo_wdat,
         o_mem_buf_pos        => s_u6_mem_buf_pos,
         o_slv_push           => open,
         o_slv_run            => open,
         o_slv_seq_last       => open,
         o_slv_wr             => open,
         o_slv_xfer_count     => s_u6_slv_xfer_count,
         o_wbm_adr            => o_wbml_adr,
         o_wbm_bte            => o_wbml_bte,
         o_wbm_cti            => o_wbml_cti,
         o_wbm_cyc            => o_wbml_cyc,
         o_wbm_dat            => o_wbml_dat,
         o_wbm_sel            => o_wbml_sel,
         o_wbm_stb            => o_wbml_stb,
         o_wbm_we             => o_wbml_we
         );                         
End Rtl;
