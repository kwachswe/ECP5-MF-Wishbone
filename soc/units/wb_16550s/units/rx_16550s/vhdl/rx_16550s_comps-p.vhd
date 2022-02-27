
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: rx_16550s_comps-p.vhd 5378 2021-12-13 00:15:46Z  $
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
Use WORK.tspc_utils.all;

Package rx_16550s_comps is
   constant c_config_fifo_latency_rd   : natural := 1;
   constant c_config_fifo_latency_wr   : natural := 1;
   constant c_config_fifo_word_size    : natural := 11;

   constant c_fifo_threshold_1   : std_logic_vector(1 downto 0) := "00";
   constant c_fifo_threshold_4   : std_logic_vector(1 downto 0) := "01";
   constant c_fifo_threshold_8   : std_logic_vector(1 downto 0) := "10";
   constant c_fifo_threshold_14  : std_logic_vector(1 downto 0) := "11";

   constant c_fifo_threshold_1_int  : natural := 1;
   constant c_fifo_threshold_4_int  : natural := 4;
   constant c_fifo_threshold_8_int  : natural := 8;
   constant c_fifo_threshold_14_int : natural := 14;

      -- Four Character times plus one max char time
   constant c_rx_timer_load_5 : natural := (5 * 4) + 12;
   constant c_rx_timer_load_6 : natural := (6 * 4) + 12;
   constant c_rx_timer_load_7 : natural := (7 * 4) + 12;
   constant c_rx_timer_load_8 : natural := (8 * 4) + 12;
   
   constant c_word_size_5     : std_logic_vector(1 downto 0) := "00";
   constant c_word_size_6     : std_logic_vector(1 downto 0) := "01";
   constant c_word_size_7     : std_logic_vector(1 downto 0) := "10";
   constant c_word_size_8     : std_logic_vector(1 downto 0) := "11";
      
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

   
   Component tspc_cdc_reg 
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
         i_wr_din       : in  std_logic_vector;
         i_wr_en        : in  std_logic;

         o_rd_dout      : out std_logic_vector;
         o_rd_ready     : out std_logic;
         
         o_wr_ready     : out std_logic
         );
   End Component;

   
   Component tspc_fifo_sync
      Generic (
         g_mem_dmram    : boolean := false;
         g_mem_words    : positive := 16; 
         g_tech_lib     : string := "ECP3";
         g_tech_type    : string := "ANY";
         g_threshold_rd : positive := 1;
         g_threshold_wr : positive := 1
         );    
      Port ( 
         i_clk          : in  std_logic;
         i_rst_n        : in  std_logic;
         i_clr          : in  std_logic := '0';

         i_rd_pop       : in  std_logic;        
         i_wr_din       : in  std_logic_vector;
         i_wr_push      : in  std_logic;

         o_rd_aempty    : out std_logic;
         o_rd_count     : out std_logic_vector(f_vec_msb(g_mem_words) downto 0);
         o_rd_dout      : out std_logic_vector;
         o_rd_empty     : out std_logic;
         o_rd_last      : out std_logic;
         o_wr_afull     : out std_logic;
         o_wr_free      : out std_logic_vector(f_vec_msb(g_mem_words) downto 0);
         o_wr_full      : out std_logic;
         o_wr_last      : out std_logic
         );
   End Component;

   
   Component rx_ser_8250_core
      Port (
         i_rst_n        : in  std_logic;

         i_xclk         : in  std_logic;
         i_xclk_en      : in  std_logic;

         i_baud_chng    : in  std_logic;
         i_par_en       : in  std_logic;
         i_par_even     : in  std_logic;
         i_par_stick    : in  std_logic;
         i_rhr_ready    : in  std_logic;
         i_rx           : in  std_logic;
         i_stop_bits    : in  std_logic;
         i_word_length  : in  std_logic_vector(1 downto 0);

         o_break        : out std_logic;
         o_dout         : out std_logic_vector(7 downto 0);
         o_err_frm      : out std_logic;
         o_err_ovr      : out std_logic;
         o_err_par      : out std_logic;
         o_frame_eval   : out std_logic;
         o_rhr_push     : out std_logic;
         o_sample_tick  : out std_logic
         );
   End Component;

End rx_16550s_comps;
