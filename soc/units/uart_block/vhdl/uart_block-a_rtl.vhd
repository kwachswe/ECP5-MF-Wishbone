
--
--    Copyright Ingenieurbuero Gardiner, 2007 - 2014
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
-- File ID     : $Id: uart_block-a_rtl.vhd 83 2021-12-12 22:09:26Z  $
-- Generated   : $LastChangedDate: 2021-12-12 23:09:26 +0100 (Sun, 12 Dec 2021) $
-- Revision    : $LastChangedRevision: 83 $
--
--------------------------------------------------------------------------------
--
-- Description : UART Wrapper
--
--------------------------------------------------------------------------------
Library IEEE;

Use IEEE.numeric_std.all;
Use WORK.tspc_utils.all;
Use WORK.uart_block_comps.all;

Architecture Rtl of uart_block is
   signal s_u1_int                  : std_logic_vector(g_nr_uarts - 1 downto 0);
   signal s_u1_uart_rts             : std_logic_vector(g_nr_uarts - 1 downto 0);
   signal s_u1_uart_tx              : std_logic_vector(g_nr_uarts - 1 downto 0);
   signal s_u1_uart_tx_en           : std_logic_vector(g_nr_uarts - 1 downto 0);
   signal s_u1_wb_ack               : std_logic_vector(g_nr_uarts - 1 downto 0);
   signal s_u1_wb_rdat              : t_dword_array(g_nr_uarts - 1 downto 0);
      
Begin
   o_int_req      <= std_logic_vector(resize(unsigned(s_u1_int), o_int_req'length ));
   
   o_uart_rts     <= std_logic_vector(resize(unsigned(s_u1_uart_rts), o_uart_rts'length ));
   o_uart_tx      <= std_logic_vector(resize(unsigned(s_u1_uart_tx), o_uart_tx'length ));
   o_uart_tx_en   <= std_logic_vector(resize(unsigned(s_u1_uart_tx_en), o_uart_tx_en'length ));
   
   o_wb_ack       <= or(s_u1_wb_ack);
   o_wb_dat       <= f_wired_or(s_u1_wb_rdat);
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U1_UART:
   for ix in 0 to g_nr_uarts - 1 generate
      U_16550:
      wb_16550s
         Generic Map (
            g_align        => "QWORD",
            g_tech_lib     => g_tech_lib
            )
         Port Map (
            i_clk          => i_clk_sys,
            i_xclk         => i_xclk,
            i_rst_n        => i_rst_n,

            i_cd           => c_tie_high,
            i_cts          => i_uart_cts(ix),
            i_dsr          => c_tie_high,
            i_ring         => c_tie_low,
            i_rx           => i_uart_rx(ix),
            i_wb_adr       => i_wb_adr,
            i_wb_cyc       => i_wb_cyc(ix),
            i_wb_dat       => i_wb_dat,
            i_wb_sel       => i_wb_sel,
            i_wb_stb       => i_wb_stb,
            i_wb_we        => i_wb_we,

            o_dtr          => open,
            o_int          => s_u1_int(ix),
            o_op1          => open,
            o_op2          => open,
            o_rts          => s_u1_uart_rts(ix),
            o_rxrdy        => open,
            o_tx           => s_u1_uart_tx(ix),
            o_tx_en        => s_u1_uart_tx_en(ix),
            o_txrdy        => open,
            o_wb_ack       => s_u1_wb_ack(ix),
            o_wb_dat       => s_u1_wb_rdat(ix)
            );
   end generate;
End Rtl;
