
--
--    Copyright Ingenieurbuero Gardiner, 2013 - 2014
--
--    All Rights Reserved
--
--       This proprietary software may be used only as authorised in a licensing,
--       product development or training agreement.
--
--       Copies may only be made to the extent permitted by such an aforementioned
--       agreement. This entire notice above must be reproduced on
--       all copies.
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_fifo_sync_mem-e.vhd 4682 2019-03-22 15:18:26Z  $
-- Generated   : $LastChangedDate: 2019-03-22 16:18:26 +0100 (Fri, 22 Mar 2019) $
-- Revision    : $LastChangedRevision: 4682 $
--
--------------------------------------------------------------------------------
--
-- Description : Memory Wrapper for Lattice PMI Memories
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Entity tspc_fifo_sync_mem is
   Generic (
      g_mem_dmram    : boolean := false;
      g_mem_words    : natural;
      g_rd_latency   : positive range 1 to 2 := 1;
      g_tech_lib     : string := "ECP3";
      g_tech_type    : string := "ANY";
      g_wr_latency   : positive := 1
      );   
   Port ( 
      i_clk          : in  std_logic;
      i_rst_n        : in  std_logic;
      i_clr          : in  std_logic;

      i_rd_adr       : in  std_logic_vector;
      i_rd_clk_en    : in  std_logic;
      i_rd_reg_en    : in  std_logic;

      i_wr_adr       : in  std_logic_vector;
      i_wr_clk_en    : in  std_logic;
      i_wr_din       : in  std_logic_vector;
      i_wr_en        : in  std_logic;

      o_rd_dout      : out std_logic_vector
      );   
End tspc_fifo_sync_mem;
