
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tx_ser_8250_core-a_rtl.vhd 5378 2021-12-13 00:15:46Z  $
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
Use WORK.tx_ser_8250_core_types.all;
Use WORK.tspc_utils.all;

Architecture Rtl of tx_ser_8250_core is
   type t_tx_fsm  is (TX_IDLE, TX_BREAK,
                      TX_START, TX_SHIFT, TX_PAR, TX_STOP1, TX_STOP2);
                      
   signal s_bit_count      : std_logic_vector(3 downto 0);
   signal s_fsm_tx         : t_tx_fsm;
   signal s_fsm_tx_next    : t_tx_fsm;
   signal s_sample_count   : std_logic_vector(3 downto 0);
   signal s_tx_reg_load    : std_logic_vector(9 downto 0);
   signal s_tx_shift_reg   : std_logic_vector(9 downto 0);
   
Begin  
   o_thr_pop   <= f_to_logic(s_fsm_tx = TX_START) and
                  f_to_logic(unsigned(s_sample_count) = 7);

   o_tsr_empty <= f_to_logic(s_fsm_tx = TX_IDLE);
                  
   o_tx        <= s_tx_shift_reg(0);
   
   o_tx_en     <= not f_to_logic(s_fsm_tx = TX_IDLE);
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   P_FSM_NEXT:
   process (all)
      variable v_fsm_tx_next     : t_tx_fsm;
   begin
      v_fsm_tx_next     := s_fsm_tx;
      case s_fsm_tx is
         when TX_IDLE =>
            if (i_thr_ready = '1') then
               v_fsm_tx_next     := TX_START;
            end if;
         
         when TX_PAR =>
            if (unsigned(s_sample_count) = 15) then
              v_fsm_tx_next  := TX_STOP1;
            end if;
                        
         when TX_START =>
            if (unsigned(s_sample_count) = 15) then
               v_fsm_tx_next     := TX_SHIFT;
            end if;
            
         when TX_SHIFT =>
            if ((unsigned(s_sample_count) = 15) and 
                (unsigned(s_bit_count) = 0)) then
               if (i_par_en = '1') then
                  v_fsm_tx_next     := TX_PAR;
               else
                  v_fsm_tx_next     := TX_STOP1;
               end if;
            end if;
                     
         when TX_STOP1 =>
            if (unsigned(s_sample_count) = 15) then
               if (i_stop_bits = '1') then
                  v_fsm_tx_next     := TX_STOP2;
               else
                  v_fsm_tx_next     := TX_IDLE;
               end if;
            end if;
                     
         when TX_STOP2 =>
            if (unsigned(s_sample_count) = 15) then
              v_fsm_tx_next  := TX_IDLE;
            end if;
            
         when TX_BREAK =>
            if (i_send_break = '0') then
               v_fsm_tx_next     := TX_IDLE;
            end if;
            
         when others =>
      end case;
      
      s_fsm_tx_next     <= v_fsm_tx_next;
   end process;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   P_TX_REG_LOAD:
   process (all)
      variable v_din : std_logic_vector(i_din'length -1 downto 0);
      variable v_par : std_logic;
   begin
      case i_word_length is
         when c_word_size_5 =>
            v_din := "000" & i_din(4 downto 0);
         when c_word_size_6 =>
            v_din := "00" & i_din(5 downto 0);
         when c_word_size_7 =>
            v_din := '0' & i_din(6 downto 0);
         when others =>
            v_din := i_din;
      end case;
      
      if (i_par_en = '1') then
         if (i_par_stick = '1') then
            v_par := not i_par_even;
         else
            v_par := (xor(v_din & not i_par_even));
         end if;
      else
         v_par := '1';
      end if;
      
      if (i_send_break = '1') then
         s_tx_reg_load  <= (others => '0');
      else
         case i_word_length is
            when c_word_size_5 =>
               if (i_par_en = '1') then
                  s_tx_reg_load  <= "111" & v_par & v_din(4 downto 0) & '0';
               else
                  s_tx_reg_load  <= "1111" & v_din(4 downto 0) & '0';
               end if;
            when c_word_size_6 =>
               if (i_par_en = '1') then
                  s_tx_reg_load  <= "11" & v_par & v_din(5 downto 0) & '0';
               else
                  s_tx_reg_load  <= "111" & v_din(5 downto 0) & '0';
               end if;
            when c_word_size_7 =>
               if (i_par_en = '1') then
                  s_tx_reg_load  <= '1' & v_par & v_din(6 downto 0) & '0';
               else
                  s_tx_reg_load  <= "11" & v_din(6 downto 0) & '0';
               end if;
            when others =>
               if (i_par_en = '1') then
                  s_tx_reg_load  <= v_par & v_din(7 downto 0) & '0';
               else
                  s_tx_reg_load  <= '1' & v_din(7 downto 0) & '0';
               end if;
         end case;         
      end if;
   end process;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   P_MAIN:
   process (i_xclk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_bit_count    <= (others => '0');
         s_fsm_tx       <= TX_IDLE;
         s_sample_count <= (others => '0');
         s_tx_shift_reg <= (others => '1');
      elsif (rising_edge(i_xclk)) then
         if (i_xclk_en = '1') then
         
               -- Load the shift register on the following transitions
            case s_fsm_tx_next is
               when TX_IDLE => 
                  if (s_fsm_tx /= TX_IDLE) then
                     s_tx_shift_reg <= (others => '1');
                  end if;
                  
               when TX_START => 
                  if (s_fsm_tx /= TX_START) then
                     s_tx_shift_reg <= s_tx_reg_load;
                  end if;

               when TX_BREAK => 
                  if (s_fsm_tx /= TX_BREAK) then
                     s_tx_shift_reg <= (others => '0');
                  end if;
               when others =>
            end case;
            
            case s_fsm_tx is
               when TX_START | TX_PAR => 
                  if (unsigned(s_sample_count) = 15) then
                     s_tx_shift_reg <= '1' & s_tx_shift_reg(s_tx_shift_reg'left downto 1);
                  end if;
                  
               when TX_SHIFT => 
                  if (unsigned(s_sample_count) = 15) then
                     s_bit_count <= std_logic_vector(unsigned(s_bit_count) - 1);
                     s_tx_shift_reg <= '1' & s_tx_shift_reg(s_tx_shift_reg'left downto 1);
                  end if;
                  
               when others =>
                  case i_word_length is
                     when c_word_size_5 =>
                        s_bit_count <= std_logic_vector(to_unsigned(c_word_size_int_5 - 1, s_bit_count'length));
                     when c_word_size_6 =>
                        s_bit_count <= std_logic_vector(to_unsigned(c_word_size_int_6 - 1, s_bit_count'length));
                     when c_word_size_7 =>
                        s_bit_count <= std_logic_vector(to_unsigned(c_word_size_int_7 - 1, s_bit_count'length));
                     when others =>
                        s_bit_count <= std_logic_vector(to_unsigned(c_word_size_int_8 - 1, s_bit_count'length));
                  end case;
            end case;
            
               -- When to update the sample counter (x16 clock)
            case s_fsm_tx is
               when TX_START | TX_SHIFT | TX_PAR | TX_STOP1 | TX_STOP2 => 
                  s_sample_count <= std_logic_vector(unsigned(s_sample_count) + 1);
               when others => 
                  s_sample_count <= (others => '0');
            end case;
                        
            s_fsm_tx    <= s_fsm_tx_next;
         end if;
         
         if (i_baud_chng = '1') then
            s_bit_count    <= (others => '0');
            s_fsm_tx       <= TX_IDLE;
            s_sample_count <= (others => '0');
         end if;         
      end if;                
   end process;
End Rtl;   
