
--
--    Copyright Ingenieurbuero Gardiner, 2013 - 2019
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
-- File ID     : $Id: jxb3_spi_dma_tgt-a_rtl.vhd 5353 2021-11-20 23:49:29Z  $
-- Generated   : $LastChangedDate: 2021-11-21 00:49:29 +0100 (Sun, 21 Nov 2021) $
-- Revision    : $LastChangedRevision: 5353 $
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

Architecture Rtl of jxb3_spi_dma_tgt is
   type t_buf_rd  is (BR_RST, BR_LISTEN, BR_DECODE, BR_BYTE_RD0, BR_BYTE_RD1, BR_BYTE_RD2, BR_BYTE_RD3, BR_ACK, BR_LAST);
   type t_buf_wr  is (BW_RST, BW_LISTEN, BW_DECODE, BW_BYTE_WR0, BW_BYTE_WR1, BW_BYTE_WR2, BW_BYTE_WR3, BW_ACK, BW_LAST);
   
   type t_dma_rd_fsm is (DR_IDLE, DR_RD_CMD, DR_RADR_INIT, DR_RADR, DR_RD_OP, DR_RD_WT_END, DR_RD_FLUSH);
   type t_dma_wr_fsm is (DW_IDLE, DW_WREN_CMD, DW_WREN_WT_ST, DW_WREN_WT_END, 
                                  DW_WR_CMD, DW_WADR_INIT, DW_WADR, DW_WR_OP, DW_WR_FLUSH);

   subtype t_phase_count   is std_logic_vector(2 downto 0);
   subtype t_bsel          is std_logic_vector(f_vec_msb(i_wb_sel'length ) - 1 downto 0);
   
   signal s_buf_dout          : t_byte;
   signal s_buf_pop           : std_logic;
   signal s_buf_pop_dx        : std_logic;
   signal s_buf_push          : std_logic; 
   signal s_dma_idle          : std_logic;
   signal s_dma_rd_pos        : t_bsel;
   signal s_fsm_buf_rd        : t_buf_rd;
   signal s_fsm_buf_rd_next   : t_buf_rd;
   signal s_fsm_buf_wr        : t_buf_wr;
   signal s_fsm_buf_wr_next   : t_buf_wr;
   signal s_fsm_dma_rd        : t_dma_rd_fsm;
   signal s_fsm_dma_rd_next   : t_dma_rd_fsm;
   signal s_fsm_dma_wr        : t_dma_wr_fsm;
   signal s_fsm_dma_wr_next   : t_dma_wr_fsm;
   signal s_mbox_rx_pop       : std_logic;
   signal s_mbox_tx_push      : std_logic;
   signal s_mbox_tx_wdat      : t_byte;
   signal s_phase_count       : t_phase_count;
   signal s_reg_xfer_buf      : t_dword;   
   signal s_spi_adr           : std_logic_vector(g_spi_adr_sz - 1 downto 0);   
   signal s_spi_en            : std_logic;
   signal s_spi_rx_last       : std_logic;
   signal s_spi_tx_last       : std_logic;
   signal s_wb_ack            : std_logic;
   signal s_wb_cti            : t_wb_cti;
   signal s_wb_din            : t_dword;
   signal s_wb_dout           : t_dword;
   signal s_wb_last           : std_logic;
   signal s_wb_rd_cyc         : std_logic;
   signal s_wb_sel            : std_logic_vector(3 downto 0);
   signal s_wb_wr_cyc         : std_logic;
   
Begin
   o_buf_pop            <= s_buf_pop;
   o_buf_push           <= s_buf_push;
   o_buf_dout           <= f_resize(s_buf_dout, t_byte'length );
   
   o_dma_idle           <= s_dma_idle;
   
   o_mbox_rx_pop        <= s_mbox_rx_pop;
   o_mbox_tx_wdat       <= f_resize(s_mbox_tx_wdat, o_mbox_tx_wdat'length );
   o_mbox_tx_push       <= s_mbox_tx_push;
   
   o_spi_en             <= s_spi_en;
   o_spi_rx_last        <= s_spi_rx_last;
   o_spi_tx_last        <= s_spi_tx_last;
   o_spi_wr             <= s_wb_wr_cyc;
   o_spi_xfer_attribs   <= f_resize(c_tie_low_byte(1 downto 0), o_spi_xfer_attribs'length );
   
   o_wb_ack             <= s_wb_ack;
   o_wb_dat             <= f_resize(s_wb_dout, o_wb_dat'length );
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   F_BUF_RD:
   process(all)
   begin
      s_buf_pop_dx         <= '0';
      s_fsm_buf_rd_next    <= s_fsm_buf_rd;
      
      case s_fsm_buf_rd is
         when BR_LISTEN =>
            if ((s_wb_rd_cyc = '1') and (s_wb_ack = '0')) then
               s_fsm_buf_rd_next    <= BR_DECODE;
            end if;
            
         when BR_DECODE =>
            if (i_buf_rd_empty = '0') then
               case s_wb_sel is
                  when "0001" | "0011" | "0111" | "1111" =>
                     s_fsm_buf_rd_next    <= BR_BYTE_RD0;

                  when "0010" | "0110" | "1110" =>
                     s_fsm_buf_rd_next    <= BR_BYTE_RD1;

                  when "0100" | "1100" =>
                     s_fsm_buf_rd_next    <= BR_BYTE_RD2;

                  when "1000" =>
                     s_fsm_buf_rd_next    <= BR_BYTE_RD3;
                  
                  when others =>                                                                                             
                     s_fsm_buf_rd_next    <= BR_ACK;
               end case;
            end if;
         
         when BR_BYTE_RD0 =>
            if (i_buf_rd_empty = '0') then
               s_buf_pop_dx   <= not s_buf_pop;
               
               if (s_buf_pop = '1') then
                  if (s_wb_sel(1) = '0') then
                     s_fsm_buf_rd_next    <= BR_ACK;
                  else
                     s_fsm_buf_rd_next    <= BR_BYTE_RD1;
                  end if;
               end if;
            end if;

         when BR_BYTE_RD1 =>
            if (i_buf_rd_empty = '0') then
               s_buf_pop_dx   <= not s_buf_pop;
               
               if (s_buf_pop = '1') then
                  if (s_wb_sel(2) = '0') then
                     s_fsm_buf_rd_next    <= BR_ACK;
                  else
                     s_fsm_buf_rd_next    <= BR_BYTE_RD2;
                  end if;
               end if;
            end if;

         when BR_BYTE_RD2 =>
            if (i_buf_rd_empty = '0') then
               s_buf_pop_dx   <= not s_buf_pop;
               
               if (s_buf_pop = '1') then
                  if (s_wb_sel(3) = '0') then
                     s_fsm_buf_rd_next    <= BR_ACK;
                  else
                     s_fsm_buf_rd_next    <= BR_BYTE_RD3;
                  end if;
               end if;
            end if;
            
         when BR_BYTE_RD3 =>
            if (i_buf_rd_empty = '0') then
               s_buf_pop_dx   <= not s_buf_pop;
            
               if (s_buf_pop = '1') then
                  s_fsm_buf_rd_next    <= BR_ACK;
               end if;
            end if;
            
         when BR_ACK =>
            if (s_wb_cti = c_wb_cti_burst_end) then
               s_fsm_buf_rd_next    <= BR_LAST;
            else         
               s_fsm_buf_rd_next    <= BR_LISTEN;
            end if;

         when BR_LAST =>
            if ((i_spi_busy = '0') or (i_dma_en = '0')) then
               s_fsm_buf_rd_next    <= BR_LISTEN;
            end if;
            
         when others => 
            s_fsm_buf_rd_next    <= BR_LISTEN;
      end case;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   F_BUF_WR:
   process(all)
   begin
      s_fsm_buf_wr_next    <= s_fsm_buf_wr;
      
      case s_fsm_buf_wr is
         when BW_LISTEN =>
            if ((s_wb_wr_cyc = '1') and (s_wb_ack = '0')) then
               s_fsm_buf_wr_next    <= BW_DECODE;
            end if;
            
         when BW_DECODE =>
            if (i_buf_wr_full = '0') then
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
            end if;
         
         when BW_BYTE_WR0 =>
            if (i_buf_wr_full = '0') then
               if (s_wb_sel(1) = '0') then
                  s_fsm_buf_wr_next    <= BW_ACK;
               else
                  if (s_buf_push = '1') then
                     s_fsm_buf_wr_next    <= BW_BYTE_WR1;
                  end if;
               end if;
            end if;

         when BW_BYTE_WR1 =>
            if (i_buf_wr_full = '0') then
               if (s_wb_sel(2) = '0') then
                  s_fsm_buf_wr_next    <= BW_ACK;
               else
                  if (s_buf_push = '1') then
                     s_fsm_buf_wr_next    <= BW_BYTE_WR2;
                  end if;
               end if;
            end if;

         when BW_BYTE_WR2 =>
            if (i_buf_wr_full = '0') then
               if (s_wb_sel(3) = '0') then
                  s_fsm_buf_wr_next    <= BW_ACK;
               else
                  if (s_buf_push = '1') then
                     s_fsm_buf_wr_next    <= BW_BYTE_WR3;
                  end if;
               end if;
            end if;
            
         when BW_BYTE_WR3 =>
            if (i_buf_wr_full = '0') then
               if (s_buf_push = '1') then
                  s_fsm_buf_wr_next    <= BW_ACK;
               end if;
            end if;
            
         when BW_ACK =>
            if (s_wb_cti = c_wb_cti_burst_end) then
               s_fsm_buf_wr_next    <= BW_LAST;
            else
               s_fsm_buf_wr_next    <= BW_LISTEN;
            end if;
            
         when BW_LAST =>
            if (((i_buf_rd_empty = '1') and (i_spi_busy = '0') and (not (s_fsm_dma_wr = DW_WREN_WT_ST))) or 
                (i_dma_en = '0')) then
               s_fsm_buf_wr_next    <= BW_LISTEN;
            end if;
            
         when others => 
            s_fsm_buf_wr_next    <= BW_LISTEN;
      end case;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   F_DMA_RD:
   process (all)
   begin
      s_fsm_dma_rd_next    <= s_fsm_dma_rd;
      
      case s_fsm_dma_rd is
         when DR_IDLE =>
            if ((i_dma_en = '1') and (s_wb_rd_cyc = '1') and (s_wb_ack = '0')) then
               s_fsm_dma_rd_next    <= DR_RD_CMD;
            end if;
         
         when DR_RD_CMD =>
            s_fsm_dma_rd_next    <= DR_RADR_INIT;
            
         when DR_RADR_INIT => 
            if ((i_mbox_tx_rdy = '1') and (s_mbox_tx_push = '0')) then
               s_fsm_dma_rd_next    <= DR_RADR;
            end if;
         
         when DR_RADR =>
            if ((unsigned(s_phase_count) = 0) and (i_mbox_rx_rdy = '1')) then
               s_fsm_dma_rd_next    <= DR_RD_OP;
            end if;

         when DR_RD_OP =>
            if (s_spi_rx_last = '1') then
               s_fsm_dma_rd_next    <= DR_RD_WT_END;
            end if;
            
         when DR_RD_WT_END =>
            if (i_spi_busy = '0') then
               s_fsm_dma_rd_next    <= DR_RD_FLUSH;
            end if;  
            
         when others => 
            s_fsm_dma_rd_next    <= DR_IDLE;
      end case;
   end process;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   F_DMA_WR:
   process (all)
   begin
      s_fsm_dma_wr_next    <= s_fsm_dma_wr;
      
      case s_fsm_dma_wr is
         when DW_IDLE =>
            if ((i_dma_en = '1') and (s_wb_wr_cyc = '1') and (s_wb_ack = '0')) then
               s_fsm_dma_wr_next    <= DW_WREN_CMD;
            end if;

         when DW_WREN_CMD => 
            s_fsm_dma_wr_next    <= DW_WREN_WT_ST;      

         when DW_WREN_WT_ST =>
            if (i_spi_busy = '1') then
               s_fsm_dma_wr_next    <= DW_WREN_WT_END;
            end if;
            
         when DW_WREN_WT_END =>
            if ((i_spi_busy = '0') and (s_mbox_rx_pop = '1')) then
               s_fsm_dma_wr_next    <= DW_WR_CMD;
            end if;

         when DW_WR_CMD =>
            s_fsm_dma_wr_next    <= DW_WADR_INIT;
            
         when DW_WADR_INIT =>
            s_fsm_dma_wr_next    <= DW_WADR;
         
         when DW_WADR =>
            if ((unsigned(s_phase_count) = 0) and (i_mbox_rx_rdy = '1')) then
               s_fsm_dma_wr_next    <= DW_WR_OP;
            end if;
            
         when DW_WR_OP =>
            if ((s_wb_last = '1') and (i_buf_rd_empty = '1') and (i_spi_busy = '0')) then
               s_fsm_dma_wr_next    <= DW_WR_FLUSH;
            end if;  
         
         when others =>
            s_fsm_dma_wr_next    <= DW_IDLE;   
            
      end case;
   end process;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_MAIN:
   process (i_clk, i_rst_n)
      subtype t_wb_op_cyc  is std_logic_vector(1 downto 0);
      
      constant c_wb_op_rd  : t_wb_op_cyc := B"01";
      constant c_wb_op_wr  : t_wb_op_cyc := B"10";
      
      variable v_wb_op_cyc    : t_wb_op_cyc;
      
      procedure p_rst_clr is
      begin
         s_buf_dout           <= (others => '0');
         s_buf_pop            <= '0';
         s_buf_push           <= '0';

         s_dma_idle           <= '0';
         s_dma_rd_pos         <= (others => '0');
         
         s_fsm_buf_rd         <= BR_RST;
         s_fsm_buf_wr         <= BW_RST;
         
         s_fsm_dma_rd         <= DR_IDLE;
         s_fsm_dma_wr         <= DW_IDLE;
         
         s_mbox_rx_pop        <= '0';
         s_mbox_tx_wdat       <= (others => '0');
         s_mbox_tx_push       <= '0';
         
         s_reg_xfer_buf       <= (others => '0');
         
         s_spi_adr            <= (others => '0');
         s_spi_en             <= '0';
         s_spi_rx_last        <= '0';
         s_spi_tx_last        <= '0';
         
         s_wb_ack             <= '0';
         s_wb_cti             <= (others => '0');
         s_wb_din             <= (others => '0');
         s_wb_dout            <= (others => '0');
         s_wb_last            <= '0';
         s_wb_rd_cyc          <= '0';
         s_wb_sel             <= (others => '0');
         s_wb_wr_cyc          <= '0';      
      end procedure;
      
   begin
      if (i_rst_n = '0') then
         p_rst_clr;
         
      elsif (rising_edge(i_clk)) then
         if (i_clr = '1') then
            p_rst_clr;
         else
            v_wb_op_cyc       := s_wb_wr_cyc & s_wb_rd_cyc;
            
               -- Default assignments
            s_buf_pop         <= '0';   
            s_buf_push        <= '0';   
            s_mbox_rx_pop     <= '0';
            s_mbox_tx_push    <= '0';
            
               -- Functional assignments
            s_dma_idle        <= f_to_logic(s_fsm_dma_rd = DR_IDLE) and f_to_logic(s_fsm_dma_wr = DW_IDLE);
            
            s_fsm_buf_rd      <= s_fsm_buf_rd_next;
            s_fsm_buf_wr      <= s_fsm_buf_wr_next;

            s_fsm_dma_rd      <= s_fsm_dma_rd_next;
            s_fsm_dma_wr      <= s_fsm_dma_wr_next;
            
            s_spi_en          <= i_dma_en and (f_to_logic(s_fsm_dma_rd /= DR_IDLE) or f_to_logic(s_fsm_dma_wr /= DW_IDLE));
                        
            s_wb_cti          <= i_wb_cti;
            s_wb_din          <= f_resize(i_wb_dat, s_wb_din'length);
            s_wb_rd_cyc       <= i_wb_cyc and i_wb_stb and not i_wb_we and not s_wb_ack;
            s_wb_sel          <= f_resize(i_wb_sel, s_wb_sel'length);
            s_wb_wr_cyc       <= i_wb_cyc and i_wb_stb and     i_wb_we and not s_wb_ack;
                        
               --    ----------------------------------------------------------
               --          Wishbone Data-Path Access
               --    ----------------------------------------------------------
            case v_wb_op_cyc is
               when c_wb_op_rd =>
                  if (s_wb_ack = '1') then
                     s_wb_ack    <= '0';
                     s_wb_dout   <= (others => '0');
                  else
                     s_buf_pop   <= s_buf_pop_dx and i_dma_en;
                     
                     s_wb_dout   <= s_reg_xfer_buf;
                     
                     case s_fsm_buf_rd is
                        when BR_ACK => 
                           s_wb_ack    <= (not s_wb_last) or (not i_dma_en);
                           
                        when BR_DECODE =>
                           s_wb_last      <= f_to_logic(s_wb_cti = c_wb_cti_burst_end);
                        
                        when BR_BYTE_RD0 =>
                           if (s_buf_pop = '1') then
                              s_reg_xfer_buf(7 downto 0)    <= i_buf_din(7 downto 0);
                           end if;

                        when BR_BYTE_RD1 =>
                           if (s_buf_pop = '1') then
                              s_reg_xfer_buf(15 downto 8)   <= i_buf_din(7 downto 0);
                           end if;

                        when BR_BYTE_RD2 =>
                           if (s_buf_pop = '1') then
                              s_reg_xfer_buf(23 downto 16)  <= i_buf_din(7 downto 0);
                           end if;

                        when BR_BYTE_RD3 =>
                           if (s_buf_pop = '1') then
                              s_reg_xfer_buf(31 downto 24)  <= i_buf_din(7 downto 0);
                           end if;

                        when BR_LAST =>
                           s_wb_ack    <= (not i_spi_busy) or (not i_dma_en);
                           
                        when others => 
                           null;
                     end case;  
                  end if;
                     
               when c_wb_op_wr =>
                  s_wb_dout   <= (others => '0');
                  
                  if (s_wb_ack = '1') then
                     s_wb_ack    <= '0';
                  else
                     case s_fsm_buf_wr is
                        when BW_ACK => 
                           s_buf_dout  <= (others => '0');
                           s_wb_ack    <= (not s_wb_last) or (not i_dma_en);

                        when BW_DECODE =>
                           s_reg_xfer_buf <= f_resize(f_reg_write(s_reg_xfer_buf, s_wb_din, s_wb_sel), s_reg_xfer_buf'length );
                           s_wb_last      <= f_to_logic(s_wb_cti = c_wb_cti_burst_end);

                        when BW_BYTE_WR0 =>
                           s_buf_dout     <= s_reg_xfer_buf(7 downto 0);
                           s_buf_push     <= i_dma_en and (not (s_buf_push or i_buf_wr_full));
                           
                        when BW_BYTE_WR1 =>
                           s_buf_dout     <= s_reg_xfer_buf(15 downto 8);   
                           s_buf_push     <= i_dma_en and (not (s_buf_push or i_buf_wr_full));
                           
                        when BW_BYTE_WR2 =>
                           s_buf_dout     <= s_reg_xfer_buf(23 downto 16);
                           s_buf_push     <= i_dma_en and (not (s_buf_push or i_buf_wr_full));
                        
                        when BW_BYTE_WR3 =>
                           s_buf_dout     <= s_reg_xfer_buf(31 downto 24);   
                           s_buf_push     <= i_dma_en and (not (s_buf_push or i_buf_wr_full));
                           
                        when BW_LAST =>
                           s_buf_dout  <= (others => '0');
                           s_wb_ack    <= (i_buf_rd_empty and (not i_spi_busy) and (not f_to_logic(s_fsm_dma_wr = DW_WREN_WT_ST))) or 
                                          (not i_dma_en);
                           
                        when others => 
                     end case;    
                  end if;
                  
               when others => 
                  s_wb_ack    <= '0';
                  s_wb_dout   <= (others => '0');
            end case;

               --    ----------------------------------------------------------
               --       Read DMA
               --    ----------------------------------------------------------
            case s_fsm_dma_rd is               
               when DR_RD_CMD =>
                  s_mbox_tx_wdat    <= c_cfi_cmd_rd; 
                  s_mbox_tx_push    <= '1';
                  s_spi_adr         <= f_resize(i_wb_adr, s_spi_adr'length );   
                  
               when DR_RADR_INIT =>
                  s_dma_rd_pos      <= f_resize(i_wb_adr, s_dma_rd_pos'length );
                  s_phase_count     <= f_reg_load(g_spi_adr_sz / t_byte'length, s_phase_count'length );
                  s_spi_rx_last     <= '0';
              
               when DR_RADR =>
                  s_mbox_rx_pop     <= i_mbox_rx_rdy and not s_mbox_rx_pop;
                  s_mbox_tx_wdat    <= s_spi_adr(s_spi_adr'left downto s_spi_adr'length - t_byte'length ); 
                  s_mbox_tx_push    <= i_mbox_tx_rdy and not s_mbox_tx_push;
                  
                  if (s_mbox_rx_pop = '1') then
                     s_phase_count  <= f_decr(s_phase_count, c_no_wrap);
                     s_spi_adr      <= f_shl(s_spi_adr, t_byte'length );
                  end if;               
                  
               when DR_RD_OP =>
                  s_buf_dout        <= f_resize(i_mbox_rx_din, s_buf_dout'length );
                  s_buf_push        <= i_mbox_rx_rdy and not i_buf_wr_full and not s_buf_push and not s_mbox_rx_pop;
                  s_mbox_rx_pop     <= i_mbox_rx_rdy and not i_buf_wr_full and not s_buf_push and not s_mbox_rx_pop;
                  s_mbox_tx_push    <= i_mbox_tx_rdy and not s_mbox_tx_push;
                  
                  s_spi_rx_last     <= f_to_logic(s_fsm_buf_rd = BR_LAST);
                  
                  if (s_buf_push = '1') then
                     s_dma_rd_pos   <= f_incr(s_dma_rd_pos);
                  end if;
               
               when DR_RD_WT_END =>
                  s_mbox_rx_pop     <= i_mbox_rx_rdy and not i_buf_wr_full and not s_buf_push and not s_mbox_rx_pop;
                  
               when DR_RD_FLUSH =>
                  s_buf_dout        <= (others => '0');
                  s_spi_rx_last     <= '0';
                  
               when others =>
                  null;
            end case;            
            
               --    ----------------------------------------------------------
               --       Write DMA
               --    ----------------------------------------------------------
            case s_fsm_dma_wr is
               when DW_WREN_CMD =>
                  s_mbox_tx_wdat    <= c_cfi_cmd_wren; 
                  s_mbox_tx_push    <= '1';
                  s_spi_adr         <= f_resize(i_wb_adr, s_spi_adr'length );   
                  s_spi_tx_last     <= '1';
                  
               when DW_WREN_WT_END =>
                     -- Clear the status received
                  s_mbox_rx_pop     <= i_mbox_rx_rdy and (not s_mbox_rx_pop) and (not i_spi_busy);

               when DW_WR_CMD =>
                  s_mbox_tx_wdat    <= c_cfi_cmd_wr; 
                  s_mbox_tx_push    <= '1';
                  s_spi_tx_last     <= '0';
                  
               when DW_WADR_INIT => 
                  s_phase_count     <= f_reg_load(g_spi_adr_sz / t_byte'length, s_phase_count'length );

               when DW_WADR =>
                  s_mbox_rx_pop     <= i_mbox_rx_rdy and not s_mbox_rx_pop;
                  s_mbox_tx_wdat    <= s_spi_adr(s_spi_adr'left downto s_spi_adr'length - t_byte'length ); 
                  s_mbox_tx_push    <= i_mbox_tx_rdy and (not s_mbox_tx_push) and (or(s_phase_count));
                  
                  if (s_mbox_tx_push = '1') then
                     s_phase_count  <= f_decr(s_phase_count, c_no_wrap);
                     s_spi_adr      <= f_shl(s_spi_adr, t_byte'length );
                  end if;

               when DW_WR_OP =>
                  s_buf_pop         <= i_mbox_tx_rdy and not i_buf_rd_empty and not s_buf_pop and not s_mbox_tx_push;
                  s_mbox_rx_pop     <= i_mbox_rx_rdy and not s_mbox_rx_pop;
                  s_mbox_tx_wdat    <= f_resize(i_buf_din, s_mbox_tx_wdat'length ); 
                  s_mbox_tx_push    <= i_mbox_tx_rdy and not i_buf_rd_empty and not s_buf_pop and not s_mbox_tx_push;
                  
                  if (s_buf_pop = '1') then
                     s_spi_tx_last     <= f_to_logic(s_fsm_buf_wr = BW_LAST) and i_buf_rd_last;
                  else
                     s_spi_tx_last     <= s_spi_tx_last and i_spi_busy;
                  end if;                  
               
               when DW_WR_FLUSH =>
                  s_mbox_tx_wdat    <= (others => '0'); 
                  s_spi_tx_last     <= '0';
                  s_wb_last         <= '0';
               
               when others =>
                  null;
            end case;
            
         end if;
      end if;
   end process;
End Rtl;
