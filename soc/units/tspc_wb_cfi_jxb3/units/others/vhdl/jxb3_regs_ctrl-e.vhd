
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
-- File ID     : $Id: jxb3_regs_ctrl-e.vhd 4840 2019-05-28 20:32:06Z  $
-- Generated   : $LastChangedDate: 2019-05-28 22:32:06 +0200 (Tue, 28 May 2019) $
-- Revision    : $LastChangedRevision: 4840 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use WORK.jxb3_cfi_reg_types.all;

Entity jxb3_regs_ctrl is
   Port (
      i_clk             : in  std_logic;
      i_rst_n           : in  std_logic;
      i_clr             : in  std_logic;

      i_adr_push        : in  std_logic;     
      i_adr_rdat        : in  std_logic_vector;
      i_buf_din         : in  std_logic_vector;
      i_buf_irq         : in  std_logic;
      i_buf_pop         : in  std_logic;
      i_buf_rd_count    : in  std_logic_vector;
      i_buf_rd_empty    : in  std_logic;
      i_buf_rd_last     : in  std_logic;
      i_buf_src_spi     : in  std_logic;
      i_buf_wr_free     : in  std_logic_vector;
      i_buf_wr_full     : in  std_logic;
      i_buf_wr_last     : in  std_logic;
      i_mbox_rx_pop     : in  std_logic;
      i_mbox_tx_rdy     : in  std_logic;
      i_resp_din        : in  std_logic_vector;
      i_resp_push       : in  std_logic;
      i_spi_busy        : in  std_logic;
      i_wb_adr          : in  std_logic_vector;
      i_wb_cyc          : in  std_logic;
      i_wb_din          : in  std_logic_vector;
      i_wb_sel          : in  std_logic_vector;
      i_wb_stb          : in  std_logic;
      i_wb_we           : in  std_logic;

      o_buf_arb_rd      : out std_logic;
      o_buf_arb_wr      : out std_logic;
      o_buf_clr         : out std_logic;
      o_buf_dout        : out std_logic_vector;
      o_buf_empty       : out std_logic;
      o_buf_irq         : out std_logic;
      o_buf_pop         : out std_logic;
      o_buf_push        : out std_logic;
      o_cfi_adr         : out std_logic_vector; 
      o_cfi_adr_push    : out std_logic;
      o_cfi_cmd         : out std_logic_vector;
      o_cfi_cmd_push    : out std_logic;
      o_cfi_ctrl        : out t_jxb3_cfi_ctrl;
      o_int_req         : out std_logic;
      o_rx_last         : out std_logic;
      o_spi_clr         : out std_logic;
      o_spi_has_pload   : out std_logic;
      o_wb_ack          : out std_logic;
      o_wb_dout         : out std_logic_vector      
      );
End jxb3_regs_ctrl;

