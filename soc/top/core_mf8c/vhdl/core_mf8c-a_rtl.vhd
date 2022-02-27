
--    
--    Copyright Ingenieurbuero Gardiner, 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--   
--------------------------------------------------------------------------------
--
-- File ID    : $Id: core_mf8c-a_rtl.vhd 157 2022-02-10 23:36:26Z  $
-- Generated  : $LastChangedDate: 2022-02-11 00:36:26 +0100 (Fri, 11 Feb 2022) $
-- Revision   : $LastChangedRevision: 157 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.numeric_std.all;
Use WORK.core_mf8c_comps.all;
Use WORK.tspc_utils.all;
Use WORK.tspc_wbone_types.all;

Architecture Rtl of core_mf8c is
   constant c_nr_cfi          : natural := 1;
   constant c_nr_dma          : natural := 1;
   constant c_nr_mems         : natural := 1;
   constant c_nr_uarts        : natural := g_nr_uarts;
   constant c_nr_wb_tgts      : natural := c_nr_dma + c_nr_mems + c_nr_uarts + c_nr_cfi;

   constant c_bmram_words     : natural := 4096;
   constant c_func_num_dma    : natural := 6;
   
   constant c_cfi_buf_sz      : natural := 2048;
   constant c_wbm_adr_sz      : natural := 16;
   constant c_wbs_adr_sz      : natural := 48;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   signal s_rtl_ack                 : std_logic;
   signal s_rtl_cyc_bmram           : std_logic;
   signal s_rtl_cyc_cfi             : std_logic;
   signal s_rtl_cyc_dma             : std_logic;
   signal s_rtl_cyc_uart            : std_logic_vector(g_nr_uarts - 1 downto 0);
   signal s_rtl_int                 : std_logic_vector(c_nr_wb_tgts - 1 downto 0);
   signal s_rtl_rdat                : std_logic_vector(31 downto 0);
   signal s_rtl_wbmh_cyc            : std_logic_vector(7 downto 0);
   signal s_rtl_xclk                : std_logic;
   
   signal s_u1_clk_125              : std_logic;
   signal s_u1_dec_adr              : std_logic_vector(c_wbm_adr_sz - 1 downto 0);
   signal s_u1_dec_bar_hit          : std_logic_vector(5 downto 0);
   signal s_u1_dec_func_hit         : std_logic_vector(7 downto 0);
   signal s_u1_dl_up                : std_logic;
   signal s_u1_ltssm_state          : std_logic_vector(3 downto 0);
   signal s_u1_rst_n                : std_logic;
   signal s_u1_wbm_adr              : std_logic_vector(c_wbm_adr_sz - 1 downto 0);
   signal s_u1_wbm_bte              : std_logic_vector(1 downto 0);
   signal s_u1_wbm_cti              : std_logic_vector(2 downto 0);
   signal s_u1_wbm_cyc              : std_logic_vector(c_nr_wb_tgts - 1 downto 0);
   signal s_u1_wbm_dat              : std_logic_vector(31 downto 0);
   signal s_u1_wbm_sel              : std_logic_vector(3 downto 0);
   signal s_u1_wbm_stb              : std_logic;
   signal s_u1_wbm_we               : std_logic;
   signal s_u1_wbs_ack              : std_logic;
   signal s_u1_wbs_rdat             : std_logic_vector(31 downto 0);
   signal s_u2_dec_wb_cyc           : std_logic_vector(c_nr_wb_tgts - 1 downto 0);
   signal s_u3_clk_pll_out          : std_logic;
   signal s_u3_clk_spi              : std_logic;
   signal s_u3_pll_lock             : std_logic;   
   signal s_u3_xclk                 : std_logic;
   signal s_u4_ack                  : std_logic;
   signal s_u4_rdat                 : t_dword;
   signal s_u4_int                  : std_logic_vector(c_nr_uarts - 1 downto 0);
   signal s_u4_uart_rts             : std_logic_vector(c_nr_uarts - 1 downto 0);
   signal s_u4_uart_tx              : std_logic_vector(c_nr_uarts - 1 downto 0);
   signal s_u5_int_req              : std_logic;
   signal s_u5_wbm_adr              : std_logic_vector(c_wbs_adr_sz - 1 downto 0);
   signal s_u5_wbm_bte              : std_logic_vector(1 downto 0);
   signal s_u5_wbm_cti              : std_logic_vector(2 downto 0);
   signal s_u5_wbm_cyc              : std_logic;
   signal s_u5_wbm_dat              : std_logic_vector(31 downto 0);
   signal s_u5_wbm_sel              : std_logic_vector(3 downto 0);
   signal s_u5_wbm_stb              : std_logic;
   signal s_u5_wbm_we               : std_logic;
   signal s_u5_wbs_ack              : std_logic;
   signal s_u5_wbs_dat              : std_logic_vector(31 downto 0);
   signal s_u6_wb_ack               : std_logic;
   signal s_u6_wb_dat               : std_logic_vector(31 downto 0);   
   signal s_u7_int_req              : std_logic;
   signal s_u7_spi_mosi             : std_logic;
   signal s_u7_spi_mosi_en          : std_logic;
   signal s_u7_spi_sclk             : std_logic;
   signal s_u7_spi_sclk_en          : std_logic;
   signal s_u7_spi_ssel             : std_logic;
   signal s_u7_wb_ack               : std_logic;
   signal s_u7_wb_dat               : std_logic_vector(31 downto 0);
   signal s_u7_wb_dma_dat           : std_logic_vector(31 downto 0);
   
