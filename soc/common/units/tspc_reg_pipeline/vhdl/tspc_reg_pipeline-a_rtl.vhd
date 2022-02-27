
--    
--    Copyright Ing. Buero Gardiner, 2007 - 2012
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_reg_pipeline-a_rtl.vhd 3001 2015-10-15 18:26:31Z  $
-- Generated   : $LastChangedDate: 2015-10-15 20:26:31 +0200 (Thu, 15 Oct 2015) $
-- Revision    : $LastChangedRevision: 3001 $
--
--------------------------------------------------------------------------------
--
-- Description : Configurable Pipeline Stage
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.numeric_std.all;

Architecture Rtl of  tspc_reg_pipeline is
   subtype t_reg_stage is std_logic_vector(i_din'length - 1 downto 0);
   
   type t_reg_stage_array is array (natural range <>) of t_reg_stage;
   
   signal s_reg_stage_array      : t_reg_stage_array(g_num_stages - 1 downto 0);
   
Begin
   o_dout   <= std_logic_vector(resize(unsigned(s_reg_stage_array(g_num_stages - 1)), o_dout'length ));
    
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_MAIN:
   process(i_clk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_reg_stage_array    <= (others => (others => '0'));
         
      elsif (rising_edge(i_clk)) then
         for ix in 0 to g_num_stages - 1 loop
            if (ix = 0) then
               s_reg_stage_array(0)    <= i_din;
            else
               s_reg_stage_array(ix)    <= s_reg_stage_array(ix - 1);
            end if;
         end loop;
      end if;
   end process;
End Rtl;

