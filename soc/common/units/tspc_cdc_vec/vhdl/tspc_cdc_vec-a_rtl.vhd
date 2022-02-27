
--    
--    Copyright Ing. Buero Gardiner, 2007 - 2012
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_cdc_vec-a_rtl.vhd 5253 2021-01-18 09:20:52Z  $
-- Generated   : $LastChangedDate: 2021-01-18 10:20:52 +0100 (Mon, 18 Jan 2021) $
-- Revision    : $LastChangedRevision: 5253 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--    
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.numeric_std.all;

Architecture Rtl of tspc_cdc_vec is
   subtype  t_cdc_sigs        is std_logic_vector(i_cdc_in'length - 1 downto 0);
   type     t_cdc_sigs_array  is array (natural range <>) of t_cdc_sigs;
   
   signal s_cdc_guard   : t_cdc_sigs_array(g_stages - 1 downto 0);
   signal s_cdc_sync    : t_cdc_sigs;
   signal s_rst_done    : std_logic_vector(1 downto 0);
   signal s_rst_sync_n  : std_logic;
   
Begin
   o_cdc_out   <= std_logic_vector(resize(unsigned(s_cdc_guard(g_stages - 1)), o_cdc_out'length ));

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_rst_sync_n   <= i_rst_n and s_rst_done(s_rst_done'left);
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_RST:
   process (i_clk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_rst_done     <= (others => '0');
      elsif (rising_edge(i_clk)) then
         s_rst_done        <= s_rst_done(s_rst_done'left - 1 downto 0) & '1';
      end if;
   end process;   
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_MAIN:
   process (i_clk, s_rst_sync_n)
   begin
      if (s_rst_sync_n = '0') then
         s_cdc_guard    <= (others => (others => '0'));
         s_cdc_sync     <= (others => '0');
         
      elsif (rising_edge(i_clk)) then
         s_cdc_guard(0)    <= s_cdc_sync;
         s_cdc_sync        <= i_cdc_in;

         if (g_stages > 1) then
            for ix in 1 to g_stages - 1 loop
               s_cdc_guard(ix) <= s_cdc_guard(ix - 1);
            end loop;
         end if;
      end if;
   end process;
End Rtl;     
