
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tx_ser_8250_core_types-p.vhd 5378 2021-12-13 00:15:46Z  $
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

Package tx_ser_8250_core_types is
   constant c_word_size_5     : std_logic_vector(1 downto 0) := "00";
   constant c_word_size_6     : std_logic_vector(1 downto 0) := "01";
   constant c_word_size_7     : std_logic_vector(1 downto 0) := "10";
   constant c_word_size_8     : std_logic_vector(1 downto 0) := "11";

   constant c_word_size_int_5 : natural := 5;
   constant c_word_size_int_6 : natural := 6;
   constant c_word_size_int_7 : natural := 7;
   constant c_word_size_int_8 : natural := 8;

End tx_ser_8250_core_types;
