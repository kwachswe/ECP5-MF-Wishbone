
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
-- File ID     : $Id: tspc_wb_cfi_jxb3_comps-p.vhd 5364 2021-12-12 22:29:02Z  $
-- Generated   : $LastChangedDate: 2021-12-12 23:29:02 +0100 (Sun, 12 Dec 2021) $
-- Revision    : $LastChangedRevision: 5364 $
--
--------------------------------------------------------------------------------
--
-- Module namespace : jxb3
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use WORK.jxb3_cfi_reg_types.all;
Use WORK.tspc_utils.all;
Use WORK.tspc_wbone_types.all;

Package tspc_wb_cfi_jxb3_comps is
   Component jxb3_regs_ctrl
      Port (
         i_clk             : in  std_logic;
         i_rst_n           : in  std_logic;
         i_clr             : in  std_logic;

         i_adr_push        : in  std_logic;     
         i_adr_rdat        : in  std_logic_vector;
         i_buf_din         : in  std_logic_vector;
         i_buf_irq         : in  std_logic;
         i_buf_pop         : in  std_logic;
         i_buf_rd_count    : in  std_logic_vector;
         i_buf_rd_empty    : in  std_logic;
         i_buf_rd_last     : in  std_logic;
         i_buf_src_spi     : in  std_logic;
         i_buf_wr_free     : in  std_logic_vector;
         i_buf_wr_full     : in  std_logic;
         i_buf_wr_last     : in  std_logic;
         i_mbox_rx_pop     : in  std_logic;
         i_mbox_tx_rdy     : in  std_logic;
         i_resp_din        : in  std_logic_vector;
         i_resp_push       : in  std_logic;
         i_spi_busy        : in  std_logic;
         i_wb_adr          : in  std_logic_vector;
         i_wb_cyc          : in  std_logic;
         i_wb_din          : in  std_logic_vector;
         i_wb_sel          : in  std_logic_vector;
         i_wb_stb          : in  std_logic;
         i_wb_we           : in  std_logic;

         o_buf_arb_rd      : out std_logic;
         o_buf_arb_wr      : out std_logic;
         o_buf_clr         : out std_logic;
         o_buf_dout        : out std_logic_vector;
         o_buf_empty       : out std_logic;
         o_buf_irq         : out std_logic;
         o_buf_pop         : out std_logic;
         o_buf_push        : out std_logic;
         o_cfi_adr         : out std_logic_vector; 
         o_cfi_adr_push    : out std_logic;
         o_cfi_cmd         : out std_logic_vector;         
         o_cfi_cmd_push    : out std_logic;
         o_cfi_ctrl        : out t_jxb3_cfi_ctrl;
         o_int_req         : out std_logic;
         o_rx_last         : out std_logic;
         o_spi_clr         : out std_logic;
         o_spi_has_pload   : out std_logic;
         o_wb_ack          : out std_logic;
         o_wb_dout         : out std_logic_vector     
         );
   End Component;


   Component jxb3_spi_dma_tgt
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
   End Component;
   
   
   Component tspc_cdc_vec
      Generic (
         g_stages    : positive := 1
         );
      Port ( 
         i_clk          : in  std_logic;
         i_rst_n        : in  std_logic;
         
         i_cdc_in       : in  std_logic_vector;
         
         o_cdc_out      : out std_logic_vector
         );
   End Component;

        
   Component tspc_cfi_spim_pw2n
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
   End Component;
   
   
   Component tspc_fifo_sync
      Generic (
         g_mem_dmram    : boolean := false;
         g_mem_words    : positive := 2048; 
         g_rd_latency   : positive range 1 to 2 := 2;
         g_tech_lib     : string := "ECP3";
         g_threshold_rd : positive := 1;
         g_threshold_wr : positive := 1
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
         o_rd_last      : out std_logic;
         o_wr_afull     : out std_logic;
         o_wr_free      : out std_logic_vector(f_vec_msb(g_mem_words) downto 0);
         o_wr_full      : out std_logic;
         o_wr_last      : out std_logic
         );
   End Component;
   

   Component tspc_cdc_reg
      Generic (
         g_mask_on_empty   : boolean := true;
         g_rd_ready_ev     : boolean := false
         );
      Port (
         i_rst_n        : in  std_logic;

         i_rd_clk       : in  std_logic;
         i_rd_clk_en    : in  std_logic;
         i_rd_en        : in  std_logic;

         i_wr_clk       : in  std_logic;
         i_wr_clk_en    : in  std_logic;
         i_wr_din       : in  std_logic_vector;
         i_wr_en        : in  std_logic;

         o_rd_dout      : out std_logic_vector;
         o_rd_ready     : out std_logic;

         o_wr_ready     : out std_logic
         );
   End Component;
End tspc_wb_cfi_jxb3_comps;
