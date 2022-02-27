
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: rx_16550s-a_rtl.vhd 5378 2021-12-13 00:15:46Z  $
-- Generated   : $LastChangedDate: 2021-12-13 01:15:46 +0100 (Mon, 13 Dec 2021) $
-- Revision    : $LastChangedRevision: 5378 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.numeric_std.all;

Use WORK.rx_16550s_comps.all;
Use WORK.tspc_utils.all;

Architecture Rtl of rx_16550s is
   constant c_fifo_word_sz    : natural := o_rhr_dout'length + 3;
   constant c_rx_timer_max    : natural := c_rx_timer_load_8;
   
   signal s_err_ack_ovr          : std_logic;
   signal s_ev_fifo_en           : std_logic;
   signal s_ev_fifo_lvl_chng     : std_logic;
   signal s_fifo_clr             : std_logic;
   signal s_fifo_dout            : std_logic_vector(c_fifo_word_sz - 1 downto 0);
   signal s_fifo_empty_prev      : std_logic;
   signal s_fifo_en_prev_clk     : std_logic;
   signal s_fifo_en_state_clk    : std_logic;
   signal s_fifo_en_sync         : std_logic;
   signal s_fifo_en_xclk         : std_logic;
   signal s_fifo_err_count       : std_logic_vector(f_vec_msb(g_mem_words) downto 0);
   signal s_fifo_err_flags       : std_logic_vector(2 downto 0);
   signal s_fifo_err_pop         : std_logic;
   signal s_fifo_err_push        : std_logic;
   signal s_fifo_lsr_dout        : std_logic_vector(o_lsr_dout'range);
   signal s_fifo_lsr_flags       : std_logic_vector(2 downto 0);
   signal s_fifo_lsr_update      : std_logic;
   signal s_fifo_rcv_err         : std_logic;
   signal s_fifo_rd_en_rhr       : std_logic;
   signal s_fifo_trigger         : std_logic;
   signal s_fifo_wr_count_reg    : std_logic_vector(f_vec_msb(g_mem_words) downto 0);
   signal s_fifo_wr_en_rhr       : std_logic;
   signal s_int_rcv_data         : std_logic;
   signal s_int_rx_timer_ack     : std_logic;
   signal s_int_rx_timer_set     : std_logic;
   signal s_lsr_dout             : std_logic_vector(o_lsr_dout'range);
   signal s_mbx_lsr_dout         : std_logic_vector(o_lsr_dout'range);
   signal s_mbx_rd_en_lsr        : std_logic;
   signal s_mbx_wr_en_err_brk    : std_logic;
   signal s_mbx_wr_en_err_frm    : std_logic;
   signal s_mbx_wr_en_err_ovr    : std_logic;
   signal s_mbx_wr_en_err_par    : std_logic;
   signal s_rd_en_lsr            : std_logic;      
   signal s_rtl_fifo_empty       : std_logic;
   signal s_rtl_fifo_pop         : std_logic;
   signal s_rtl_fifo_push        : std_logic;
   signal s_rtl_rd_en_rhr        : std_logic;
   signal s_rtl_rx_sym           : std_logic_vector(c_fifo_word_sz - 1 downto 0);
   signal s_rtl_wr_en_rhr        : std_logic;
   signal s_rx                   : std_logic_vector(3 downto 0);
   signal s_rx_sdin              : std_logic;
   signal s_rx_sdin_filtered     : std_logic;
   signal s_rx_timer             : std_logic_vector(f_vec_msb(c_rx_timer_max) downto 0);
   signal s_rx_timer_int         : std_logic;
   signal s_rx_timer_int_en_sync : std_logic;
   signal s_rx_timer_int_en_xclk : std_logic;
   signal s_timer_clr_fifo       : std_logic;
   signal s_timer_restart        : std_logic;
   signal s_u1_dout              : std_logic_vector(7 downto 0);
   signal s_u1_err_break         : std_logic;
   signal s_u1_err_frm           : std_logic;
   signal s_u1_err_ovr           : std_logic;
   signal s_u1_err_par           : std_logic;
   signal s_u1_frame_eval        : std_logic;
   signal s_u1_push              : std_logic;
   signal s_u1_sample_tick       : std_logic;
   signal s_u2_fifo_rd_count     : std_logic_vector(f_vec_msb(g_mem_words) downto 0);
   signal s_u2_rd_dout           : std_logic_vector(c_fifo_word_sz - 1 downto 0); 
   signal s_u2_rd_empty          : std_logic;
   signal s_u2_wr_free           : std_logic_vector(f_vec_msb(g_mem_words) downto 0);
   signal s_u2_wr_full           : std_logic;
   signal s_u3_rd_dout           : std_logic_vector(c_fifo_word_sz - 1 downto 0);
   signal s_u3_rd_ready          : std_logic;
   signal s_u3_wr_ready          : std_logic;
   signal s_u4_err_brk           : std_logic;
   signal s_u5_fifo_err_push     : std_logic;
   signal s_u6_err_frm           : std_logic;
   signal s_u7_err_ovr           : std_logic;
   signal s_u8_err_par           : std_logic;
   signal s_u9_rx_timer          : std_logic;
   signal s_u9_wr_ready          : std_logic;
   signal s_word_length_sync     : std_logic_vector(i_word_length'range);
   signal s_word_length_xclk     : std_logic_vector(i_word_length'range);

Begin
   
   o_int_line_status <= (or(s_lsr_dout(4 downto 1))) and i_int_en_line_status;
   
   o_int_rcv_data    <= s_int_rcv_data and i_int_en_rcv_data;
   
   o_int_rcv_timer   <= s_u9_rx_timer and i_int_en_rcv_data and i_fifo_en;
   
   o_lsr_dout        <= s_lsr_dout;
                     
   o_rhr_dout        <= s_u3_rd_dout(o_rhr_dout'length - 1 downto 0) when (i_fifo_en = '0') else
                        s_fifo_dout(o_rhr_dout'length - 1 downto 0);

   o_rxrdy           <= (s_u3_rd_ready and not i_fifo_en) or
                        (i_fifo_en and not s_u2_rd_empty and not i_dma_mode) or
                        (i_fifo_en and i_dma_mode and s_fifo_trigger);
                        
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_err_ack_ovr        <= i_rd_en_lsr and s_u7_err_ovr;
   
   s_fifo_clr           <= i_fifo_clr or s_ev_fifo_en;
   
   s_fifo_err_flags     <= s_fifo_dout(10 downto 8);
     
   s_fifo_err_push      <= s_fifo_wr_en_rhr and (s_u1_err_break or s_u1_err_frm or s_u1_err_par);
   
   s_fifo_lsr_dout      <= s_fifo_rcv_err & "00" 
                                          & s_fifo_lsr_flags 
                                          & s_u7_err_ovr
                                          & not s_rtl_fifo_empty;

   s_fifo_rcv_err       <= i_fifo_en and f_to_logic(unsigned(s_fifo_err_count) /= 0);
                           
   s_fifo_rd_en_rhr     <= i_rd_en_rhr and s_fifo_en_state_clk and not s_rtl_fifo_empty;
   
   s_fifo_wr_en_rhr     <= s_u1_push and s_fifo_en_xclk and not s_u2_wr_full;

   s_int_rcv_data       <= (s_u3_rd_ready and not i_fifo_en) or
                           (i_fifo_en and s_fifo_trigger);

   s_int_rx_timer_ack   <= i_rd_en_rhr and s_u9_rx_timer;
   
      -- Only set the character timeout interrupt when a character is available
   s_int_rx_timer_set   <= f_to_logic(unsigned(s_rx_timer) = 1) and s_u1_sample_tick and
                           s_rx_timer_int_en_xclk and ((s_u3_rd_ready and not s_fifo_en_xclk) or
                                                       (s_fifo_en_xclk and not s_rtl_fifo_empty));

      -- These are the lsr bits sourced by the receiver logic                              
   s_lsr_dout           <= s_mbx_lsr_dout when (i_fifo_en = '0') else
                           s_fifo_lsr_dout;

   s_mbx_lsr_dout       <= "000" & s_u4_err_brk & s_u6_err_frm & s_u8_err_par
                                 & s_u7_err_ovr & s_u3_rd_ready;
                                                                  
   s_mbx_rd_en_lsr      <= i_rd_en_lsr and not i_fifo_en;
   s_mbx_wr_en_err_brk  <= s_u1_push and s_u1_err_break and not s_fifo_en_state_clk;
   s_mbx_wr_en_err_frm  <= s_u1_push and s_u1_err_frm and not s_fifo_en_state_clk;
   s_mbx_wr_en_err_ovr  <= s_u1_push and s_u1_err_ovr;
   s_mbx_wr_en_err_par  <= s_u1_push and s_u1_err_par and not s_fifo_en_state_clk;

   s_rtl_fifo_empty     <= (not s_u3_rd_ready and not i_fifo_en) or (s_u2_rd_empty and i_fifo_en);
   s_rtl_fifo_pop       <= i_rd_en_rhr and i_fifo_en;
   s_rtl_fifo_push      <= s_u3_rd_ready and i_fifo_en and not s_u2_wr_full;
   
   s_rtl_rd_en_rhr      <= (i_rd_en_rhr and not i_fifo_en) or s_rtl_fifo_push;

   s_rtl_rx_sym         <= s_u1_err_break & s_u1_err_frm & s_u1_err_par &  
                           s_u1_dout;
                           
   s_rtl_wr_en_rhr      <= s_u1_push and s_u3_wr_ready;

   s_rx_sdin            <= i_loopback_rx when (i_loopback_en = '1') else
                           s_rx_sdin_filtered;

   s_timer_clr_fifo     <= s_fifo_en_xclk and s_u2_rd_empty;
               
      -- The following events restart the received character timeout timer or
      -- hold the timer at the reload value
   s_timer_restart      <= s_timer_clr_fifo or not s_rx_timer_int_en_xclk or not s_fifo_en_xclk
                           or
                           s_fifo_wr_en_rhr or s_ev_fifo_lvl_chng or not s_u9_wr_ready
                           or
                           (s_fifo_en_xclk and f_to_logic(unsigned(s_rx_timer) = 0));
                                                                                                 
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_FT:   
   process (all) 
   begin
      case i_fifo_threshold_sel is
         when c_fifo_threshold_1 =>
            s_fifo_trigger <= f_to_logic(unsigned(s_u2_fifo_rd_count) > (c_fifo_threshold_1_int - 1));
         when c_fifo_threshold_4 =>
            s_fifo_trigger <= f_to_logic(unsigned(s_u2_fifo_rd_count) > (c_fifo_threshold_4_int - 1));
         when c_fifo_threshold_8 =>
            s_fifo_trigger <= f_to_logic(unsigned(s_u2_fifo_rd_count) > (c_fifo_threshold_8_int - 1));
         when others =>
            s_fifo_trigger <= f_to_logic(unsigned(s_u2_fifo_rd_count) > (c_fifo_threshold_14_int - 1));
      end case;
   end process;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_FIFO_LSR:
   process (i_rst_n, i_clk)
   begin
      if (i_rst_n = '0') then
         s_fifo_lsr_flags        <= (others => '0');
         s_fifo_lsr_update       <= '0';
      elsif (rising_edge(i_clk)) then
         s_fifo_lsr_update    <= s_fifo_rd_en_rhr or (s_fifo_empty_prev and not s_rtl_fifo_empty);
         
         if ((s_fifo_lsr_update and not s_rtl_fifo_empty) = '1') then
            s_fifo_lsr_flags <= s_fifo_err_flags;
         elsif (i_rd_en_lsr = '1') then
            s_fifo_lsr_flags  <= (others => '0');
         end if;
      end if;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_RX_FILTER_OUT:
   process (all)
   begin
      case s_rx(3 downto 1) is
         when "111" | "110" | "101" | "011" =>
            s_rx_sdin_filtered   <= '1';
         when others =>
            s_rx_sdin_filtered   <= '0';
      end case;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_MAIN_CLK:
   process (i_clk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_ev_fifo_en         <= '0';
         s_fifo_dout          <= (others => '0');
         s_fifo_empty_prev    <= '0';
         s_fifo_en_prev_clk   <= '0';
         s_fifo_en_state_clk  <= '0';
         s_fifo_err_count     <= (others => '0');
         s_fifo_err_pop       <= '0';
         s_rd_en_lsr          <= '0';
         s_rx                 <= (others => '1');
      elsif (rising_edge(i_clk)) then
         s_ev_fifo_en         <= f_to_logic(s_fifo_en_state_clk /= s_fifo_en_prev_clk);
         
         
         s_fifo_empty_prev    <= s_rtl_fifo_empty;
         s_fifo_en_state_clk  <= i_fifo_en;
         s_fifo_en_prev_clk   <= s_fifo_en_state_clk;

         s_fifo_err_pop       <= (s_fifo_rd_en_rhr and f_to_logic(unsigned(s_fifo_err_flags) /= 0))
                                 or
                                 (s_rd_en_lsr and s_fifo_en_state_clk);

         s_rd_en_lsr          <= i_rd_en_lsr;
         
            -- Add a pipeline stage to relax timing closure with ECP5UM/-7
            -- Streaming read from the FIFO is not allowed anyway since the trailing edge of the ISA bus read
            -- pulse must be emulated for each read cycle
         if (s_u2_rd_empty = '0') then
            s_fifo_dout          <= s_u2_rd_dout;
         end if;
         
         s_rx(0)  <= i_rx;
         for i in s_rx'length - 1 downto 1 loop
            s_rx(i)  <= s_rx(i - 1);
         end loop;
         
         if (s_fifo_clr = '1') then
            s_fifo_err_count  <= (others => '0');
         else
            if ((s_fifo_err_pop = '1') and (s_u5_fifo_err_push = '0')) then
               if (unsigned(s_fifo_err_count) /= 0) then
                  s_fifo_err_count  <= std_logic_vector(unsigned(s_fifo_err_count) - 1);
               end if;
            elsif ((s_fifo_err_pop = '0') and (s_u5_fifo_err_push = '1')) then
               if (unsigned(s_fifo_err_count) /= g_mem_words) then
                  s_fifo_err_count  <= std_logic_vector(unsigned(s_fifo_err_count) + 1);
               end if;
            end if;
         end if;
      end if;
   end process;
         
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_MAIN_XCLK:
   process (i_rst_n, i_xclk)  
   begin
      if (i_rst_n = '0') then
         s_ev_fifo_lvl_chng      <= '0';
         s_fifo_en_sync          <= '0';
         s_fifo_en_xclk          <= '0';
         s_fifo_wr_count_reg     <= (others => '0');
         s_rx_timer              <= (others => '0');
         s_rx_timer_int          <= '0';
         s_rx_timer_int_en_sync  <= '0';
         s_rx_timer_int_en_xclk  <= '0';
         s_word_length_sync      <= (others => '0');
         s_word_length_xclk      <= (others => '0');
      elsif (rising_edge(i_xclk)) then
         s_fifo_en_sync          <= i_fifo_en;
         s_fifo_en_xclk          <= s_fifo_en_sync;
         s_rx_timer_int_en_sync  <= i_int_en_rcv_data;
         s_rx_timer_int_en_xclk  <= s_rx_timer_int_en_sync;
         s_word_length_sync      <= i_word_length;
         s_word_length_xclk      <= s_word_length_sync;
         
         if (i_xclk_en = '1') then       
            s_ev_fifo_lvl_chng   <= f_to_logic(unsigned(s_u2_wr_free) /= unsigned(s_fifo_wr_count_reg));
            s_fifo_wr_count_reg  <= s_u2_wr_free;
                                                 
            if (s_timer_restart = '1') then
               case s_word_length_xclk is
                  when c_word_size_5 =>
                     s_rx_timer  <= std_logic_vector(to_unsigned(c_rx_timer_load_5, s_rx_timer'length));
                  when c_word_size_6 =>
                     s_rx_timer  <= std_logic_vector(to_unsigned(c_rx_timer_load_6, s_rx_timer'length));
                  when c_word_size_7 =>
                     s_rx_timer  <= std_logic_vector(to_unsigned(c_rx_timer_load_7, s_rx_timer'length));
                  when others =>
                     s_rx_timer  <= std_logic_vector(to_unsigned(c_rx_timer_load_8, s_rx_timer'length));
               end case;
            elsif ((s_u1_sample_tick = '1') and (unsigned(s_rx_timer) > 0)) then
               s_rx_timer  <= std_logic_vector(unsigned(s_rx_timer) - 1);
            end if;
         end if;
      end if;
   end process;
    
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U1_RX_CORE:
   rx_ser_8250_core
      Port Map(
         i_rst_n        => i_rst_n,

         i_xclk         => i_xclk,
         i_xclk_en      => i_xclk_en,

         i_baud_chng    => i_baud_chng,
         i_par_en       => i_par_en,
         i_par_even     => i_par_even,
         i_par_stick    => i_par_stick,
         i_rhr_ready    => s_u3_wr_ready,
         i_rx           => s_rx_sdin,
         i_stop_bits    => i_stop_bits,
         i_word_length  => i_word_length,

         o_break        => s_u1_err_break,
         o_dout         => s_u1_dout,
         o_err_frm      => s_u1_err_frm,
         o_err_ovr      => s_u1_err_ovr,
         o_err_par      => s_u1_err_par,
         o_frame_eval   => s_u1_frame_eval,
         o_rhr_push     => s_u1_push,
         o_sample_tick  => s_u1_sample_tick
         );

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U2_FIFO:
   tspc_fifo_sync
      Generic Map (
         g_mem_dmram    => g_mem_dmram,
         g_mem_words    => g_mem_words, 
         g_tech_lib     => g_tech_lib
         )    
      Port Map ( 
         i_clk          => i_clk,
         i_rst_n        => i_rst_n,
         i_clr          => i_fifo_clr,
         
         i_rd_pop       => s_rtl_fifo_pop,        
         i_wr_din       => s_u3_rd_dout,
         i_wr_push      => s_rtl_fifo_push,

         o_rd_aempty    => open,
         o_rd_count     => s_u2_fifo_rd_count,
         o_rd_dout      => s_u2_rd_dout,
         o_rd_empty     => s_u2_rd_empty,
         o_rd_last      => open,
         o_wr_afull     => open,
         o_wr_free      => s_u2_wr_free,
         o_wr_full      => s_u2_wr_full,
         o_wr_last      => open
         );
        
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U3_RHR:
      -- Clock Domain crossing for Rx Buffer
   tspc_cdc_reg
      Port Map(
         i_rst_n        => i_rst_n, 

         i_rd_clk       => i_clk, 
         i_rd_clk_en    => c_tie_high, 
         i_rd_en        => s_rtl_rd_en_rhr, 

         i_wr_clk       => i_xclk, 
         i_wr_clk_en    => i_xclk_en, 
         i_wr_din       => s_rtl_rx_sym, 
         i_wr_en        => s_rtl_wr_en_rhr, 

         o_rd_dout      => s_u3_rd_dout, 
         o_rd_ready     => s_u3_rd_ready, 

         o_wr_ready     => s_u3_wr_ready 
         );

   U4_ERR_BRK:
      -- Clock Domain crossing for break interrupt
   tspc_cdc_ack
      Port Map(
         i_rst_n        => i_rst_n, 

         i_rd_clk       => i_clk, 
         i_rd_clk_en    => c_tie_high, 
         i_rd_en        => s_mbx_rd_en_lsr, 

         i_wr_clk       => i_xclk, 
         i_wr_clk_en    => i_xclk_en, 
         i_wr_din       => c_tie_low,
         i_wr_en        => s_mbx_wr_en_err_brk, 

         o_rd_dout      => open,
         o_rd_ready     => s_u4_err_brk, 

         o_wr_ready     => open 
         );

   U5_ERR_FIFO:
      -- Clock Domain crossing for FIFO error push
   tspc_cdc_ack
      Port Map(
         i_rst_n        => i_rst_n, 

         i_rd_clk       => i_clk, 
         i_rd_clk_en    => c_tie_high, 
         i_rd_en        => s_u5_fifo_err_push, 

         i_wr_clk       => i_xclk, 
         i_wr_clk_en    => i_xclk_en, 
         i_wr_din       => c_tie_low,
         i_wr_en        => s_fifo_err_push, 

         o_rd_dout      => open,
         o_rd_ready     => s_u5_fifo_err_push, 

         o_wr_ready     => open 
         );
                  
   U6_ERR_FRM:
      -- Clock Domain crossing for framing error
   tspc_cdc_ack
      Port Map(
         i_rst_n        => i_rst_n, 

         i_rd_clk       => i_clk, 
         i_rd_clk_en    => c_tie_high, 
         i_rd_en        => s_mbx_rd_en_lsr, 

         i_wr_clk       => i_xclk, 
         i_wr_clk_en    => i_xclk_en, 
         i_wr_din       => c_tie_low,
         i_wr_en        => s_mbx_wr_en_err_frm, 

         o_rd_dout      => open,
         o_rd_ready     => s_u6_err_frm, 

         o_wr_ready     => open 
         );

   U7_ERR_OVR:
      -- Clock Domain crossing for rx-fifo overrun error
   tspc_cdc_ack
      Port Map(
         i_rst_n        => i_rst_n, 

         i_rd_clk       => i_clk, 
         i_rd_clk_en    => c_tie_high, 
         i_rd_en        => s_err_ack_ovr, 

         i_wr_clk       => i_xclk, 
         i_wr_clk_en    => i_xclk_en, 
         i_wr_din       => c_tie_low,
         i_wr_en        => s_mbx_wr_en_err_ovr, 

         o_rd_dout      => open,
         o_rd_ready     => s_u7_err_ovr, 

         o_wr_ready     => open 
         );

   U8_ERR_PAR:
      -- Clock Domain crossing for receive parity error
   tspc_cdc_ack
      Port Map(
         i_rst_n        => i_rst_n, 

         i_rd_clk       => i_clk,
         i_rd_clk_en    => c_tie_high, 
         i_rd_en        => s_mbx_rd_en_lsr, 

         i_wr_clk       => i_xclk, 
         i_wr_clk_en    => i_xclk_en, 
         i_wr_din       => c_tie_low,
         i_wr_en        => s_mbx_wr_en_err_par, 

         o_rd_dout      => open,
         o_rd_ready     => s_u8_err_par, 

         o_wr_ready     => open 
         );

   U9_RX_TMOUT:
      -- Clock Domain crossing for read character timeout interrupt
   tspc_cdc_ack
      Port Map(
         i_rst_n        => i_rst_n, 

         i_rd_clk       => i_clk, 
         i_rd_clk_en    => c_tie_high, 
         i_rd_en        => s_int_rx_timer_ack, 

         i_wr_clk       => i_xclk, 
         i_wr_clk_en    => i_xclk_en, 
         i_wr_din       => c_tie_low,
         i_wr_en        => s_int_rx_timer_set, 

         o_rd_dout      => open,
         o_rd_ready     => s_u9_rx_timer, 

         o_wr_ready     => s_u9_wr_ready 
         );     
End Rtl;
