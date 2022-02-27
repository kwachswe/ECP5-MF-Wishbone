
--
--    Copyright Ing. Buero Gardiner 2008 - 2012
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: wb_16550s-e.vhd 3693 2017-05-27 22:44:51Z  $
-- Generated   : $LastChangedDate: 2017-05-28 00:44:51 +0200 (Sun, 28 May 2017) $
-- Revision    : $LastChangedRevision: 3693 $
--
--------------------------------------------------------------------------------
--
-- Description : Entity for 16550 compatible UART with Wihbone Interface
--
--       i_clk    : System clock for register clock domain etc.
--       i_xclk   : Nom. Freq. 1.8432 MHz for Rx/Tx
--
-- Alignment can be specified as "WORD", "HWORD" or "QWORD"
--    "WORD" means the UART registers are always on bits 7:0, irrespective of the
--           external bus size
--    "HWORD" means the UART registers are alternately on bits 7:0 
--            (even registers) and 15:8 (odd registers). External bus is 16 bits
--            Byte lane affinity is preserved
--    "QWORD" means the UART registers alternate from bits 7:0 
--            (even registers) to 31:24 (2. odd registers). External bus is 
--            32 bits. Byte lane affinity is preserved
--
--    Note, even in the modes HWORD and QWORD only one byte can be written at a
--    time. The byte select line must match the lower address bit settings. 
--    On reads, the same value is displayed on each byte lane
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Entity wb_16550s is
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
End wb_16550s;
