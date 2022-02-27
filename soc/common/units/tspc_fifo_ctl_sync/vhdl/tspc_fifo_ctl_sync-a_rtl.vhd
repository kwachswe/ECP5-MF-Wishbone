
--
--    Copyright Ingenieurbuero Gardiner, 2013 - 2014
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
-- File ID     : $Id: tspc_fifo_ctl_sync-a_rtl.vhd 4687 2019-03-22 16:01:06Z  $
-- Generated   : $LastChangedDate: 2019-03-22 17:01:06 +0100 (Fri, 22 Mar 2019) $
-- Revision    : $LastChangedRevision: 4687 $
--
--------------------------------------------------------------------------------
--
-- Description : Control Logic for Synchronous FIFO
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Architecture Rtl of tspc_fifo_ctl_sync is
   subtype t_cmd_op     is std_logic_vector(1 downto 0);
   subtype t_mem_count  is std_logic_vector(o_rd_adr'length downto 0);
   subtype t_mem_ptr    is std_logic_vector(o_rd_adr'length -1 downto 0);

   constant c_cmd_nop      : t_cmd_op := B"00";
   constant c_cmd_pop      : t_cmd_op := B"01";
   constant c_cmd_push     : t_cmd_op := B"10";
   constant c_cmd_push_pop : t_cmd_op := B"11";
   
   signal s_mem_rd_adr     : t_mem_ptr;
   signal s_mem_rd_adr_out : t_mem_ptr;
   signal s_mem_rd_en      : std_logic;
   signal s_mem_wr_adr     : t_mem_ptr;
   signal s_mem_wr_en      : std_logic;   
   signal s_rd_adr_next    : t_mem_ptr;
   signal s_rd_aempty      : std_logic;
   signal s_rd_aempty_out  : std_logic;
   signal s_rd_count       : t_mem_count;
   signal s_rd_count_out   : t_mem_count;
   signal s_rd_done        : std_logic;
   signal s_rd_pop         : std_logic;
   signal s_rd_empty       : std_logic;
   signal s_rd_empty_out   : std_logic;
   signal s_rd_last        : std_logic;
   signal s_rd_last_out    : std_logic;
   signal s_wr_afull       : std_logic;
   signal s_wr_done        : std_logic;
   signal s_wr_free        : t_mem_count;
   signal s_wr_full        : std_logic;         
   signal s_wr_last        : std_logic;
   
begin
   o_rd_adr       <= s_mem_rd_adr_out;
   o_rd_aempty    <= s_rd_aempty_out;
   o_rd_count     <= s_rd_count_out;
   o_rd_empty     <= s_rd_empty_out;
   o_rd_en        <= s_mem_rd_en;
   o_rd_last      <= s_rd_last_out;
   
   o_wr_adr       <= s_mem_wr_adr;
   o_wr_afull     <= s_wr_afull;
   o_wr_free      <= s_wr_free;
   o_wr_en        <= s_mem_wr_en;
   o_wr_full      <= s_wr_full;
   o_wr_last      <= s_wr_last;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_mem_wr_en       <= i_wr_en and not s_wr_full;

      --    ===================================================================
   R_DPS_EQ1:
   if (g_rd_latency = 1) generate
      s_mem_rd_adr_out  <= s_rd_adr_next when (s_rd_pop = '1') else s_mem_rd_adr;   
      s_mem_rd_en       <= '1';
      
      s_rd_aempty_out   <= s_rd_aempty;
      s_rd_count_out    <= s_rd_count;
      s_rd_empty_out    <= s_rd_empty;
      s_rd_last_out     <= s_rd_last;
      
      s_rd_pop          <= i_rd_en and not s_rd_empty;
      
         --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      R_MAIN :
      process (i_clk, i_rst_n)   
         constant c_aempty_clr      : natural := g_flag_rd_threshold + 1;
         constant c_aempty_set      : natural := g_flag_rd_threshold;
         constant c_afull_clr       : natural := g_flag_wr_threshold;
         constant c_afull_set       : natural := g_flag_wr_threshold + 1;
         constant c_count_two       : natural := 2;
         constant c_fifo_one_free   : natural := g_mem_words - 1;
         
         variable v_cmd_op_rd : t_cmd_op;
         variable v_cmd_op_wr : t_cmd_op;
         
         procedure p_rst_clr is
         begin
            s_rd_adr_next  <= (others => '0');
            s_rd_aempty    <= '0';
            s_rd_count     <= (others => '0');
            s_rd_done      <= '0';
            s_rd_empty     <= '1';
            s_rd_last      <= '0';
            
            s_mem_rd_adr   <= (others => '0');
            s_mem_wr_adr   <= (others => '0');
            
            s_wr_afull     <= '0';
            s_wr_done      <= '0';
            s_wr_free      <= f_reg_load(g_mem_words, s_wr_free'length );
            s_wr_full      <= '0';
            s_wr_last      <= '0';
         end procedure;
         
      begin
         if (i_rst_n = '0') then
            p_rst_clr;
         elsif (rising_edge(i_clk)) then
            if (i_clr = '1') then      
               p_rst_clr;
               
            else   
               v_cmd_op_rd := s_wr_done & s_rd_pop;
               v_cmd_op_wr := s_mem_wr_en & s_rd_done;

               s_rd_adr_next  <= f_incr(s_mem_rd_adr);
               s_rd_done      <= s_rd_pop;
               s_wr_done      <= s_mem_wr_en;
               
               case v_cmd_op_rd is
                  when c_cmd_pop =>
                     s_rd_aempty    <= (s_rd_aempty or f_to_logic(unsigned(s_rd_count) = c_aempty_set)) and not s_rd_last;
                     s_rd_count     <= f_decr(s_rd_count);
                     s_rd_empty     <= s_rd_last;
                     s_rd_last      <= f_to_logic(unsigned(s_rd_count) = c_count_two);
                     
                  when c_cmd_push =>
                     s_rd_aempty    <= s_rd_aempty and not f_to_logic(unsigned(s_rd_count) = c_aempty_clr);
                     s_rd_count     <= f_incr(s_rd_count);
                     s_rd_empty     <= '0';
                     s_rd_last      <= s_rd_empty;
                     
                  when others =>
               end case;

               case v_cmd_op_wr is
                  when c_cmd_pop =>                  
                     s_wr_afull     <= s_wr_afull and not f_to_logic(unsigned(s_wr_free) = c_afull_clr);
                     s_wr_free      <= f_incr(s_wr_free);
                     s_wr_full      <= '0'; 
                     s_wr_last      <= s_wr_full;
                     
                  when c_cmd_push =>                  
                     s_wr_afull     <= (s_wr_afull or f_to_logic(unsigned(s_wr_free) = c_afull_set)) and not s_wr_last;
                     s_wr_free      <= f_decr(s_wr_free);
                     s_wr_full      <= s_wr_last; 
                     s_wr_last      <= f_to_logic(unsigned(s_wr_free) = c_count_two);
                     
                  when others =>
               end case;
               
               if (s_rd_pop = '1') then
                  s_mem_rd_adr   <= f_incr(s_mem_rd_adr);    
                  s_rd_adr_next  <= f_incr(s_rd_adr_next);
               else
                  s_rd_adr_next  <= f_incr(s_mem_rd_adr);
               end if;
               
               if (s_mem_wr_en = '1')  then
                  s_mem_wr_adr <= f_incr(s_mem_wr_adr);    
               end if;         
            end if;
         end if;
      end process;           
   end generate;

      --    ===================================================================
   R_DPS_EQ2:
   if (g_rd_latency = 2) generate
      constant c_bp_adr_rdy         : natural   := 0;
      constant c_bp_oreg_rdy        : natural   := 1;
      
      signal s_egrs_lock            : std_logic;
      signal s_egrs_last_wait       : t_byte;      
      signal s_egr_pipe             : std_logic_vector(1 downto 0);
      signal s_egr_pop              : std_logic;
      signal s_egr_push             : std_logic;
      signal s_egrs_avail_eq0       : std_logic;
      signal s_egrs_avail_eq1       : std_logic;
      signal s_egrs_avail_eq2       : std_logic;
      signal s_egrs_avail_gt0       : std_logic;
      signal s_egrs_avail_gt1       : std_logic;
      signal s_egrs_avail_gt2       : std_logic;      
      signal s_egrs_decr            : std_logic;
      signal s_egrs_incr            : std_logic;      
      signal s_mem_adr_prefetch     : std_logic;
      signal s_mem_adr_refresh      : std_logic;
      signal s_mem_dat_prefetch     : std_logic;  
      signal s_mem_dat_refresh      : std_logic;  
      signal s_mem_dpath_step       : std_logic;
      signal s_rd_adr_incr          : std_logic;
      signal s_rsrc_avail           : t_mem_count;
      signal s_rsrc_avail_ne0       : std_logic;

      
   begin
      s_egr_pop            <= i_rd_en and not s_rd_empty_out;
      s_egr_push           <= s_rsrc_avail_ne0 and not s_egrs_lock;

      s_egrs_decr          <= s_egr_pop and not s_egr_push;
      s_egrs_incr          <= s_egr_push and not s_egr_pop;    
      s_egrs_lock          <= s_egr_pipe(c_bp_oreg_rdy) and not s_egr_pipe(c_bp_adr_rdy) and (not (and(s_egrs_last_wait)));
      
      s_mem_adr_prefetch   <= s_egrs_avail_gt0 and (not (or(s_egr_pipe)));
      s_mem_adr_refresh    <= s_egr_pipe(c_bp_oreg_rdy) and s_egrs_incr and (not s_egr_pipe(c_bp_adr_rdy));
                              
      s_mem_dat_prefetch   <= s_egr_pipe(c_bp_adr_rdy) and not s_egr_pipe(c_bp_oreg_rdy);
      
      s_mem_dpath_step     <= s_rd_pop and (and(s_egr_pipe)) and (s_egrs_avail_gt2 or (s_egrs_avail_eq2 and (not s_egrs_decr)));

      s_mem_rd_adr_out     <= s_rd_adr_next when (s_rd_adr_incr = '1') else s_mem_rd_adr;   
      
      s_mem_rd_en          <= (s_mem_adr_prefetch or s_mem_adr_refresh 
                                                  or s_mem_dat_prefetch --or s_mem_dat_refresh
                                                  or s_mem_dpath_step
                                                  or (s_rd_pop and (and(s_egr_pipe)))) and not s_egrs_avail_eq0;

      s_rd_adr_incr        <= s_mem_dpath_step or (s_mem_dat_prefetch and s_egr_push)
                                               or (s_mem_dat_prefetch and s_egrs_avail_gt1)
                                               or s_mem_adr_refresh
                                               or (s_rd_pop and s_egr_pipe(c_bp_oreg_rdy) and (not (s_egr_pipe(c_bp_adr_rdy))));
                                                  
      s_rd_aempty_out      <= '0' when (s_egr_pipe(c_bp_oreg_rdy) = '0') else s_rd_aempty;
      s_rd_count_out       <= (others => '0') when (s_egr_pipe(c_bp_oreg_rdy) = '0') else s_rd_count;
      s_rd_empty_out       <= '1' when (s_egr_pipe(c_bp_oreg_rdy) = '0') else s_rd_empty;
      s_rd_last_out        <= '0' when (s_egr_pipe(c_bp_oreg_rdy) = '0') else s_rd_last;      

      s_rd_pop             <= i_rd_en and not s_rd_empty_out;
      
      s_egrs_avail_eq0     <= f_to_logic(unsigned(s_rd_count) = 0);
      s_egrs_avail_eq1     <= f_to_logic(unsigned(s_rd_count) = 1);
      s_egrs_avail_eq2     <= f_to_logic(unsigned(s_rd_count) = 2);
      s_egrs_avail_gt0     <= not s_egrs_avail_eq0;  
      s_egrs_avail_gt1     <= f_to_logic(unsigned(s_rd_count) > 1);
      s_egrs_avail_gt2     <= f_to_logic(unsigned(s_rd_count) > 2);
      
      s_rsrc_avail_ne0     <= f_to_logic(unsigned(s_rsrc_avail) > 0);  
      
         --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      R_MAIN :
      process (i_clk, i_rst_n)     
         constant c_aempty_clr      : natural := g_flag_rd_threshold + 1;
         constant c_aempty_set      : natural := g_flag_rd_threshold;      
         constant c_afull_clr       : natural := g_flag_wr_threshold;
         constant c_afull_set       : natural := g_flag_wr_threshold + 1;
         constant c_count_two       : natural := 2;
         
         variable v_cmd_op_pq       : t_cmd_op;
         variable v_cmd_op_rd       : t_cmd_op;
         variable v_cmd_op_wr       : t_cmd_op;

         procedure p_rst_clr is
         begin
            s_egrs_last_wait     <= (others => '0');
            s_egr_pipe           <= (others => '0');
            
            s_mem_dat_refresh    <= '0';
            s_mem_rd_adr         <= (others => '0');
            s_mem_wr_adr         <= (others => '0');
            
            s_rd_adr_next        <= (others => '0');
            s_rd_aempty          <= '0';
            s_rd_count           <= (others => '0');
            s_rd_done            <= '0';
            s_rd_empty           <= '1';
            s_rd_last            <= '0';            
            
            s_rsrc_avail         <= (others => '0');
            
            s_wr_afull           <= '0';
            s_wr_done            <= '0';
            s_wr_free            <= f_reg_load(g_mem_words, s_wr_free'length );
            s_wr_full            <= '0';
            s_wr_last            <= '0';            
         end procedure;
         
      begin
         if (i_rst_n = '0') then
            p_rst_clr;
         elsif (rising_edge(i_clk)) then
            if (i_clr = '1') then      
               p_rst_clr;
               
            else
               v_cmd_op_pq       := s_wr_done & s_egr_push;
               v_cmd_op_rd       := s_egr_push & s_rd_pop;
               v_cmd_op_wr       := s_mem_wr_en & s_rd_done;
               
               s_egr_pipe(c_bp_adr_rdy)   <= s_mem_adr_prefetch or s_mem_adr_refresh 
                                                                or (s_egr_pipe(c_bp_adr_rdy) and s_egrs_avail_gt2)
                                                                or (s_egr_pipe(c_bp_adr_rdy) and s_egrs_avail_eq2 and (not s_egrs_decr))
                                                                or (s_egr_pipe(c_bp_adr_rdy) and s_egrs_incr and (not s_egr_pipe(c_bp_oreg_rdy)));
               s_egr_pipe(c_bp_oreg_rdy)  <= s_egr_pipe(c_bp_adr_rdy) or (s_egr_pipe(c_bp_oreg_rdy) and not s_rd_pop);
                                             
               s_mem_dat_refresh          <= s_mem_adr_refresh;
               
               s_rd_done                  <= s_rd_pop;

               s_wr_done                  <= s_mem_wr_en;

               if ((s_egr_pipe(c_bp_adr_rdy) = '0') and (s_egr_pipe(c_bp_oreg_rdy) = '1')) then
                  s_egrs_last_wait     <= s_egrs_last_wait(s_egrs_last_wait'left - 1 downto 0) & c_tie_high;
               else
                  s_egrs_last_wait     <= (others => '0');
               end if;
               
               if (s_rd_adr_incr = '1') then
                  s_mem_rd_adr      <= f_incr(s_mem_rd_adr);
                  s_rd_adr_next     <= f_incr(s_rd_adr_next);
               else
                  s_rd_adr_next     <= f_incr(s_mem_rd_adr);
               end if;
               
                  -- Container wr-side to egress-in
               case v_cmd_op_pq is
                  when c_cmd_pop =>
                     if (s_rsrc_avail_ne0 = '1') then
                        s_rsrc_avail   <= f_decr(s_rsrc_avail);
                     end if;
                     
                  when c_cmd_push =>
                     s_rsrc_avail   <= f_incr(s_rsrc_avail);
                     
                  when others =>               
               end case;
               
                  -- Container egress-in to read_rdy
               case v_cmd_op_rd is
                  when c_cmd_pop =>
                     s_rd_aempty    <= (s_rd_aempty or f_to_logic(unsigned(s_rd_count) = c_aempty_set)) and not s_rd_last;
                     s_rd_count     <= f_decr(s_rd_count);
                     s_rd_empty     <= s_rd_last;
                     s_rd_last      <= f_to_logic(unsigned(s_rd_count) = c_count_two);
                     
                  when c_cmd_push =>
                     s_rd_aempty    <= s_rd_aempty and not f_to_logic(unsigned(s_rd_count) = c_aempty_clr);
                     s_rd_count     <= f_incr(s_rd_count);
                     s_rd_empty     <= '0';
                     s_rd_last      <= s_rd_empty;
                     
                  when others =>
               end case;
               
                  -- Container wr_done / rd_done
               case v_cmd_op_wr is
                  when c_cmd_pop =>                  
                     s_wr_afull     <= s_wr_afull and not f_to_logic(unsigned(s_wr_free) = c_afull_clr);
                     s_wr_free      <= f_incr(s_wr_free);
                     s_wr_full      <= '0'; 
                     s_wr_last      <= s_wr_full;
                     
                  when c_cmd_push =>                  
                     s_wr_afull     <= (s_wr_afull or f_to_logic(unsigned(s_wr_free) = c_afull_set)) and not s_wr_last;
                     s_wr_free      <= f_decr(s_wr_free);
                     s_wr_full      <= s_wr_last; 
                     s_wr_last      <= f_to_logic(unsigned(s_wr_free) = c_count_two);
                     
                  when others =>
               end case;
                              
               if (s_mem_wr_en = '1')  then
                  s_mem_wr_adr <= f_incr(s_mem_wr_adr);    
               end if;                  
            end if;
         end if;
      end process;               
   end generate;
End Rtl;

