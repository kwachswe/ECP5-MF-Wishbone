
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: pcat_16550s_comps-p.vhd 5378 2021-12-13 00:15:46Z  $
-- Generated   : $LastChangedDate: 2021-12-13 01:15:46 +0100 (Mon, 13 Dec 2021) $
-- Revision    : $LastChangedRevision: 5378 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.std_logic_1164.all;

Package pcat_16550s_comps is
   Component modem_regs_16550s
      Port (
         i_rst_n              : in  std_logic;
         i_clk                : in  std_logic;
         i_xclk               : in  std_logic;

         i_addr               : in  std_logic_vector(2 downto 0);
         i_cd                 : in  std_logic;
         i_cts                : in  std_logic;
         i_din                : in  std_logic_vector(7 downto 0);
         i_dsr                : in  std_logic;
         i_int_line_status    : in  std_logic;
         i_int_rcv_data       : in  std_logic;
         i_int_rcv_timer      : in  std_logic;
         i_int_tx_empty       : in  std_logic;
         i_lsr_din            : in  std_logic_vector(7 downto 0);
         i_rd                 : in  std_logic;
         i_rhr_din            : in  std_logic_vector(7 downto 0);
         i_ring               : in  std_logic;
         i_sel                : in  std_logic;
         i_wr                 : in  std_logic;
      
         o_baud_chng          : out std_logic;
         o_din                : out std_logic_vector(7 downto 0);
         o_dma_mode           : out std_logic;
         o_dout               : out std_logic_vector(7 downto 0);
         o_dtr                : out std_logic;
         o_fifo_clr_rx        : out std_logic;
         o_fifo_clr_tx        : out std_logic;
         o_fifo_en            : out std_logic;
         o_fifo_threshold_sel : out std_logic_vector(1 downto 0);
         o_int                : out std_logic;
         o_int_ack_tx_empty   : out std_logic;
         o_int_en_line_status : out std_logic;
         o_int_en_rcv_data    : out std_logic;
         o_int_en_tx_empty    : out std_logic;
         o_loopback_en        : out std_logic;
         o_op1                : out std_logic;
         o_op2                : out std_logic;
         o_par_en             : out std_logic;
         o_par_even           : out std_logic;
         o_par_stick          : out std_logic;
         o_rd_en_isr          : out std_logic;
         o_rd_en_lsr          : out std_logic;
         o_rd_en_rhr          : out std_logic;
         o_rts                : out std_logic;
         o_send_break         : out std_logic;
         o_stop_bits          : out std_logic;
         o_word_length        : out std_logic_vector(1 downto 0);
         o_wr_en_thr          : out std_logic;
         o_xclk_en            : out std_logic
         );
   End Component;
   
   Component rx_16550s
      Generic (
         g_mem_dmram    : boolean := false;
         g_mem_words    : natural := 16;
         g_tech_lib     : string := "ECP3"
         );
      Port (
         i_rst_n              : in  std_logic;
         i_clk                : in  std_logic;

         i_xclk               : in  std_logic;
         i_xclk_en            : in  std_logic;

         i_baud_chng          : in  std_logic;
         i_dma_mode           : in  std_logic;
         i_fifo_clr           : in  std_logic;
         i_fifo_en            : in  std_logic;
         i_fifo_threshold_sel : in  std_logic_vector(1 downto 0);
         i_int_en_line_status : in  std_logic;
         i_int_en_rcv_data    : in  std_logic;
         i_loopback_en        : in  std_logic;
         i_loopback_rx        : in  std_logic;
         i_par_en             : in  std_logic;
         i_par_even           : in  std_logic;
         i_par_stick          : in  std_logic;
         i_rd_en_lsr          : in  std_logic;
         i_rd_en_rhr          : in  std_logic;
         i_rx                 : in  std_logic;
         i_stop_bits          : in  std_logic;
         i_word_length        : in  std_logic_vector(1 downto 0);

         o_int_line_status    : out std_logic;
         o_int_rcv_data       : out std_logic;
         o_int_rcv_timer      : out std_logic;
         o_lsr_dout           : out std_logic_vector(7 downto 0);
         o_rhr_dout           : out std_logic_vector(7 downto 0);
         o_rxrdy              : out std_logic
         );
   End Component;

   Component tx_16550s
      Generic (
         g_mem_dmram    : boolean := false;
         g_mem_words    : natural := 16;
         g_tech_lib     : string := "ECP3"
         );
      Port (
         i_rst_n              : in  std_logic;
         i_clk                : in  std_logic;

         i_xclk               : in  std_logic;
         i_xclk_en            : in  std_logic;

         i_baud_chng          : in  std_logic;
         i_dma_mode           : in  std_logic;
         i_fifo_clr           : in  std_logic;
         i_fifo_en            : in  std_logic;
         i_int_ack_tx_empty   : in  std_logic;
         i_int_en_tx_empty    : in  std_logic;
         i_par_en             : in  std_logic;
         i_par_even           : in  std_logic;
         i_par_stick          : in  std_logic;
         i_send_break         : in  std_logic;
         i_stop_bits          : in  std_logic;
         i_thr_din            : in  std_logic_vector;
         i_word_length        : in  std_logic_vector(1 downto 0);
         i_wr_en_thr          : in  std_logic;

         o_int_tx_empty       : out std_logic;
         o_lsr_dout           : out std_logic_vector(7 downto 0);
         o_tx                 : out std_logic;
         o_tx_en              : out std_logic;         
         o_txrdy              : out std_logic
         );
   End Component;
End pcat_16550s_comps;
