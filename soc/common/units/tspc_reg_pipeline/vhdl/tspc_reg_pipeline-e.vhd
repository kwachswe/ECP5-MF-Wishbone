
--    
--    Copyright Ing. Buero Gardiner, 2007 - 2012
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_reg_pipeline-e.vhd 3001 2015-10-15 18:26:31Z  $
-- Generated   : $LastChangedDate: 2015-10-15 20:26:31 +0200 (Thu, 15 Oct 2015) $
-- Revision    : $LastChangedRevision: 3001 $
--
--------------------------------------------------------------------------------
--
-- Description : Configurable Pipeline Stage
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Entity tspc_reg_pipeline is
   Generic (
      g_num_stages   : positive := 1
      );
   Port (
      i_clk       : in  std_logic;
      i_rst_n     : in  std_logic;

      i_din       : in  std_logic_vector;

      o_dout      : out std_logic_vector
      );
End tspc_reg_pipeline;
