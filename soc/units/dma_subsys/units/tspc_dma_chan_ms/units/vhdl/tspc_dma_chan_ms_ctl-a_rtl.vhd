
--
--    Copyright Ing. Buero Gardiner 2008 - 2012
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_dma_chan_ms_ctl-a_rtl.vhd 5350 2021-11-20 23:05:22Z  $
-- Generated   : $LastChangedDate: 2021-11-21 00:05:22 +0100 (Sun, 21 Nov 2021) $
-- Revision    : $LastChangedRevision: 5350 $
--
--------------------------------------------------------------------------------
--
-- Description :
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.numeric_std.all;
Use WORK.tspc_utils.all;
Use WORK.tspc_wbone_types.all;

Architecture Rtl of tspc_dma_chan_ms_ctl is
   type t_dma_chan_fsm is (RC_RST,  RC_IDLE, 
                                    RC_CHAN_INIT,  RC_CMD_CHK,   RC_CMD_GET,    RC_CMD_DECODE_1, RC_CMD_DECODE_2,
                                    RC_SLV_INIT,   RC_SLV_PUSH,
                                    RC_INIT_BURST, RC_BURST_ADJ_1, RC_BURST_ADJ_2, RC_FIFO_WT_RD, RC_FIFO_WT_WR,
                                    RC_RD_INIT,    RC_RD_XFER,
                                    RC_WR_INIT,    RC_WR_XFER,
                                    RC_DMA_DONE,   RC_CHK_CONT, RC_RECOV, RC_WAIT_SLV_END);

   subtype t_byte_adr      is std_logic_vector(f_vec_msb(o_wbm_sel'length - 1) downto 0);
   subtype t_dma_adr       is std_logic_vector(i_dma_adr'length - 1 downto 0);
   subtype t_dma_count     is std_logic_vector(i_dma_xfer_count'length - 1 downto 0);
   subtype t_fifo_count    is std_logic_vector(i_fifo_rd_count'length - 1 downto 0);
   subtype t_page_adr_rd   is std_logic_vector(f_vec_msb(g_dma_burst_words_rd - 1) downto 0);
   subtype t_page_adr_wr   is std_logic_vector(f_vec_msb(g_dma_burst_words_wr - 1) downto 0);
   subtype t_xfer_count    is std_logic_vector(maximum(f_vec_msb(g_dma_burst_words_rd), f_vec_msb(g_dma_burst_words_wr)) downto 0);
   subtype t_xfer_decr     is std_logic_vector(f_vec_msb(o_wbm_sel'length ) downto 0);

   constant c_count_init_rd   : t_xfer_count := std_logic_vector(to_unsigned(g_dma_burst_words_rd, t_xfer_count'length));
   constant c_count_init_wr   : t_xfer_count := std_logic_vector(to_unsigned(g_dma_burst_words_wr, t_xfer_count'length));
   
   signal s_adr_byte             : t_byte_adr;
   signal s_beat_count           : t_dma_count;
   signal s_burst_trunc          : std_logic;
   signal s_dma_adr              : t_dma_adr;
   signal s_dma_adr_load         : t_dma_adr;
   signal s_dma_adr_pop          : std_logic;
   signal s_dma_chain_end        : std_logic;
   signal s_dma_chain_linear     : std_logic;
   signal s_dma_chan_fsm_next    : t_dma_chan_fsm;
   signal s_dma_chan_fsm         : t_dma_chan_fsm;
   signal s_dma_cmd_pop          : std_logic;
   signal s_dma_cmd_rdy          : std_logic;
   signal s_dma_mode_strm        : std_logic;
   signal s_dma_xfer_adr_rst     : std_logic;
   signal s_dma_xfer_int_done    : std_logic;
   signal s_ev_cmd_fifo_empty    : std_logic;
   signal s_fifo_avail           : t_fifo_count;
   signal s_fifo_dout            : std_logic_vector(o_fifo_wdat'length -1 downto 0);
   signal s_fifo_push            : std_logic;
   signal s_fifo_rd_count        : t_fifo_count;
   signal s_fifo_wr_free         : t_fifo_count;
   signal s_int_period_ev        : std_logic;
   signal s_int_period_count     : std_logic_vector(i_dma_int_period'length - 1 downto 0);
   signal s_int_period_load      : std_logic_vector(i_dma_int_period'length - 1 downto 0);
   signal s_int_period           : std_logic_vector(i_dma_int_period'length - 1 downto 0);
   signal s_int_xfer_ev          : std_logic;
   signal s_lseq_start_ev        : std_logic;
   signal s_mbuf_pos             : std_logic_vector(i_mem_buf_words'length -1 downto 0);
   signal s_mbuf_pos_max         : std_logic_vector(i_mem_buf_words'length -1 downto 0);
   signal s_mbuf_words           : std_logic_vector(i_mem_buf_words'length -1 downto 0);   
   signal s_mode_wr              : std_logic;
   signal s_page_adr_load        : t_page_adr_rd;
   signal s_page_adr_rd          : t_page_adr_rd;
   signal s_page_adr_wr          : t_page_adr_wr;
   signal s_run                  : std_logic;
   signal s_seq_done_ev          : std_logic;
   signal s_slv_run              : std_logic;
   signal s_slv_seq_last         : std_logic;
   signal s_slv_wr               : std_logic;        
   signal s_slv_xfer_count       : t_dma_count;
   signal s_tick_tmout           : std_logic;
   signal s_tick_tmout_ev        : std_logic;
   signal s_tick_tmout_prev      : std_logic;
   signal s_tmout_norun_ev       : std_logic;
   signal s_total_count          : t_dma_count;
   signal s_wbm_bte              : std_logic_vector(o_wbm_bte'length - 1 downto 0);
   signal s_wbm_cti              : std_logic_vector(o_wbm_cti'length - 1 downto 0);
   signal s_wbm_cyc              : std_logic;
   signal s_wbm_last             : std_logic;
   signal s_wbm_sel              : std_logic_vector(o_wbm_sel'length - 1 downto 0);
   signal s_wbm_sel_first        : std_logic_vector(o_wbm_sel'length - 1 downto 0);
   signal s_wbm_sel_xtnd         : std_logic_vector((2 * o_wbm_sel'length ) - 1 downto 0);
   signal s_wbm_stb              : std_logic;
   signal s_wbm_wdat             : std_logic_vector(o_wbm_dat'length - 1 downto 0);
   signal s_wbm_wr               : std_logic;
   signal s_wt_stop_wdog         : std_logic_vector(1 downto 0);
   signal s_xfer_count           : t_xfer_count;
   signal s_xfer_decr            : t_xfer_decr;

Begin
   o_chain_active       <= s_dma_chain_linear;
   
   o_dma_adr_pop        <= s_dma_adr_pop;
   o_dma_cmd_pop        <= s_dma_cmd_pop;
   o_dma_idle           <= f_to_logic(s_dma_chan_fsm = RC_IDLE) or f_to_logic(s_dma_chan_fsm = RC_RECOV);
   o_dma_wr             <= s_mode_wr;

   o_ev_cmd_fifo_empty  <= s_ev_cmd_fifo_empty;
   o_ev_dma_cmd_done    <= f_to_logic(s_dma_chan_fsm = RC_DMA_DONE);
   o_ev_dma_int_period  <= s_int_period_ev;
   o_ev_dma_int_xfer    <= s_int_xfer_ev;
   o_ev_dma_lseq_start  <= s_lseq_start_ev;
   o_ev_dma_seq_done    <= s_seq_done_ev;

   o_fifo_wdat          <= s_fifo_dout;
   o_fifo_pop           <= f_to_logic(s_dma_chan_fsm = RC_WR_INIT) or
                           (f_to_logic(s_dma_chan_fsm = RC_WR_XFER) and i_wbm_ack and not s_wbm_last);

   o_fifo_push          <= s_fifo_push;

   o_mem_buf_pos        <= f_cp_resize(s_mbuf_pos, o_mem_buf_pos'length);

   o_slv_push           <= f_to_logic(s_dma_chan_fsm = RC_SLV_PUSH);
   o_slv_run            <= s_slv_run;
   o_slv_seq_last       <= s_slv_seq_last;
   o_slv_wr             <= s_slv_wr;
   o_slv_xfer_count     <= std_logic_vector(resize(unsigned(s_slv_xfer_count), o_slv_xfer_count'length ));
   
   o_wbm_adr            <= f_resize(s_dma_adr, o_wbm_adr'length);
   o_wbm_bte            <= s_wbm_bte;
   o_wbm_cti            <= s_wbm_cti;
   o_wbm_cyc            <= s_wbm_cyc;
   o_wbm_dat            <= f_cp_resize(s_wbm_wdat, o_wbm_dat'length);
   o_wbm_sel            <= f_cp_resize(s_wbm_sel, o_wbm_sel'length);
   o_wbm_stb            <= s_wbm_stb;
   o_wbm_we             <= s_wbm_wr;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_adr_byte        <= s_dma_adr_load(t_byte_adr'range );
   
   s_page_adr_load   <= f_cp_resize(s_dma_adr_load(s_dma_adr_load'left downto t_byte_adr'length ), s_page_adr_load'length );
   
   s_page_adr_rd     <= f_cp_resize(s_dma_adr(s_dma_adr'left downto t_byte_adr'length ), s_page_adr_rd'length );
   s_page_adr_wr     <= f_cp_resize(s_dma_adr(s_dma_adr'left downto t_byte_adr'length ), s_page_adr_wr'length );
   
   s_tick_tmout_ev   <= s_tick_tmout and not s_tick_tmout_prev;

   s_tmout_norun_ev  <= '1' when (not g_dma_xfer_atomic) else
                        f_to_logic(unsigned(not s_wt_stop_wdog) = 0);

   s_wbm_last        <= f_to_logic(s_wbm_cti = c_wb_cti_burst_end);

   s_wbm_sel_xtnd    <= f_resize(f_shl(f_to_strobe(s_total_count, 2 * s_wbm_sel'length ), s_dma_adr(t_byte_adr'range )), s_wbm_sel_xtnd'length );
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_FSM:
   process(all)
   begin
      s_dma_chan_fsm_next     <= s_dma_chan_fsm;

      case s_dma_chan_fsm is
         when RC_IDLE =>
            if ((s_run and s_dma_cmd_rdy) = '1') then
               s_dma_chan_fsm_next  <= RC_CHAN_INIT;
            end if;

         when RC_CHAN_INIT =>
            s_dma_chan_fsm_next  <= RC_CMD_CHK;

         when RC_CMD_CHK =>
            if (s_run = '0') then
               s_dma_chan_fsm_next  <= RC_IDLE;
            elsif (s_dma_cmd_rdy = '1') then
               s_dma_chan_fsm_next  <= RC_CMD_GET;
            end if;

         when RC_CMD_GET =>
            s_dma_chan_fsm_next  <= RC_CMD_DECODE_1;

         when RC_CMD_DECODE_1 =>
            s_dma_chan_fsm_next  <= RC_CMD_DECODE_2;
            
         when RC_CMD_DECODE_2 =>
            if (g_is_master) then
               s_dma_chan_fsm_next  <= RC_SLV_INIT;            
            else
               s_dma_chan_fsm_next  <= RC_INIT_BURST;
            end if;

         when RC_SLV_INIT =>
             s_dma_chan_fsm_next  <= RC_SLV_PUSH;

         when RC_SLV_PUSH =>
             s_dma_chan_fsm_next  <= RC_INIT_BURST;
                                         
         when RC_INIT_BURST =>
            s_dma_chan_fsm_next  <= RC_BURST_ADJ_1;

         when RC_BURST_ADJ_1 =>
            s_dma_chan_fsm_next  <= RC_BURST_ADJ_2;
         
         when RC_BURST_ADJ_2 =>
            if (s_mode_wr = '0') then
               s_dma_chan_fsm_next  <= RC_FIFO_WT_RD;
            else
               s_dma_chan_fsm_next  <= RC_FIFO_WT_WR;
            end if;

         when RC_FIFO_WT_RD =>
            if ((s_tmout_norun_ev = '1') and (s_run = '0')) then
               s_dma_chan_fsm_next   <= RC_IDLE;
            elsif (unsigned(s_fifo_wr_free) >= unsigned(s_xfer_count)) then
               s_dma_chan_fsm_next   <= RC_RD_INIT;
            end if;

         when RC_FIFO_WT_WR =>
            if ((s_tmout_norun_ev = '1') and (s_run = '0')) then
               s_dma_chan_fsm_next   <= RC_IDLE;
            elsif (unsigned(s_fifo_avail) >= unsigned(s_xfer_count)) then
               s_dma_chan_fsm_next   <= RC_WR_INIT;
            end if;

         when RC_RD_INIT =>
            s_dma_chan_fsm_next   <= RC_RD_XFER;

         when RC_RD_XFER =>
            if ((i_wbm_ack = '1') and (s_wbm_last = '1')) then
               if (unsigned(s_beat_count) = 1) then
                  s_dma_chan_fsm_next  <= RC_CHK_CONT;
               else
                  s_dma_chan_fsm_next  <= RC_INIT_BURST;
               end if;
            end if;

         when RC_WR_INIT =>
            s_dma_chan_fsm_next   <= RC_WR_XFER;

         when RC_WR_XFER =>
            if ((i_wbm_ack = '1') and (s_wbm_last = '1')) then
               if (unsigned(s_beat_count) = 1) then
                  s_dma_chan_fsm_next  <= RC_CHK_CONT;
               else
                  s_dma_chan_fsm_next  <= RC_INIT_BURST;
               end if;
            end if;

         when RC_CHK_CONT =>
            if ((s_run = '1') and (s_dma_chain_end = '0')) then
               s_dma_chan_fsm_next  <= RC_CMD_CHK;
            else
               if (g_mode_ms) then
                  if (g_is_master) then
                     s_dma_chan_fsm_next  <= RC_WAIT_SLV_END;
                  else
                     s_dma_chan_fsm_next  <= RC_RECOV;
                  end if;
               else
                  s_dma_chan_fsm_next  <= RC_DMA_DONE;
               end if;
            end if;

         when RC_WAIT_SLV_END =>
               -- This state is only reached in an MS-mode master
               -- Wait for the slave to reach DMA_IDLE
            if (i_slv_idle = '1') then
               s_dma_chan_fsm_next  <= RC_DMA_DONE;
            end if;

         when RC_DMA_DONE =>
            s_dma_chan_fsm_next  <= RC_IDLE;
            
         when RC_RECOV =>
               -- This state is only reached in an MS-mode slave
               -- Signal Idle and wait for the master to deactivate run                       
            if (i_dma_run = '0') then
               s_dma_chan_fsm_next  <= RC_IDLE;
            end if;
            
         when others =>
            s_dma_chan_fsm_next  <= RC_IDLE;
         
      end case;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_MAIN:
   process (i_clk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_beat_count         <= (others => '0');
         s_burst_trunc        <= '0';
         s_dma_adr            <= (others => '0');
         s_dma_adr_load       <= (others => '0');
         s_dma_adr_pop        <= '0';
         s_dma_chain_end      <= '0';
         s_dma_chain_linear   <= '0';
         s_dma_chan_fsm       <= RC_RST;
         s_dma_cmd_pop        <= '0';
         s_dma_cmd_rdy        <= '0';
         s_dma_mode_strm      <= '0';
         s_dma_xfer_adr_rst   <= '0';
         s_dma_xfer_int_done  <= '0';
         s_ev_cmd_fifo_empty  <= '0';
         s_fifo_avail         <= (others => '0');
         s_fifo_dout          <= (others => '0');
         s_fifo_push          <= '0';
         s_fifo_rd_count      <= (others => '0');
         s_fifo_wr_free       <= (others => '0');
         s_int_period_ev      <= '0';
         s_int_period         <= (others => '0');
         s_int_period_count   <= (others => '0');
         s_int_period_load    <= (others => '0');
         s_int_xfer_ev        <= '0';
         s_lseq_start_ev      <= '0';
         s_mbuf_pos           <= (others => '0');            
         s_mbuf_pos_max       <= (others => '0');
         s_mbuf_words         <= (others => '0');      
         s_mode_wr            <= '0';
         s_run                <= '0';
         s_seq_done_ev        <= '0';
         s_slv_run            <= '0';
         s_slv_seq_last       <= '0';
         s_slv_wr             <= '0';
         s_slv_xfer_count     <= (others => '0');      
         s_tick_tmout         <= '0';
         s_tick_tmout_prev    <= '0';
         s_total_count        <= (others => '0');
         s_wbm_bte            <= (others => '0');
         s_wbm_cti            <= (others => '0');
         s_wbm_cyc            <= '0';
         s_wbm_sel            <= (others => '0');
         s_wbm_sel_first      <= (others => '0');
         s_wbm_stb            <= '0';
         s_wbm_wdat           <= (others => '0');
         s_wbm_wr             <= '0';
         s_wt_stop_wdog       <= (others => '0');
         s_xfer_count         <= (others => '0');
         s_xfer_decr          <= (others => '0');
      elsif (rising_edge(i_clk)) then
            -- Default assignments
         s_dma_adr_pop        <= '0';
         s_dma_cmd_pop        <= '0';
         s_fifo_push          <= '0';
         s_int_period_ev      <= '0';
         s_int_xfer_ev        <= '0';
         s_lseq_start_ev      <= '0';
         s_seq_done_ev        <= '0';
         
            -- Functional assignments
         s_dma_cmd_rdy        <= i_dma_cmd_rdy;
         s_dma_mode_strm      <= i_dma_mode_strm;
         s_ev_cmd_fifo_empty  <= s_dma_cmd_rdy and not i_dma_cmd_rdy;
         s_fifo_avail         <= f_cp_resize(s_fifo_rd_count, s_fifo_avail'length);
         s_fifo_rd_count      <= f_cp_resize(i_fifo_rd_count, s_fifo_rd_count'length);
         s_fifo_wr_free       <= f_cp_resize(i_fifo_wr_free, s_fifo_wr_free'length);
         s_mbuf_pos_max       <= std_logic_vector(unsigned(s_mbuf_words) - 1);
         s_mbuf_words         <= i_mem_buf_words;
         s_run                <= i_dma_run;
         s_slv_run            <= s_slv_run and not i_slv_lseq_start; 
         s_tick_tmout         <= i_tick_timeout;
         s_tick_tmout_prev    <= s_tick_tmout;

         if (s_tick_tmout_ev = '1') then
            s_wt_stop_wdog   <= f_incr(s_wt_stop_wdog);
         end if;

         if ((i_dma_clr = '1') and (s_run = '0')) then
            s_dma_chan_fsm       <= RC_IDLE;
         else
            s_dma_chan_fsm       <= s_dma_chan_fsm_next;
         end if;
         
         case s_dma_chan_fsm is
            when RC_CHAN_INIT =>
                  -- We don't want these settings to change during a DMA sequence (e.g. Scatter/Gather)
                  -- so pick them up here before we pop the first command
               s_int_period_count   <= s_int_period_load;
               s_mode_wr            <= i_dma_mode_wr;

            when RC_CMD_GET =>
               s_dma_chain_end      <= i_dma_xfer_seq_last;
               s_dma_chain_linear   <= not i_dma_mode_sg;
               s_dma_xfer_adr_rst   <= i_dma_xfer_adr_rst;
               s_dma_xfer_int_done  <= i_dma_xfer_int_done;
               s_lseq_start_ev      <= i_dma_xfer_seq_last;
               s_total_count        <= i_dma_xfer_count;
               s_wt_stop_wdog       <= (others => '0');

               if (s_dma_chain_linear = '0') then
                  s_dma_adr_load       <= f_cp_resize(i_dma_adr, s_dma_adr_load'length);
               end if;

            when RC_CMD_DECODE_1 =>
               s_beat_count   <= f_add(s_total_count, s_dma_adr_load(t_byte_adr'range ));
               s_dma_adr_pop  <= s_dma_chain_end or (not s_dma_chain_linear);
               s_dma_cmd_pop  <= '1';
               
               if (s_dma_xfer_adr_rst = '1') then
                  s_mbuf_pos     <= (others => '0');
               end if;

            when RC_CMD_DECODE_2 =>               
               if (o_wbm_sel'length > 1) then
                  if (unsigned(s_beat_count(t_byte_adr'range )) = 0) then
                     s_beat_count   <= f_shr(s_beat_count, t_byte_adr'length );
                  else
                     s_beat_count   <= f_incr(f_shr(s_beat_count, t_byte_adr'length ));
                  end if;
               end if;
               
            when RC_SLV_INIT =>
               s_slv_seq_last    <= s_dma_chain_end;
               s_slv_wr          <= not s_mode_wr;
               s_slv_xfer_count  <= s_total_count;

            when RC_SLV_PUSH =>
               s_slv_run      <= '1';
               
            when RC_INIT_BURST =>
               s_wbm_sel_first   <= f_to_strobe(s_total_count, o_wbm_sel'length );
               
               if (s_mode_wr = '0') then
                  s_xfer_count   <= f_sub(c_count_init_rd, s_page_adr_load);
               else
                  s_xfer_count   <= f_sub(c_count_init_wr, s_page_adr_load);
               end if;

            when RC_BURST_ADJ_1 =>
               s_burst_trunc     <= f_to_logic(unsigned(s_beat_count) < unsigned(s_xfer_count));    
               s_wbm_sel_first   <= f_shl(s_wbm_sel_first, s_adr_byte);
            
            when RC_BURST_ADJ_2 =>
               if (s_burst_trunc = '1') then
                  s_xfer_count   <= f_cp_resize(s_beat_count, s_xfer_count'length);
               end if;

            when RC_RD_INIT =>
               s_dma_adr   <= s_dma_adr_load;
               s_wbm_bte   <= c_wb_bte_burst_linear;
               s_wbm_cyc   <= '1';
               s_wbm_sel   <= s_wbm_sel_first;
               s_wbm_stb   <= '1';
               s_wbm_wr    <= '0';

               s_xfer_decr <= f_resize(f_be_to_bcd(s_wbm_sel_first), s_xfer_decr'length );

               if ((unsigned(s_beat_count) = 1) or (and(s_page_adr_load) = '1')) then
                  s_wbm_cti   <= c_wb_cti_burst_end;
               else
                  s_wbm_cti   <= c_wb_cti_burst_incr;
               end if;

             when RC_WR_INIT =>
               s_dma_adr   <= s_dma_adr_load;
               s_wbm_bte   <= c_wb_bte_burst_linear;
               s_wbm_cyc   <= '1';
               s_wbm_sel   <= s_wbm_sel_first;
               s_wbm_stb   <= '1';
               s_wbm_wdat  <= f_cp_resize(i_fifo_rdat, s_wbm_wdat'length);
               s_wbm_wr    <= '1';

               s_xfer_decr <= f_resize(f_be_to_bcd(s_wbm_sel_first), s_xfer_decr'length );
               
               if ((unsigned(s_beat_count) = 1) or (and(s_page_adr_load) = '1')) then
                  s_wbm_cti   <= c_wb_cti_burst_end;
               else
                  s_wbm_cti   <= c_wb_cti_burst_incr;
               end if;

            when RC_RD_XFER =>
               if (i_wbm_ack = '1') then
                  s_beat_count      <= f_decr(s_beat_count);

                  s_dma_adr(t_byte_adr'length - 1 downto 0)             <= (others => '0');
                  s_dma_adr(s_dma_adr'left downto t_byte_adr'length )   <= f_incr(s_dma_adr(s_dma_adr'left downto t_byte_adr'length ));

                  s_fifo_dout       <= f_cp_resize(i_wbm_dat, s_fifo_dout'length);
                  s_fifo_push       <= '1';
                  
                  s_int_period_ev   <= f_to_logic(unsigned(s_int_period_count) = 1);

                  s_total_count     <= f_sub(s_total_count, s_xfer_decr);
                                          
                  s_xfer_decr       <= f_resize(f_be_to_bcd(s_wbm_sel_xtnd(s_wbm_sel_xtnd'left downto s_wbm_sel'length )), s_xfer_decr'length );
                  
                  if ((s_dma_mode_strm = '0') and (s_mbuf_pos = s_mbuf_pos_max)) then
                     s_mbuf_pos  <= (others => '0');
                  else
                     s_mbuf_pos  <=  f_add(s_mbuf_pos, s_xfer_decr);
                  end if;

                  if (unsigned(s_int_period_count) = 0) then
                     s_int_period_count   <= s_int_period_load;
                  else
                     s_int_period_count   <= f_decr(s_int_period_count);
                  end if;

                  if (s_wbm_cti = c_wb_cti_burst_end) then
                     s_dma_adr      <= (others => '0');
                     s_dma_adr_load(t_byte_adr'range )   <= "00";
                     s_dma_adr_load(s_dma_adr'left downto t_byte_adr'length )  <= f_incr(s_dma_adr(s_dma_adr'left downto t_byte_adr'length ));

                     s_wbm_bte      <= (others => '0');
                     s_wbm_cti      <= (others => '0');
                     s_wbm_cyc      <= '0';
                     s_wbm_sel      <= (others => '0');
                     s_wbm_stb      <= '0';
                     s_wbm_wr       <= '0';         
                  else
                     s_wbm_sel   <= s_wbm_sel_xtnd(s_wbm_sel_xtnd'left downto s_wbm_sel'length );                  
                     
                     if ((unsigned(s_beat_count) = 2) or (unsigned(s_page_adr_rd) = g_dma_burst_words_rd - 2)) then
                        s_wbm_cti   <= c_wb_cti_burst_end;                   
                     end if;
                  end if;
               end if;

            when RC_WR_XFER =>
               if (i_wbm_ack = '1') then
                  s_beat_count      <= f_decr(s_beat_count);
                  
                  s_dma_adr(t_byte_adr'length - 1 downto 0)             <= (others => '0');
                  s_dma_adr(s_dma_adr'left downto t_byte_adr'length )   <= f_incr(s_dma_adr(s_dma_adr'left downto t_byte_adr'length ));
                  
                  s_int_period_ev   <= f_to_logic(unsigned(s_int_period_count) = 1);

                  s_total_count     <= f_sub(s_total_count, s_xfer_decr);

                  s_xfer_decr       <= f_resize(f_be_to_bcd(s_wbm_sel_xtnd(s_wbm_sel_xtnd'left downto s_wbm_sel'length )), s_xfer_decr'length );

                  if (unsigned(s_int_period_count) = 0) then
                     s_int_period_count   <= s_int_period_load;
                  else
                     s_int_period_count   <= f_decr(s_int_period_count);
                  end if;
                  
                  if ((s_dma_mode_strm = '0') and (s_mbuf_pos = s_mbuf_pos_max)) then
                     s_mbuf_pos  <= (others => '0');
                  else
                     s_mbuf_pos  <= f_add(s_mbuf_pos, s_xfer_decr);
                  end if;

                  if (s_wbm_last = '1') then
                     s_wbm_wdat     <= (others => '0');
                  else
                     s_wbm_wdat     <= f_cp_resize(i_fifo_rdat, s_wbm_wdat'length);
                  end if;

                  if (s_wbm_cti = c_wb_cti_burst_end) then
                     s_dma_adr      <= (others => '0');
                     s_dma_adr_load(t_byte_adr'range )   <= "00";
                     s_dma_adr_load(s_dma_adr'left downto t_byte_adr'length )  <= f_incr(s_dma_adr(s_dma_adr'left downto t_byte_adr'length ));

                     s_wbm_bte      <= (others => '0');
                     s_wbm_cti      <= (others => '0');
                     s_wbm_cyc      <= '0';
                     s_wbm_sel      <= (others => '0');
                     s_wbm_stb      <= '0';
                     s_wbm_wr       <= '0';         
                  else
                     s_wbm_sel   <= s_wbm_sel_xtnd(s_wbm_sel_xtnd'left downto s_wbm_sel'length );  
                     
                     if ((unsigned(s_beat_count) = 2) or (unsigned(s_page_adr_wr) = g_dma_burst_words_wr - 2)) then
                        s_wbm_cti   <= c_wb_cti_burst_end;
                     end if;
                  end if;
               end if;

            when RC_DMA_DONE =>
               s_dma_chain_linear   <= s_dma_chain_linear and not s_dma_chain_end;
               s_int_xfer_ev        <= s_dma_xfer_int_done or s_dma_chain_end;
               s_seq_done_ev        <= s_dma_chain_end;
               
            when RC_RECOV => 
               s_dma_chain_linear   <= s_dma_chain_linear and not s_dma_chain_end;
               
            when others =>
         end case;

         if (i_dma_clr = '1') then
            s_mbuf_pos           <= (others => '0');
            s_dma_chain_linear   <= '0';
         end if;
      end if;
   end process;
End Rtl;
