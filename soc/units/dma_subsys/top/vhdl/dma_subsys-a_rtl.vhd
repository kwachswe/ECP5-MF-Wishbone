
Library IEEE;
Use IEEE.numeric_std.all;
Use WORK.dma_subsys_comps.all;
Use WORK.dma_subsys_regs_types.all;
Use WORK.tspc_dma_chan_ms_types.all;

Architecture Rtl of dma_subsys is
   constant c_tie_high        : std_logic := '1';
   constant c_tie_low         : std_logic := '0';
   constant c_tie_low_bus     : std_logic_vector(31 downto 0) := (others => '0');
   
   signal s_u1_chh_cfifo_count   : std_logic_vector(15 downto 0);
   signal s_u1_chl_cfifo_count   : std_logic_vector(15 downto 0);
   signal s_u1_dma_sta           : t_tspc_dma_ms_sta;    
   signal s_u1_dma_xfer_pos      : std_logic_vector(31 downto 0);
   signal s_u1_ev_int_req        : std_logic;
   signal s_u1_wbmh_adr          : std_logic_vector(o_wbm_adr'length - 1 downto 0);
   signal s_u1_wbmh_bte          : std_logic_vector(o_wbm_bte'length - 1 downto 0);
   signal s_u1_wbmh_cti          : std_logic_vector(o_wbm_cti'length - 1 downto 0);
   signal s_u1_wbmh_cyc          : std_logic;
   signal s_u1_wbmh_dat          : std_logic_vector(o_wbm_dat'length - 1 downto 0);
   signal s_u1_wbmh_sel          : std_logic_vector(o_wbm_sel'length - 1 downto 0);
   signal s_u1_wbmh_stb          : std_logic;
   signal s_u1_wbmh_we           : std_logic;
   signal s_u1_wbml_adr          : std_logic_vector(31 downto 0);
   signal s_u1_wbml_bte          : std_logic_vector(o_wbm_bte'length - 1 downto 0);
   signal s_u1_wbml_cti          : std_logic_vector(o_wbm_cti'length - 1 downto 0);
   signal s_u1_wbml_cyc          : std_logic;
   signal s_u1_wbml_dat          : std_logic_vector(o_wbm_dat'length - 1 downto 0);
   signal s_u1_wbml_sel          : std_logic_vector(o_wbm_sel'length - 1 downto 0);
   signal s_u1_wbml_stb          : std_logic;
   signal s_u1_wbml_we           : std_logic;
   signal s_u2_dma_chh_adr       : std_logic_vector(o_wbm_adr'length - 1 downto 0);
   signal s_u2_dma_chl_adr       : std_logic_vector(31 downto 0);
   signal s_u2_dma_ctl           : t_tspc_dma_ms_ctl;
   signal s_u2_dma_xfer_flags    : t_tspc_dma_ms_flags;
   signal s_u2_dma_xfer_sz       : std_logic_vector(23 downto 0);
   signal s_u2_int_req           : std_logic;
   signal s_u2_wb_ack            : std_logic;
   signal s_u2_wb_dat            : std_logic_vector(o_wbs_dat'length - 1 downto 0);
   signal s_u3_wb_ack            : std_logic;
   signal s_u3_wb_dat            : std_logic_vector(31 downto 0);
   
Begin
   o_int_req         <= s_u2_int_req;

   o_wbm_adr         <= s_u1_wbmh_adr;
   o_wbm_bte         <= s_u1_wbmh_bte;
   o_wbm_cti         <= s_u1_wbmh_cti;
   o_wbm_cyc         <= s_u1_wbmh_cyc;
   o_wbm_dat         <= s_u1_wbmh_dat;
   o_wbm_sel         <= s_u1_wbmh_sel;
   o_wbm_stb         <= s_u1_wbmh_stb;
   o_wbm_we          <= s_u1_wbmh_we;
   o_wbs_ack         <= s_u2_wb_ack;
   o_wbs_dat         <= s_u2_wb_dat; 
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U1_DMA_ENGINE:
   tspc_dma_chan_ms
      Generic Map (
         g_tech_lib           => g_tech_lib
         )
      Port Map (
         i_clk                => i_clk,
         i_rst_n              => i_rst_n,

         i_dma_chh_adr        => s_u2_dma_chh_adr,
         i_dma_chl_adr        => s_u2_dma_chl_adr,
         i_dma_ctl            => s_u2_dma_ctl,
         i_dma_xfer_flags     => s_u2_dma_xfer_flags,
         i_dma_xfer_sz        => s_u2_dma_xfer_sz,
         i_tick_timeout       => c_tie_low,
         i_wbmh_ack           => i_wbm_ack,
         i_wbmh_dat           => i_wbm_dat,
         i_wbml_ack           => s_u3_wb_ack,
         i_wbml_dat           => s_u3_wb_dat,

         o_chh_cfifo_count    => s_u1_chh_cfifo_count,
         o_chl_cfifo_count    => s_u1_chl_cfifo_count,
         o_dma_sta            => s_u1_dma_sta,
         o_dma_xfer_pos       => s_u1_dma_xfer_pos,
         o_ev_int_req         => s_u1_ev_int_req,
         o_wbmh_adr           => s_u1_wbmh_adr,
         o_wbmh_bte           => s_u1_wbmh_bte,
         o_wbmh_cti           => s_u1_wbmh_cti,
         o_wbmh_cyc           => s_u1_wbmh_cyc,
         o_wbmh_dat           => s_u1_wbmh_dat,
         o_wbmh_sel           => s_u1_wbmh_sel,
         o_wbmh_stb           => s_u1_wbmh_stb,
         o_wbmh_we            => s_u1_wbmh_we,
         o_wbml_adr           => s_u1_wbml_adr,
         o_wbml_bte           => s_u1_wbml_bte,
         o_wbml_cti           => s_u1_wbml_cti,
         o_wbml_cyc           => s_u1_wbml_cyc,
         o_wbml_dat           => s_u1_wbml_dat,
         o_wbml_sel           => s_u1_wbml_sel,
         o_wbml_stb           => s_u1_wbml_stb,
         o_wbml_we            => s_u1_wbml_we 
         );
         
   U2_DMA_REGS:
   dma_subsys_regs
      Port Map (
         i_clk                => i_clk,
         i_rst_n              => i_rst_n,   

         i_dma_hfifo_count    => s_u1_chh_cfifo_count,
         i_dma_lfifo_count    => s_u1_chl_cfifo_count,
         i_dma_ev_int_req     => s_u1_ev_int_req,
         i_dma_sta            => s_u1_dma_sta,
         i_dma_xfer_pos       => s_u1_dma_xfer_pos,   
         i_wb_adr             => i_wbs_adr,
         i_wb_cyc             => i_wbs_cyc,
         i_wb_dat             => i_wbs_dat,
         i_wb_sel             => i_wbs_sel,
         i_wb_stb             => i_wbs_stb,
         i_wb_we              => i_wbs_we,

         o_dma_chh_adr        => s_u2_dma_chh_adr,
         o_dma_chl_adr        => s_u2_dma_chl_adr,
         o_dma_ctl            => s_u2_dma_ctl,
         o_dma_xfer_flags     => s_u2_dma_xfer_flags,
         o_dma_xfer_sz        => s_u2_dma_xfer_sz,   
         o_int_req            => s_u2_int_req,
         o_wb_ack             => s_u2_wb_ack,
         o_wb_dat             => s_u2_wb_dat   
         );

   U3_BMRAM:
      tsls_wb_bmram
      Generic Map (
         g_array_sz        => 16384,
         g_tech_lib        => g_tech_lib
         )
      Port Map (
         i_clk       => i_clk,
         i_rst_n     => i_rst_n,    

         i_wb_adr    => s_u1_wbml_adr,
         i_wb_bte    => s_u1_wbml_bte,
         i_wb_cti    => s_u1_wbml_cti,
         i_wb_cyc    => s_u1_wbml_cyc,
         i_wb_dat    => s_u1_wbml_dat,
         i_wb_lock   => c_tie_low,
         i_wb_sel    => s_u1_wbml_sel,
         i_wb_stb    => s_u1_wbml_stb,
         i_wb_we     => s_u1_wbml_we,

         o_wb_ack    => s_u3_wb_ack,
         o_wb_dat    => s_u3_wb_dat
         );   
End Rtl;
