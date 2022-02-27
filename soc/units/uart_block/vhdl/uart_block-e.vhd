
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
-- File ID     : $Id: uart_block-e.vhd 83 2021-12-12 22:09:26Z  $
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

Entity uart_block is
   Generic (
      g_nr_uarts        : natural := 6;
      g_tech_lib        : string := "ECP3"
      );
   Port (
      i_clk_sys      : in  std_logic;
      i_xclk         : in  std_logic;
      i_rst_n        : in  std_logic;

      i_uart_cts     : in  std_logic_vector(g_nr_uarts - 1 downto 0);
      i_uart_rx      : in  std_logic_vector(g_nr_uarts - 1 downto 0);
      i_wb_adr       : in  std_logic_vector;
      i_wb_cyc       : in  std_logic_vector(g_nr_uarts - 1 downto 0);
      i_wb_dat       : in  std_logic_vector;
      i_wb_sel       : in  std_logic_vector;
      i_wb_stb       : in  std_logic;
      i_wb_we        : in  std_logic;

      o_int_req      : out std_logic_vector(g_nr_uarts - 1 downto 0);
      o_uart_tx_en   : out std_logic_vector(g_nr_uarts - 1 downto 0);
      o_uart_rts     : out std_logic_vector(g_nr_uarts - 1 downto 0);
      o_uart_tx      : out std_logic_vector(g_nr_uarts - 1 downto 0);
      o_wb_ack       : out std_logic;
      o_wb_dat       : out std_logic_vector
      );
End Entity;
