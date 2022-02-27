--    
--    Copyright Ing. Buero Gardiner, 2007 - 2015
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_event_latch-e.vhd 2874 2015-07-10 23:16:13Z  $
-- Generated   : $LastChangedDate: 2015-07-11 01:16:13 +0200 (Sat, 11 Jul 2015) $
-- Revision    : $LastChangedRevision: 2874 $
--
--------------------------------------------------------------------------------
--
-- Description : mode_options : free_run | event
--    
--    A second rising edge on i_start or a rising edge on i_stop copies the 
--    counter value to the slave output stage
--
--    i_count_en must be synchronous to i_clk
--------------------------------------------------------------------------------

Library IEEE; 
Use IEEE.std_logic_1164.all;

Entity tspc_event_latch is
   Port (
      i_clk       : in  std_logic;
      i_rst_n     : in  std_logic;

      i_clr       : in  std_logic;
      i_event     : in  std_logic_vector;

      o_event_reg : out std_logic_vector
      );
End tspc_event_latch;