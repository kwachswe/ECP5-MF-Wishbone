
--
--    Copyright Ingenieurbuero Gardiner, 2007 - 2014
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
-- File ID     : $Id: uart_block_comps-p.vhd 83 2021-12-12 22:09:26Z  $
-- Generated   : $LastChangedDate: 2021-12-12 23:09:26 +0100 (Sun, 12 Dec 2021) $
-- Revision    : $LastChangedRevision: 83 $
--
--------------------------------------------------------------------------------
--
-- Description : UART Wrapper
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Package uart_block_comps is
   Component wb_16550s
      Generic (
         g_align           : string := "WORD";
         g_mem_dmram_rx    : boolean := false;
         g_mem_dmram_tx    : boolean := false;
         g_mem_words_rx    : natural := 16;
         g_mem_words_tx    : natural := 16;
         g_tech_lib        : string := "ECP3"
         );
      Port (
         i_clk          : in  std_logic;
         i_xclk         : in  std_logic;
         i_rst_n        : in  std_logic;

         i_cd           : in  std_logic;
         i_cts          : in  std_logic;
         i_dsr          : in  std_logic;
         i_ring         : in  std_logic;
         i_rx           : in  std_logic;
         i_wb_adr       : in  std_logic_vector;
         i_wb_cyc       : in  std_logic;
         i_wb_dat       : in  std_logic_vector;
         i_wb_sel       : in  std_logic_vector;
         i_wb_stb       : in  std_logic;
         i_wb_we        : in  std_logic;

         o_dtr          : out std_logic;
         o_int          : out std_logic;
         o_op1          : out std_logic;
         o_op2          : out std_logic;
         o_rts          : out std_logic;
         o_rxrdy        : out std_logic;
         o_tx           : out std_logic;
         o_tx_en        : out std_logic;
         o_txrdy        : out std_logic;
         o_wb_ack       : out std_logic;
         o_wb_dat       : out std_logic_vector
         );
   End Component;
End Package uart_block_comps;
