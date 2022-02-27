
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: modem_regs_16550s_comps-p.vhd 5378 2021-12-13 00:15:46Z  $
-- Generated   : $LastChangedDate: 2021-12-13 01:15:46 +0100 (Mon, 13 Dec 2021) $
-- Revision    : $LastChangedRevision: 5378 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.std_logic_1164.all;

Package modem_regs_16550s_comps is

   type t_io_ctl is
      record
         addr  : std_logic_vector(2 downto 0);
         din   : std_logic_vector(7 downto 0);
         rd    : std_logic;
         wr    : std_logic;
      end record;   

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      
   constant c_bsel_dma_mode_en      : natural := 3;
   constant c_bsel_divisor_en       : natural := 7;
   constant c_bsel_dtr              : natural := 0;
   constant c_bsel_fifo_en          : natural := 0;
   constant c_bsel_loopback_en      : natural := 4;
   constant c_bsel_int_en_modem     : natural := 3;
   constant c_bsel_int_en_rx_data   : natural := 0;
   constant c_bsel_int_en_rx_line   : natural := 2;
   constant c_bsel_int_en_tx_empty  : natural := 1;
   constant c_bsel_op1              : natural := 2;
   constant c_bsel_op2              : natural := 3;
   constant c_bsel_par_en           : natural := 3;
   constant c_bsel_par_even         : natural := 4;
   constant c_bsel_par_stick        : natural := 5;
   constant c_bsel_rts              : natural := 1;
   constant c_bsel_rx_fifo_reset    : natural := 1;
   constant c_bsel_rx_fifo_trig_lsb : natural := 6;
   constant c_bsel_rx_fifo_trig_msb : natural := 7;
   constant c_bsel_send_break       : natural := 6;
   constant c_bsel_stop_bits        : natural := 2;
   constant c_bsel_tx_fifo_reset    : natural := 2;
   constant c_bsel_word_length_lsb  : natural := 0;
   constant c_bsel_word_length_msb  : natural := 1;
   
   constant c_int_src_modem_sta     : std_logic_vector(3 downto 0) := "0000";
   constant c_int_src_rx_line_sta   : std_logic_vector(3 downto 0) := "0110";
   constant c_int_src_rx_timer      : std_logic_vector(3 downto 0) := "1100";
   constant c_int_src_rx_data       : std_logic_vector(3 downto 0) := "0100";
   constant c_int_src_tx_empty      : std_logic_vector(3 downto 0) := "0010";
   constant c_int_src_none          : std_logic_vector(3 downto 0) := "0001";
   
   constant c_reg_addr_dll          : std_logic_vector(2 downto 0) := "000";
   constant c_reg_addr_dlm          : std_logic_vector(2 downto 0) := "001";
   constant c_reg_addr_fcr          : std_logic_vector(2 downto 0) := "010";
   constant c_reg_addr_ier          : std_logic_vector(2 downto 0) := "001";
   constant c_reg_addr_isr          : std_logic_vector(2 downto 0) := "010";
   constant c_reg_addr_lcr          : std_logic_vector(2 downto 0) := "011";
   constant c_reg_addr_lsr          : std_logic_vector(2 downto 0) := "101";
   constant c_reg_addr_mcr          : std_logic_vector(2 downto 0) := "100";
   constant c_reg_addr_msr          : std_logic_vector(2 downto 0) := "110";
   constant c_reg_addr_rhr          : std_logic_vector(2 downto 0) := "000";
   constant c_reg_addr_spr          : std_logic_vector(2 downto 0) := "111";
   constant c_reg_addr_thr          : std_logic_vector(2 downto 0) := "000";

   constant c_reg_init_dll          : std_logic_vector(7 downto 0) := X"00";
   constant c_reg_init_dlm          : std_logic_vector(7 downto 0) := X"00";
   constant c_reg_init_fcr          : std_logic_vector(7 downto 0) := X"00";
   constant c_reg_init_ier          : std_logic_vector(7 downto 0) := X"00";
   constant c_reg_init_lcr          : std_logic_vector(7 downto 0) := X"00";
   constant c_reg_init_mcr          : std_logic_vector(7 downto 0) := X"00";
   constant c_reg_init_spr          : std_logic_vector(7 downto 0) := X"FF";
   
   constant c_reg_mask_fcr          : std_logic_vector(7 downto 0) := X"CF";
   constant c_reg_mask_fcr_fifo_clr : std_logic_vector(7 downto 0) := X"C9";
   constant c_reg_mask_ier          : std_logic_vector(7 downto 0) := X"0F";
   constant c_reg_mask_mcr          : std_logic_vector(7 downto 0) := X"1F";


      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   constant c_io_ctl_init  : t_io_ctl := (
                              addr  => (others => '0'),
                              din   => (others => '0'),
                              rd    => '0',
                              wr    => '0'
                              );

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Component tspc_cdc_ack
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
   End Component;                              
End modem_regs_16550s_comps;
