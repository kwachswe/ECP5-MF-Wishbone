
--    
--    Copyright Ing. Buero Gardiner, 2021
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_cdc_ack-e.vhd 5369 2021-12-12 23:22:31Z  $
-- Generated   : $LastChangedDate: 2021-12-13 00:22:31 +0100 (Mon, 13 Dec 2021) $
-- Revision    : $LastChangedRevision: 5369 $
--
--------------------------------------------------------------------------------
--
-- Description : Master/Slave register pair for CDC applications
--
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.std_logic_1164.all;

Entity tspc_cdc_ack is
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
      i_wr_din       : in  std_logic;
      i_wr_en        : in  std_logic;

      o_rd_dout      : out std_logic;
      o_rd_ready     : out std_logic;
      
      o_wr_ready     : out std_logic
      );
End tspc_cdc_ack;
