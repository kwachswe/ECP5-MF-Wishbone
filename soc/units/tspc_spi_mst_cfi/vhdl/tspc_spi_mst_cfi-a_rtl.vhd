
--
--    Copyright Ing. Buero Gardiner 2017 - 2018
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_spi_mst_cfi-a_rtl.vhd 5345 2021-11-20 22:57:11Z  $
-- Generated   : $LastChangedDate: 2021-11-20 23:57:11 +0100 (Sat, 20 Nov 2021) $
-- Revision    : $LastChangedRevision: 5345 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
-- Notes:
--    When MSB first
--       Xmit Data are taken from the dat_tx MSB
--       Rcv Data are shifted into the dat_rx LSB
--    When LSB First
--       Xmit Data are taken from the dat_tx LSB
--       Rcv Data are shifted into the dat_tx MSB
--
--    For intermediate or variable shift sizes, a wrapper logic could for   
--    instance contain a barrel shifter
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.numeric_std.all;
Use WORK.tspc_utils.all;

Architecture Rtl of tspc_spi_mst_cfi is
   
   type t_spi_fsm is (SC_RST,  SC_IDLE, 
                               SC_DECODE, SC_CLK_EN, SC_ENABLE_SU, SC_ENABLE, 
                               SC_CMD_PRELOAD, SC_CMD_SAMPLE, SC_CMD_SHIFT,
                               SC_ADR_SAMPLE, SC_ADR_SHIFT, 
                               SC_DAT_PRELOAD, SC_DAT_SAMPLE, SC_DAT_SHIFT, 
                               SC_CHK_CONT, SC_DISABLE, SC_HOLD, SC_CLK_REL);
   
   subtype t_ssel_su is integer range 0 to g_ssel_su;

   signal s_adr_pop           : std_logic;
   signal s_adr_push          : std_logic;
   signal s_adr_rdy           : std_logic;  
   signal s_cmd_pop           : std_logic;
   signal s_cnt_ssel_sh       : t_ssel_su;
   signal s_mode_cpha         : std_logic;
   signal s_mode_cpol         : std_logic;  
   signal s_mode_lsb_first    : std_logic;
   signal s_mode_wr           : std_logic;
   signal s_mode_xfer_sz      : std_logic_vector(i_mode_xfer_sz'length - 1 downto 0);
   signal s_rx_last_done      : std_logic;
   signal s_rxdat_push        : std_logic;
   signal s_shift_load_dat    : std_logic_vector(f_vec_msb(i_tx_wdat'length - 1) downto 0);
   signal s_shift_pos_adr     : std_logic_vector(f_vec_msb(i_adr_in'length - 1) downto 0);
   signal s_shift_pos_cmd     : std_logic_vector(f_vec_msb(i_cmd_in'length - 1) downto 0);
   signal s_shift_pos_dat     : std_logic_vector(f_vec_msb(i_tx_wdat'length - 1) downto 0);
   signal s_shift_tick        : std_logic;
   signal s_spi_adr_phase     : std_logic;
   signal s_spi_adr_rx        : std_logic_vector(o_adr_out'length - 1 downto 0);
   signal s_spi_adr_tx        : std_logic_vector(i_adr_in'length - 1 downto 0);
   signal s_spi_cmd_phase     : std_logic;
   signal s_spi_cmd           : std_logic_vector(i_cmd_in'length - 1 downto 0);
   signal s_spi_dat_rx        : std_logic_vector(o_rxdat'length - 1 downto 0);
   signal s_spi_dat_tx        : std_logic_vector(i_tx_wdat'length - 1 downto 0);
   signal s_spi_data_rdy      : std_logic;
   signal s_spi_fsm           : t_spi_fsm;
   signal s_spi_fsm_next      : t_spi_fsm;
   signal s_spi_init_rdy      : std_logic;
   signal s_spi_mosi_en       : std_logic;
   signal s_spi_mosi_lsb      : std_logic;
   signal s_spi_mosi_msb      : std_logic;
   signal s_spi_sclk          : std_logic;
   signal s_spi_sclk_en       : std_logic;
   signal s_spi_ssel          : std_logic;
   signal s_spi_sta           : std_logic_vector(i_cmd_in'length - 1 downto 0);
   signal s_sta_valid         : std_logic;
   signal s_txdat_pop         : std_logic;
   
Begin
   o_adr_out         <= f_cp_resize(s_spi_adr_rx, o_adr_out'length );
   o_adr_pop         <= s_adr_pop;
   o_adr_push        <= s_adr_push;
   
   o_cmd_pop         <= s_cmd_pop;
   
   o_rxdat           <= s_spi_dat_rx;
   
   o_rxdat_push      <= s_rxdat_push;
   
   o_spi_adr_phase   <= s_spi_adr_phase;
   
   o_spi_busy        <= not f_to_logic(s_spi_fsm = SC_IDLE);
   
   o_spi_cmd_phase   <= s_spi_cmd_phase;
   
   o_spi_end_ev      <= f_to_logic(s_spi_fsm = SC_DISABLE);
   
   o_spi_mosi        <= s_spi_mosi_lsb when (s_mode_lsb_first = '1') else
                        s_spi_mosi_msb;

   o_spi_mosi_en     <= s_spi_mosi_en;
                        
   o_spi_sclk        <= s_spi_sclk;
   o_spi_sclk_en     <= s_spi_sclk_en;

   o_spi_ssel        <= s_spi_ssel;
   
   o_sta_out         <= f_cp_resize(s_spi_sta, o_sta_out'length);
   o_sta_valid       <= s_sta_valid;
   
   o_txdat_pop       <= s_txdat_pop;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_spi_mosi_lsb    <= s_spi_cmd(0)      when (s_spi_cmd_phase = '1') else 
                        s_spi_adr_tx(0)   when (s_spi_adr_phase = '1') else
                        s_spi_dat_tx(0);
                        
   s_spi_mosi_msb    <= s_spi_cmd(s_spi_cmd'left )       when (s_spi_cmd_phase = '1') else 
                        s_spi_adr_tx(s_spi_adr_tx'left ) when (s_spi_adr_phase = '1') else
                        s_spi_dat_tx(s_spi_dat_tx'left );                        

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_FSM:
   process (all)
   begin
      s_spi_fsm_next    <= s_spi_fsm;
      
      case (s_spi_fsm) is
         when SC_IDLE =>
            if ((i_spi_en = '1') and (s_spi_init_rdy = '1')) then
               s_spi_fsm_next <= SC_DECODE;
            end if;
         
         when SC_DECODE =>
            s_spi_fsm_next <= SC_CLK_EN;
           
         when SC_CLK_EN => 
            if (g_ssel_su > 1) then
               s_spi_fsm_next <= SC_ENABLE_SU;
            else
               s_spi_fsm_next <= SC_ENABLE;
            end if;
            
         when SC_ENABLE_SU => 
            if (s_cnt_ssel_sh < 2) then
               s_spi_fsm_next <= SC_ENABLE;
            end if;
            
         when SC_ENABLE =>
            if (i_cmd_rdy = '1') then
               s_spi_fsm_next <= SC_CMD_PRELOAD;
            elsif (i_has_pload = '1') then
               s_spi_fsm_next <= SC_DAT_PRELOAD;
            else 
               s_spi_fsm_next <= SC_CHK_CONT;
            end if;

         when SC_CMD_PRELOAD =>
            s_spi_fsm_next <= SC_CMD_SAMPLE;
            
         when SC_CMD_SAMPLE =>
            s_spi_fsm_next <= SC_CMD_SHIFT;
         
         when SC_CMD_SHIFT =>
            if (unsigned(s_shift_pos_cmd) = 0) then
               if (s_adr_rdy = '1') then
                  s_spi_fsm_next <= SC_ADR_SAMPLE;
               elsif (i_has_pload = '1') then
                  if (s_spi_data_rdy = '1') then
                     s_spi_fsm_next <= SC_DAT_SAMPLE;
                  else
                     s_spi_fsm_next <= SC_CHK_CONT;
                  end if;
               else
                  s_spi_fsm_next <= SC_CHK_CONT;
               end if;
            else
               s_spi_fsm_next <= SC_CMD_SAMPLE;
            end if;

         when SC_ADR_SAMPLE =>
            s_spi_fsm_next <= SC_ADR_SHIFT;
         
         when SC_ADR_SHIFT =>
            if (unsigned(s_shift_pos_adr) = 0) then
               if (i_has_pload = '1') then
                  if (s_spi_data_rdy = '1') then
                     s_spi_fsm_next <= SC_DAT_SAMPLE;
                  else
                     s_spi_fsm_next <= SC_CHK_CONT;
                  end if;               
               else
                  s_spi_fsm_next <= SC_CHK_CONT;
               end if;
            else
               s_spi_fsm_next <= SC_ADR_SAMPLE;
            end if;
            
         when SC_DAT_PRELOAD =>
            s_spi_fsm_next <= SC_DAT_SAMPLE;
                        
         when SC_DAT_SAMPLE =>
            s_spi_fsm_next <= SC_DAT_SHIFT;
         
         when SC_DAT_SHIFT =>
            if (unsigned(s_shift_pos_dat) = 0) then
               if ((i_has_pload = '0') or (s_spi_data_rdy = '0')) then
                  s_spi_fsm_next <= SC_CHK_CONT;
               else
                  s_spi_fsm_next <= SC_DAT_SAMPLE;
               end if;
            else
               s_spi_fsm_next <= SC_DAT_SAMPLE;
            end if;
         
         when SC_CHK_CONT =>
            if ((i_has_pload = '0') or (s_rx_last_done = '1')) then
                  -- We'll add another counter controlled operating mode later which will keep ssel active
                  -- if there are no data but counter > 0
               s_spi_fsm_next <= SC_DISABLE;
            else
               if (s_spi_data_rdy = '1') then
                  s_spi_fsm_next <= SC_DAT_PRELOAD;
               end if;
            end if;
            
         when SC_DISABLE =>
            s_spi_fsm_next <= SC_HOLD;
            
         when SC_HOLD => 
            if (s_cnt_ssel_sh < 2) then
               s_spi_fsm_next <= SC_CLK_REL;
            end if;
                     
         when SC_CLK_REL =>
            s_spi_fsm_next <= SC_IDLE;
        
         when others =>
            s_spi_fsm_next <= SC_IDLE;
      end case;
   end process;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_MAIN:
   process (i_clk, i_rst_n)
      procedure p_rst_clr is
      begin
         s_adr_pop         <= '0';
         s_adr_push        <= '0';
         s_adr_rdy         <= '0';
         s_cmd_pop         <= '0';
         s_cnt_ssel_sh     <= 0;
         s_mode_cpha       <= '0';
         s_mode_cpol       <= '0';
         s_mode_lsb_first  <= '0';
         s_mode_wr         <= '0';
         s_mode_xfer_sz    <= (others => '0');
         s_rx_last_done    <= '0';
         s_rxdat_push      <= '0';
         s_shift_pos_adr   <= (others => '0');
         s_shift_load_dat  <= (others => '0');
         s_shift_pos_cmd   <= (others => '0');
         s_shift_pos_dat   <= (others => '0');
         s_shift_tick      <= '0';
         s_spi_adr_phase   <= '0';
         s_spi_adr_rx      <= (others => '0');
         s_spi_adr_tx      <= (others => '0');
         s_spi_cmd         <= (others => '0');
         s_spi_cmd_phase   <= '0';
         s_spi_dat_rx      <= (others => '0');
         s_spi_dat_tx      <= (others => '0');
         s_spi_data_rdy    <= '0';
         s_spi_fsm         <= SC_RST;
         s_spi_init_rdy    <= '0';
         s_spi_mosi_en     <= '0';
         s_spi_sclk        <= '0';
         s_spi_sclk_en     <= '0';
         s_spi_ssel        <= '0';
         s_spi_sta         <= (others => '0');
         s_sta_valid       <= '0';
         s_txdat_pop       <= '0';      
      end procedure;

   begin
      if (i_rst_n = '0') then
         p_rst_clr;
      elsif (rising_edge(i_clk)) then
         if (i_clr = '1') then  
            p_rst_clr;
         else
               -- Default assignments
            s_adr_pop         <= '0';
            s_adr_push        <= '0';
            s_rxdat_push      <= '0';
            s_shift_tick      <= '0';
            s_sta_valid       <= '0';
            s_txdat_pop       <= '0';   
            
               -- Functional assignments
            s_adr_rdy         <= i_adr_rdy;
            
            s_cmd_pop         <= f_to_logic(s_spi_fsm = SC_CMD_PRELOAD);
                       
            s_spi_data_rdy    <= (i_rx_rdy and (not s_mode_wr) and (not s_rx_last_done)) or
                                 (i_rx_rdy and i_tx_rdy and s_mode_wr);
                                 
            s_spi_fsm         <= s_spi_fsm_next;
            
            s_spi_init_rdy    <= (s_mode_wr and (i_cmd_rdy or i_tx_rdy)) or
                                 (i_cmd_rdy and i_rx_rdy and (not s_mode_wr));
            
            if (unsigned(s_mode_xfer_sz) = 0) then
               s_shift_load_dat  <= std_logic_vector(to_unsigned(i_tx_wdat'length - 1, s_shift_load_dat'length));
            else
               s_shift_load_dat  <= std_logic_vector(resize(unsigned(s_mode_xfer_sz) - 1, s_shift_load_dat'length));
            end if;
                     
            case s_spi_fsm is
               when SC_IDLE =>
                  s_mode_cpol       <= i_mode_cpol;
                  s_mode_lsb_first  <= i_mode_lsb_first;
                  s_mode_cpha       <= i_mode_cpha;
                  s_mode_wr         <= i_mode_wr;
                  s_mode_xfer_sz    <= i_mode_xfer_sz;
                  s_spi_sclk        <= i_mode_cpol;
                                 
               when SC_DECODE =>
                  s_cnt_ssel_sh     <= g_ssel_su;
                  s_mode_cpol       <= i_mode_cpol;
                  s_mode_lsb_first  <= i_mode_lsb_first;
                  s_mode_cpha       <= i_mode_cpha;
                  s_mode_wr         <= i_mode_wr;
                  s_rx_last_done    <= '0';
                  s_spi_sclk        <= i_mode_cpol;
                  
               when SC_CLK_EN =>
                  s_spi_sclk_en     <= '1';
                  
               when SC_ENABLE_SU => 
                  s_cnt_ssel_sh     <= s_cnt_ssel_sh;
                  s_spi_mosi_en     <= i_cmd_rdy or s_mode_wr;
                  s_spi_sclk        <= s_mode_cpol;
                  s_spi_ssel        <= '1';
                  
               when SC_ENABLE =>
                  s_spi_sclk        <= s_mode_cpol;
                  s_spi_ssel        <= '1';

               when SC_CMD_PRELOAD =>
                  s_shift_pos_cmd   <= std_logic_vector(to_unsigned(i_cmd_in'length - 1, s_shift_pos_cmd'length));
                  s_spi_cmd         <= i_cmd_in;
                  s_spi_cmd_phase   <= '1';
                  s_spi_mosi_en     <= i_cmd_rdy or s_mode_wr;
                     -- Invert the clock at the start of the first bit time if mode CPHA is active
                  s_spi_sclk        <= s_spi_sclk xor s_mode_cpha;

               when SC_CMD_SAMPLE =>
                  s_spi_sclk     <= not s_spi_sclk;
                  s_sta_valid    <= f_to_logic(unsigned(s_shift_pos_cmd) = 0);
               
                  if (s_mode_lsb_first = '1') then
                     s_spi_sta   <= i_spi_miso & s_spi_sta(s_spi_sta'left downto 1);
                  else
                     s_spi_sta   <= s_spi_sta(s_spi_sta'left - 1 downto 0) & i_spi_miso;
                  end if;
                
               when SC_CMD_SHIFT =>
                  s_shift_pos_cmd   <= std_logic_vector(unsigned(s_shift_pos_cmd) - 1);
 
                  if (s_mode_lsb_first = '1') then
                     s_spi_cmd   <= std_logic_vector(shift_right(unsigned(s_spi_cmd), 1));
                  else
                     s_spi_cmd   <= std_logic_vector(shift_left(unsigned(s_spi_cmd), 1));
                  end if;
                  
                  if (unsigned(s_shift_pos_cmd) = 0) then
                     s_adr_pop         <= i_adr_rdy;
                     s_shift_pos_adr   <= std_logic_vector(to_unsigned(i_adr_in'length - 1, s_shift_pos_adr'length));
                     s_shift_pos_dat   <= s_shift_load_dat;
                     s_spi_adr_phase   <= s_adr_rdy;
                     s_spi_adr_tx      <= i_adr_in;
                     s_spi_cmd_phase   <= '0';
                     s_spi_dat_tx      <= i_tx_wdat;
                     s_spi_mosi_en     <= s_mode_wr;
                     s_txdat_pop       <= s_spi_data_rdy and s_mode_wr and (not i_adr_rdy);
                     
                     if ((s_mode_cpha = '0') or (s_spi_data_rdy = '1') or (s_adr_rdy = '1')) then
                        s_spi_sclk  <= not s_spi_sclk;
                     end if;
                  else
                     s_spi_sclk  <= not s_spi_sclk;
                  end if;
                  
               when SC_DAT_PRELOAD =>
                  s_shift_pos_dat   <= s_shift_load_dat;
                  s_spi_cmd_phase   <= '0';
                  s_spi_adr_tx      <= i_adr_in;
                  s_spi_dat_tx      <= i_tx_wdat;
                  s_spi_mosi_en     <= s_mode_wr;
                     -- Invert the clock at the start of the first bit time if mode CPHA is active
                  s_spi_sclk        <= s_spi_sclk xor s_mode_cpha;                  
                  s_txdat_pop       <= s_spi_data_rdy and s_mode_wr;
                  
               when SC_ADR_SAMPLE =>
                  s_spi_sclk     <= not s_spi_sclk;
                  s_adr_push     <= f_to_logic(unsigned(s_shift_pos_adr) = 0);
               
                  if (s_mode_lsb_first = '1') then
                     s_spi_adr_rx   <= i_spi_miso & s_spi_adr_rx(s_spi_adr_rx'left downto 1);
                  else
                     s_spi_adr_rx   <= s_spi_adr_rx(s_spi_adr_rx'left - 1 downto 0) & i_spi_miso;
                  end if;
                  
               when SC_ADR_SHIFT =>
                  s_shift_pos_adr   <= std_logic_vector(unsigned(s_shift_pos_adr) - 1);
 
                  if (s_mode_lsb_first = '1') then
                     s_spi_adr_tx   <= std_logic_vector(shift_right(unsigned(s_spi_adr_tx), 1));
                  else
                     s_spi_adr_tx   <= std_logic_vector(shift_left(unsigned(s_spi_adr_tx), 1));
                  end if;
                  
                  if (unsigned(s_shift_pos_adr) = 0) then     
                     s_spi_adr_phase   <= '0';
                     s_txdat_pop       <= s_spi_data_rdy and s_mode_wr;
                    
                     if ((s_mode_cpha = '0') or (s_spi_data_rdy = '1')) then
                        s_spi_sclk  <= not s_spi_sclk;
                     end if;                     
                  else
                     s_spi_sclk  <= not s_spi_sclk;                  
                  end if;
                  
               when SC_DAT_SAMPLE =>
                  s_rx_last_done    <= s_rx_last_done or (i_rx_last and (not s_mode_wr));
                  s_shift_tick   <= f_to_logic(s_shift_pos_dat = s_shift_load_dat);

                  s_spi_sclk     <= not s_spi_sclk;
                  s_rxdat_push   <= f_to_logic(unsigned(s_shift_pos_dat) = 0) and i_rx_rdy;
               
                  if (s_mode_lsb_first = '1') then
                     s_spi_dat_rx   <= i_spi_miso & s_spi_dat_rx(s_spi_dat_rx'left downto 1);
                  else
                     s_spi_dat_rx   <= s_spi_dat_rx(s_spi_dat_rx'left - 1 downto 0) & i_spi_miso;
                  end if;
                  
               when SC_DAT_SHIFT =>                  
                  s_shift_pos_dat   <= std_logic_vector(unsigned(s_shift_pos_dat) - 1);
                  
                  s_spi_adr_phase   <= '0';
                  s_spi_cmd_phase   <= '0';
 
                  if (s_mode_lsb_first = '1') then
                     s_spi_dat_tx   <= std_logic_vector(shift_right(unsigned(s_spi_dat_tx), 1));
                  else
                     s_spi_dat_tx   <= std_logic_vector(shift_left(unsigned(s_spi_dat_tx), 1));
                  end if;
                  
                  if (unsigned(s_shift_pos_dat) = 0) then
                     s_shift_pos_dat   <= s_shift_load_dat;
                     s_spi_dat_tx      <= i_tx_wdat;
                     s_txdat_pop       <= s_spi_data_rdy and s_mode_wr;
                     
                     if ((s_mode_cpha = '0') or (s_spi_data_rdy = '1')) then
                        s_spi_sclk  <= not s_spi_sclk;
                     end if;                     
                  else
                     s_spi_sclk  <= not s_spi_sclk;                  
                  end if;
               
               when SC_CHK_CONT =>
                  if (i_has_pload = '1') then
                     s_spi_sclk        <= s_mode_cpol;
                  end if;
                  
               when SC_DISABLE =>
                  s_cnt_ssel_sh  <= g_ssel_hld;
                  s_spi_ssel     <= '0';

               when SC_HOLD => 
                  s_cnt_ssel_sh  <= s_cnt_ssel_sh - 1;
                  s_spi_mosi_en  <= '0';

               when SC_CLK_REL =>
                  s_spi_sclk_en     <= '0';
                  
               when others =>   
                  s_spi_sclk     <= s_mode_cpol;
            end case;
         end if;
      end if;
   end process;
End Rtl;
