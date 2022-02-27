
--
--    Copyright Ingenieurbuero Gardiner, 2018
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
-- File ID     : $Id: jxb3_cfi_reg_types-p.vhd 4888 2019-08-01 16:57:42Z  $
-- Generated   : $LastChangedDate: 2019-08-01 18:57:42 +0200 (Thu, 01 Aug 2019) $
-- Revision    : $LastChangedRevision: 4888 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use WORK.tspc_utils.all;

Package jxb3_cfi_reg_types is
   constant c_bp_buf_mode_rd        : natural := 1;
   constant c_bp_buf_mode_wr        : natural := 0;
   
   constant c_bp_ctrl_buf_mode      : natural := 10;
   constant c_bp_ctrl_dbuf_clr      : natural := 22;
   constant c_bp_ctrl_dma_en        : natural := 12;
   constant c_bp_ctrl_int_ack       : natural := 17;
   constant c_bp_ctrl_int_en        : natural := 1;
   constant c_bp_ctrl_int_mask      : natural := 9;
   constant c_bp_ctrl_lsb_first     : natural := 4;
   constant c_bp_ctrl_mode_cpha     : natural := 2;
   constant c_bp_ctrl_mode_cpol     : natural := 3;
   constant c_bp_ctrl_spi_clr       : natural := 23;
   constant c_bp_ctrl_spi_en        : natural := 0;
   constant c_bp_ctrl_spi_trig      : natural := 16;
   
   constant c_bp_dx_int_req         : natural := 9;
   constant c_bp_dx_src_spi         : natural := 8;
   
   constant c_bp_sta_buf_empty      : natural := 27;
   constant c_bp_sta_buf_full       : natural := 26;
   constant c_bp_sta_int_req        : natural := 25;
   constant c_bp_sta_spi_busy       : natural := 24;

   constant c_buf_mode_duplex       : std_logic_vector(1 downto 0) := B"11";
   constant c_buf_mode_none         : std_logic_vector(1 downto 0) := B"00";
   constant c_buf_mode_rx           : std_logic_vector(1 downto 0) := B"10";
   constant c_buf_mode_tx           : std_logic_vector(1 downto 0) := B"01";

   constant c_cfi_cmd_rd            : t_byte := X"03";  
   constant c_cfi_cmd_wr            : t_byte := X"02";  
   constant c_cfi_cmd_wren          : t_byte := X"06";  
   
      -- c_reg_adr_buf_base_min : Use upper half of register address space for accessing data buffer
   constant c_reg_adr_buf_base_min  : natural := 16#40#;
   constant c_reg_adr_buf_pos       : natural := 16#24#;
   constant c_reg_adr_buf_count     : natural := 16#1C#;
   constant c_reg_adr_cfi_adr       : natural := 16#0C#;
   constant c_reg_adr_cfi_cmd       : natural := 16#08#;
   constant c_reg_adr_ctrl_sta      : natural := 16#00#;
   constant c_reg_adr_rsps_0        : natural := 16#10#;
   constant c_reg_adr_rsps_1        : natural := 16#14#;
   constant c_reg_adr_xfer_count    : natural := 16#18#;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   type t_jxb3_cfi_ctrl is
      record
         buf_mode    : std_logic_vector(1 downto 0);
         dbuf_clr    : std_logic;
         dma_en      : std_logic;
         int_ack     : std_logic;
         int_en      : std_logic;
         int_mask    : std_logic;         
         lsb_first   : std_logic;
         mode_cpha   : std_logic;
         mode_cpol   : std_logic;
         spi_clr     : std_logic;
         spi_en      : std_logic;
         spi_trig    : std_logic;
      end record;

   type t_jxb3_cfi_sta is
      record
         buf_empty   : std_logic;
         buf_full    : std_logic;
         int_req     : std_logic;
         spi_busy    : std_logic;
      end record;
      
   type t_jxb3_ctrl_sta is
      record
         ctrl  : t_jxb3_cfi_ctrl;
         sta   : t_jxb3_cfi_sta;
      end record;
      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   constant c_jxb3_cfi_ctrl_init    : t_jxb3_cfi_ctrl := (
                                          buf_mode => (others => '0'),
                                          others   => '0'
                                          );
                          
   constant c_jxb3_cfi_sta_init     : t_jxb3_cfi_sta := (
                                          others => '0'
                                          );
                                          
   constant c_jxb3_ctrl_sta_init    : t_jxb3_ctrl_sta := (
                                          ctrl  => c_jxb3_cfi_ctrl_init,
                                          sta   => c_jxb3_cfi_sta_init
                                          );
                                          
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_reg_read(rv : t_jxb3_ctrl_sta; sz : natural) return std_logic_vector;

   function f_reg_update(rv : t_jxb3_ctrl_sta; irq    : std_logic; 
                                               bmt    : std_logic; 
                                               bfull  : std_logic;
                                               bsy    : std_logic) return t_jxb3_ctrl_sta;
   
   function f_reg_write(rv    : t_jxb3_ctrl_sta;
                        dv    : std_logic_vector;
                        ben   : std_logic_vector) return t_jxb3_ctrl_sta;
                        
End jxb3_cfi_reg_types;
