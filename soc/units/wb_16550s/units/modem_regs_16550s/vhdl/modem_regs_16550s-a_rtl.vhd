
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: modem_regs_16550s-a_rtl.vhd 5378 2021-12-13 00:15:46Z  $
-- Generated   : $LastChangedDate: 2021-12-13 01:15:46 +0100 (Mon, 13 Dec 2021) $
-- Revision    : $LastChangedRevision: 5378 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------
-- THe IBM PC uses MCR.Out2 as an an interrupt enable(set to 1) 
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.numeric_std.all;
Use WORK.modem_regs_16550s_comps.all;
Use WORK.tspc_utils.all;

Architecture Rtl of modem_regs_16550s is  
   signal s_baud_counter         : std_logic_vector(15 downto 0);
   signal s_cd_sync1             : std_logic;
   signal s_cd_sync2             : std_logic;
   signal s_cts_sync1            : std_logic;
   signal s_cts_sync2            : std_logic;
   signal s_dlls_update          : std_logic;
   signal s_dlms_update          : std_logic;
   signal s_dout                 : std_logic_vector(o_dout'length - 1 downto 0); 
   signal s_dsr_sync1            : std_logic;
   signal s_dsr_sync2            : std_logic;
   signal s_fifo_en_prev         : std_logic;
   signal s_fifo_en_update       : std_logic;
   signal s_int_ack_tx_empty     : std_logic;
   signal s_int_en_modem_status  : std_logic;
   signal s_int_modem_status     : std_logic;
   signal s_int_req              : std_logic;
   signal s_int_vector           : std_logic_vector(3 downto 0);
   signal s_int_vector_prev      : std_logic_vector(3 downto 0);
   signal s_io_ctl               : t_io_ctl;
   signal s_op_rd                : std_logic;
   signal s_op_wr                : std_logic;
   signal s_rd_en_isr            : std_logic;  
   signal s_rd_en_msr            : std_logic;
   signal s_reg_dll              : std_logic_vector(7 downto 0);
   signal s_reg_dlm              : std_logic_vector(7 downto 0);
   signal s_reg_fcr              : std_logic_vector(7 downto 0);
   signal s_reg_ier              : std_logic_vector(7 downto 0);
   signal s_reg_lcr              : std_logic_vector(7 downto 0);
   signal s_reg_mcr              : std_logic_vector(7 downto 0);
   signal s_reg_msr              : std_logic_vector(7 downto 0);
   signal s_reg_spr              : std_logic_vector(7 downto 0);
   signal s_ring_sync1           : std_logic;
   signal s_ring_sync2           : std_logic;
   signal s_u1_dlls_update       : std_logic;
   signal s_u2_dlms_update       : std_logic;
   signal s_wr_en_dll            : std_logic;
   signal s_wr_en_dlm            : std_logic;
   signal s_wr_en_fcr            : std_logic;
   signal s_wr_en_ier            : std_logic;
   signal s_wr_en_lcr            : std_logic;
   signal s_wr_en_mcr            : std_logic;
   signal s_wr_en_spr            : std_logic;
   signal s_wr_en_thr            : std_logic;
   
Begin 
   o_baud_chng          <= s_u1_dlls_update or s_u2_dlms_update;
   
   o_din                <= s_io_ctl.din;
   
   o_dma_mode           <= s_reg_fcr(c_bsel_dma_mode_en);

   o_dout               <= s_dout;
   
   o_dtr                <= s_reg_mcr(c_bsel_dtr);

   o_fifo_clr_rx        <= s_reg_fcr(c_bsel_rx_fifo_reset) or s_fifo_en_update;
   o_fifo_clr_tx        <= s_reg_fcr(c_bsel_tx_fifo_reset) or s_fifo_en_update;
   o_fifo_en            <= s_reg_fcr(c_bsel_fifo_en);
   o_fifo_threshold_sel <= s_reg_fcr(c_bsel_rx_fifo_trig_msb downto c_bsel_rx_fifo_trig_lsb);

   o_int                <= s_int_req;

   o_int_ack_tx_empty   <= s_int_ack_tx_empty; 
                             
   o_int_en_line_status <= s_reg_ier(c_bsel_int_en_rx_line);
   o_int_en_rcv_data    <= s_reg_ier(c_bsel_int_en_rx_data);
   o_int_en_tx_empty    <= s_reg_ier(c_bsel_int_en_tx_empty);

   o_loopback_en  <= s_reg_mcr(c_bsel_loopback_en);
   o_op1          <= s_reg_mcr(c_bsel_op1);
   o_op2          <= s_reg_mcr(c_bsel_op2);
   
   o_par_en       <= s_reg_lcr(c_bsel_par_en);
   o_par_even     <= s_reg_lcr(c_bsel_par_even);
   o_par_stick    <= s_reg_lcr(c_bsel_par_stick);

   o_rd_en_isr    <= s_rd_en_isr;
   
   o_rd_en_lsr    <= s_op_rd and f_to_logic(s_io_ctl.addr = c_reg_addr_lsr);
   
   o_rd_en_rhr    <= s_op_rd and f_to_logic(s_io_ctl.addr = c_reg_addr_rhr)
                             and not s_reg_lcr(c_bsel_divisor_en);

   o_rts          <= s_reg_mcr(c_bsel_rts);

   o_send_break   <= s_reg_lcr(c_bsel_send_break);
   o_stop_bits    <= s_reg_lcr(c_bsel_stop_bits);
   o_word_length  <= s_reg_lcr(c_bsel_word_length_msb downto c_bsel_word_length_lsb);

   o_wr_en_thr    <= s_op_wr and f_to_logic(s_io_ctl.addr = c_reg_addr_thr)
                             and not s_reg_lcr(c_bsel_divisor_en);
                                 
   o_xclk_en      <= f_to_logic(unsigned(s_baud_counter) = 0);
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_int_en_modem_status   <= s_reg_ier(c_bsel_int_en_modem);

   s_op_rd     <= s_io_ctl.rd and not i_rd;

   s_op_wr     <= s_io_ctl.wr and not i_wr;
   
   s_rd_en_isr <= s_op_rd and f_to_logic(s_io_ctl.addr = c_reg_addr_isr);
   
   s_rd_en_msr <= s_op_rd and f_to_logic(s_io_ctl.addr = c_reg_addr_msr);
                           
   s_wr_en_dll <= s_op_wr and f_to_logic(s_io_ctl.addr = c_reg_addr_dll)
                          and s_reg_lcr(c_bsel_divisor_en);

   s_wr_en_dlm <= s_op_wr and f_to_logic(s_io_ctl.addr = c_reg_addr_dlm)
                          and s_reg_lcr(c_bsel_divisor_en);
                                                                  
   s_wr_en_fcr <= s_op_wr and f_to_logic(s_io_ctl.addr = c_reg_addr_fcr);

   s_wr_en_ier <= s_op_wr and f_to_logic(s_io_ctl.addr = c_reg_addr_ier)
                          and not s_reg_lcr(c_bsel_divisor_en);

   s_wr_en_lcr <= s_op_wr and f_to_logic(s_io_ctl.addr = c_reg_addr_lcr);

   s_wr_en_mcr <= s_op_wr and f_to_logic(s_io_ctl.addr = c_reg_addr_mcr);

   s_wr_en_spr <= s_op_wr and f_to_logic(s_io_ctl.addr = c_reg_addr_spr);

   s_wr_en_thr <= s_op_wr and f_to_logic(s_io_ctl.addr = c_reg_addr_thr);
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_RD_MUX:
   process (all)
   begin
      if ((i_rd = '1') and (i_sel = '1')) then
         case i_addr is
            when c_reg_addr_rhr =>
               if (s_reg_lcr(c_bsel_divisor_en) = '1') then
                  s_dout   <= s_reg_dll;
               else
                  s_dout   <= i_rhr_din;
               end if;

            when c_reg_addr_ier =>
               if (s_reg_lcr(c_bsel_divisor_en) = '1') then
                  s_dout   <= s_reg_dlm;
               else
                  s_dout   <= s_reg_ier and c_reg_mask_ier;
               end if;

            when c_reg_addr_isr =>
               s_dout   <= s_reg_fcr(c_bsel_fifo_en) & s_reg_fcr(c_bsel_fifo_en) & "00" &
                           s_int_vector;
               
            when c_reg_addr_lcr =>
               s_dout   <= s_reg_lcr;

            when c_reg_addr_lsr =>
               s_dout   <= i_lsr_din;
               
            when c_reg_addr_mcr =>
               s_dout   <= s_reg_mcr and c_reg_mask_mcr;

            when c_reg_addr_msr =>
               s_dout   <= s_reg_msr;

            when c_reg_addr_spr =>
               s_dout   <= s_reg_spr;
                                                                                                         
            when others => 
               s_dout   <= (others => '0');
         end case;
      else
         s_dout   <= (others => '0');
      end if;
   end process;
         
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_BAUD_RATE:
   process (i_xclk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_baud_counter    <= (others => '0');
      elsif (rising_edge(i_xclk)) then
         if ((unsigned(s_baud_counter) = 0) or (s_u1_dlls_update = '1') or (s_u2_dlms_update = '1')) then
            if ((unsigned(s_reg_dlm) = 0) and (unsigned(s_reg_dll) = 0)) then
               s_baud_counter   <= (others => '0');
            else
               s_baud_counter <= std_logic_vector((unsigned(s_reg_dlm) & unsigned(s_reg_dll)) - 1);
            end if;
         else
            s_baud_counter <= std_logic_vector(unsigned(s_baud_counter) - 1);
         end if;
      end if;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_IO_CTL:
   process (i_clk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_io_ctl <= c_io_ctl_init;
      elsif (rising_edge(i_clk)) then
         s_io_ctl.addr  <= i_addr;
         s_io_ctl.din   <= i_din;
         if (i_sel = '1') then
            s_io_ctl.rd    <= i_rd;
            s_io_ctl.wr    <= i_wr;
         else
            s_io_ctl.rd    <= '0';
            s_io_ctl.wr    <= '0';
         end if;
      end if;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_INT_VECTOR:
   process (i_clk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_int_req      <= '0';
         s_int_vector   <= c_int_src_none;
      elsif (rising_edge(i_clk)) then
         s_int_req   <= f_to_logic(s_int_vector /= c_int_src_none);
         
            -- Prio 1: Line Status Interrupt
         if ((s_reg_ier(c_bsel_int_en_rx_line) = '1') and
             (i_int_line_status = '1')) then
            s_int_vector   <= c_int_src_rx_line_sta; 

            -- Prio 2: Rx Data Timeout
         elsif ((s_reg_ier(c_bsel_int_en_rx_data) = '1') and
                (i_int_rcv_timer = '1')) then
            s_int_vector   <= c_int_src_rx_timer; 

            -- Prio 3: Rx Data Ready
         elsif ((s_reg_ier(c_bsel_int_en_rx_data) = '1') and
                (i_int_rcv_data = '1')) then
            s_int_vector   <= c_int_src_rx_data; 

            -- Prio 4: Tx FIFO Empty
         elsif ((s_reg_ier(c_bsel_int_en_tx_empty) = '1') and
                (s_int_ack_tx_empty = '0') and
                (i_int_tx_empty = '1')) then
            s_int_vector   <= c_int_src_tx_empty; 

            -- Prio 5: Modem Status
         elsif ((s_reg_ier(c_bsel_int_en_modem) = '1') and
                (s_int_modem_status = '1')) then
            s_int_vector   <= c_int_src_modem_sta; 

         else
            s_int_vector   <= c_int_src_none;
         end if;
      end if;
   end process;
      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_REG_BLOCK:
   process (i_clk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_dlls_update        <= '0';
         s_dlms_update        <= '0';
         s_fifo_en_prev       <= '0';
         s_fifo_en_update     <= '0';
         s_int_ack_tx_empty   <= '0';
         s_int_vector_prev    <= (others => '0');
         s_reg_dll            <= c_reg_init_dll;
         s_reg_dlm            <= c_reg_init_dlm;
         s_reg_fcr            <= c_reg_init_fcr;
         s_reg_ier            <= c_reg_init_ier;
         s_reg_lcr            <= c_reg_init_lcr;
         s_reg_mcr            <= c_reg_init_mcr;
         s_reg_spr            <= c_reg_init_spr;
      elsif (rising_edge(i_clk)) then
         s_dlls_update        <= '0';
         s_dlms_update        <= '0';

         s_fifo_en_prev       <= s_reg_fcr(c_bsel_fifo_en);
         s_fifo_en_update     <= s_fifo_en_prev xor s_reg_fcr(c_bsel_fifo_en);
                
         s_int_ack_tx_empty   <= s_wr_en_thr or 
                                 (s_rd_en_isr and f_to_logic(s_int_vector_prev = c_int_src_tx_empty));
         
         s_int_vector_prev    <= s_int_vector;
          
         if (s_wr_en_dll = '1') then
            s_reg_dll         <= s_io_ctl.din;
            s_dlls_update     <= '1';
         end if;
         if (s_wr_en_dlm = '1') then
            s_reg_dlm         <= s_io_ctl.din;
            s_dlms_update     <= '1';
         end if;
         if (s_wr_en_fcr = '1') then
            s_reg_fcr   <= s_io_ctl.din and c_reg_mask_fcr;
         else
            s_reg_fcr   <= s_reg_fcr and c_reg_mask_fcr_fifo_clr;
         end if;
         if (s_wr_en_ier = '1') then
            s_reg_ier   <= s_io_ctl.din and c_reg_mask_ier;
         end if;
         if (s_wr_en_lcr = '1') then
            s_reg_lcr   <= s_io_ctl.din;
         end if;
         if (s_wr_en_mcr = '1') then
            s_reg_mcr   <= s_io_ctl.din and c_reg_mask_mcr;
         end if;
         if (s_wr_en_spr = '1') then
            s_reg_spr   <= s_io_ctl.din;
         end if;
      end if;
   end process;
         
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_REG_MSR:
   process (i_clk, i_rst_n)
      variable v_delta_cd              : std_logic;
      variable v_delta_cts             : std_logic;
      variable v_delta_dsr             : std_logic;
      variable v_delta_ring            : std_logic;
   begin
      if (i_rst_n = '0') then
         s_int_modem_status   <= '0';
         s_reg_msr            <= (others => '0');
      elsif (rising_edge(i_clk)) then
         s_reg_msr(7 downto 4)   <= s_cd_sync2 & s_ring_sync2 & s_dsr_sync2 & s_cts_sync2;
         if (s_rd_en_msr = '1') then
            s_int_modem_status      <= '0';
            s_reg_msr(3 downto 0)   <= (others => '0');
         else
            v_delta_cd     := f_to_logic(s_reg_msr(7) /= s_cd_sync2);
            v_delta_cts    := f_to_logic(s_reg_msr(4) /= s_cts_sync2);
            v_delta_dsr    := f_to_logic(s_reg_msr(5) /= s_dsr_sync2);
            v_delta_ring   := f_to_logic(s_reg_msr(6) /= s_ring_sync2);

            s_int_modem_status   <= s_int_en_modem_status and
                                    f_to_logic(unsigned(s_reg_msr(3 downto 0)) /= 0);
                                                          
            s_reg_msr(3)   <= s_reg_msr(3) or v_delta_cd;
            s_reg_msr(2)   <= s_reg_msr(2) or v_delta_ring;
            s_reg_msr(1)   <= s_reg_msr(1) or v_delta_dsr;
            s_reg_msr(0)   <= s_reg_msr(0) or v_delta_cts;
         end if;
      end if;
   end process;
      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   P_SYNC:
   process (i_clk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_cd_sync1     <= '0';
         s_cd_sync2     <= '0';
         s_cts_sync1    <= '0';
         s_cts_sync2    <= '0';
         s_dsr_sync1    <= '0';
         s_dsr_sync2    <= '0';
         s_ring_sync1   <= '0';
         s_ring_sync2   <= '0';
      elsif(rising_edge(i_clk)) then
         s_cd_sync1     <= i_cd;
         s_cd_sync2     <= s_cd_sync1;
         s_cts_sync1    <= i_cts;
         s_cts_sync2    <= s_cts_sync1;
         s_dsr_sync1    <= i_dsr;
         s_dsr_sync2    <= s_dsr_sync1;
         s_ring_sync1   <= i_ring;
         s_ring_sync2   <= s_ring_sync1;
      end if;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
   U1_CDC_DLLS:
   tspc_cdc_ack
      Port Map (
         i_rst_n        => i_rst_n,

         i_rd_clk       => i_xclk,
         i_rd_clk_en    => c_tie_high,
         i_rd_en        => s_u1_dlls_update,

         i_wr_clk       => i_clk,
         i_wr_clk_en    => c_tie_high,
         i_wr_din       => c_tie_low,
         i_wr_en        => s_dlls_update,

         o_rd_dout      => open,
         o_rd_ready     => s_u1_dlls_update,

         o_wr_ready     => open
         );   

   U2_CDC_DLMS:
   tspc_cdc_ack
      Port Map (
         i_rst_n        => i_rst_n,

         i_rd_clk       => i_xclk,
         i_rd_clk_en    => c_tie_high,
         i_rd_en        => s_u2_dlms_update,

         i_wr_clk       => i_clk,
         i_wr_clk_en    => c_tie_high,
         i_wr_din       => c_tie_low,
         i_wr_en        => s_dlms_update,

         o_rd_dout      => open,
         o_rd_ready     => s_u2_dlms_update,

         o_wr_ready     => open
         );   
End Rtl;
