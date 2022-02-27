
--    
--    Copyright Ing. Buero Gardiner, 2007 - 2012
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_cdc_reg-e.vhd 4100 2018-04-27 22:02:08Z  $
-- Generated   : $LastChangedDate: 2018-04-28 00:02:08 +0200 (Sat, 28 Apr 2018) $
-- Revision    : $LastChangedRevision: 4100 $
--
--------------------------------------------------------------------------------
--
-- Description : Master/Slave register pair for CDC applications
--
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.std_logic_1164.all;

Entity tspc_cdc_reg is
   Generic (
      g_mask_on_empty   : boolean := false;
      g_rd_ready_ev     : boolean := false
      );
   Port (
      i_rst_n        : in  std_logic;

      i_rd_clk       : in  std_logic;
      i_rd_clk_en    : in  std_logic;
      i_rd_en        : in  std_logic;

      i_wr_clk       : in  std_logic;
      i_wr_clk_en    : in  std_logic;
      i_wr_din       : in  std_logic_vector;
      i_wr_en        : in  std_logic;

      o_rd_dout      : out std_logic_vector;
      o_rd_ready     : out std_logic;
      
      o_wr_ready     : out std_logic
      );
End tspc_cdc_reg;
