
--    
--    Copyright Ingenieurbuero Gardiner, 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--   
--------------------------------------------------------------------------------
--
-- File ID    : $Id: versa_ecp5_comps-p.vhd 83 2021-12-12 22:09:26Z  $
-- Generated  : $LastChangedDate: 2021-12-12 23:09:26 +0100 (Sun, 12 Dec 2021) $
-- Revision   : $LastChangedRevision: 83 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;

Package versa_ecp5_comps is
   Component tspc_cdc_vec
      Generic (
         g_stages    : positive := 1
         );
      Port ( 
         i_clk       : in  std_logic;
         i_rst_n     : in  std_logic;
         
         i_cdc_in    : in  std_logic_vector;
         
         o_cdc_out   : out std_logic_vector
         );
   End Component;
End versa_ecp5_comps;
