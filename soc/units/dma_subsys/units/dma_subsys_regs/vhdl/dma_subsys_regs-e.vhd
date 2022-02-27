
--
--    Developed by Ingenieurbuero Gardiner
--                 Heuglinstr. 29a
--                 81249 Muenchen
--                 charles.gardiner@ib-gardiner.eu
--
--    Copyright Ingenieurbuero Gardiner, 2004 - 2017
--------------------------------------------------------------------------------
--
-- File ID     : $Id: dma_subsys_regs-e.vhd 82 2021-12-12 21:57:48Z  $
-- Generated   : $LastChangedDate: 2021-12-12 22:57:48 +0100 (Sun, 12 Dec 2021) $
-- Revision    : $LastChangedRevision: 82 $
--
--------------------------------------------------------------------------------
--
-- Description :
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use WORK.tspc_dma_chan_ms_types.all;

Entity dma_subsys_regs is
   Port (
      i_clk                : in  std_logic;
      i_rst_n              : in  std_logic;   

      i_dma_ev_int_req     : in  std_logic;
      i_dma_hfifo_count    : in  std_logic_vector;
      i_dma_lfifo_count    : in  std_logic_vector;       
      i_dma_sta            : in  t_tspc_dma_ms_sta;
      i_dma_xfer_pos       : in  std_logic_vector;      
      i_wb_adr             : in  std_logic_vector;
      i_wb_cyc             : in  std_logic;
      i_wb_dat             : in  std_logic_vector;
      i_wb_sel             : in  std_logic_vector;
      i_wb_stb             : in  std_logic;
      i_wb_we              : in  std_logic;      

      o_dma_chh_adr        : out std_logic_vector;
      o_dma_chl_adr        : out std_logic_vector;
      o_dma_ctl            : out t_tspc_dma_ms_ctl;
      o_dma_xfer_flags     : out t_tspc_dma_ms_flags;
      o_dma_xfer_sz        : out std_logic_vector;          
      o_int_req            : out std_logic;
      o_wb_ack             : out std_logic;      
      o_wb_dat             : out std_logic_vector       
      );
End dma_subsys_regs;
