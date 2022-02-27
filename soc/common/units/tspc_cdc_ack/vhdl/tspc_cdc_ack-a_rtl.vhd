
--    
--    Copyright Ing. Buero Gardiner, 2021
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_cdc_ack-a_rtl.vhd 5369 2021-12-12 23:22:31Z  $
-- Generated   : $LastChangedDate: 2021-12-13 00:22:31 +0100 (Mon, 13 Dec 2021) $
-- Revision    : $LastChangedRevision: 5369 $
--
--------------------------------------------------------------------------------
--
-- Description :
--
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.numeric_std.all;
Use WORK.tspc_utils.all;

Architecture Rtl of tspc_cdc_ack is
   signal s_crd_flag          : std_logic;
   signal s_crd_dout          : std_logic;
   signal s_crd_mst_slv_ev    : std_logic;
   signal s_crd_rd_en         : std_logic;
   signal s_crd_ready         : std_logic;
   signal s_crd_reg_slv       : std_logic;   
   signal s_crd_rst           : std_logic;  
   signal s_crd_rst_sync      : std_logic;
   signal s_crd_wr_flag       : std_logic;
   signal s_crd_wr_flag_sync  : std_logic;
   signal s_cwr_flag          : std_logic;
   signal s_cwr_rd_flag       : std_logic;
   signal s_cwr_rd_flag_sync  : std_logic;
   signal s_cwr_ready         : std_logic;
   signal s_cwr_reg_mst       : std_logic;
   signal s_cwr_rst           : std_logic;  
   signal s_cwr_rst_sync      : std_logic;   
   
Begin
   o_rd_dout   <= s_crd_dout;
   o_rd_ready  <= s_crd_ready;
   
   o_wr_ready  <= s_cwr_ready;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_crd_mst_slv_ev   <= f_to_logic(s_crd_flag /= s_crd_wr_flag);

   R_MASK:
   if g_mask_on_empty generate
      s_crd_dout  <= '0' when (s_crd_ready = '0') 
                         else
                     s_crd_reg_slv;   
   else generate
      s_crd_dout  <= s_crd_reg_slv;      
   end generate;
   
   R_RD_EN:
   if g_rd_ready_ev generate
      s_crd_rd_en    <= s_crd_ready;
   else generate
      s_crd_rd_en    <= i_rd_en and s_crd_ready;
   end generate;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
   R_RD:
   process (i_rst_n, i_rd_clk)
   begin
      if (i_rst_n = '0') then
         s_crd_flag           <= '0';
         s_crd_ready          <= '0';
         s_crd_reg_slv        <= '0';
         s_crd_rst            <= '1';
         s_crd_rst_sync       <= '1';
         s_crd_wr_flag        <= '0';
         s_crd_wr_flag_sync   <= '0';
      elsif (rising_edge(i_rd_clk)) then
         s_crd_rst_sync  <= '0';
         s_crd_rst       <= s_crd_rst_sync;
         
         if ((i_rd_clk_en = '1') and (s_crd_rst = '0')) then
            s_crd_ready        <= s_crd_mst_slv_ev;
            s_crd_wr_flag      <= s_crd_wr_flag_sync;
            s_crd_wr_flag_sync <= s_cwr_flag;
            
            if (s_crd_mst_slv_ev = '1') then
               s_crd_reg_slv  <= s_cwr_reg_mst;
            end if;
            
            if (s_crd_rd_en = '1') then
               s_crd_flag   <= not s_crd_flag;
               s_crd_ready  <= '0';
            end if;
         end if;
      end if;
   end process;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
   R_WR:
   process (i_rst_n, i_wr_clk)
   begin
      if (i_rst_n = '0') then
         s_cwr_flag         <= '0';
         s_cwr_rd_flag      <= '0';
         s_cwr_rd_flag_sync <= '0';
         s_cwr_ready        <= '0';
         s_cwr_reg_mst      <= '0';
         s_cwr_rst          <= '1';
         s_cwr_rst_sync     <= '1';
      elsif (rising_edge(i_wr_clk)) then
         s_cwr_rst_sync  <= '0';
         s_cwr_rst       <= s_cwr_rst_sync;
         
         if ((i_wr_clk_en = '1') and (s_cwr_rst = '0')) then
            s_cwr_rd_flag      <= s_cwr_rd_flag_sync;
            s_cwr_rd_flag_sync <= s_crd_flag;
            s_cwr_ready        <= f_to_logic(s_cwr_flag = s_cwr_rd_flag);
            
            if ((i_wr_en = '1') and (s_cwr_ready = '1')) then
               s_cwr_reg_mst  <= i_wr_din;
               s_cwr_flag     <= not s_cwr_flag;
               s_cwr_ready    <= '0';
            end if;
         end if;
      end if;
   end process;
End Rtl;
