
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: pcat_16550s-e.vhd 5378 2021-12-13 00:15:46Z  $
-- Generated   : $LastChangedDate: 2021-12-13 01:15:46 +0100 (Mon, 13 Dec 2021) $
-- Revision    : $LastChangedRevision: 5378 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--       i_clk    : System clock for accessing registers etc.
--       i_xclk   : Nom. Freq. 1.8432 MHz for Rx/Tx
--
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.std_logic_1164.all;

Entity pcat_16550s is
   Generic (
      g_mem_dmram_rx    : boolean := false;
      g_mem_dmram_tx    : boolean := false;
      g_mem_words_rx    : natural := 16;
      g_mem_words_tx    : natural := 16;
      g_tech_lib        : string := "ECP3"
      );
   Port (
      i_clk       : in  std_logic;
      i_rst_n     : in  std_logic;
      
      i_addr      : in  std_logic_vector(2 downto 0);
      i_cd        : in  std_logic;
      i_cts       : in  std_logic;
      i_din       : in  std_logic_vector(7 downto 0);
      i_dsr       : in  std_logic;
      i_rd        : in  std_logic;
      i_ring      : in  std_logic;
      i_rx        : in  std_logic;
      i_sel       : in  std_logic;
      i_wr        : in  std_logic;
      i_xclk      : in  std_logic;
      
      o_dout      : out std_logic_vector(7 downto 0);
      o_dtr       : out std_logic;
      o_int       : out std_logic;
      o_op1       : out std_logic;
      o_op2       : out std_logic;
      o_rts       : out std_logic;
      o_rxrdy     : out std_logic;
      o_tx        : out std_logic;
      o_tx_en     : out std_logic;    
      o_txrdy     : out std_logic
      );
End pcat_16550s;
