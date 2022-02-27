
Library IEEE;
Use IEEE.numeric_std.all;

Architecture Rtl of adr_decode is
   constant c_nr_funcs     : natural := i_dec_func_hit'length;
   
   signal s_dec_wb_cyc     : std_logic_vector(o_dec_wb_cyc'length - 1 downto 0);
   
Begin
   o_dec_wb_cyc   <= s_dec_wb_cyc;

      -- UARTS
   s_dec_wb_cyc(0)   <= i_dec_func_hit(0) and i_dec_bar_hit(0);
   s_dec_wb_cyc(1)   <= i_dec_func_hit(1) and i_dec_bar_hit(0);
   s_dec_wb_cyc(2)   <= i_dec_func_hit(2) and i_dec_bar_hit(0);
   s_dec_wb_cyc(3)   <= i_dec_func_hit(3) and i_dec_bar_hit(0);
   s_dec_wb_cyc(4)   <= i_dec_func_hit(4) and i_dec_bar_hit(0);

      -- DMA Regs
   s_dec_wb_cyc(5)   <= i_dec_func_hit(5) and i_dec_bar_hit(0);

      -- Target Memory
   s_dec_wb_cyc(6)   <= i_dec_func_hit(6) and i_dec_bar_hit(0);
   
      -- CFI Mem
   s_dec_wb_cyc(7)   <= i_dec_func_hit(7) and i_dec_bar_hit(0);

End Rtl;
