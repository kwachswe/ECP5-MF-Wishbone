
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
-- File ID     : $Id: jxb3_cfi_reg_types-pb.vhd 4585 2019-02-02 16:42:36Z  $
-- Generated   : $LastChangedDate: 2019-02-02 17:42:36 +0100 (Sat, 02 Feb 2019) $
-- Revision    : $LastChangedRevision: 4585 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use WORK.tspc_utils.all;

Package Body jxb3_cfi_reg_types is
   function f_reg_read(rv : t_jxb3_ctrl_sta; sz : natural) return std_logic_vector is
   
      variable v_retval    : std_logic_vector(sz - 1 downto 0);      
   begin
      v_retval    := (others => '0');
      
      v_retval(c_bp_ctrl_buf_mode)     := rv.ctrl.buf_mode(0);
      v_retval(c_bp_ctrl_buf_mode + 1) := rv.ctrl.buf_mode(1);
      v_retval(c_bp_ctrl_dma_en)       := rv.ctrl.dma_en;
      v_retval(c_bp_ctrl_int_en)       := rv.ctrl.int_en;
      v_retval(c_bp_ctrl_int_mask)     := rv.ctrl.int_mask;
      v_retval(c_bp_ctrl_lsb_first)    := rv.ctrl.lsb_first;
      v_retval(c_bp_ctrl_mode_cpha)    := rv.ctrl.mode_cpha;
      v_retval(c_bp_ctrl_mode_cpol)    := rv.ctrl.mode_cpol;
      v_retval(c_bp_ctrl_spi_en)       := rv.ctrl.spi_en;
      v_retval(c_bp_sta_buf_empty)     := rv.sta.buf_empty;
      v_retval(c_bp_sta_buf_full)      := rv.sta.buf_full;
      v_retval(c_bp_sta_int_req)       := rv.sta.int_req;
      v_retval(c_bp_sta_spi_busy)      := rv.sta.spi_busy;
      
      return v_retval;
   end function;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_reg_update(rv : t_jxb3_ctrl_sta; irq    : std_logic; 
                                               bmt    : std_logic; 
                                               bfull  : std_logic;
                                               bsy    : std_logic) return t_jxb3_ctrl_sta is
   
      variable v_retval    : t_jxb3_ctrl_sta;         
   begin
      v_retval    := rv;
      
         -- The following bits are single-shot self-clearing events
      v_retval.ctrl.dbuf_clr     := '0';
      v_retval.ctrl.int_ack      := '0';
      v_retval.ctrl.spi_clr      := '0';      
      v_retval.ctrl.spi_trig     := '0';      

      v_retval.sta.buf_empty     := bmt;
      v_retval.sta.buf_full      := bfull;
      v_retval.sta.int_req       := v_retval.sta.int_req or (irq and v_retval.ctrl.int_en);
      v_retval.sta.spi_busy      := bsy;
      
      return v_retval;
   end function;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_reg_write(rv    : t_jxb3_ctrl_sta;
                        dv    : std_logic_vector;
                        ben   : std_logic_vector) return t_jxb3_ctrl_sta is

      variable v_ben       : std_logic_vector((t_dword'length / 8) - 1 downto 0);
      variable v_din       : t_dword;                        
      variable v_retval    : t_jxb3_ctrl_sta;      
   begin
      v_ben    := f_cp_resize(ben, v_ben'length );
      v_din    := f_cp_resize(dv, v_din'length );
      
      v_retval.sta   := rv.sta;
      
         -- The following bits are single-shot self-clearing events
      v_retval.ctrl.dbuf_clr     := v_din(c_bp_ctrl_dbuf_clr)  and v_ben(c_bp_ctrl_dbuf_clr / 8);
      v_retval.ctrl.int_ack      := v_din(c_bp_ctrl_int_ack)   and v_ben(c_bp_ctrl_int_ack / 8);
      v_retval.ctrl.spi_clr      := v_din(c_bp_ctrl_spi_clr)   and v_ben(c_bp_ctrl_spi_clr / 8);
      v_retval.ctrl.spi_trig     := v_din(c_bp_ctrl_spi_trig)  and v_ben(c_bp_ctrl_spi_trig / 8);

         -- Hold, clear on write with '1'
      v_retval.sta.int_req       := rv.sta.int_req  and not
                                    (v_din(c_bp_ctrl_int_ack) and v_ben(c_bp_ctrl_int_ack / 8));
                                          
         -- Rd/Wr, controlled by byte-enable
      v_retval.ctrl.buf_mode(0)  := (v_din(c_bp_ctrl_buf_mode) and v_ben(c_bp_ctrl_buf_mode / 8)) or
                                    (rv.ctrl.buf_mode(0) and not v_ben(c_bp_ctrl_buf_mode / 8));   
      v_retval.ctrl.buf_mode(1)  := (v_din(c_bp_ctrl_buf_mode + 1) and v_ben((c_bp_ctrl_buf_mode + 1) / 8)) or
                                    (rv.ctrl.buf_mode(1) and not v_ben((c_bp_ctrl_buf_mode + 1) / 8));  
      v_retval.ctrl.dma_en       := (v_din(c_bp_ctrl_dma_en) and v_ben(c_bp_ctrl_dma_en / 8)) or
                                    (rv.ctrl.dma_en and not v_ben(c_bp_ctrl_dma_en / 8));                                     
      v_retval.ctrl.int_en       := (v_din(c_bp_ctrl_int_en) and v_ben(c_bp_ctrl_int_en / 8)) or
                                    (rv.ctrl.int_en and not v_ben(c_bp_ctrl_int_en / 8));      
      v_retval.ctrl.int_mask     := (v_din(c_bp_ctrl_int_mask) and v_ben(c_bp_ctrl_int_mask / 8)) or
                                    (rv.ctrl.int_mask and not v_ben(c_bp_ctrl_int_mask / 8));                                  
      v_retval.ctrl.lsb_first    := (v_din(c_bp_ctrl_lsb_first) and v_ben(c_bp_ctrl_lsb_first / 8)) or
                                    (rv.ctrl.lsb_first and not v_ben(c_bp_ctrl_lsb_first / 8));       
      v_retval.ctrl.mode_cpha    := (v_din(c_bp_ctrl_mode_cpha) and v_ben(c_bp_ctrl_mode_cpha / 8)) or
                                    (rv.ctrl.mode_cpha and not v_ben(c_bp_ctrl_mode_cpha / 8));  
      v_retval.ctrl.mode_cpol    := (v_din(c_bp_ctrl_mode_cpol) and v_ben(c_bp_ctrl_mode_cpol / 8)) or
                                    (rv.ctrl.mode_cpol and not v_ben(c_bp_ctrl_mode_cpol / 8));  
      v_retval.ctrl.spi_en       := (v_din(c_bp_ctrl_spi_en) and v_ben(c_bp_ctrl_spi_en / 8)) or
                                    (rv.ctrl.spi_en and not v_ben(c_bp_ctrl_spi_en / 8));      
                              
      return v_retval;
   end function;
   
End jxb3_cfi_reg_types;
