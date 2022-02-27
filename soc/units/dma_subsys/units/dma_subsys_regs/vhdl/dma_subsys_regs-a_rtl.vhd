
--
--    Developed by Ingenieurbuero Gardiner
--                 Heuglinstr. 29a
--                 81249 Muenchen
--                 charles.gardiner@ib-gardiner.eu
--
--    Copyright Ingenieurbuero Gardiner, 2004 - 2017
--------------------------------------------------------------------------------
--
-- File ID     : $Id: dma_subsys_regs-a_rtl.vhd 82 2021-12-12 21:57:48Z  $
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
Use WORK.dma_subsys_regs_types.all;
Use WORK.tspc_dma_chan_ms_types.all;
Use WORK.tspc_utils.all;

Architecture Rtl of dma_subsys_regs is
   signal s_data_rd_mux             : std_logic_vector(31 downto 0);
   signal s_dma_chl_cmd_push        : std_logic;
   signal s_regdma_cfifo_count      : t_regdma_cfifo_count;
   signal s_regdma_cmd_sta          : t_regdma_cmd_sta;
   signal s_regdma_hadr_high        : std_logic_vector(c_msb_host_adr_high downto 0);
   signal s_regdma_hadr_low         : std_logic_vector(31 downto 0);
   signal s_regdma_ladr             : std_logic_vector(31 downto 0);
   signal s_regdma_xfer_attribs     : t_regdma_xfer_attribs;
   signal s_regdma_xfer_pos         : std_logic_vector(c_msb_ddr_adr downto 0);   
   signal s_regdma_xfer_size        : std_logic_vector(c_msb_ddr_adr downto 0);
   signal s_wb_ack                  : std_logic;
   signal s_wb_adr                  : std_logic_vector(c_wb_adr_sz - 1 downto 0);
   signal s_wb_adr_in               : std_logic_vector(c_wb_adr_sz - 1 downto 0);
   signal s_wb_din                  : std_logic_vector(31 downto 0);
   signal s_wb_dout                 : std_logic_vector(31 downto 0);
   signal s_wb_rd_cyc               : std_logic;
   signal s_wb_sel                  : std_logic_vector(3 downto 0);
   signal s_wb_wr_cyc               : std_logic;
   
