
--    
--    Copyright Ing. Buero Gardiner, 2007 - 2021
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_cdc_vec-e.vhd 5240 2021-01-13 13:38:50Z  $
-- Generated   : $LastChangedDate: 2021-01-13 14:38:50 +0100 (Wed, 13 Jan 2021) $
-- Revision    : $LastChangedRevision: 5240 $
--
--------------------------------------------------------------------------------
--
-- Description : Vector synchroniser for array of independent signals
--    
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;

Entity tspc_cdc_vec is
   Generic (
      g_stages    : positive := 1
      );
   Port ( 
      i_clk          : in  std_logic;
      i_rst_n        : in  std_logic;
      
      i_cdc_in       : in  std_logic_vector;
      
      o_cdc_out      : out std_logic_vector
      );
End tspc_cdc_vec;
      
