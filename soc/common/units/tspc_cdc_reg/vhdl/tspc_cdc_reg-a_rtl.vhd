
--    
--    Copyright Ing. Buero Gardiner, 2007 - 2012
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_cdc_reg-a_rtl.vhd 4294 2018-06-17 22:48:54Z  $
-- Generated   : $LastChangedDate: 2018-06-18 00:48:54 +0200 (Mon, 18 Jun 2018) $
-- Revision    : $LastChangedRevision: 4294 $
--
--------------------------------------------------------------------------------
--
-- Description :
--
--------------------------------------------------------------------------------

Library IEEE;

Use IEEE.numeric_std.all;
Use WORK.tspc_utils.all;

Architecture Rtl of tspc_cdc_reg is
   signal s_crd_flag          : std_logic;
   signal s_crd_dout          : std_logic_vector(o_rd_dout'length -1 downto 0);
   signal s_crd_mst_slv_ev    : std_logic;
   signal s_crd_rd_en         : std_logic;
   signal s_crd_ready         : std_logic;
   signal s_crd_reg_slv       : std_logic_vector(i_wr_din'length -1 downto 0);   
   signal s_crd_rst           : std_logic;  
   signal s_crd_rst_sync      : std_logic;
   signal s_crd_wr_flag       : std_logic;
   signal s_crd_wr_flag_sync  : std_logic;
   signal s_cwr_flag          : std_logic;
   signal s_cwr_rd_flag       : std_logic;
   signal s_cwr_rd_flag_sync  : std_logic;
   signal s_cwr_ready         : std_logic;
   signal s_cwr_reg_mst       : std_logic_vector(i_wr_din'length -1 downto 0);
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
      s_crd_dout  <= (others => '0') when (s_crd_ready = '0') 
                                     else
                     f_cp_resize(s_crd_reg_slv, s_crd_dout'length );   
   else generate
      s_crd_dout  <= f_cp_resize(s_crd_reg_slv, s_crd_dout'length );      
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
         s_crd_reg_slv        <= (others => '0');
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
         s_cwr_reg_mst      <= (others => '0');
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
