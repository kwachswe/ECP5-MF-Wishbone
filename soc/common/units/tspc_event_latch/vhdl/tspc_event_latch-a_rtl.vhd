--    
--    Copyright Ing. Buero Gardiner, 2007 - 2015
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_event_latch-a_rtl.vhd 2874 2015-07-10 23:16:13Z  $
-- Generated   : $LastChangedDate: 2015-07-11 01:16:13 +0200 (Sat, 11 Jul 2015) $
-- Revision    : $LastChangedRevision: 2874 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--    
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.numeric_std.all;

Architecture Rtl of tspc_event_latch is
   signal s_event_reg   : std_logic_vector(i_event'length -1 downto 0);
   
Begin
   o_event_reg <= std_logic_vector(resize(unsigned(s_event_reg), o_event_reg'length ));
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_MAIN:
   process (i_clk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_event_reg    <= (others => '0');
      elsif (rising_edge(i_clk)) then 
         if (i_clr = '1') then
            s_event_reg    <= (others => '0');
         else
            s_event_reg    <= s_event_reg or i_event;
         end if;
      end if; 
   end process;
end Rtl;