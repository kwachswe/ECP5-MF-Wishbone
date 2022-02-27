
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tx_ser_8250_core-e.vhd 5378 2021-12-13 00:15:46Z  $
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

Entity tx_ser_8250_core is
   Port (
      i_rst_n        : in  std_logic;

      i_xclk         : in  std_logic;
      i_xclk_en      : in  std_logic;

      i_baud_chng    : in  std_logic;
      i_din          : in  std_logic_vector(7 downto 0);
      i_par_en       : in  std_logic;
      i_par_even     : in  std_logic;
      i_par_stick    : in  std_logic;
      i_send_break   : in  std_logic;
      i_stop_bits    : in  std_logic;
      i_thr_ready    : in  std_logic;
      i_word_length  : in  std_logic_vector(1 downto 0);
      
      o_thr_pop      : out std_logic;
      o_tsr_empty    : out std_logic;
      o_tx           : out std_logic;
      o_tx_en        : out std_logic
      );
End tx_ser_8250_core;
 
