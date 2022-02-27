
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: pcat_16550s-a_rtl.vhd 5378 2021-12-13 00:15:46Z  $
-- Generated   : $LastChangedDate: 2021-12-13 01:15:46 +0100 (Mon, 13 Dec 2021) $
-- Revision    : $LastChangedRevision: 5378 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Use WORK.pcat_16550s_comps.all;

Architecture Rtl of pcat_16550s is
   signal s_cd                      : std_logic;
   signal s_cts                     : std_logic;
   signal s_dsr                     : std_logic;
   signal s_lsr_din                 : std_logic_vector(7 downto 0);
   signal s_ring                    : std_logic;   
   signal s_u1_baud_chng            : std_logic;
   signal s_u1_din                  : std_logic_vector(7 downto 0);
   signal s_u1_dma_mode             : std_logic;
   signal s_u1_dtr                  : std_logic;
   signal s_u1_fifo_clr_rx          : std_logic;
   signal s_u1_fifo_clr_tx          : std_logic;
   signal s_u1_fifo_en              : std_logic;
   signal s_u1_fifo_threshold_sel   : std_logic_vector(1 downto 0);
   signal s_u1_int                  : std_logic;
   signal s_u1_int_ack_tx_empty     : std_logic;
   signal s_u1_int_en_line_status   : std_logic;
   signal s_u1_int_en_rcv_data      : std_logic;
   signal s_u1_int_en_tx_empty      : std_logic;
   signal s_u1_loopback_en          : std_logic;
   signal s_u1_op1                  : std_logic;
   signal s_u1_op2                  : std_logic;
   signal s_u1_par_en               : std_logic;
   signal s_u1_par_even             : std_logic;
   signal s_u1_par_stick            : std_logic;
   signal s_u1_rd_en_lsr            : std_logic;
   signal s_u1_rd_en_rhr            : std_logic;
   signal s_u1_rts                  : std_logic;
   signal s_u1_send_break           : std_logic;
   signal s_u1_stop_bits            : std_logic;
   signal s_u1_word_length          : std_logic_vector(1 downto 0);
   signal s_u1_wr_en_thr            : std_logic;
   signal s_u1_xclk_en              : std_logic;
   signal s_u2_int_line_status      : std_logic;
   signal s_u2_int_rcv_data         : std_logic;
   signal s_u2_int_rcv_timer        : std_logic;
   signal s_u2_lsr_dout             : std_logic_vector(7 downto 0);
   signal s_u2_rhr_dout             : std_logic_vector(7 downto 0);
   signal s_u3_int_tx_empty         : std_logic;
   signal s_u3_lsr_dout             : std_logic_vector(7 downto 0);
   signal s_u3_tx                   : std_logic;
   signal s_u3_tx_en                : std_logic;
   
