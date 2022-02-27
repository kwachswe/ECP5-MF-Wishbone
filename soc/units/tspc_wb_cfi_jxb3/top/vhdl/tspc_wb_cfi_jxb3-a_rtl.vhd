
--
--    Copyright Ingenieurbuero Gardiner, 2018
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
-- File ID     : $Id: tspc_wb_cfi_jxb3-a_rtl.vhd 5364 2021-12-12 22:29:02Z  $
-- Generated   : $LastChangedDate: 2021-12-12 23:29:02 +0100 (Sun, 12 Dec 2021) $
-- Revision    : $LastChangedRevision: 5364 $
--
--------------------------------------------------------------------------------
--
-- Module namespace : jxb3
--
-- Description : 
--     
--
--------------------------------------------------------------------------------

Use WORK.tspc_wb_cfi_jxb3_comps.all;
Use WORK.jxb3_cfi_reg_types.all;
Use WORK.tspc_utils.all;

Architecture Rtl of tspc_wb_cfi_jxb3 is
   constant c_adr_reg_sz  : positive := maximum(i_wb_reg_adr'length, f_vec_size(c_reg_adr_buf_base_min));
   
   subtype t_adr_dma    is std_logic_vector(g_spi_adr_sz - 1 downto 0);
   subtype t_adr_reg    is std_logic_vector(c_adr_reg_sz - 1 downto 0);
   subtype t_buf_count  is std_logic_vector(f_vec_msb(g_buf_words) downto 0);
   subtype t_cdc_ctrl   is std_logic_vector(7 downto 0);
   subtype t_cdc_sta    is std_logic_vector(0 downto 0);
   subtype t_cfi_adr    is std_logic_vector(g_spi_adr_sz - 1 downto 0);
   subtype t_cfi_cmd    is std_logic_vector(g_spi_cmd_sz - 1 downto 0);
   
   constant c_bp_cdc_ctl_cpha       : natural := 0;
   constant c_bp_cdc_ctl_cpol       : natural := 1;
   constant c_bp_cdc_ctl_has_pload  : natural := 2;   
   constant c_bp_cdc_ctl_lsb_first  : natural := 3;
   constant c_bp_cdc_ctl_mode_wr    : natural := 4;
   constant c_bp_cdc_ctl_rx_last    : natural := 5; 
   constant c_bp_cdc_ctl_spi_en     : natural := 6;
   constant c_bp_cdc_ctl_tx_last    : natural := 7; 
   constant c_bp_cdc_sta_spi_busy   : natural := 0;
   
   signal s_rtl_adr_dma          : t_adr_dma;
   signal s_rtl_adr_reg          : t_adr_reg;
   signal s_rtl_buf_mode_wr      : std_logic;
   signal s_rtl_cdc_ctrl         : t_cdc_ctrl;
   signal s_rtl_cdc_sta          : t_cdc_sta;
   signal s_rtl_u7_rx_tx_last    : std_logic;
   signal s_u1_rxdat             : t_byte;
   signal s_u1_rxdat_push        : std_logic;
   signal s_u1_spi_busy          : std_logic;
   signal s_u1_spi_mosi          : std_logic;
   signal s_u1_spi_mosi_en       : std_logic;
   signal s_u1_spi_sclk          : std_logic;
   signal s_u1_spi_sclk_en       : std_logic;
   signal s_u1_spi_ssel          : std_logic;
   signal s_u1_txdat_pop         : std_logic;
   signal s_u2_buf_arb_rd        : std_logic;
   signal s_u2_buf_arb_wr        : std_logic;
   signal s_u2_buf_clr           : std_logic;
   signal s_u2_buf_dout          : t_byte;
   signal s_u2_buf_empty         : std_logic;
   signal s_u2_buf_irq           : std_logic;
   signal s_u2_buf_pop           : std_logic;
   signal s_u2_buf_push          : std_logic;
   signal s_u2_cfi_adr           : t_cfi_adr;
   signal s_u2_cfi_adr_push      : std_logic;
   signal s_u2_cfi_cmd           : t_cfi_cmd;
   signal s_u2_cfi_cmd_push      : std_logic;
   signal s_u2_int_req           : std_logic;
   signal s_u2_reg_cfi_ctl       : t_jxb3_cfi_ctrl;
   signal s_u2_rx_last           : std_logic;
   signal s_u2_spi_clr           : std_logic;
   signal s_u2_spi_has_pload     : std_logic;
   signal s_u2_wb_ack            : std_logic;
   signal s_u2_wb_dout           : t_dword;
   signal s_u3_dma_idle          : std_logic;
   signal s_u3_dp_pop            : std_logic;
   signal s_u3_dp_push           : std_logic;
   signal s_u3_dp_wdat           : t_byte;
   signal s_u3_mbox_rx_pop       : std_logic;
   signal s_u3_mbox_tx_push      : std_logic;
   signal s_u3_mbox_tx_wdat      : t_byte;
   signal s_u3_spi_en            : std_logic;
   signal s_u3_spi_has_pload     : std_logic;
   signal s_u3_spi_rx_last       : std_logic;
   signal s_u3_spi_tx_last       : std_logic;
   signal s_u3_spi_wr            : std_logic;
   signal s_u3_spi_xfer_attribs  : std_logic_vector(1 downto 0); 
   signal s_u3_wb_ack            : std_logic;
   signal s_u3_wb_dout           : t_dword;
   signal s_u4_rd_count          : t_buf_count;
   signal s_u4_rd_dout           : std_logic_vector(9 downto 0);
   signal s_u4_rd_empty          : std_logic;
   signal s_u4_rd_last           : std_logic;
   signal s_u4_wr_free           : t_buf_count;
   signal s_u4_wr_full           : std_logic;
   signal s_u4_wr_last           : std_logic;
   signal s_u5_rd_dout           : t_byte;
   signal s_u5_rd_ready          : std_logic;
   signal s_u5_wr_ready          : std_logic;
   signal s_u6_rd_dout           : t_byte;
   signal s_u6_rd_ready          : std_logic;
   signal s_u6_wr_ready         : std_logic;
   signal s_u7_cdc_out          : t_cdc_ctrl;        
   signal s_u8_cdc_out          : t_cdc_sta;        
   
Begin
   o_img_has_update     <= c_tie_low;
   o_img_reload         <= c_tie_low;
   o_int_req            <= c_tie_low;
   o_spi_mosi           <= s_u1_spi_mosi;
   o_spi_mosi_en        <= s_u1_spi_mosi_en;
   o_spi_sclk           <= s_u1_spi_sclk;
   o_spi_sclk_en        <= s_u1_spi_sclk_en;
   o_spi_ssel           <= s_u1_spi_ssel;

   o_wb_dma_ack         <= s_u3_wb_ack;
   o_wb_dma_dout        <= s_u3_wb_dout;
   
   o_wb_reg_ack         <= s_u2_wb_ack;
   o_wb_reg_dout        <= s_u2_wb_dout;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   s_rtl_adr_dma        <= f_resize(i_wb_dma_adr, s_rtl_adr_dma'length );
   
   s_rtl_adr_reg        <= f_resize(i_wb_reg_adr, s_rtl_adr_reg'length );

   s_rtl_buf_mode_wr    <= f_to_logic(s_u2_reg_cfi_ctl.buf_mode = c_buf_mode_duplex) or
                           f_to_logic(s_u2_reg_cfi_ctl.buf_mode = c_buf_mode_tx);
                           
   s_rtl_cdc_ctrl       <= (c_bp_cdc_ctl_cpha      => s_u2_reg_cfi_ctl.mode_cpha,
                            c_bp_cdc_ctl_cpol      => s_u2_reg_cfi_ctl.mode_cpol,
                            c_bp_cdc_ctl_has_pload => c_tie_low,
                            c_bp_cdc_ctl_lsb_first => s_u2_reg_cfi_ctl.lsb_first,
                            c_bp_cdc_ctl_mode_wr   => s_u3_spi_wr,
                            c_bp_cdc_ctl_rx_last   => s_u3_spi_rx_last,
                            c_bp_cdc_ctl_spi_en    => s_u3_spi_en,
                            c_bp_cdc_ctl_tx_last   => s_u3_spi_tx_last
                            );
                            
   s_rtl_cdc_sta        <= (c_bp_cdc_sta_spi_busy  => s_u1_spi_busy);
   
   s_rtl_u7_rx_tx_last  <= s_u7_cdc_out(c_bp_cdc_ctl_rx_last) or s_u7_cdc_out(c_bp_cdc_ctl_tx_last);
                                              
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U1_SPI: 
      -- At the moment we leave out the CDC for signals from the register lines
      -- which are pseudo-static and which are typically setup before SPI is started
   tspc_cfi_spim_pw2n
      Port Map (
         i_clk                => i_clk_spi,
         i_rst_n              => i_rst_n,
         i_clr                => i_clr,

         i_mode_cpha          => s_u7_cdc_out(c_bp_cdc_ctl_cpha),
         i_mode_cpol          => s_u7_cdc_out(c_bp_cdc_ctl_cpol),
         i_mode_half_dplx     => c_tie_low,
         i_mode_lsb_first     => s_u7_cdc_out(c_bp_cdc_ctl_lsb_first),
         i_mode_wr            => s_u7_cdc_out(c_bp_cdc_ctl_mode_wr),
         i_rx_last            => s_rtl_u7_rx_tx_last,
         i_rx_rdy             => s_u6_wr_ready,
         i_spi_miso           => i_spi_miso,
         i_tx_last            => s_rtl_u7_rx_tx_last,
         i_tx_rdy             => s_u5_rd_ready,
         i_tx_wdat            => s_u5_rd_dout,
         i_xfer_attrib        => c_tie_low_byte(1 downto 0),
         i_xfer_en            => s_u7_cdc_out(c_bp_cdc_ctl_spi_en),
            
         o_rxdat              => s_u1_rxdat,
         o_rxdat_push         => s_u1_rxdat_push,
         o_spi_busy           => s_u1_spi_busy,
         o_spi_end_ev         => open,
         o_spi_mosi           => s_u1_spi_mosi,
         o_spi_mosi_en        => s_u1_spi_mosi_en,
         o_spi_sclk           => s_u1_spi_sclk,
         o_spi_sclk_en        => s_u1_spi_sclk_en,
         o_spi_ssel           => s_u1_spi_ssel,
         o_txdat_pop          => s_u1_txdat_pop
         );

   U2_REGS:
   jxb3_regs_ctrl
      Port Map (
         i_clk             => i_clk_sys,
         i_rst_n           => i_rst_n,
         i_clr             => i_clr,

         i_adr_push        => s_u5_rd_ready,
         i_adr_rdat        => s_u5_rd_dout,
         i_buf_din         => s_u4_rd_dout(7 downto 0),
         i_buf_irq         => s_u4_rd_dout(c_bp_dx_int_req),
         i_buf_pop         => s_u3_dp_pop,
         i_buf_rd_count    => s_u4_rd_count,
         i_buf_rd_empty    => s_u4_rd_empty,
         i_buf_rd_last     => s_u4_rd_last,
         i_buf_src_spi     => s_u4_rd_dout(c_bp_dx_src_spi),
         i_buf_wr_free     => s_u4_wr_free,
         i_buf_wr_full     => s_u4_wr_full,
         i_buf_wr_last     => s_u4_wr_last,
         i_mbox_rx_pop     => c_tie_low,
         i_mbox_tx_rdy     => s_u5_wr_ready,
         i_resp_din        => s_u6_rd_dout,
         i_resp_push       => s_u6_rd_ready,
         i_spi_busy        => s_u8_cdc_out(c_bp_cdc_sta_spi_busy),
         i_wb_adr          => s_rtl_adr_reg,
         i_wb_cyc          => i_wb_reg_cyc,
         i_wb_din          => i_wb_reg_din,
         i_wb_sel          => i_wb_reg_sel,
         i_wb_stb          => i_wb_reg_stb,
         i_wb_we           => i_wb_reg_we,

         o_buf_arb_rd      => s_u2_buf_arb_rd,
         o_buf_arb_wr      => s_u2_buf_arb_wr,
         o_buf_clr         => s_u2_buf_clr,
         o_buf_dout        => s_u2_buf_dout,
         o_buf_empty       => s_u2_buf_empty,
         o_buf_irq         => s_u2_buf_irq,
         o_buf_pop         => s_u2_buf_pop,
         o_buf_push        => s_u2_buf_push,
         o_cfi_adr         => s_u2_cfi_adr,
         o_cfi_adr_push    => s_u2_cfi_adr_push,
         o_cfi_cmd         => s_u2_cfi_cmd,     
         o_cfi_cmd_push    => s_u2_cfi_cmd_push,
         o_cfi_ctrl        => s_u2_reg_cfi_ctl,
         o_int_req         => s_u2_int_req,
         o_rx_last         => s_u2_rx_last,
         o_spi_clr         => s_u2_spi_clr,
         o_spi_has_pload   => s_u2_spi_has_pload,
         o_wb_ack          => s_u2_wb_ack,
         o_wb_dout         => s_u2_wb_dout
         );         
         
   U3_DMA:
   jxb3_spi_dma_tgt
      Generic Map (
         g_spi_adr_sz      => g_spi_adr_sz
         )
      Port Map (
         i_clk                => i_clk_sys,
         i_rst_n              => i_rst_n,
         i_clr                => i_clr,
         
         i_buf_din            => s_u4_rd_dout,
         i_buf_rd_empty       => s_u4_rd_empty,
         i_buf_rd_last        => s_u4_rd_last,
         i_buf_wr_full        => s_u4_wr_full,
         i_buf_wr_last        => s_u4_wr_last,
         i_dma_en             => c_tie_high,
         i_mbox_rx_din        => s_u6_rd_dout,
         i_mbox_rx_rdy        => s_u6_rd_ready,     
         i_mbox_tx_rdy        => s_u5_wr_ready,
         i_spi_busy           => s_u8_cdc_out(c_bp_cdc_sta_spi_busy),
         i_wb_adr             => i_wb_dma_adr,
         i_wb_cti             => i_wb_dma_cti,
         i_wb_cyc             => i_wb_dma_cyc,
         i_wb_dat             => i_wb_dma_din,
         i_wb_sel             => i_wb_dma_sel,
         i_wb_stb             => i_wb_dma_stb,
         i_wb_we              => i_wb_dma_we,

         o_buf_dout           => s_u3_dp_wdat,
         o_buf_pop            => s_u3_dp_pop,
         o_buf_push           => s_u3_dp_push,
         o_spi_en             => s_u3_spi_en,
         o_spi_rx_last        => s_u3_spi_rx_last,
         o_spi_tx_last        => s_u3_spi_tx_last,
         o_spi_wr             => s_u3_spi_wr,
         o_spi_xfer_attribs   => s_u3_spi_xfer_attribs,
         o_dma_idle           => s_u3_dma_idle,
         o_mbox_rx_pop        => s_u3_mbox_rx_pop,
         o_mbox_tx_push       => s_u3_mbox_tx_push,
         o_mbox_tx_wdat       => s_u3_mbox_tx_wdat,
         o_wb_ack             => s_u3_wb_ack,
         o_wb_dat             => s_u3_wb_dout     
         );
      
   U4_BUF:
   tspc_fifo_sync
      Generic Map (
         g_rd_latency   => g_buf_rd_latency,
         g_mem_words    => g_buf_words,
         g_tech_lib     => g_tech_lib
         )
      Port Map (
         i_rst_n        => i_rst_n,
         i_clk          => i_clk_sys,
         i_clr          => s_u2_reg_cfi_ctl.dbuf_clr,

         i_rd_pop       => s_u3_dp_pop,
         i_wr_din       => s_u3_dp_wdat,
         i_wr_push      => s_u3_dp_push,

         o_rd_aempty    => open,
         o_rd_count     => s_u4_rd_count,
         o_rd_dout      => s_u4_rd_dout,
         o_rd_empty     => s_u4_rd_empty,
         o_rd_last      => s_u4_rd_last,
         o_wr_afull     => open,
         o_wr_free      => s_u4_wr_free,
         o_wr_full      => s_u4_wr_full,
         o_wr_last      => s_u4_wr_last
         );      
        
   U5_MBX_DAT_TX:
      -- Clock-domain crossing for SPI Write Data
   tspc_cdc_reg
      Port Map (
         i_rst_n        => i_rst_n,

         i_rd_clk       => i_clk_spi,
         i_rd_clk_en    => c_tie_high,
         i_rd_en        => s_u1_txdat_pop,

         i_wr_clk       => i_clk_sys,
         i_wr_clk_en    => c_tie_high,
         i_wr_din       => s_u3_mbox_tx_wdat,
         i_wr_en        => s_u3_mbox_tx_push,

         o_rd_dout      => s_u5_rd_dout,
         o_rd_ready     => s_u5_rd_ready,

         o_wr_ready     => s_u5_wr_ready
         );      

   U6_MBX_DAT_RX:
      -- Clock-domain crossing for SPI Read Data
   tspc_cdc_reg
      Generic Map (
         g_mask_on_empty   => false
         )
      Port Map (
         i_rst_n        => i_rst_n,

         i_rd_clk       => i_clk_sys,
         i_rd_clk_en    => c_tie_high,
         i_rd_en        => s_u3_mbox_rx_pop,

         i_wr_clk       => i_clk_spi,
         i_wr_clk_en    => c_tie_high,
         i_wr_din       => s_u1_rxdat,
         i_wr_en        => s_u1_rxdat_push,

         o_rd_dout      => s_u6_rd_dout,
         o_rd_ready     => s_u6_rd_ready,

         o_wr_ready     => s_u6_wr_ready
         );    
        
   U7_CDC_CTL:
   tspc_cdc_vec
      Port Map ( 
         i_clk          => i_clk_spi,
         i_rst_n        => i_rst_n,
         
         i_cdc_in       => s_rtl_cdc_ctrl,
         
         o_cdc_out      => s_u7_cdc_out
         );        
                  
   U8_CDC_STA:
   tspc_cdc_vec
      Port Map ( 
         i_clk          => i_clk_sys,
         i_rst_n        => i_rst_n,
         
         i_cdc_in       => s_rtl_cdc_sta,
         
         o_cdc_out      => s_u8_cdc_out
         );             
End Rtl;
