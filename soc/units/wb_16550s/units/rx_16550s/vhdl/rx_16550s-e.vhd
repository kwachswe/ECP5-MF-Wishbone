
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: rx_16550s-e.vhd 5378 2021-12-13 00:15:46Z  $
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

Entity rx_16550s is
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
End rx_16550s;
 
