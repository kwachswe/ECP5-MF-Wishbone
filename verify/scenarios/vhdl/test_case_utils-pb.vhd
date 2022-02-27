
--    Copyright Ingenieurbuero Gardiner, 2019 - 2020
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: test_case_utils-pb.vhd 156 2022-02-10 23:35:17Z  $
-- Generated   : $LastChangedDate: 2022-02-11 00:35:17 +0100 (Fri, 11 Feb 2022) $
-- Revision    : $LastChangedRevision: 156 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------
Library versa_ecp5_tb_lib;
Use versa_ecp5_tb_lib.dma_subsys_regs_types.all;

Package Body test_case_utils is  
   procedure f_write_sgdma(signal clk        : in    std_logic;
                           signal sv         : inout t_bfm_stim;
                           signal rv         : in    t_bfm_resp;
                                  dma_wr     : in    boolean;
                                  sge_list   : in    t_dma_sge_list; 
                                  chn_nr     : in    natural := 0;
                                  no_close   : in    boolean := false) is
      variable v_chan_nr      : natural;
      variable v_dma_dir      : t_dword := (others =>'0');
      variable v_dma_irq      : t_dword := (others =>'0');
      variable v_dma_seq_end  : t_dword := (others =>'0');
      
   begin
      v_chan_nr   := chn_nr mod c_dut_dma_rsrc'length;
      
      if (dma_wr) then
         v_dma_dir   := std_logic_vector(to_unsigned(2 ** c_bpos_dma_attrib_host_wr, t_dword'length ));
      else
         v_dma_dir   := (others =>'0');
      end if;
      
      for ix in sge_list'low to sge_list'high loop
         memwr(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(v_chan_nr)) +
                                             c_adr_dma_hadr_high), sge_list(ix).adr_high);  
         memwr(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(v_chan_nr)) +
                                             c_adr_dma_hadr_low), sge_list(ix).adr_low);    
         memwr(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(v_chan_nr)) +
                                             c_adr_dma_xfer_size), sge_list(ix).xfer_sz);  
                                             
         if (sge_list(ix).irq) then
            v_dma_irq   := std_logic_vector(to_unsigned(2 ** c_bpos_dma_attrib_int_req, t_dword'length ));
         else
            v_dma_irq   := (others =>'0');
         end if;

         if ((ix = sge_list'high ) and (no_close = false)) then
            v_dma_seq_end  := std_logic_vector(to_unsigned(2 ** c_bpos_dma_attrib_seq_last, t_dword'length ));
         else
            v_dma_seq_end  := (others =>'0');
         end if;

         memwr(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(v_chan_nr)) +
                                             c_adr_dma_xfer_attribs), v_dma_dir or v_dma_irq or v_dma_seq_end);  
                                             
         memwr(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(v_chan_nr)) +
                                             c_adr_dma_cmd_sta), 
                            std_logic_vector(to_unsigned(2 ** c_bpos_hcmd_push, t_dword'length )), be_first => X"2");          
      end loop;
   end procedure;
      
End test_case_utils;
