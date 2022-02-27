
--
--    Copyright Ing. Buero Gardiner, 2008 - 2011
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: wb_16550s-a_rtl.vhd 4396 2018-08-10 23:24:29Z  $
-- Generated   : $LastChangedDate: 2018-08-11 01:24:29 +0200 (Sat, 11 Aug 2018) $
-- Revision    : $LastChangedRevision: 4396 $
--
--------------------------------------------------------------------------------
--
-- Description : Entity for 16550 compatible UART with Wishbone Interface
--
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.numeric_std.all;
Use WORK.tspc_utils.all;

Architecture Rtl of wb_16550s is
   constant c_addr_lsb  : natural := f_vec_msb(i_wb_dat'length / 8);
   constant c_num_chars : natural := o_wb_dat'length / 8;
   
   signal s_rtl_addr       : std_logic_vector(2 downto 0);
   signal s_rtl_sel        : std_logic;
   signal s_rtl_wdat       : std_logic_vector(7 downto 0);
   signal s_rtl_wr_ack     : std_logic;
   signal s_u1_dout        : std_logic_vector(7 downto 0);
   signal s_wb_ack_out     : std_logic;
   signal s_wb_addr_in     : std_logic_vector(4 downto 0);
   signal s_wb_rdat_out    : std_logic_vector(o_wb_dat'length - 1 downto 0);
   signal s_wb_rd_op       : std_logic;
   signal s_wb_sel_in      : std_logic_vector(3 downto 0);
   signal s_wb_wdat_in     : std_logic_vector(31 downto 0);

   Component pcat_16550s
      Generic (
         g_mem_dmram_rx    : boolean := false;
         g_mem_dmram_tx    : boolean := false;
         g_mem_words_rx    : natural := 16;
         g_mem_words_tx    : natural := 16;
         g_tech_lib        : string := "ECP3"
         );
      Port (
         i_clk    : in  std_logic;
         i_rst_n  : in  std_logic;

         i_addr   : in  std_logic_vector(2 downto 0);
         i_cd     : in  std_logic;
         i_cts    : in  std_logic;
         i_din    : in  std_logic_vector(7 downto 0);
         i_dsr    : in  std_logic;
         i_rd     : in  std_logic;
         i_ring   : in  std_logic;
         i_rx     : in  std_logic;
         i_sel    : in  std_logic;
         i_wr     : in  std_logic;
         i_xclk   : in  std_logic;

         o_dout   : out std_logic_vector(7 downto 0);
         o_dtr    : out std_logic;
         o_int    : out std_logic;
         o_op1    : out std_logic;
         o_op2    : out std_logic;
         o_rts    : out std_logic;
         o_rxrdy  : out std_logic;
         o_tx     : out std_logic;
         o_tx_en  : out std_logic;
         o_txrdy  : out std_logic
         );
   End Component;   
   
Begin
   o_wb_ack    <= s_wb_ack_out;
   o_wb_dat    <= std_logic_vector(resize(unsigned(s_wb_rdat_out), o_wb_dat'length));
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   s_rtl_wr_ack   <= s_wb_ack_out and not s_wb_rd_op;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_BA:
   if (g_align = "QWORD") generate
         -- In this mode, data byte 'walks from rightmost to leftmost byte.
         -- The external interface must be 32 bit. Each byte retains its 
         -- affinity to a byte lane at all times.
         -- Still, only one byte can be written at a time 
      s_rtl_addr(2)  <= s_wb_addr_in(2);
      
      s_rtl_addr(1 downto 0)  <= "11" when (s_wb_sel_in(3 downto 0) = "1000") else
                                 "10" when (s_wb_sel_in(3 downto 0) = "0100") else
                                 "01" when (s_wb_sel_in(3 downto 0) = "0010") else
                                 "00";       
      
      s_rtl_sel   <= s_wb_sel_in(3) xor s_wb_sel_in(2) xor s_wb_sel_in(1) xor s_wb_sel_in(0);
                     
      s_rtl_wdat  <= s_wb_wdat_in(31 downto 24) when (s_wb_sel_in(3 downto 0) = "1000") else
                     s_wb_wdat_in(23 downto 16) when (s_wb_sel_in(3 downto 0) = "0100") else
                     s_wb_wdat_in(15 downto 8)  when (s_wb_sel_in(3 downto 0) = "0010") else
                     s_wb_wdat_in(7 downto 0); 
   end generate;
   
   R_DWA:
   if (g_align = "WORD") generate
         -- In this mode, data is carried on the right-most eight bits only.
         -- This is independent of whether the external bus is 8/16/32 bit
         -- In other words, the modem registers are aligned to an external
         -- word boundary
      s_rtl_addr  <= std_logic_vector(resize(shift_right(unsigned(s_wb_addr_in), c_addr_lsb),
                                             s_rtl_addr'length));
      s_rtl_sel   <= s_wb_sel_in(0);
      s_rtl_wdat  <= s_wb_wdat_in(7 downto 0);
   end generate;

   R_WA:
   if (g_align = "HWORD") generate
         -- In this mode, data is carried alternately on the right-most eight bits 
         -- and next right-most bits only. Thus the external bus width must be at
         -- 16 bit. Each byte retains its affinity to a byte lane at all times.
         -- Still, only one byte can be written at a time 
      s_rtl_addr  <= s_wb_addr_in(2 downto 1) & s_wb_sel_in(1);
                        
      s_rtl_sel   <= s_wb_sel_in(1) xor s_wb_sel_in(0);
                     
      s_rtl_wdat  <= s_wb_wdat_in(15 downto 8) when (s_wb_sel_in(1 downto 0) = "10") else
                     s_wb_wdat_in(7 downto 0);                                            
   end generate;
      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   U1_UART:
   pcat_16550s
      Generic Map (
         g_mem_dmram_rx    => g_mem_dmram_rx,
         g_mem_dmram_tx    => g_mem_dmram_tx,
         g_mem_words_rx    => g_mem_words_rx,
         g_mem_words_tx    => g_mem_words_tx,
         g_tech_lib        => g_tech_lib
         )
      Port Map (
         i_clk    => i_clk,
         i_rst_n  => i_rst_n,

         i_addr   => s_rtl_addr,
         i_cd     => i_cd,
         i_cts    => i_cts,
         i_din    => s_rtl_wdat,
         i_dsr    => i_dsr,
         i_rd     => s_wb_rd_op,
         i_ring   => i_ring,
         i_rx     => i_rx,
         i_sel    => s_rtl_sel,
         i_wr     => s_rtl_wr_ack,
         i_xclk   => i_xclk,

         o_dout   => s_u1_dout,
         o_dtr    => o_dtr,
         o_int    => o_int,
         o_op1    => o_op1,
         o_op2    => o_op2,
         o_rts    => o_rts,
         o_rxrdy  => o_rxrdy,
         o_tx     => o_tx,
         o_tx_en  => o_tx_en,
         o_txrdy  => o_txrdy
         );

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   R_MAIN:
   process (i_clk, i_rst_n)
   begin
      if (i_rst_n = '0') then
         s_wb_ack_out   <= '0';
         s_wb_addr_in   <= (others => '0');
         s_wb_rdat_out  <= (others => '0');
         s_wb_rd_op     <= '0';
         s_wb_sel_in    <= (others => '0');
         s_wb_wdat_in   <= (others => '0');
      elsif (rising_edge(i_clk)) then
         s_wb_ack_out   <= ((i_wb_cyc and i_wb_stb and not s_wb_ack_out and i_wb_we ) or
                            (i_wb_cyc and i_wb_stb and not s_wb_ack_out and s_wb_rd_op)) and not s_wb_ack_out;
                           
         s_wb_addr_in   <= std_logic_vector(resize(unsigned(i_wb_adr), s_wb_addr_in'length));
         s_wb_rdat_out  <= (others => '0');
         s_wb_rd_op     <= i_wb_cyc and i_wb_stb and not i_wb_we and not s_wb_ack_out;
         s_wb_sel_in    <= std_logic_vector(resize(unsigned(i_wb_sel), s_wb_sel_in'length));
         s_wb_wdat_in   <= std_logic_vector(resize(unsigned(i_wb_dat), s_wb_wdat_in'length));

         if ((s_wb_rd_op and not s_wb_ack_out) = '1') then
               --  On reads, display the same byte on all lanes. This ensures that byte lane affinity is
               --  guaranteed, independently of the external bus size
            for ix in 0 to c_num_chars - 1 loop
               s_wb_rdat_out(((ix + 1) * 8) - 1 downto ix * 8)   <= s_u1_dout;
            end loop;
         end if;
      end if;
   end process;
End Rtl;
