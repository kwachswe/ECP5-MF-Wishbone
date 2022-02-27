--
--    Copyright Ing. Buero Gardiner 2008 - 2012
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_dma_chan_ms_types-p.vhd 4387 2018-08-10 18:23:52Z  $
-- Generated   : $LastChangedDate: 2018-08-10 20:23:52 +0200 (Fri, 10 Aug 2018) $
-- Revision    : $LastChangedRevision: 4387 $
--
--------------------------------------------------------------------------------
--
-- Description :
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Package tspc_dma_chan_ms_types is
   type t_tspc_dma_ms_ctl is
      record
         cmd_push_mst   : std_logic;
         cmd_push_slv   : std_logic;
         dma_clr        : std_logic;
         dma_en         : std_logic;
         int_dis_hfe    : std_logic;
         int_dis_lfe    : std_logic;  
      end record;

   type t_tspc_dma_ms_flags is
      record
         adr_rst  : std_logic;
         dma_last : std_logic;
         dma_wr   : std_logic;
         int_req  : std_logic;
      end record;

   type t_tspc_dma_ms_sta is
      record
         dfifo_empty    : std_logic;
         dma_idle       : std_logic;
         dma_wait       : std_logic;
         hcfifo_empty   : std_logic;
         lcfifo_empty   : std_logic;
      end record;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   constant c_nr_flag_fields  : positive := 4;

   constant c_tspc_dma_ms_ctl_init     : t_tspc_dma_ms_ctl     := (others => '0');
   constant c_tspc_dma_ms_flags_init   : t_tspc_dma_ms_flags   := (others => '0');

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_get_flags(vPack : std_logic_vector; vAdrSz : positive) return t_tspc_dma_ms_flags;

   function f_get_adr(vPack : std_logic_vector; vAdrSz : positive) return std_logic_vector;

   function f_get_packed_cmd_sz(vAdrSz : positive; vXferSz : positive) return positive;

   function f_get_xfer_sz(vPack : std_logic_vector; vXferSz : positive) return std_logic_vector;

   function f_pack(vFlags : t_tspc_dma_ms_flags) return std_logic_vector;
      
   function f_pack(vAdr : std_logic_vector; vFlags : t_tspc_dma_ms_flags; vSize : std_logic_vector) return std_logic_vector;

End tspc_dma_chan_ms_types;
