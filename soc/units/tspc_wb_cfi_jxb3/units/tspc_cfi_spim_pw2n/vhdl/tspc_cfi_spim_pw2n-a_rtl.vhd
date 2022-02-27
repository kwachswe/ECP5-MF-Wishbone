
--
--    Copyright Ing. Buero Gardiner 2017 - 2018
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_cfi_spim_pw2n-a_rtl.vhd 4788 2019-05-12 21:19:07Z  $
-- Generated   : $LastChangedDate: 2019-05-12 23:19:07 +0200 (Sun, 12 May 2019) $
-- Revision    : $LastChangedRevision: 4788 $
--
--------------------------------------------------------------------------------
--
-- Description :
--       i_clk          : 2x SPI Frequency
--       i_xfer_attrib  : data b"00", cmd b="01", resp b"10", cmd/resp "11"
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.numeric_std.all;
Use WORK.tspc_cfi_spim_pw2n_types.all;
Use WORK.tspc_utils.all;

Architecture Rtl of tspc_cfi_spim_pw2n is
   type t_cfi_fsm is (SC_RST, SC_IDLE, SC_DECODE, SC_CLK_EN, SC_ENABLE_SU, SC_ENABLE, 
                              SC_DAT_PRELOAD, SC_DAT_SAMPLE, SC_DAT_SHIFT, 
                              SC_WT_XFER_RDY, SC_DISABLE, SC_HOLD, SC_CLK_REL);
                              
   subtype t_phase_cnt  is std_logic_vector(f_vec_msb(maximum(g_ssel_hld, g_ssel_su)) downto 0);
   subtype t_spi_sreg   is std_logic_vector(i_tx_wdat'length - 1 downto 0);
   subtype t_spi_pos    is std_logic_vector(f_vec_msb(t_spi_sreg'length - 1) downto 0);
   
   constant c_shift_pos_init  : t_spi_pos := f_reg_load(t_spi_sreg'length - 1, t_spi_pos'length );

   signal s_cfi_fsm           : t_cfi_fsm;
   signal s_cfi_fsm_next      : t_cfi_fsm;
   signal s_cfi_xfer_done     : std_logic;
   signal s_cfi_xmit_rdy      : std_logic;
   signal s_mode_cpha         : std_logic;
   signal s_mode_cpol         : std_logic;
   signal s_mode_half_dplx    : std_logic;
   signal s_mode_lsb_first    : std_logic;
   signal s_mode_wr           : std_logic;   
   signal s_phase_ssel_sh     : t_phase_cnt;
   signal s_rx_dat_pend       : std_logic;
   signal s_rx_dat_push       : std_logic;
   signal s_rx_last           : std_logic;
   signal s_rx_push_en        : std_logic;
   signal s_shift_pos         : t_spi_pos;
   signal s_spi_dat_rx        : t_spi_sreg;
   signal s_spi_dat_tx        : t_spi_sreg;   
   signal s_spi_mosi_en       : std_logic;
   signal s_spi_mosi_lsb      : std_logic;
   signal s_spi_mosi_msb      : std_logic;   
   signal s_spi_sclk          : std_logic;
   signal s_spi_sclk_en       : std_logic;
   signal s_spi_ssel          : std_logic;
   signal s_spi_tick          : std_logic;
   signal s_tx_dat_pop        : std_logic;
   signal s_tx_last           : std_logic;
   signal s_tx_pop_en         : std_logic;
   signal s_xfer_attrib       : t_xfer_type;
   signal s_xfer_en           : std_logic;
   
Begin
   o_rxdat              <= f_resize(s_spi_dat_rx, o_rxdat'length );
   o_rxdat_push         <= s_rx_dat_push;
   
   o_spi_busy           <= not f_to_logic(s_cfi_fsm = SC_IDLE);
   o_spi_end_ev         <= c_tie_low;
   o_spi_mosi           <= s_spi_mosi_lsb when (s_mode_lsb_first = '1') else
                           s_spi_mosi_msb;
   o_spi_mosi_en        <= s_spi_mosi_en;
   o_spi_sclk           <= s_spi_sclk;
   o_spi_sclk_en        <= s_spi_sclk_en;
   o_spi_ssel           <= s_spi_ssel;
   
   o_txdat_pop          <= s_tx_dat_pop;
      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_spi_mosi_lsb       <= s_spi_dat_tx(0);
   s_spi_mosi_msb       <= s_spi_dat_tx(s_spi_dat_tx'left );
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_FSM:
   process(all)
   begin
      s_cfi_fsm_next    <= s_cfi_fsm;
      
      case (s_cfi_fsm) is
         when SC_IDLE =>
            if ((s_xfer_en = '1') and (s_cfi_xmit_rdy = '1')) then
               s_cfi_fsm_next <= SC_DECODE;
            end if;
         
         when SC_DECODE =>
            s_cfi_fsm_next <= SC_CLK_EN;

         when SC_CLK_EN => 
            if (g_ssel_su > 1) then
               s_cfi_fsm_next <= SC_ENABLE_SU;
            else
               s_cfi_fsm_next <= SC_ENABLE;
            end if;
            
         when SC_ENABLE_SU => 
            if (unsigned(s_phase_ssel_sh) < 2) then
               s_cfi_fsm_next <= SC_ENABLE;
            end if;

         when SC_ENABLE =>
            s_cfi_fsm_next <= SC_DAT_PRELOAD;
            
         when SC_DAT_PRELOAD =>
            s_cfi_fsm_next <= SC_DAT_SAMPLE;
                        
         when SC_DAT_SAMPLE =>
            s_cfi_fsm_next <= SC_DAT_SHIFT;   

         when SC_DAT_SHIFT =>
            if (unsigned(s_shift_pos) = 0) then
               if ((s_cfi_xfer_done = '1') or (s_xfer_en = '0')) then
                  if ((s_rx_push_en = '1') and (i_rx_rdy = '0')) then
                     s_cfi_fsm_next <= SC_WT_XFER_RDY;
                  else
                     s_cfi_fsm_next <= SC_DISABLE;
                  end if;
               elsif (s_cfi_xmit_rdy = '0') then
                  s_cfi_fsm_next <= SC_WT_XFER_RDY;
               else
                  s_cfi_fsm_next <= SC_DAT_SAMPLE;
               end if;
            else
               s_cfi_fsm_next <= SC_DAT_SAMPLE;
            end if;
         
         when SC_WT_XFER_RDY =>
            if (s_cfi_xmit_rdy = '1') then
               if ((s_cfi_xfer_done = '1') or (s_xfer_en = '0')) then
                  s_cfi_fsm_next <= SC_DISABLE;
               else
                  s_cfi_fsm_next <= SC_DAT_SAMPLE;
               end if;
            elsif ((s_xfer_en = '0') and (s_rx_dat_pend = '0')) then
               s_cfi_fsm_next <= SC_DISABLE;
            end if;

         when SC_DISABLE =>
            s_cfi_fsm_next <= SC_HOLD;
            
         when SC_HOLD => 
            if (unsigned(s_phase_ssel_sh) < 2) then
               s_cfi_fsm_next <= SC_CLK_REL;
            end if;
                     
         when SC_CLK_REL =>
            s_cfi_fsm_next <= SC_IDLE;
             
         when others =>
            s_cfi_fsm_next <= SC_IDLE;
      end case;
   end process;
      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_MAIN:
   process (i_clk, i_rst_n)
      procedure p_rst_clr is
      begin
         s_cfi_fsm            <= SC_RST;
         s_cfi_xfer_done      <= '0';
         s_cfi_xmit_rdy       <= '0';
         s_mode_cpha          <= '0';
         s_mode_cpol          <= '0';
         s_mode_half_dplx     <= '0';
         s_mode_lsb_first     <= '0';
         s_mode_wr            <= '0';       
         s_phase_ssel_sh      <= (others => '0');
         s_rx_dat_pend        <= '0';
         s_rx_dat_push        <= '0';
         s_rx_last            <= '0';
         s_rx_push_en         <= '0';
         s_shift_pos          <= (others => '0');
         s_spi_dat_rx         <= (others => '0');
         s_spi_dat_tx         <= (others => '0');
         s_spi_mosi_en        <= '0';
         s_spi_sclk           <= '0';
         s_spi_sclk_en        <= '0';
         s_spi_ssel           <= '0';
         s_spi_tick           <= '0';
         s_tx_dat_pop         <= '0';
         s_tx_last            <= '0';
         s_tx_pop_en          <= '0';
         s_xfer_attrib        <= (others => '0');
         s_xfer_en            <= '0';
      end procedure;
      
   begin
      if (i_rst_n = '0') then
         p_rst_clr;
      elsif (rising_edge(i_clk)) then
         if (i_clr = '1') then
            p_rst_clr;
            
         else
               -- Default assignments
            s_rx_dat_push     <= '0';
            s_spi_tick        <= '0';
            s_tx_dat_pop      <= '0';   
            s_xfer_en         <= i_xfer_en;
            
               -- Functional assignments
            s_cfi_fsm         <= s_cfi_fsm_next;
            
            if (s_mode_half_dplx = '1') then
               case s_xfer_attrib is
                  when c_xa_cmd =>
                     s_cfi_xfer_done   <= s_tx_last;
                     s_cfi_xmit_rdy    <= i_tx_rdy;
                     s_rx_push_en      <= '0';
                     s_tx_pop_en       <= '1';
                  
                  when c_xa_resp =>
                     s_cfi_xfer_done   <= s_tx_last;
                     s_cfi_xmit_rdy    <= i_rx_rdy;
                     s_rx_push_en      <= '1';
                     s_tx_pop_en       <= '0';
                     
                  when others => 
                     if (i_mode_wr = '1') then
                        s_cfi_xfer_done   <= s_tx_last;
                        s_cfi_xmit_rdy    <= i_tx_rdy;        
                        s_rx_push_en      <= '0';
                        s_tx_pop_en       <= '1';                        
                     else
                        s_cfi_xfer_done   <= s_rx_last;
                        s_cfi_xmit_rdy    <= i_rx_rdy;  
                        s_rx_push_en      <= '1';
                        s_tx_pop_en       <= '0';                        
                     end if;
               end case;
               
            else
               case s_xfer_attrib is
                  when c_xa_cmd =>
                     s_cfi_xfer_done   <= s_tx_last;
                     s_cfi_xmit_rdy    <= i_tx_rdy;
                     s_rx_push_en      <= '0';
                     s_tx_pop_en       <= '1';
                     
                  when c_xa_resp =>
                     s_cfi_xfer_done   <= s_rx_last;
                     s_cfi_xmit_rdy    <= i_rx_rdy;
                     s_rx_push_en      <= '1';
                     s_tx_pop_en       <= '0';
                     
                  when others => 
                     s_cfi_xfer_done   <= s_rx_last and s_tx_last;
                     s_cfi_xmit_rdy    <= i_rx_rdy and i_tx_rdy;
                     s_rx_push_en      <= '1';
                     s_tx_pop_en       <= '1';                     
               end case;
            end if;
            
            if ((s_spi_tick = '1') or (s_cfi_fsm = SC_IDLE))  then
               s_rx_last      <= i_rx_last;
               s_tx_last      <= i_tx_last;
               s_xfer_attrib  <= f_resize(i_xfer_attrib, s_xfer_attrib'length );
            end if;
            
            case s_cfi_fsm is
               when SC_IDLE =>
                  s_spi_sclk        <= i_mode_cpol;

               when SC_DECODE =>
                  s_mode_cpha          <= i_mode_cpha;
                  s_mode_cpol          <= i_mode_cpol;
                  s_mode_half_dplx     <= i_mode_half_dplx;
                  s_mode_lsb_first     <= i_mode_lsb_first;
                  s_mode_wr            <= i_mode_wr;    
                  s_phase_ssel_sh      <= f_reg_load(g_ssel_su, s_phase_ssel_sh'length );

               when SC_CLK_EN =>
                  s_spi_sclk_en     <= '1';
                  
               when SC_ENABLE_SU => 
                  s_phase_ssel_sh   <= f_decr(s_phase_ssel_sh);
                  s_spi_sclk        <= s_mode_cpol;
                  s_spi_ssel        <= '1';
                  
               when SC_ENABLE =>
                  s_spi_sclk        <= s_mode_cpol;
                  s_spi_ssel        <= '1';
                  
               when SC_DAT_PRELOAD =>
                  s_shift_pos       <= c_shift_pos_init;
                  s_spi_dat_tx      <= i_tx_wdat;
                  s_spi_mosi_en     <= s_mode_wr;
                     -- Invert the clock at the start of the first bit time if mode CPHA is active
                  s_spi_sclk        <= s_spi_sclk xor s_mode_cpha;                  
                  s_spi_tick        <= '1';
                  s_tx_dat_pop      <= s_tx_pop_en;
                  
               when SC_DAT_SAMPLE =>
                  s_spi_sclk     <= not s_spi_sclk;
                  s_rx_dat_pend  <= f_to_logic(unsigned(s_shift_pos) = 0) and s_rx_push_en and (not i_rx_rdy);
                  s_rx_dat_push  <= f_to_logic(unsigned(s_shift_pos) = 0) and s_rx_push_en and i_rx_rdy;
                  
                  if (s_mode_lsb_first = '1') then
                     s_spi_dat_rx   <= i_spi_miso & s_spi_dat_rx(s_spi_dat_rx'left downto 1);
                  else
                     s_spi_dat_rx   <= s_spi_dat_rx(s_spi_dat_rx'left - 1 downto 0) & i_spi_miso;
                  end if;
                  
               when SC_DAT_SHIFT =>            
                  s_shift_pos    <= std_logic_vector(unsigned(s_shift_pos) - 1);

                  if (s_mode_lsb_first = '1') then
                     s_spi_dat_tx   <= std_logic_vector(shift_right(unsigned(s_spi_dat_tx), 1));
                  else
                     s_spi_dat_tx   <= std_logic_vector(shift_left(unsigned(s_spi_dat_tx), 1));
                  end if;
                  
                  if (unsigned(s_shift_pos) = 0) then
                     s_shift_pos       <= c_shift_pos_init;
                     s_spi_dat_tx      <= i_tx_wdat;
                     s_spi_tick        <= '1';
                     s_tx_dat_pop       <= s_tx_pop_en and i_tx_rdy;
                     
                     if ((s_mode_cpha = '0') or ((s_cfi_xmit_rdy = '1') and (s_cfi_xfer_done = '0'))) then
                           -- Invert the clock if the transfer is still enabled
                        s_spi_sclk  <= s_spi_sclk xor s_xfer_en;
                     end if;                     
                  else
                     s_spi_sclk  <= not s_spi_sclk;                  
                  end if;

               when SC_WT_XFER_RDY =>
                  if (s_cfi_xmit_rdy = '1') then
                     s_rx_dat_push  <= s_rx_push_en and i_rx_rdy and s_rx_dat_pend;
                     s_spi_tick     <= s_xfer_en and (not s_cfi_xfer_done);
                     s_tx_dat_pop   <= s_tx_pop_en and i_tx_rdy;
                     
                     if ((s_tx_pop_en= '1') and (i_tx_rdy = '1')) then
                        s_spi_dat_tx      <= i_tx_wdat;                     
                     end if;
                     
                     if ((s_xfer_en = '1') and (s_cfi_xfer_done = '0') and (s_mode_cpha = '1')) then
                        s_spi_sclk  <= not s_spi_sclk;
                     end if;
                  end if;
                  
               when SC_DISABLE =>
                  s_phase_ssel_sh   <= f_reg_load(g_ssel_hld, s_phase_ssel_sh'length );
                  s_spi_ssel        <= '0';

               when SC_HOLD => 
                  s_phase_ssel_sh   <= f_decr(s_phase_ssel_sh);
                  s_spi_mosi_en     <= '0';

               when SC_CLK_REL =>
                  s_spi_sclk_en     <= '0';
                  
               when others =>   
                  s_spi_sclk     <= s_mode_cpol;
                  
            end case;
         end if;
      end if;
   end process;
End Rtl;
