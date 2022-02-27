
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tx_16550s-a_rtl.vhd 5378 2021-12-13 00:15:46Z  $
-- Generated   : $LastChangedDate: 2021-12-13 01:15:46 +0100 (Mon, 13 Dec 2021) $
-- Revision    : $LastChangedRevision: 5378 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--    The TX Interrupt is generated in the following situations
--       1) FIFO enabled and FIFO runs empty
--       2) FIFO enabled, FIFO Empty and interrupt enable goes active (EXAR datasheet)
--       3) FIFO not enabled and THR runs empty
--
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.numeric_std.all;
Use WORK.tx_16550s_comps.all;
Use WORK.tx_ser_8250_core_types.all;
Use WORK.tspc_utils.all;

Architecture Rtl of tx_16550s is  
   constant c_pos_fifo_empty     : natural := 0;
   constant c_pos_thr_rdy        : natural := 1;
   
   signal s_rtl_attrib           : std_logic_vector(1 downto 0);
   signal s_rtl_ev_int_thre      : std_logic_vector(0 downto 0);
   signal s_rtl_fifo_pop         : std_logic;
   signal s_rtl_fifo_push        : std_logic;
   signal s_rtl_thr_din          : std_logic_vector(i_thr_din'length - 1 downto 0);
   signal s_rtl_wr_en_thr        : std_logic;
   signal s_sta_thr_empty        : std_logic;
   signal s_sta_tx_empty         : std_logic;
   signal s_tx_int_ack           : std_logic;
   signal s_u1_thr_pop           : std_logic;
   signal s_u1_tx                : std_logic;
   signal s_u1_tx_en             : std_logic;
   signal s_u1_tx_tsr_empty      : std_logic;
   signal s_u2_fifo_rd_count     : std_logic_vector(f_vec_msb(g_mem_words) downto 0);
   signal s_u2_rd_dout           : std_logic_vector(i_thr_din'length - 1 downto 0);
   signal s_u2_rd_empty          : std_logic;
   signal s_u2_wr_free           : std_logic_vector(f_vec_msb(g_mem_words) downto 0);
   signal s_u2_wr_full           : std_logic;
   signal s_u3_rd_dout           : std_logic_vector(i_thr_din'length - 1 downto 0);
   signal s_u3_wr_ready          : std_logic;
   signal s_u3_rd_ready          : std_logic;
   signal s_u4_int_thre          : std_logic_vector(0 downto 0);   
   signal s_u5_attrib            : std_logic_vector(1 downto 0);
   
Begin
   o_int_tx_empty    <= s_u4_int_thre(0);
   
   o_lsr_dout        <= '0' & s_sta_tx_empty & s_sta_thr_empty & "00000";
   
   o_tx              <= s_u1_tx;
   o_tx_en           <= s_u1_tx_en;
   
   o_txrdy           <= (s_u3_wr_ready and not i_fifo_en) or
                        (s_u2_rd_empty and i_fifo_en and not i_dma_mode) or
                        (i_fifo_en and i_dma_mode and not s_u2_wr_full);
                         
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                
   s_rtl_attrib(c_pos_fifo_empty)   <= s_u2_rd_empty and i_int_en_tx_empty;
   s_rtl_attrib(c_pos_thr_rdy)      <= s_u3_wr_ready and i_int_en_tx_empty;
                   
   s_rtl_ev_int_thre(0) <= (s_rtl_attrib(c_pos_thr_rdy)    and not s_u5_attrib(c_pos_thr_rdy)    and not i_fifo_en) or
                           (s_rtl_attrib(c_pos_fifo_empty) and not s_u5_attrib(c_pos_fifo_empty) and     i_fifo_en);
                           
   s_rtl_fifo_pop       <= s_u3_wr_ready and not s_u2_rd_empty and i_fifo_en; 
   s_rtl_fifo_push      <= i_fifo_en and i_wr_en_thr;
   
   s_rtl_thr_din        <= i_thr_din when (i_fifo_en = '0') else s_u2_rd_dout;
   
   s_rtl_wr_en_thr      <= (i_wr_en_thr and not i_fifo_en) or s_rtl_fifo_pop;

   s_sta_thr_empty      <= s_u3_wr_ready when (i_fifo_en = '0') else
                           (s_u3_wr_ready and s_u2_rd_empty);
         
   s_sta_tx_empty       <= s_u2_rd_empty or not i_fifo_en;

   s_tx_int_ack         <= i_int_ack_tx_empty or i_wr_en_thr;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U1_TX_CORE:
   tx_ser_8250_core
      Port Map(
         i_rst_n        => i_rst_n,

         i_xclk         => i_xclk,
         i_xclk_en      => i_xclk_en,

         i_baud_chng    => i_baud_chng,
         i_din          => s_u3_rd_dout,
         i_par_en       => i_par_en,
         i_par_even     => i_par_even,
         i_par_stick    => i_par_stick,
         i_send_break   => i_send_break,
         i_stop_bits    => i_stop_bits,
         i_thr_ready    => s_u3_rd_ready,
         i_word_length  => i_word_length,

         o_thr_pop      => s_u1_thr_pop,
         o_tsr_empty    => s_u1_tx_tsr_empty,
         o_tx           => s_u1_tx,
         o_tx_en        => s_u1_tx_en
         );
         
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U2_FIFO:
   tspc_fifo_sync
      Generic Map (
         g_mem_dmram    => g_mem_dmram,
         g_mem_words    => g_mem_words, 
         g_tech_lib     => g_tech_lib
         )   
      Port Map ( 
         i_clk          => i_clk,
         i_rst_n        => i_rst_n,
         i_clr          => i_fifo_clr,
         
         i_rd_pop       => s_rtl_fifo_pop,        
         i_wr_din       => i_thr_din,
         i_wr_push      => s_rtl_fifo_push,

         o_rd_aempty    => open,
         o_rd_count     => s_u2_fifo_rd_count,
         o_rd_dout      => s_u2_rd_dout,
         o_rd_empty     => s_u2_rd_empty,
         o_rd_last      => open,
         o_wr_afull     => open,
         o_wr_free      => s_u2_wr_free,
         o_wr_full      => s_u2_wr_full,
         o_wr_last      => open
         );   
         
   U3_THR:
      -- Clock Domain THR   
   tspc_cdc_reg
      Port Map(
         i_rst_n        => i_rst_n, 

         i_rd_clk       => i_xclk, 
         i_rd_clk_en    => i_xclk_en, 
         i_rd_en        => s_u1_thr_pop, 

         i_wr_clk       => i_clk, 
         i_wr_clk_en    => c_tie_high, 
         i_wr_din       => s_rtl_thr_din, 
         i_wr_en        => s_rtl_wr_en_thr, 

         o_rd_dout      => s_u3_rd_dout, 
         o_rd_ready     => s_u3_rd_ready, 

         o_wr_ready     => s_u3_wr_ready 
         );

   U4_INT_THRE:
   tspc_event_latch
      Port Map (
         i_clk       => i_clk,
         i_rst_n     => i_rst_n,

         i_clr       => i_int_ack_tx_empty,
         i_event     => s_rtl_ev_int_thre,

         o_event_reg => s_u4_int_thre
         );

         
   U5_RP:
   tspc_reg_pipeline
      Port Map (
         i_clk       => i_clk,
         i_rst_n     => i_rst_n,

         i_din       => s_rtl_attrib,

         o_dout      => s_u5_attrib
         );
         
End Rtl;
