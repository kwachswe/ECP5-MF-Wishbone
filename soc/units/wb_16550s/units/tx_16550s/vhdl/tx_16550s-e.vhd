
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tx_16550s-e.vhd 5378 2021-12-13 00:15:46Z  $
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

Entity tx_16550s is
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
End tx_16550s;
