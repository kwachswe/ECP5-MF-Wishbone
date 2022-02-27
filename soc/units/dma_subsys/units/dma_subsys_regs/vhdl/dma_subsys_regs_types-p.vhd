--
--    Developed by Ingenieurbuero Gardiner
--                 Heuglinstr. 29a
--                 81249 Muenchen
--                 charles.gardiner@ib-gardiner.eu
--
--    Copyright Ingenieurbuero Gardiner, 2004 - 2014
--------------------------------------------------------------------------------
--
-- File ID     : $Id: dma_subsys_regs_types-p.vhd 82 2021-12-12 21:57:48Z  $
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

Package dma_subsys_regs_types is
      -- Configuration Settings
   constant c_ddr_adr_sz               : positive := 23;
   constant c_host_adr_sz              : positive := 48;
   constant c_wb_adr_sz                : positive := 8;

         -- Derived Settings
   constant c_msb_host_adr_high        : positive := c_host_adr_sz - 32 - 1;
   constant c_msb_ddr_adr              : positive := c_ddr_adr_sz - 1;

      -- Register Addresses
   constant c_adr_dma_cfifo_count      : natural := 16#1C#;
   constant c_adr_dma_cmd_sta          : natural := 16#00#;
   constant c_adr_dma_hadr_high        : natural := 16#0C#;
   constant c_adr_dma_hadr_low         : natural := 16#08#;
   constant c_adr_dma_ladr             : natural := 16#14#;
   constant c_adr_dma_xfer_attribs     : natural := 16#10#;
   constant c_adr_dma_xfer_pos         : natural := 16#18#;
   constant c_adr_dma_xfer_size        : natural := 16#04#;
   
      -- Bit / Bit-Field Positions
   constant c_bpos_dfifo_empty         : natural := 23;
   constant c_bpos_dma_attrib_host_wr  : natural := 0;
   constant c_bpos_dma_attrib_int_req  : natural := 1;
   constant c_bpos_dma_attrib_seq_last : natural := 2;   
   constant c_bpos_dma_clr             : natural := 12;
   constant c_bpos_dma_en              : natural := 0;
   constant c_bpos_dma_idle            : natural := 18;
   constant c_bpos_hcfifo_empty        : natural := 21;
   constant c_bpos_hcmd_push           : natural := 10;
   constant c_bpos_int_ack             : natural := 9;
   constant c_bpos_int_dis_hfe         : natural := 2;
   constant c_bpos_int_dis_lfe         : natural := 3;
   constant c_bpos_int_en              : natural := 1;
   constant c_bpos_int_req             : natural := 17;
   constant c_bpos_irq_globdma         : natural := 0;
   constant c_bpos_irq_ram             : natural := 0;
   constant c_bpos_lcfifo_empty        : natural := 22;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   type t_regdma_cfifo_count is
      record
         hfifo_count    : std_logic_vector(15 downto 0);
         lfifo_count    : std_logic_vector(15 downto 0);
      end record;
      
   type t_regdma_cmd is
      record
         dma_clr     : std_logic;
         dma_en      : std_logic;
         hcmd_push   : std_logic;
         int_ack     : std_logic;
         int_dis_hfe : std_logic;
         int_dis_lfe : std_logic;
         int_en      : std_logic;
      end record;

   type t_regdma_xfer_attribs is
      record
         host_wr     : std_logic;
         int_req     : std_logic;
         seq_last    : std_logic;
      end record;
            
   type t_regdma_sta is
      record
         dfifo_empty    : std_logic;
         dma_idle       : std_logic;
         hcfifo_empty   : std_logic;
         int_req        : std_logic;
         lcfifo_empty   : std_logic;
      end record;

   type t_regdma_cmd_sta is
      record
         cmd   : t_regdma_cmd;
         sta   : t_regdma_sta;
      end record;
               
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   constant c_regdma_cfifo_count_init  : t_regdma_cfifo_count  := (others => (others => '0'));
   
   constant c_regdma_cmd_init          : t_regdma_cmd := (others => '0');

   constant c_regdma_xfer_attribs_init : t_regdma_xfer_attribs := (others => '0');
   
   constant c_regdma_sta_init          : t_regdma_sta := (others => '0');

   constant c_regdma_cmd_sta_init      : t_regdma_cmd_sta := (
                                                   cmd   => c_regdma_cmd_init,
                                                   sta   => c_regdma_sta_init);
      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_convert(rv : t_regdma_cmd; vPm : std_logic; vPs : std_logic) return t_tspc_dma_ms_ctl;

   function f_convert(rv : t_regdma_xfer_attribs ) return t_tspc_dma_ms_flags;
   
   function f_reg_read(rv : t_regdma_cfifo_count) return std_logic_vector;
         
   function f_reg_read(rv : t_regdma_cmd_sta) return std_logic_vector;

   function f_reg_read(rv : t_regdma_xfer_attribs) return std_logic_vector;
      
   function f_reg_update(rv : t_regdma_cfifo_count;   vHfCnt   : std_logic_vector;
                                                      vLfCnt   : std_logic_vector) return t_regdma_cfifo_count;
                                                                                                                              
   function f_reg_update(rv : t_regdma_cmd_sta; vDfEmpty  : std_logic;
                                                vDmaIdle  : std_logic;
                                                vHcEmpty  : std_logic;
                                                vIntEv    : std_logic;
                                                vLcEmpty  : std_logic) return t_regdma_cmd_sta;
                                                               
   function f_reg_write(rv    : t_regdma_cmd_sta;
                        dv    : std_logic_vector;
                        ben   : std_logic_vector) return t_regdma_cmd_sta;

   function f_reg_write(rv    : t_regdma_xfer_attribs;
                        dv    : std_logic_vector;
                        ben   : std_logic_vector) return t_regdma_xfer_attribs;
End dma_subsys_regs_types;
