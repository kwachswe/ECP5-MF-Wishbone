
--
--    Developed by Ingenieurbuero Gardiner
--                 Heuglinstr. 29a
--                 81249 Muenchen
--                 charles.gardiner@ib-gardiner.eu
--
--    Copyright Ingenieurbuero Gardiner, 2004 - 2014
--------------------------------------------------------------------------------
--
-- File ID     : $Id: dma_subsys_regs_types-pb.vhd 82 2021-12-12 21:57:48Z  $
-- Generated   : $LastChangedDate: 2021-12-12 22:57:48 +0100 (Sun, 12 Dec 2021) $
-- Revision    : $LastChangedRevision: 82 $
--
--------------------------------------------------------------------------------
--
-- Description :
--
--------------------------------------------------------------------------------


Library IEEE;
Use IEEE.numeric_std.all;
Use WORK.tspc_utils.all;

Package Body dma_subsys_regs_types is

   function f_convert(rv : t_regdma_cmd; vPm : std_logic; vPs : std_logic) return t_tspc_dma_ms_ctl is
      variable v_ret_val   : t_tspc_dma_ms_ctl;
      
   begin
      v_ret_val   := c_tspc_dma_ms_ctl_init;

      v_ret_val.cmd_push_mst  := vPm;
      v_ret_val.cmd_push_slv  := vPs;

      v_ret_val.dma_clr       := rv.dma_clr;
      v_ret_val.dma_en        := rv.dma_en;
      v_ret_val.int_dis_hfe   := rv.int_dis_hfe;
      v_ret_val.int_dis_lfe   := rv.int_dis_lfe;
      
      return v_ret_val;
   end;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
   function f_convert(rv : t_regdma_xfer_attribs ) return t_tspc_dma_ms_flags is
      variable v_ret_val   : t_tspc_dma_ms_flags;
      
   begin
      v_ret_val   := c_tspc_dma_ms_flags_init;

      v_ret_val.dma_last   := rv.seq_last;
      v_ret_val.dma_wr     := rv.host_wr;      
      v_ret_val.int_req    := rv.int_req;

      return v_ret_val;
   end;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    
   function f_reg_read(rv : t_regdma_cfifo_count) return std_logic_vector is
      variable v_ret_val   : std_logic_vector(31 downto 0);
         
   begin
      v_ret_val   := f_cp_resize(rv.lfifo_count, 16) & f_cp_resize(rv.hfifo_count, 16);

      return v_ret_val;
   end;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~       
   function f_reg_read(rv : t_regdma_cmd_sta) return std_logic_vector is
      variable v_ret_val   : std_logic_vector(31 downto 0);  
      
   begin
      v_ret_val   := (others => '0');

      v_ret_val(c_bpos_dma_en)       := rv.cmd.dma_en;
      v_ret_val(c_bpos_int_dis_hfe)  := rv.cmd.int_dis_hfe;
      v_ret_val(c_bpos_int_dis_lfe)  := rv.cmd.int_dis_lfe;
      v_ret_val(c_bpos_int_en)       := rv.cmd.int_en;

      v_ret_val(c_bpos_dfifo_empty)  := rv.sta.dfifo_empty;
      v_ret_val(c_bpos_dma_idle)     := rv.sta.dma_idle;
      v_ret_val(c_bpos_hcfifo_empty) := rv.sta.hcfifo_empty;
      v_ret_val(c_bpos_int_req)      := rv.sta.int_req;
      v_ret_val(c_bpos_lcfifo_empty) := rv.sta.lcfifo_empty;
                       
      return v_ret_val;
   end;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
   function f_reg_read(rv : t_regdma_xfer_attribs) return std_logic_vector is
      variable v_ret_val   : std_logic_vector(31 downto 0);
        
   begin
      v_ret_val   := (others => '0');

      v_ret_val(c_bpos_dma_attrib_host_wr)   := rv.host_wr;
      v_ret_val(c_bpos_dma_attrib_int_req)   := rv.int_req;
      v_ret_val(c_bpos_dma_attrib_seq_last)  := rv.seq_last;
                  
      return v_ret_val;            
   end;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
   function f_reg_update(rv : t_regdma_cfifo_count;   vHfCnt   : std_logic_vector;
                                                      vLfCnt   : std_logic_vector) return t_regdma_cfifo_count is
      variable v_ret_val   : t_regdma_cfifo_count;
                                                            
   begin
      v_ret_val.hfifo_count   := f_cp_resize(vHfCnt, v_ret_val.hfifo_count'length );
      v_ret_val.lfifo_count   := f_cp_resize(vLfCnt, v_ret_val.lfifo_count'length );
            
      return v_ret_val; 
   end;
                                                                     
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_reg_update(rv : t_regdma_cmd_sta; vDfEmpty  : std_logic;
                                                vDmaIdle  : std_logic;
                                                vHcEmpty  : std_logic;
                                                vIntEv    : std_logic;
                                                vLcEmpty  : std_logic) return t_regdma_cmd_sta is
      variable v_ret_val   : t_regdma_cmd_sta;

   begin
      v_ret_val   := rv;

      v_ret_val.cmd.dma_clr   := '0';
      v_ret_val.cmd.hcmd_push := '0';
      v_ret_val.cmd.int_ack   := '0';

      v_ret_val.sta.dfifo_empty  := vDfEmpty;
      v_ret_val.sta.dma_idle     := vDmaIdle;
      v_ret_val.sta.hcfifo_empty := vHcEmpty;
      v_ret_val.sta.lcfifo_empty := vLcEmpty;

      v_ret_val.sta.int_req      := v_ret_val.sta.int_req or (v_ret_val.cmd.int_en and vIntEv);
                  
      return v_ret_val;
   end;
         
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_reg_write(rv    : t_regdma_cmd_sta;
                        dv    : std_logic_vector;
                        ben   : std_logic_vector) return t_regdma_cmd_sta is
      variable v_ben       : std_logic_vector(3 downto 0);
      variable v_din       : std_logic_vector(31 downto 0);                        
      variable v_ret_val   : t_regdma_cmd_sta;
                        
   begin
      v_ben       := std_logic_vector(resize(unsigned(ben), v_ben'length));
      v_din       := std_logic_vector(resize(unsigned(dv), v_din'length));
      v_ret_val   := rv;

         -- The following bits are single-shot events
      v_ret_val.cmd.dma_clr    := v_din(c_bpos_dma_clr) and v_ben(c_bpos_dma_clr / 8);
      v_ret_val.cmd.hcmd_push  := v_din(c_bpos_hcmd_push) and v_ben(c_bpos_hcmd_push / 8);
      v_ret_val.cmd.int_ack    := v_din(c_bpos_int_ack) and v_ben(c_bpos_int_ack / 8);
                            
         -- Hold current value if the corresponding byte-enable is not set
      v_ret_val.cmd.dma_en       := (v_din(c_bpos_dma_en) and v_ben(c_bpos_dma_en / 8)) or
                                    (rv.cmd.dma_en and not v_ben(c_bpos_dma_en / 8));
                                 
      v_ret_val.cmd.int_dis_hfe  := (v_din(c_bpos_int_dis_hfe) and v_ben(c_bpos_int_dis_hfe / 8)) or
                                    (rv.cmd.int_dis_hfe and not v_ben(c_bpos_int_dis_hfe / 8));

      v_ret_val.cmd.int_dis_lfe  := (v_din(c_bpos_int_dis_lfe) and v_ben(c_bpos_int_dis_lfe / 8)) or
                                    (rv.cmd.int_dis_lfe and not v_ben(c_bpos_int_dis_lfe / 8));

      v_ret_val.cmd.int_en       := (v_din(c_bpos_int_en) and v_ben(c_bpos_int_en / 8)) or
                                    (rv.cmd.int_en and not v_ben(c_bpos_int_en / 8));

      v_ret_val.sta.int_req      := v_ret_val.sta.int_req  and not
                                    (v_din(c_bpos_int_ack) and v_ben(c_bpos_int_ack / 8)); 

      return v_ret_val;
   end;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_reg_write(rv    : t_regdma_xfer_attribs;
                        dv    : std_logic_vector;
                        ben   : std_logic_vector) return t_regdma_xfer_attribs is
      variable v_ben       : std_logic_vector(3 downto 0);
      variable v_din       : std_logic_vector(31 downto 0);
      variable v_ret_val   : t_regdma_xfer_attribs;

   begin
      v_ben       := std_logic_vector(resize(unsigned(ben), v_ben'length));
      v_din       := std_logic_vector(resize(unsigned(dv), v_din'length));
      v_ret_val   := rv;

         -- Hold current value if the corresponding byte-enable is not set
      v_ret_val.host_wr       := (v_din(c_bpos_dma_attrib_host_wr) and v_ben(c_bpos_dma_attrib_host_wr / 8)) or
                                 (rv.host_wr and not v_ben(c_bpos_dma_attrib_host_wr / 8));

      v_ret_val.int_req       := (v_din(c_bpos_dma_attrib_int_req) and v_ben(c_bpos_dma_attrib_int_req / 8)) or
                                 (rv.int_req and not v_ben(c_bpos_dma_attrib_int_req / 8));

      v_ret_val.seq_last      := (v_din(c_bpos_dma_attrib_seq_last) and v_ben(c_bpos_dma_attrib_seq_last / 8)) or
                                 (rv.seq_last and not v_ben(c_bpos_dma_attrib_seq_last / 8));

      return v_ret_val;
   end;   
End dma_subsys_regs_types;
