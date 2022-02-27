
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: rx_ser_8250_core-e.vhd 5378 2021-12-13 00:15:46Z  $
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

Entity rx_ser_8250_core is
   Port (
      i_rst_n        : in  std_logic;

      i_xclk         : in  std_logic;
      i_xclk_en      : in  std_logic;

      i_baud_chng    : in  std_logic;
      i_par_en       : in  std_logic;
      i_par_even     : in  std_logic;
      i_par_stick    : in  std_logic;
      i_rhr_ready    : in  std_logic;
      i_rx           : in  std_logic;
      i_stop_bits    : in  std_logic;
      i_word_length  : in  std_logic_vector(1 downto 0);
      
      o_break        : out std_logic;
      o_dout         : out std_logic_vector(7 downto 0);
      o_err_frm      : out std_logic;
      o_err_ovr      : out std_logic;
      o_err_par      : out std_logic;
      o_frame_eval   : out std_logic;
      o_rhr_push     : out std_logic;
      o_sample_tick  : out std_logic
      );
End rx_ser_8250_core;
