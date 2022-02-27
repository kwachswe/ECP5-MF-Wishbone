
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
-- File ID     : $Id: jxb3_regs_ctrl-a_rtl.vhd 4840 2019-05-28 20:32:06Z  $
-- Generated   : $LastChangedDate: 2019-05-28 22:32:06 +0200 (Tue, 28 May 2019) $
-- Revision    : $LastChangedRevision: 4840 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.numeric_std.all;
Use WORK.jxb3_cfi_reg_types.all;
Use WORK.tspc_utils.all;

Architecture Rtl of jxb3_regs_ctrl is
   type t_buf_rd  is (BR_LISTEN, BR_DECODE, BR_BYTE_RD0, BR_BYTE_RD1, BR_BYTE_RD2, BR_BYTE_RD3, BR_ACK);
   type t_buf_wr  is (BW_LISTEN, BW_DECODE, BW_BYTE_WR0, BW_BYTE_WR1, BW_BYTE_WR2, BW_BYTE_WR3, BW_ACK);
   
   signal s_buf_dout          : t_byte;
   signal s_buf_empty         : std_logic;
   signal s_buf_pop           : std_logic;
   signal s_buf_pop_dx        : std_logic;
   signal s_buf_push          : std_logic;
   signal s_ev_spi_end        : std_logic;
   signal s_ev_spi_start      : std_logic;
   signal s_fsm_buf_rd        : t_buf_rd;
   signal s_fsm_buf_rd_next   : t_buf_rd;
   signal s_fsm_buf_wr        : t_buf_wr;
   signal s_fsm_buf_wr_next   : t_buf_wr;
   signal s_int_req           : std_logic;
   signal s_reg_buf_count     : t_dword;
   signal s_reg_buf_pos       : t_dword;
   signal s_reg_cfi_adr       : std_logic_vector(o_cfi_adr'length - 1 downto 0);
   signal s_reg_cfi_adr_push  : std_logic;
   signal s_reg_cfi_cmd       : std_logic_vector(o_cfi_cmd'length - 1 downto 0);
   signal s_reg_cfi_cmd_push  : std_logic;
   signal s_reg_ctrl_sta      : t_jxb3_ctrl_sta;
   signal s_reg_rsps_0        : std_logic_vector(o_cfi_cmd'length - 1 downto 0);
   signal s_reg_rsps_1        : std_logic_vector(o_cfi_adr'length - 1 downto 0);
   signal s_reg_xcount_eq0    : std_logic;
   signal s_reg_xfer_buf      : t_dword;   
   signal s_reg_xfer_count    : t_hword;
   signal s_spi_busy          : t_edge_det;
   signal s_spi_has_pload     : std_logic;
   signal s_wb_ack            : std_logic;
   signal s_wb_adr            : std_logic_vector(i_wb_adr'length - 1 downto 0);
   signal s_wb_adr_in         : std_logic_vector(i_wb_adr'length - 1 downto 0);
   signal s_wb_din            : t_dword;
   signal s_wb_dout           : t_dword;
   signal s_wb_rd_cyc         : std_logic;
   signal s_wb_rd_mux         : t_dword;
   signal s_wb_sel            : std_logic_vector(3 downto 0);
   signal s_wb_wr_cyc         : std_logic;
   signal s_xfer_count        : t_hword;
   signal s_xfer_count_eq0    : std_logic;
   signal s_xfer_count_eq1    : std_logic;
   
Begin
   o_buf_arb_rd      <= f_to_logic(s_fsm_buf_rd /= BR_LISTEN);
   o_buf_arb_wr      <= f_to_logic(s_fsm_buf_wr /= BW_LISTEN);
   
   o_buf_clr         <= s_reg_ctrl_sta.ctrl.dbuf_clr;
   o_buf_dout        <= s_buf_dout;
   o_buf_empty       <= s_buf_empty;
   o_buf_irq         <= c_tie_low;
   o_buf_pop         <= s_buf_pop;
   o_buf_push        <= s_buf_push;
   
   o_cfi_adr         <= s_reg_cfi_adr;
   o_cfi_adr_push    <= s_reg_cfi_adr_push;
   
   o_cfi_cmd         <= s_reg_cfi_cmd;
   o_cfi_cmd_push    <= s_reg_cfi_cmd_push;
   
   o_cfi_ctrl        <= s_reg_ctrl_sta.ctrl;
   
   o_int_req         <= s_int_req;
   
   o_rx_last         <= s_xfer_count_eq1;
   
   o_spi_clr         <= s_reg_ctrl_sta.ctrl.spi_clr;
   o_spi_has_pload   <= s_spi_has_pload;
   
   o_wb_ack          <= s_wb_ack;
   o_wb_dout         <= f_cp_resize(s_wb_dout, o_wb_dout'length );
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                 
   s_wb_adr_in       <= f_cp_resize(f_align_adr(i_wb_adr, t_dword'length / t_byte'length ), s_wb_adr_in'length );
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   F_FSM_RD:
   process(all)
   begin
      s_buf_pop_dx    <= '0';
      s_fsm_buf_rd_next   <= s_fsm_buf_rd;
      
      case s_fsm_buf_rd is
         when BR_LISTEN =>
            if ((s_wb_adr(s_wb_adr'left ) = '1') and (s_wb_rd_cyc = '1') and (s_wb_ack = '0')) then
               s_fsm_buf_rd_next    <= BR_DECODE;
            end if;
            
         when BR_DECODE =>
            case s_wb_sel is
               when "0001" | "0011" | "0111" | "1111" =>
                  s_buf_pop_dx         <= '1';
                  s_fsm_buf_rd_next    <= BR_BYTE_RD0;

               when "0010" | "0110" | "1110" =>
                  s_buf_pop_dx         <= '1';
                  s_fsm_buf_rd_next    <= BR_BYTE_RD1;

               when "0100" | "1100" =>
                  s_buf_pop_dx         <= '1';
                  s_fsm_buf_rd_next    <= BR_BYTE_RD2;

               when "1000" =>
                  s_buf_pop_dx         <= '1';
                  s_fsm_buf_rd_next    <= BR_BYTE_RD3;
               
               when others =>                                                                                             
                  s_fsm_buf_rd_next    <= BR_ACK;
            end case;
         
         when BR_BYTE_RD0 =>
            if ((i_buf_rd_last = '1') or (s_wb_sel(1) = '0')) then
               s_fsm_buf_rd_next    <= BR_ACK;
            else
               s_buf_pop_dx         <= '1';
               s_fsm_buf_rd_next    <= BR_BYTE_RD1;
            end if;

         when BR_BYTE_RD1 =>
            if ((i_buf_rd_last = '1') or (s_wb_sel(2) = '0')) then
               s_fsm_buf_rd_next    <= BR_ACK;
            else
               s_buf_pop_dx         <= '1';
               s_fsm_buf_rd_next    <= BR_BYTE_RD2;
            end if;

         when BR_BYTE_RD2 =>
            if ((i_buf_rd_last = '1') or (s_wb_sel(3) = '0')) then
               s_fsm_buf_rd_next    <= BR_ACK;
            else
               s_buf_pop_dx         <= '1';
               s_fsm_buf_rd_next    <= BR_BYTE_RD3;
            end if;
            
         when BR_BYTE_RD3 =>
            s_fsm_buf_rd_next    <= BR_ACK;
            
         when BR_ACK =>
            s_fsm_buf_rd_next    <= BR_LISTEN;
            
         when others => 
      end case;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   F_FSM_WR:
   process(all)
   begin
      s_fsm_buf_wr_next    <= s_fsm_buf_wr;
      
      case s_fsm_buf_wr is
         when BW_LISTEN =>
            if ((s_wb_adr(s_wb_adr'left ) = '1') and (s_wb_wr_cyc = '1') and (s_wb_ack = '0')) then
               s_fsm_buf_wr_next    <= BW_DECODE;
            end if;
            
         when BW_DECODE =>
            case s_wb_sel is
               when "0001" | "0011" | "0111" | "1111" =>
                  s_fsm_buf_wr_next    <= BW_BYTE_WR0;

               when "0010" | "0110" | "1110" =>
                  s_fsm_buf_wr_next    <= BW_BYTE_WR1;

               when "0100" | "1100" =>
                  s_fsm_buf_wr_next    <= BW_BYTE_WR2;

               when "1000" =>
                  s_fsm_buf_wr_next    <= BW_BYTE_WR3;
               
               when others =>                                                                                             
                  s_fsm_buf_wr_next    <= BW_ACK;
            end case;
         
         when BW_BYTE_WR0 =>
            if ((i_buf_wr_last = '1') or (s_wb_sel(1) = '0')) then
               s_fsm_buf_wr_next    <= BW_ACK;
            else
               s_fsm_buf_wr_next    <= BW_BYTE_WR1;
            end if;

         when BW_BYTE_WR1 =>
            if ((i_buf_wr_last = '1') or (s_wb_sel(2) = '0')) then
               s_fsm_buf_wr_next    <= BW_ACK;
            else
               s_fsm_buf_wr_next    <= BW_BYTE_WR2;
            end if;

         when BW_BYTE_WR2 =>
            if ((i_buf_wr_last = '1') or (s_wb_sel(3) = '0')) then
               s_fsm_buf_wr_next    <= BW_ACK;
            else
               s_fsm_buf_wr_next    <= BW_BYTE_WR3;
            end if;
            
         when BW_BYTE_WR3 =>
            s_fsm_buf_wr_next    <= BW_ACK;
            
         when BW_ACK =>
            s_fsm_buf_wr_next    <= BW_LISTEN;
            
         when others => 
      end case;
   end process;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_RD_MUX:
   process (all)
      variable v_reg_adr   : natural;
   begin
      v_reg_adr   := to_integer(unsigned(s_wb_adr));
      
      case v_reg_adr is       
         when c_reg_adr_buf_count =>
            s_wb_rd_mux    <= f_reg_read(s_reg_buf_count, s_wb_rd_mux'length );
         
         when c_reg_adr_buf_pos =>
            s_wb_rd_mux    <= f_reg_read(s_reg_buf_pos, s_wb_rd_mux'length );
            
         when c_reg_adr_cfi_adr =>
            s_wb_rd_mux    <= f_cp_resize(s_reg_cfi_adr, s_wb_rd_mux'length );
            
         when c_reg_adr_cfi_cmd =>
            s_wb_rd_mux    <= f_cp_resize(s_reg_cfi_cmd, s_wb_rd_mux'length );
            
         when c_reg_adr_ctrl_sta =>
            s_wb_rd_mux    <= f_reg_read(s_reg_ctrl_sta, s_wb_rd_mux'length );

         when c_reg_adr_rsps_0 =>
            s_wb_rd_mux    <= f_reg_read(s_reg_rsps_0, s_wb_rd_mux'length );

         when c_reg_adr_rsps_1 =>
            s_wb_rd_mux    <= f_reg_read(s_reg_rsps_1, s_wb_rd_mux'length );
            
         when c_reg_adr_xfer_count =>
            s_wb_rd_mux    <= f_reg_read(s_reg_xfer_count, s_wb_rd_mux'length );
         
         when others => 
            if ((s_wb_adr(s_wb_adr'left ) = '1') and (s_wb_rd_cyc = '1')) then
               s_wb_rd_mux    <= f_reg_read(s_reg_xfer_buf, s_wb_rd_mux'length );
            else
               s_wb_rd_mux    <= (others => '0');
            end if;
      end case;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_MAIN:
   process (i_clk, i_rst_n)
      variable v_reg_adr   : natural;
      
      procedure p_rst_clr is
      begin
         s_buf_dout           <= (others => '0');
         s_buf_empty          <= '1';
         s_buf_pop            <= '0';
         s_buf_push           <= '0';
         
         s_ev_spi_end         <= '0';
         s_ev_spi_start       <= '0';
         
         s_fsm_buf_rd         <= BR_LISTEN;
         s_fsm_buf_wr         <= BW_LISTEN;
         s_int_req            <= '0';
         
         s_reg_buf_count      <= (others => '0');
         s_reg_buf_pos        <= (others => '0');
         s_reg_cfi_adr        <= (others => '0');
         s_reg_cfi_adr_push   <= '0';
         s_reg_cfi_cmd        <= (others => '0');
         s_reg_cfi_cmd_push   <= '0';
         s_reg_ctrl_sta       <= c_jxb3_ctrl_sta_init;
         s_reg_rsps_0         <= (others => '0');
         s_reg_rsps_1         <= (others => '0');
         s_reg_xcount_eq0     <= '1';
         s_reg_xfer_buf       <= (others => '0');
         s_reg_xfer_count     <= (others => '0');
         
         s_spi_busy           <= (others => '0');
         s_spi_has_pload      <= '0';
         
         s_wb_ack             <= '0';
         s_wb_adr             <= (others => '0');
         s_wb_din             <= (others => '0');
         s_wb_dout            <= (others => '0');
         s_wb_rd_cyc          <= '0';
         s_wb_sel             <= (others => '0');
         s_wb_wr_cyc          <= '0';
         
         s_xfer_count         <= (others => '0');
         s_xfer_count_eq0     <= '1';
         s_xfer_count_eq1     <= '0';
      end procedure;
      
   begin
      if (i_rst_n = '0') then
         p_rst_clr;
         
      elsif (rising_edge(i_clk)) then
         if (i_clr = '1') then
            p_rst_clr;
         else
            v_reg_adr         := to_integer(unsigned(s_wb_adr));
            
               -- Default assignments
            s_buf_dout           <= (others => '0');
            s_buf_pop            <= '0';
            s_buf_push           <= '0';
            s_reg_cfi_adr_push   <= '0';
            s_reg_cfi_cmd_push   <= '0';
            s_wb_ack             <= '0';
            
               -- Functional assignments
            s_buf_empty       <= i_buf_rd_empty or (i_buf_src_spi and not i_buf_rd_empty);

            s_ev_spi_end      <= f_det_fall(s_spi_busy);
            s_ev_spi_start    <= f_det_rise(s_spi_busy);
            
            s_fsm_buf_rd      <= s_fsm_buf_rd_next;
            s_fsm_buf_wr      <= s_fsm_buf_wr_next;
            
            s_int_req         <= s_reg_ctrl_sta.sta.int_req and (not s_reg_ctrl_sta.ctrl.int_mask);
            
            s_reg_xcount_eq0  <= not (or(s_reg_xfer_count));
            
            s_spi_busy        <= f_shin_lsb(s_spi_busy, i_spi_busy);
            
            s_spi_has_pload   <= i_spi_busy and (f_to_logic(unsigned(s_xfer_count) /= 0) or 
                                                 (((not s_buf_empty) or (not i_mbox_tx_rdy)) and (
                                                         f_to_logic(s_reg_ctrl_sta.ctrl.buf_mode = c_buf_mode_duplex) or
                                                         f_to_logic(s_reg_ctrl_sta.ctrl.buf_mode = c_buf_mode_tx))));
                                                 
            s_wb_adr          <= s_wb_adr_in;
            s_wb_din          <= f_cp_resize(i_wb_din, s_wb_din'length);
            s_wb_dout         <= (others => '0');
            s_wb_sel          <= f_cp_resize(i_wb_sel, s_wb_sel'length);
                        
            s_wb_rd_cyc       <= i_wb_cyc and i_wb_stb and not i_wb_we and not s_wb_ack;
            s_wb_wr_cyc       <= i_wb_cyc and i_wb_stb and     i_wb_we and not s_wb_ack;
            
               --    ----------------------------------------------------------
            s_reg_buf_count   <= f_cp_resize(i_buf_wr_free, t_hword'length ) & f_cp_resize(i_buf_rd_count, t_hword'length );
            
            s_reg_ctrl_sta    <= f_reg_update(s_reg_ctrl_sta,  irq   => s_ev_spi_end,
                                                               bmt   => i_buf_rd_empty,
                                                               bfull => i_buf_wr_full,
                                                               bsy   => i_spi_busy);
            
               --    ----------------------------------------------------------
            if (i_adr_push = '1') then
               s_reg_rsps_1   <= f_cp_resize(f_swap_endian(i_adr_rdat), s_reg_rsps_1'length );
            end if;
            
            if (i_resp_push = '1') then
               s_reg_rsps_0   <= f_cp_resize(i_resp_din, s_reg_rsps_0'length );
            end if;
            
            if (s_reg_ctrl_sta.ctrl.spi_clr = '1') then
               s_reg_buf_pos     <= (others => '0');
            elsif (i_buf_pop = '1') then
               s_reg_buf_pos     <= f_incr(s_reg_buf_pos);
            end if;
            
            if (s_ev_spi_start = '1') then
               s_xfer_count      <= f_reg_load(s_reg_xfer_count, s_xfer_count'length );
               s_xfer_count_eq0  <= not (or(s_reg_xfer_count));
               s_xfer_count_eq1  <= f_to_logic(unsigned(s_reg_xfer_count) = 1);
               
            elsif ((i_mbox_rx_pop = '1') and (s_xfer_count_eq0 = '0')) then
               s_xfer_count      <= f_decr(s_xfer_count);
               s_xfer_count_eq0  <= f_to_logic(unsigned(s_xfer_count) = 1);
               s_xfer_count_eq1  <= f_to_logic(unsigned(s_xfer_count) = 2);
            end if;
            
               --    ----------------------------------------------------------
            if (s_wb_rd_cyc = '1') then
               if (s_wb_ack = '1') then
                  s_wb_ack    <= '0';
                  s_wb_dout   <= (others => '0');
               else
                  s_wb_dout   <= s_wb_rd_mux;
                  
                  if (s_wb_adr(s_wb_adr'left ) = '1') then
                     s_buf_pop   <= s_buf_pop_dx;
                     s_wb_ack    <= f_to_logic(s_fsm_buf_rd = BR_ACK);
                     
                     case s_fsm_buf_rd is
                        when BR_BYTE_RD0 =>
                           s_reg_xfer_buf(7 downto 0)    <= i_buf_din(7 downto 0);

                        when BR_BYTE_RD1 =>
                           s_reg_xfer_buf(15 downto 8)   <= i_buf_din(7 downto 0);

                        when BR_BYTE_RD2 =>
                           s_reg_xfer_buf(23 downto 16)  <= i_buf_din(7 downto 0);

                        when BR_BYTE_RD3 =>
                           s_reg_xfer_buf(31 downto 24)  <= i_buf_din(7 downto 0);
                           
                        when others => 
                     end case;                     
                  else
                     s_wb_ack    <= '1';
                  end if;
               end if;               
            end if;
            
               --    ----------------------------------------------------------
            if (s_wb_wr_cyc = '1') then   
               s_wb_ack    <= ((not s_wb_ack) and (not s_wb_adr(s_wb_adr'left ))) or 
                              (s_wb_adr(s_wb_adr'left ) and f_to_logic(s_fsm_buf_wr = BW_ACK));
               
               if (s_wb_adr(s_wb_adr'left ) = '1') then                 
                  case s_fsm_buf_wr is
                     when BW_DECODE =>
                        s_reg_xfer_buf <= f_cp_resize(f_reg_write(s_reg_xfer_buf, s_wb_din, s_wb_sel), s_reg_xfer_buf'length );

                     when BW_BYTE_WR0 =>
                        s_buf_dout     <= s_reg_xfer_buf(7 downto 0);
                        s_buf_push     <= '1';
                        
                     when BW_BYTE_WR1 =>
                        s_buf_dout     <= s_reg_xfer_buf(15 downto 8);   
                        s_buf_push     <= '1';
                        
                     when BW_BYTE_WR2 =>
                        s_buf_dout     <= s_reg_xfer_buf(23 downto 16);
                        s_buf_push     <= '1';
                     
                     when BW_BYTE_WR3 =>
                        s_buf_dout     <= s_reg_xfer_buf(31 downto 24);   
                        s_buf_push     <= '1';
                        
                     when others => 
                  end case;               
               elsif (s_wb_ack = '1') then
                  case (v_reg_adr) is
                     when c_reg_adr_cfi_adr =>
                        s_reg_cfi_adr        <= f_cp_resize(f_reg_write(s_reg_cfi_adr, s_wb_din, s_wb_sel), s_reg_cfi_adr'length );
                        s_reg_cfi_adr_push   <= '1';
                        
                     when c_reg_adr_cfi_cmd =>
                        s_reg_cfi_cmd        <= f_cp_resize(f_reg_write(s_reg_cfi_cmd, s_wb_din, s_wb_sel), s_reg_cfi_cmd'length );
                        s_reg_cfi_cmd_push   <= '1';
                        
                     when c_reg_adr_ctrl_sta =>
                        s_reg_ctrl_sta    <= f_reg_write(s_reg_ctrl_sta, s_wb_din, s_wb_sel);
                        
                     when c_reg_adr_xfer_count =>
                        s_reg_xfer_count     <= f_cp_resize(f_reg_write(s_reg_xfer_count, s_wb_din, s_wb_sel), s_reg_xfer_count'length );
                        
                     when others =>   
                  end case;
               end if;
            end if;
            
               --    ----------------------------------------------------------
         end if;
      end if;
   end process;
End Rtl;
