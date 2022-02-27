
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: modem_regs_16550s-e.vhd 5378 2021-12-13 00:15:46Z  $
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

Entity modem_regs_16550s is
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
      o_dma_mode           : out std_logic;
      o_din                : out std_logic_vector(7 downto 0);
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
End modem_regs_16550s;
