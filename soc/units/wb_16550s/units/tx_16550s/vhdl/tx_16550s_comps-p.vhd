
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tx_16550s_comps-p.vhd 5378 2021-12-13 00:15:46Z  $
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

Package tx_16550s_comps is
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
   
   
   Component tspc_event_latch
      Port (
         i_clk       : in  std_logic;
         i_rst_n     : in  std_logic;

         i_clr       : in  std_logic;
         i_event     : in  std_logic_vector;

         o_event_reg : out std_logic_vector
         );
   End Component; 

   
   Component tspc_reg_pipeline
      Generic (
         g_num_stages   : positive := 1
         );
      Port (
         i_clk       : in  std_logic;
         i_rst_n     : in  std_logic;

         i_din       : in  std_logic_vector;

         o_dout      : out std_logic_vector
         );
   End Component;   
      
      
   Component tx_ser_8250_core
      Port (
         i_rst_n        : in  std_logic;

         i_xclk         : in  std_logic;
         i_xclk_en      : in  std_logic;

         i_baud_chng    : in  std_logic;
         i_din          : in  std_logic_vector(7 downto 0);
         i_par_en       : in  std_logic;
         i_par_even     : in  std_logic;
         i_par_stick    : in  std_logic;
         i_send_break   : in  std_logic;
         i_stop_bits    : in  std_logic;
         i_thr_ready    : in  std_logic;
         i_word_length  : in  std_logic_vector(1 downto 0);

         o_thr_pop      : out std_logic;
         o_tsr_empty    : out std_logic;
         o_tx           : out std_logic;
         o_tx_en        : out std_logic
         );
   End Component;   
End tx_16550s_comps;