Begin
   o_dtr <= s_u1_dtr and not s_u1_loopback_en;
   
   o_int <= s_u1_int;
   o_op1 <= s_u1_op1 and not s_u1_loopback_en;
   
   o_op2 <= s_u1_op2 and not s_u1_loopback_en;

   o_rts <= s_u1_rts and not s_u1_loopback_en;
   
   o_tx     <= s_u3_tx or s_u1_loopback_en;
   o_tx_en  <= s_u3_tx_en and not s_u1_loopback_en;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_cd        <= i_cd when (s_u1_loopback_en = '0') else
                  s_u1_op2; 
                  
   s_cts       <= i_cts when (s_u1_loopback_en = '0') else
                  s_u1_rts; 
                  
   s_dsr       <= i_dsr when (s_u1_loopback_en = '0') else
                  s_u1_dtr;
                                                      
   s_lsr_din   <= s_u2_lsr_dout or s_u3_lsr_dout;
   
   s_ring      <= i_ring when (s_u1_loopback_en = '0') else
                  s_u1_op1; 
                  
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U1_CTL:
   modem_regs_16550s
      Port Map(
         i_rst_n              => i_rst_n,
         i_clk                => i_clk,
         i_xclk               => i_xclk,

         i_addr               => i_addr,
         i_cd                 => s_cd,
         i_cts                => s_cts,
         i_din                => i_din,
         i_dsr                => s_dsr,
         i_int_line_status    => s_u2_int_line_status,
         i_int_rcv_data       => s_u2_int_rcv_data,
         i_int_rcv_timer      => s_u2_int_rcv_timer,
         i_int_tx_empty       => s_u3_int_tx_empty,
         i_lsr_din            => s_lsr_din,
         i_rd                 => i_rd,
         i_rhr_din            => s_u2_rhr_dout,
         i_ring               => s_ring,
         i_sel                => i_sel,
         i_wr                 => i_wr,
      
         o_baud_chng          => s_u1_baud_chng,
         o_din                => s_u1_din,
         o_dma_mode           => s_u1_dma_mode,
         o_dout               => o_dout,
         o_dtr                => s_u1_dtr,
         o_fifo_clr_rx        => s_u1_fifo_clr_rx,
         o_fifo_clr_tx        => s_u1_fifo_clr_tx,
         o_fifo_en            => s_u1_fifo_en,
         o_fifo_threshold_sel => s_u1_fifo_threshold_sel,
         o_int                => s_u1_int,
         o_int_ack_tx_empty   => s_u1_int_ack_tx_empty,
         o_int_en_line_status => s_u1_int_en_line_status,
         o_int_en_rcv_data    => s_u1_int_en_rcv_data,
         o_int_en_tx_empty    => s_u1_int_en_tx_empty,
         o_loopback_en        => s_u1_loopback_en,
         o_op1                => s_u1_op1,
         o_op2                => s_u1_op2,
         o_par_en             => s_u1_par_en,
         o_par_even           => s_u1_par_even,
         o_par_stick          => s_u1_par_stick,
         o_rd_en_isr          => open,
         o_rd_en_lsr          => s_u1_rd_en_lsr,
         o_rd_en_rhr          => s_u1_rd_en_rhr,
         o_rts                => s_u1_rts,
         o_send_break         => s_u1_send_break,
         o_stop_bits          => s_u1_stop_bits,
         o_word_length        => s_u1_word_length,
         o_wr_en_thr          => s_u1_wr_en_thr,
         o_xclk_en            => s_u1_xclk_en
         );
         
   U2_RX:
   rx_16550s
      Generic Map (
         g_mem_dmram    => g_mem_dmram_rx,
         g_mem_words    => g_mem_words_rx,
         g_tech_lib     => g_tech_lib
         )
      Port Map(
         i_rst_n              => i_rst_n,
         i_clk                => i_clk,

         i_xclk               => i_xclk,
         i_xclk_en            => s_u1_xclk_en,

         i_baud_chng          => s_u1_baud_chng,
         i_dma_mode           => s_u1_dma_mode,
         i_fifo_clr           => s_u1_fifo_clr_rx,
         i_fifo_en            => s_u1_fifo_en,
         i_fifo_threshold_sel => s_u1_fifo_threshold_sel,
         i_int_en_line_status => s_u1_int_en_line_status,
         i_int_en_rcv_data    => s_u1_int_en_rcv_data,
         i_loopback_en        => s_u1_loopback_en,
         i_loopback_rx        => s_u3_tx,
         i_par_en             => s_u1_par_en,
         i_par_even           => s_u1_par_even,
         i_par_stick          => s_u1_par_stick,
         i_rd_en_lsr          => s_u1_rd_en_lsr,
         i_rd_en_rhr          => s_u1_rd_en_rhr,
         i_rx                 => i_rx,
         i_stop_bits          => s_u1_stop_bits,
         i_word_length        => s_u1_word_length,

         o_int_line_status    => s_u2_int_line_status,
         o_int_rcv_data       => s_u2_int_rcv_data,
         o_int_rcv_timer      => s_u2_int_rcv_timer,
         o_lsr_dout           => s_u2_lsr_dout,
         o_rhr_dout           => s_u2_rhr_dout,
         o_rxrdy              => o_rxrdy
         );

   U3_TX:
   tx_16550s
      Generic Map (
         g_mem_dmram    => g_mem_dmram_tx,
         g_mem_words    => g_mem_words_tx,
         g_tech_lib     => g_tech_lib
         )
      Port Map(
         i_rst_n              => i_rst_n,
         i_clk                => i_clk,

         i_xclk               => i_xclk,
         i_xclk_en            => s_u1_xclk_en,

         i_baud_chng          => s_u1_baud_chng,
         i_dma_mode           => s_u1_dma_mode,
         i_fifo_clr           => s_u1_fifo_clr_tx,
         i_fifo_en            => s_u1_fifo_en,
         i_int_ack_tx_empty   => s_u1_int_ack_tx_empty,
         i_int_en_tx_empty    => s_u1_int_en_tx_empty,
         i_par_en             => s_u1_par_en,
         i_par_even           => s_u1_par_even,
         i_par_stick          => s_u1_par_stick,
         i_send_break         => s_u1_send_break,
         i_stop_bits          => s_u1_stop_bits,
         i_thr_din            => s_u1_din,
         i_word_length        => s_u1_word_length,
         i_wr_en_thr          => s_u1_wr_en_thr,

         o_int_tx_empty       => s_u3_int_tx_empty,
         o_lsr_dout           => s_u3_lsr_dout,
         o_tx                 => s_u3_tx,
         o_tx_en              => s_u3_tx_en,
         o_txrdy              => o_txrdy
         );
End Rtl;