Begin
   o_clk_sys         <= s_u1_clk_125;
   
   o_dl_up           <= s_u1_dl_up;
   o_ltssm_state     <= s_u1_ltssm_state;

   o_spi_mosi        <= s_u7_spi_mosi;
   o_spi_mosi_en     <= s_u7_spi_mosi_en;
   o_spi_sclk        <= s_u7_spi_sclk;
   o_spi_ssel        <= s_u7_spi_ssel;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_rtl_ack         <= s_u4_ack or s_u5_wbs_ack or s_u6_wb_ack or s_u7_wb_ack;
   s_rtl_cyc_bmram   <= s_u1_wbm_cyc(c_nr_uarts + 1);
   s_rtl_cyc_cfi     <= s_u1_wbm_cyc(c_nr_uarts + 2);
   s_rtl_cyc_dma     <= s_u1_wbm_cyc(c_nr_uarts);
   s_rtl_cyc_uart    <= s_u1_wbm_cyc(c_nr_uarts - 1 downto 0);
   s_rtl_int         <= s_u7_int_req & c_tie_low & s_u5_int_req & s_u4_int;
   s_rtl_rdat        <= s_u4_rdat or s_u5_wbs_dat or s_u6_wb_dat or s_u7_wb_dat;
   
   s_rtl_wbmh_cyc    <= (c_func_num_dma   => s_u5_wbm_cyc,
                         others           => c_tie_low);

   s_rtl_xclk        <= s_u3_clk_pll_out; -- s_u3_xclk;
                         
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U1_PCIE:
   if g_tech_lib = "ECP3" Generate
      U1_E3:
      pciemf_subsys
         Port Map (
            i_rst_n              => i_perst_n,
            i_dec_wb_cyc         => s_u2_dec_wb_cyc,
            i_hdinn0             => i_hdinn0,
            i_hdinp0             => i_hdinp0,
            i_pci_int_req        => s_rtl_int,
            i_refclkn            => i_refclkn,
            i_refclkp            => i_refclkp,
            i_wbm_ack            => s_rtl_ack,
            i_wbm_dat            => s_rtl_rdat,
            i_wbs_adr            => s_u5_wbm_adr,
            i_wbs_bte            => s_u5_wbm_bte,
            i_wbs_cti            => s_u5_wbm_cti,
            i_wbs_cyc            => s_rtl_wbmh_cyc,
            i_wbs_dat            => s_u5_wbm_dat,
            i_wbs_sel            => s_u5_wbm_sel,
            i_wbs_stb            => s_u5_wbm_stb,
            i_wbs_we             => s_u5_wbm_we,

            o_dec_adr            => s_u1_dec_adr,
            o_dec_bar_hit        => s_u1_dec_bar_hit,
            o_dec_func_hit       => s_u1_dec_func_hit,
            o_clk_125            => s_u1_clk_125,
            o_dl_up              => s_u1_dl_up,
            o_ltssm_state        => s_u1_ltssm_state,
            o_hdoutn0            => o_hdoutn0,
            o_hdoutp0            => o_hdoutp0,
            o_rst_n              => s_u1_rst_n,
            o_rst_func_n         => open,
            o_wbm_adr            => s_u1_wbm_adr,
            o_wbm_bte            => s_u1_wbm_bte,
            o_wbm_cti            => s_u1_wbm_cti,
            o_wbm_cyc            => s_u1_wbm_cyc,
            o_wbm_dat            => s_u1_wbm_dat,
            o_wbm_sel            => s_u1_wbm_sel,
            o_wbm_stb            => s_u1_wbm_stb,
            o_wbm_we             => s_u1_wbm_we,
            o_wbs_ack            => s_u1_wbs_ack,
            o_wbs_dat            => s_u1_wbs_rdat,
            o_wbs_err            => open
            );   
   else generate
      U1_E5:
      pcie_mfx1_top_combo
         Port Map (
            ix_rst_n             => i_perst_n,
            ix_dec_wb_cyc        => s_u2_dec_wb_cyc,
            ix_hdinn0            => i_hdinn0,
            ix_hdinp0            => i_hdinp0,
            ix_pci_int_req       => s_rtl_int,
            ix_refclkn           => i_refclkn,
            ix_refclkp           => i_refclkp,
            ix_wbm_ack           => s_rtl_ack,
            ix_wbm_dat           => s_rtl_rdat,
            ix_wbs_adr           => s_u5_wbm_adr,
            ix_wbs_bte           => s_u5_wbm_bte,
            ix_wbs_cti           => s_u5_wbm_cti,
            ix_wbs_cyc           => s_rtl_wbmh_cyc,
            ix_wbs_dat           => s_u5_wbm_dat,
            ix_wbs_sel           => s_u5_wbm_sel,
            ix_wbs_stb           => s_u5_wbm_stb,
            ix_wbs_we            => s_u5_wbm_we,

            ox_dec_adr           => s_u1_dec_adr,
            ox_dec_bar_hit       => s_u1_dec_bar_hit,
            ox_dec_func_hit      => s_u1_dec_func_hit,
            ox_clk_125           => s_u1_clk_125,
            ox_dl_up             => s_u1_dl_up,
            ox_ltssm_state       => s_u1_ltssm_state,
            ox_hdoutn0           => o_hdoutn0,
            ox_hdoutp0           => o_hdoutp0,
            ox_rst_n             => s_u1_rst_n,
            ox_rst_func_n        => open,
            ox_wbm_adr           => s_u1_wbm_adr,
            ox_wbm_bte           => s_u1_wbm_bte,
            ox_wbm_cti           => s_u1_wbm_cti,
            ox_wbm_cyc           => s_u1_wbm_cyc,
            ox_wbm_dat           => s_u1_wbm_dat,
            ox_wbm_sel           => s_u1_wbm_sel,
            ox_wbm_stb           => s_u1_wbm_stb,
            ox_wbm_we            => s_u1_wbm_we,
            ox_wbs_ack           => s_u1_wbs_ack,
            ox_wbs_dat           => s_u1_wbs_rdat,
            ox_wbs_err           => open
            );
   End Generate;
         
   U2_DEC:
   adr_decode
      Port Map(
         i_dec_adr         => s_u1_dec_adr,
         i_dec_bar_hit     => s_u1_dec_bar_hit,
         i_dec_func_hit    => s_u1_dec_func_hit,

         o_dec_wb_cyc      => s_u2_dec_wb_cyc
         );            

   U3_CLK:
   clock_gen
      Generic Map (
         g_tech_lib     => g_tech_lib
         )
      Port Map (
         i_clk_125m     => s_u1_clk_125,
         i_rst_n        => s_u1_rst_n,

         o_clk_spi      => s_u3_clk_spi,
         o_clk_pll_out  => s_u3_clk_pll_out,
         o_pll_lock     => s_u3_pll_lock,
         o_xclk         => s_u3_xclk
         );
         
   U4_UART:
   uart_block
      Generic Map (
         g_nr_uarts        => c_nr_uarts,
         g_tech_lib        => g_tech_lib
         )
      Port Map (
         i_clk_sys      => s_u1_clk_125,
         i_xclk         => s_u3_xclk,
         i_rst_n        => s_u1_rst_n,

         i_uart_cts     => i_uart_cts,
         i_uart_rx      => i_uart_rx,
         i_wb_adr       => s_u1_wbm_adr(7 downto 0),
         i_wb_cyc       => s_rtl_cyc_uart,
         i_wb_dat       => s_u1_wbm_dat,
         i_wb_sel       => s_u1_wbm_sel,
         i_wb_stb       => s_u1_wbm_stb,
         i_wb_we        => s_u1_wbm_we,

         o_int_req      => s_u4_int,
         o_uart_rts     => s_u4_uart_rts,
         o_uart_tx      => s_u4_uart_tx,
         o_wb_ack       => s_u4_ack,
         o_wb_dat       => s_u4_rdat
         );
      
   U5_DMA:
   dma_subsys
      Generic Map (
         g_tech_lib        => g_tech_lib
         )
      Port Map (
         i_clk             => s_u1_clk_125,
         i_rst_n           => s_u1_rst_n,
         
         i_wbm_ack         => s_u1_wbs_ack,
         i_wbm_dat         => s_u1_wbs_rdat,  
         i_wbs_adr         => s_u1_wbm_adr,
         i_wbs_cyc         => s_rtl_cyc_dma,
         i_wbs_dat         => s_u1_wbm_dat,
         i_wbs_sel         => s_u1_wbm_sel,
         i_wbs_stb         => s_u1_wbm_stb,
         i_wbs_we          => s_u1_wbm_we,
         
         o_int_req         => s_u5_int_req,
         o_wbm_adr         => s_u5_wbm_adr,
         o_wbm_bte         => s_u5_wbm_bte,
         o_wbm_cti         => s_u5_wbm_cti,
         o_wbm_cyc         => s_u5_wbm_cyc,
         o_wbm_dat         => s_u5_wbm_dat,
         o_wbm_sel         => s_u5_wbm_sel,
         o_wbm_stb         => s_u5_wbm_stb,
         o_wbm_we          => s_u5_wbm_we,
         o_wbs_ack         => s_u5_wbs_ack,
         o_wbs_dat         => s_u5_wbs_dat      
         );

   U6_BMRAM:
   tsls_wb_bmram
      Generic Map (
         g_array_sz        => c_bmram_words,
         g_tech_lib        => g_tech_lib
         )
      Port Map (
         i_clk       => s_u1_clk_125,
         i_rst_n     => s_u1_rst_n,
         
         i_wb_adr    => s_u1_wbm_adr,
         i_wb_bte    => s_u1_wbm_bte, 
         i_wb_cti    => s_u1_wbm_cti,
         i_wb_cyc    => s_rtl_cyc_bmram,
         i_wb_dat    => s_u1_wbm_dat,
         i_wb_lock   => c_tie_low,
         i_wb_sel    => s_u1_wbm_sel,
         i_wb_stb    => s_u1_wbm_stb,
         i_wb_we     => s_u1_wbm_we,
            
         o_wb_ack    => s_u6_wb_ack,      
         o_wb_dat    => s_u6_wb_dat
         );
         
   U7_CFI:
   tspc_wb_cfi_jxb3
      Generic Map (
         g_buf_words       => c_cfi_buf_sz, 
         g_tech_lib        => g_tech_lib
         )
      Port Map (
         i_clk_spi            => s_u3_clk_spi,
         i_clk_sys            => s_u1_clk_125,
         i_rst_n              => s_u1_rst_n,
         i_clr                => c_tie_low,

         i_spi_miso           => i_spi_miso,
         i_sys_rdy            => s_u1_dl_up,
         i_wb_dma_adr         => c_tie_low_byte,
         i_wb_dma_cti         => c_wb_cti_burst_incr,
         i_wb_dma_cyc         => c_tie_low,
         i_wb_dma_din         => c_tie_low_dword,
         i_wb_dma_sel         => c_tie_low_byte(3 downto 0),
         i_wb_dma_stb         => c_tie_low,
         i_wb_dma_we          => c_tie_low,
         i_wb_reg_adr         => s_u1_wbm_adr(11 downto 0),
         i_wb_reg_cyc         => s_rtl_cyc_cfi,
         i_wb_reg_din         => s_u1_wbm_dat,
         i_wb_reg_sel         => s_u1_wbm_sel,
         i_wb_reg_stb         => s_u1_wbm_stb,
         i_wb_reg_we          => s_u1_wbm_we,

         o_img_has_update     => open,
         o_img_reload         => open,
         o_int_req            => s_u7_int_req,
         o_spi_mosi           => s_u7_spi_mosi,
         o_spi_mosi_en        => s_u7_spi_mosi_en,
         o_spi_sclk           => s_u7_spi_sclk,
         o_spi_sclk_en        => s_u7_spi_sclk_en,
         o_spi_ssel           => s_u7_spi_ssel,
         o_wb_dma_ack         => open,
         o_wb_dma_dout        => s_u7_wb_dma_dat,
         o_wb_reg_ack         => s_u7_wb_ack,
         o_wb_reg_dout        => s_u7_wb_dat           
         );  
End Rtl;
