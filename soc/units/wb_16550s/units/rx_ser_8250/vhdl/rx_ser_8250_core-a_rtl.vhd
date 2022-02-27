
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: rx_ser_8250_core-a_rtl.vhd 5378 2021-12-13 00:15:46Z  $
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
Use WORK.rx_ser_8250_core_types.all;
Use WORK.tspc_utils.all;

Architecture Rtl of rx_ser_8250_core is    
   type t_rx_fsm  is (RX_IDLE, RX_SYNC, 
                      RX_COLLECT, RX_START, RX_WAIT_START, 
                      RX_BREAK);

   constant c_sample_phase       : natural := 7;
   constant c_push_phase         : natural := c_sample_phase + 1;
   
   signal s_bit_count            : std_logic_vector(3 downto 0);
   signal s_bit_count_load       : std_logic_vector(s_bit_count'range);
   signal s_chk_par              : std_logic;
   signal s_chk_start            : std_logic;
   signal s_chk_stop             : std_logic;
   signal s_dout                 : std_logic_vector(o_dout'length - 1 downto 0);
   signal s_edge_falling         : std_logic;
   signal s_edge_rising          : std_logic;
   signal s_ev_sdin_fall         : std_logic;
   signal s_frame_eval_collect   : std_logic;
   signal s_frame_eval_sync      : std_logic;
   signal s_frame_match          : std_logic;
   signal s_fsm_rx               : t_rx_fsm;
   signal s_fsm_rx_next          : t_rx_fsm;
   signal s_mark                 : std_logic;
   signal s_mark_count           : std_logic_vector(3 downto 0);
   signal s_rhr_push_break       : std_logic;
   signal s_rhr_push_collect     : std_logic;
   signal s_rhr_push_sync        : std_logic;
   signal s_rx_data              : std_logic;
   signal s_rx_data_prev         : std_logic;
   signal s_rx_data_sync         : std_logic;
   signal s_rx_shift_reg         : std_logic_vector(11 downto 0);
   signal s_sample_count         : std_logic_vector(3 downto 0);
   signal s_space                : std_logic;
   signal s_space_count          : std_logic_vector(3 downto 0);
   signal s_stop_bit             : std_logic;
   signal s_symbol_match         : std_logic;

Begin
   o_break        <= f_to_logic(s_fsm_rx = RX_BREAK);
   
   o_dout         <= s_dout;
   
   o_frame_eval   <= s_frame_eval_collect or s_frame_eval_sync;
                     
   o_err_frm      <= not s_frame_match and s_rhr_push_collect;
                                       
   o_err_ovr      <= s_frame_match and not i_rhr_ready
                                   and f_to_logic(s_fsm_rx = RX_COLLECT)
                                   and f_to_logic(unsigned(s_bit_count) = 0);
                                    
   o_err_par      <= s_frame_match and not s_symbol_match 
                                   and f_to_logic(unsigned(s_bit_count) = 0);   

   o_rhr_push     <= s_rhr_push_collect or s_rhr_push_sync or s_rhr_push_break; 

   o_sample_tick  <= f_to_logic(unsigned(not s_sample_count) = 0);
                                      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         -- When a character has been completely received, the 'Start' bit is at bit position [1]
         -- Bit [0] is used to measure MARK/SPACE over all stop bits
   s_chk_start          <= f_to_logic(s_rx_shift_reg(1) = '0');
            
   s_ev_sdin_fall       <= s_rx_data_prev and not s_rx_data;
   
   s_frame_eval_collect <= f_to_logic(s_fsm_rx = RX_COLLECT) and
                           f_to_logic(unsigned(s_bit_count) = 0);

   s_frame_eval_sync    <= f_to_logic(s_fsm_rx = RX_SYNC) and
                           f_to_logic(s_frame_match = '1');

   s_frame_match        <= s_chk_start and s_chk_stop;

   s_rhr_push_break     <= s_space and (f_to_logic(s_fsm_rx = RX_SYNC) or 
                                        f_to_logic(s_fsm_rx = RX_COLLECT));
   
   s_rhr_push_collect   <= s_frame_match and f_to_logic(unsigned(s_sample_count) > c_sample_phase)
                                         and f_to_logic(s_fsm_rx = RX_COLLECT)
                                         and f_to_logic(unsigned(s_bit_count) = 0); 

   s_rhr_push_sync      <= f_to_logic(s_fsm_rx = RX_SYNC) and
                           f_to_logic(unsigned(s_bit_count) = 0) and
                           f_to_logic(unsigned(s_sample_count) > c_sample_phase) and
                           f_to_logic(s_frame_match = '1');

   s_symbol_match       <= s_chk_start and s_chk_par and s_chk_stop;
                                                                                                              
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_FSM_NEXT:
   process (s_bit_count, s_edge_rising, s_ev_sdin_fall, s_frame_match, s_fsm_rx, 
            s_mark, s_sample_count, s_space, s_stop_bit, s_frame_match)

   begin
      s_fsm_rx_next  <= s_fsm_rx;

      case s_fsm_rx is
         when RX_IDLE =>
            if (s_ev_sdin_fall = '1') then
               s_fsm_rx_next  <= RX_SYNC;
            end if;

         when RX_SYNC =>
            if ((s_frame_match = '1') and (unsigned(s_bit_count) = 0)
                                      and (unsigned(s_sample_count) > c_sample_phase)) then
               s_fsm_rx_next  <= RX_WAIT_START;
            end if;

         when RX_START =>
            s_fsm_rx_next  <= RX_COLLECT;

         when RX_COLLECT =>
            if (unsigned(s_bit_count) = 0) then
               if (s_frame_match = '1') then
                  s_fsm_rx_next  <= RX_WAIT_START;
               elsif (unsigned(not s_sample_count) = 0) then
                     -- If the start and stop bits don't look ok, re-synchronise
                     -- by returning to IDLE and waiting for the next falling edge
                  s_fsm_rx_next  <= RX_IDLE;
               end if;
            end if;

         when RX_WAIT_START =>
            if (s_stop_bit = '0') then
                  -- The next start-bit is in the leftmost (i.e. Stop Bit) position
                  -- We shift in from the MSB side. The actual position of the MSB
                  -- depends on the word size, whether parity is enabled etc.
               s_fsm_rx_next  <= RX_START;
            end if;

         when RX_BREAK =>
            if (s_ev_sdin_fall = '1') then
               s_fsm_rx_next  <= RX_SYNC;
            elsif (s_edge_rising = '1') then
               s_fsm_rx_next  <= RX_IDLE;
            end if;     
                                                           
         when others =>
      end case;
      
         -- Falling edge (start bit) always wins
      if (s_space = '1') then
         if (s_ev_sdin_fall = '1') then
            s_fsm_rx_next  <= RX_SYNC;
         else
            s_fsm_rx_next  <= RX_BREAK;
         end if;
      elsif (s_mark = '1') then
         if (s_ev_sdin_fall = '1') then
            s_fsm_rx_next  <= RX_SYNC;
         else
            s_fsm_rx_next  <= RX_IDLE;
         end if;
      end if;
   end process;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_DOUT:
   process (i_word_length, s_rx_shift_reg)
   begin
      case i_word_length is
         when c_word_size_5 =>
            s_dout   <= "000" & s_rx_shift_reg(6 downto 2);
         when c_word_size_6 =>
            s_dout   <= "00" & s_rx_shift_reg(7 downto 2);
         when c_word_size_7 =>
            s_dout   <= '0' & s_rx_shift_reg(8 downto 2);
         when others =>
            s_dout   <= s_rx_shift_reg(9 downto 2);
      end case;
   end process;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_SYM_CHK:
   process (i_par_en, i_par_even, i_par_stick, i_stop_bits, i_word_length,
            s_mark_count, s_rx_shift_reg, s_space_count)
      variable v_total_length    : positive;
   begin
      
      if (i_par_en = '0') then
         s_chk_par   <= '1';
      else
         if (i_par_stick = '0') then
            case i_word_length is
               when c_word_size_5 =>
                  s_chk_par   <= f_to_logic((xor(s_rx_shift_reg(7 downto 2))) /= i_par_even);
               when c_word_size_6 =>
                  s_chk_par   <= f_to_logic((xor(s_rx_shift_reg(8 downto 2))) /= i_par_even);
               when c_word_size_7 =>
                  s_chk_par   <= f_to_logic((xor(s_rx_shift_reg(9 downto 2))) /= i_par_even);
               when others =>
                  s_chk_par   <= f_to_logic((xor(s_rx_shift_reg(10 downto 2))) /= i_par_even);
            end case;
         else
            case i_word_length is
               when c_word_size_5 =>
                  s_chk_par   <= f_to_logic(s_rx_shift_reg(7) /= i_par_even);
               when c_word_size_6 =>
                  s_chk_par   <= f_to_logic(s_rx_shift_reg(8) /= i_par_even);
               when c_word_size_7 =>
                  s_chk_par   <= f_to_logic(s_rx_shift_reg(9) /= i_par_even);
               when others =>
                  s_chk_par   <= f_to_logic(s_rx_shift_reg(10) /= i_par_even);
            end case;
         end if;
      end if;

         -- Check and extract the Stop Bit
      case i_word_length is
         when c_word_size_5 =>
            if (i_par_en = '0') then
               s_bit_count_load  <= std_logic_vector(to_unsigned(6, s_bit_count_load'length));
               s_stop_bit        <= s_rx_shift_reg(7);
               s_chk_stop        <= f_to_logic(s_rx_shift_reg(7) = '1');
            else
               s_bit_count_load  <= std_logic_vector(to_unsigned(7, s_bit_count_load'length));
               s_stop_bit        <= s_rx_shift_reg(8);
               s_chk_stop        <= f_to_logic(s_rx_shift_reg(8) = '1');
            end if;

         when c_word_size_6 =>
            if (i_par_en = '0') then
               s_bit_count_load  <= std_logic_vector(to_unsigned(7, s_bit_count_load'length));
               s_stop_bit        <= s_rx_shift_reg(8);
               s_chk_stop        <= f_to_logic(s_rx_shift_reg(8) = '1');
            else
               s_bit_count_load  <= std_logic_vector(to_unsigned(8, s_bit_count_load'length));
               s_stop_bit        <= s_rx_shift_reg(9);
               s_chk_stop        <= f_to_logic(s_rx_shift_reg(9) = '1');
            end if;

         when c_word_size_7 =>
            if (i_par_en = '0') then
               s_bit_count_load  <= std_logic_vector(to_unsigned(8, s_bit_count_load'length));
               s_stop_bit        <= s_rx_shift_reg(9);
               s_chk_stop        <= f_to_logic(s_rx_shift_reg(9) = '1');
            else
               s_bit_count_load  <= std_logic_vector(to_unsigned(9, s_bit_count_load'length));
               s_stop_bit        <= s_rx_shift_reg(10);
               s_chk_stop        <= f_to_logic(s_rx_shift_reg(10) = '1');
            end if;
            
         when others =>
            if (i_par_en = '0') then
               s_bit_count_load  <= std_logic_vector(to_unsigned(9, s_bit_count_load'length));
               s_stop_bit        <= s_rx_shift_reg(10);
               s_chk_stop        <= f_to_logic(s_rx_shift_reg(10) = '1');
            else
               s_bit_count_load  <= std_logic_vector(to_unsigned(10, s_bit_count_load'length));
               s_stop_bit        <= s_rx_shift_reg(11);
               s_chk_stop        <= f_to_logic(s_rx_shift_reg(11) = '1');
            end if;
      end case;
      
      v_total_length := f_get_word_size(i_word_length, i_par_en, i_stop_bits);
      case v_total_length is
         when 6 =>
            s_mark   <= f_to_logic(unsigned(s_mark_count) = 7);
            s_space  <= f_to_logic(unsigned(s_space_count) = 7);
         when 7 =>
            s_mark   <= f_to_logic(unsigned(s_mark_count) = 8);
            s_space  <= f_to_logic(unsigned(s_space_count) = 8);
         when 8 =>
            s_mark   <= f_to_logic(unsigned(s_mark_count) = 9);
            s_space  <= f_to_logic(unsigned(s_space_count) = 9);
         when 9 =>
            s_mark   <= f_to_logic(unsigned(s_mark_count) = 10);
            s_space  <= f_to_logic(unsigned(s_space_count) = 10);
         when 10 =>
            s_mark   <= f_to_logic(unsigned(s_mark_count) = 11);
            s_space  <= f_to_logic(unsigned(s_space_count) = 11);
         when others =>
            s_mark   <= f_to_logic(unsigned(s_mark_count) = 12);
            s_space  <= f_to_logic(unsigned(s_space_count) = 12);
      end case;
   end process;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   P_MAIN:
   process (i_xclk, i_rst_n)
      variable v_rx_shift_reg_in : std_logic_vector(s_rx_shift_reg'range);
      variable v_sample_valid    : std_logic;
      variable v_sample_value    : std_logic;
   begin
      if (i_rst_n = '0') then
         s_bit_count    <= (others => '0');
         s_edge_falling <= '0';
         s_edge_rising  <= '0';
         s_fsm_rx       <= RX_IDLE;
         s_mark_count   <= (others => '0');
         s_space_count  <= (others => '0');
         s_rx_data      <= '1';
         s_rx_data_prev <= '1';
         s_rx_data_sync <= '1';
         s_rx_shift_reg <= (others => '1');
         s_sample_count <= (others => '0');
      elsif (rising_edge(i_xclk)) then
         s_rx_data      <= s_rx_data_sync;
         s_rx_data_sync <= i_rx;
         if (i_xclk_en = '1') then
            s_sample_count <= std_logic_vector(unsigned(s_sample_count) + 1);

               --          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
               --    Synchronisation and edge detection
               --          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            s_rx_data_prev <= s_rx_data;
            case s_rx_data is
               when '0' =>
                  if (s_rx_data_prev = '1') then
                     s_edge_falling <= '1';
                     s_edge_rising  <= '0';
                     s_mark_count   <= (others => '0');
                     s_space_count  <= (others => '0');
                  end if;
               when '1' =>
                  if (s_rx_data_prev = '0') then
                     s_edge_falling <= '0';
                     s_edge_rising  <= '1';
                     s_mark_count   <= (others => '0');
                     s_space_count  <= (others => '0');
                  end if;
               when others =>
            end case;
            
               --          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
               --    Collect the incoming data symbol
               --          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            if (to_integer(unsigned(s_sample_count)) = c_sample_phase) then
                  -- A sample is considered valid if its state is consistent with the last
                  -- edge (rising/falling) observed
               v_sample_valid := '0';
               case s_rx_data is
                  when '0' =>
                     v_sample_value := '0';
                     if (s_edge_falling = '1') then
                        v_sample_valid := '1';
                     end if;
                     
                     s_mark_count   <= (others => '0');
                     if (s_space = '0') then
                        s_space_count  <= std_logic_vector(unsigned(s_space_count) + 1);
                     end if;
                     
                  when '1' =>
                     v_sample_value := '1';
                     if (s_edge_rising = '1') then
                        v_sample_valid := '1';
                     end if;

                     if (s_mark = '0') then
                        s_mark_count   <= std_logic_vector(unsigned(s_mark_count) + 1);
                     end if;
                     s_space_count  <= (others => '0');
                     
                  when others =>
               end case;

                  --          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  --    Capture a valid bit
                  --          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~               
               if (v_sample_valid = '1') then
                  case i_word_length is
                     when c_word_size_5 =>
                        if (i_par_en = '0') then
                           v_rx_shift_reg_in := "1111" & v_sample_value & s_rx_shift_reg(7 downto 1);
                        else
                           v_rx_shift_reg_in := "111" & v_sample_value & s_rx_shift_reg(8 downto 1);
                        end if;

                     when c_word_size_6 =>
                        if (i_par_en = '0') then
                           v_rx_shift_reg_in := "111" & v_sample_value & s_rx_shift_reg(8 downto 1);
                        else
                           v_rx_shift_reg_in := "11" & v_sample_value & s_rx_shift_reg(9 downto 1);
                        end if;

                     when c_word_size_7 =>
                        if (i_par_en = '0') then
                           v_rx_shift_reg_in := "11" & v_sample_value & s_rx_shift_reg(9 downto 1);
                        else
                           v_rx_shift_reg_in := '1' & v_sample_value & s_rx_shift_reg(10 downto 1);
                        end if;

                     when others =>
                        if (i_par_en = '0') then
                           v_rx_shift_reg_in := '1' & v_sample_value & s_rx_shift_reg(10 downto 1);
                        else
                           v_rx_shift_reg_in := v_sample_value & s_rx_shift_reg(11 downto 1);
                        end if;
                        
                  end case;
                  s_rx_shift_reg <= v_rx_shift_reg_in;
               end if;
            elsif (to_integer(unsigned(s_sample_count)) < c_sample_phase) then
               if (s_fsm_rx = RX_IDLE) then
                  s_rx_shift_reg <= (others => '1');
               end if;
            end if;
            
            
            case s_fsm_rx is                          
               when RX_START  =>
                  
               when RX_WAIT_START  =>
                  if (s_ev_sdin_fall = '1') then
                     s_bit_count <= s_bit_count_load;
                     s_sample_count <= (others => '0');
                  end if;
               
               when RX_SYNC   => 
                     -- While we are calibrating, resync on any falling edge once we have  
                     -- received one character. We are not yet sure
                     -- which one is the start bit
                  if ((s_ev_sdin_fall = '1') and (unsigned(s_bit_count) = 0)) then
                     s_sample_count <= (others => '0');
                  end if;
                  if ((unsigned(s_bit_count) /= 0) and
                      (unsigned(s_sample_count) = 15)) then
                     s_bit_count <= std_logic_vector(unsigned(s_bit_count) - 1);
                  end if;
                  
               when RX_COLLECT =>
                  if ((unsigned(s_bit_count) /= 0) and
                      (unsigned(s_sample_count) = 15)) then
                     s_bit_count <= std_logic_vector(unsigned(s_bit_count) - 1);
                  end if;
                  
               when others =>
                  s_rx_shift_reg <= (others => '0');
                  
                  if (s_ev_sdin_fall = '1') then
                     s_bit_count    <= s_bit_count_load;
                     s_sample_count <= (others => '0');
                  else
                     s_bit_count <= (others => '1');
                  end if;
            end case;
            
            s_fsm_rx       <= s_fsm_rx_next;
         end if;
         
         if (i_baud_chng = '1') then
            s_bit_count    <= (others => '0');
            s_fsm_rx       <= RX_IDLE;
            s_mark_count   <= (others => '0');
            s_space_count  <= (others => '0');
            s_sample_count <= (others => '0');
         end if;
      end if;                
   end process;
End Rtl;