Begin
   o_dma_chh_adr        <= f_cp_resize(s_regdma_hadr_high & s_regdma_hadr_low, o_dma_chh_adr 'length );

   o_dma_chl_adr        <= f_cp_resize(s_regdma_ladr, o_dma_chl_adr'length );
   
   o_dma_ctl            <= f_convert(s_regdma_cmd_sta.cmd, s_regdma_cmd_sta.cmd.hcmd_push, s_dma_chl_cmd_push);

   o_dma_xfer_flags     <= f_convert(s_regdma_xfer_attribs);

   o_dma_xfer_sz        <= f_cp_resize(s_regdma_xfer_size, o_dma_xfer_sz'length );

   o_int_req            <= s_regdma_cmd_sta.sta.int_req;
   
   o_wb_ack             <= s_wb_ack;
   o_wb_dat             <= s_wb_dout;
      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_wb_adr_in          <= std_logic_vector(resize(unsigned(i_wb_adr), s_wb_adr_in'length ));
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_RD_MUX:
   process (all)
      variable v_reg_adr   : natural;   
   begin
      v_reg_adr   := to_integer(unsigned(s_wb_adr));

      case (v_reg_adr) is
         when c_adr_dma_cfifo_count =>
            s_data_rd_mux  <= f_reg_read(s_regdma_cfifo_count);
                     
         when c_adr_dma_cmd_sta =>
            s_data_rd_mux  <= f_reg_read(s_regdma_cmd_sta);

         when c_adr_dma_hadr_high =>
            s_data_rd_mux  <= f_cp_resize(s_regdma_hadr_high, s_data_rd_mux'length);

         when c_adr_dma_hadr_low =>
            s_data_rd_mux  <= f_cp_resize(s_regdma_hadr_low, s_data_rd_mux'length);

         when c_adr_dma_ladr =>
            s_data_rd_mux  <= f_cp_resize(s_regdma_ladr, s_data_rd_mux'length);

         when c_adr_dma_xfer_attribs =>
            s_data_rd_mux  <= f_reg_read(s_regdma_xfer_attribs);

         when c_adr_dma_xfer_pos =>
            s_data_rd_mux  <= f_cp_resize(s_regdma_xfer_pos, s_data_rd_mux'length);
            
         when c_adr_dma_xfer_size =>
            s_data_rd_mux  <= f_cp_resize(s_regdma_xfer_size, s_data_rd_mux'length);
                                                 
         when others =>
            s_data_rd_mux  <= (others => '0');         
      end case;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_MAIN:
   process (i_clk, i_rst_n)
      variable v_reg_adr   : natural;
   begin
      if (i_rst_n = '0') then
         s_dma_chl_cmd_push         <= '0';
         s_regdma_cfifo_count       <= c_regdma_cfifo_count_init;
         s_regdma_cmd_sta           <= c_regdma_cmd_sta_init;
         s_regdma_hadr_high         <= (others => '0');
         s_regdma_hadr_low          <= (others => '0');
         s_regdma_ladr              <= (others => '0');
         s_regdma_xfer_attribs      <= c_regdma_xfer_attribs_init;
         s_regdma_xfer_pos          <= (others => '0');
         s_regdma_xfer_size         <= (others => '0');
         s_wb_ack                   <= '0';
         s_wb_adr                   <= (others => '0');
         s_wb_din                   <= (others => '0');
         s_wb_dout                  <= (others => '0');
         s_wb_rd_cyc                <= '0';
         s_wb_sel                   <= (others => '0');
         s_wb_wr_cyc                <= '0';         
         
      elsif (rising_edge(i_clk)) then
         v_reg_adr   := to_integer(unsigned(s_wb_adr));

         s_dma_chl_cmd_push         <= '0';

         s_regdma_cfifo_count <= f_reg_update(s_regdma_cfifo_count,  vHfCnt => i_dma_hfifo_count,
                                                                     vLfCnt => i_dma_lfifo_count);
                                                                                          
         s_regdma_cmd_sta     <= f_reg_update(s_regdma_cmd_sta,   vDfEmpty => i_dma_sta.dfifo_empty,
                                                                  vDmaIdle => i_dma_sta.dma_idle,
                                                                  vHcEmpty => i_dma_sta.hcfifo_empty,
                                                                  vIntEv   => i_dma_ev_int_req,
                                                                  vLcEmpty => i_dma_sta.lcfifo_empty);

         s_regdma_xfer_pos    <= f_cp_resize(i_dma_xfer_pos, s_regdma_xfer_pos'length );
                  
         s_wb_adr                   <= s_wb_adr_in(c_wb_adr_sz - 1 downto 2) & "00";
            -- Acknowledge a write cycle when the data are accepted
         s_wb_ack                   <= i_wb_cyc and i_wb_stb and i_wb_we and not s_wb_ack;
         s_wb_din                   <= f_cp_resize(i_wb_dat, s_wb_din'length);
         s_wb_dout                  <= (others => '0');
         s_wb_sel                   <= f_cp_resize(i_wb_sel, s_wb_sel'length);

         s_wb_rd_cyc                <= i_wb_cyc and i_wb_stb and not i_wb_we and not s_wb_ack;
         s_wb_wr_cyc                <= i_wb_cyc and i_wb_stb and     i_wb_we and not s_wb_ack;

         if (s_wb_rd_cyc = '1') then
            s_wb_ack    <= not s_wb_ack;
            if (s_wb_ack = '1') then
               s_wb_dout   <= (others => '0');
            else
               s_wb_dout   <= s_data_rd_mux;
            end if;
         end if;

         if (s_wb_wr_cyc = '1') then
            case (v_reg_adr) is
               when c_adr_dma_cmd_sta =>
                  s_regdma_cmd_sta        <= f_reg_write(s_regdma_cmd_sta, s_wb_din, s_wb_sel);
                  
               when c_adr_dma_hadr_high =>
                  s_regdma_hadr_high      <= f_reg_write(s_regdma_hadr_high, s_wb_din, s_wb_sel);

               when c_adr_dma_hadr_low =>
                  s_regdma_hadr_low       <= f_reg_write(s_regdma_hadr_low, s_wb_din, s_wb_sel);

               when c_adr_dma_ladr =>
                  s_dma_chl_cmd_push      <= '1';
                  s_regdma_ladr           <= f_reg_write(s_regdma_ladr, s_wb_din, s_wb_sel);
                                                                        
               when c_adr_dma_xfer_attribs =>
                  s_regdma_xfer_attribs   <= f_reg_write(s_regdma_xfer_attribs, s_wb_din, s_wb_sel);

               when c_adr_dma_xfer_size =>
                  s_regdma_xfer_size      <= f_reg_write(s_regdma_xfer_size, s_wb_din, s_wb_sel);
                                                        
               when others =>
            end case;         
         end if;            
      end if;      
   end process;      
End Rtl;
