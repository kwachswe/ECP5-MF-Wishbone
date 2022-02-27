
Library IEEE;
Use IEEE.std_logic_1164.all;

Package core_mf8c_comps is
   Component adr_decode
      Port (
         i_dec_adr         : in  std_logic_vector;
         i_dec_bar_hit     : in  std_logic_vector(5 downto 0);
         i_dec_func_hit    : in  std_logic_vector(7 downto 0);

         o_dec_wb_cyc      : out std_logic_vector
         );
   End Component;
   

   Component clock_gen
      Generic (
         g_tech_lib     : string := "ECP3"
         );
      Port (
         i_clk_125m     : in  std_logic;
         i_rst_n        : in  std_logic;

         o_clk_pll_out  : out std_logic;
         o_clk_spi      : out std_logic;
         o_pll_lock     : out std_logic;
         o_xclk         : out std_logic
         );
   End Component;
   
   
   Component dma_subsys
      Generic (
         g_tech_lib        : string := "ECP5"
         );
      Port (
         i_clk             : in  std_logic;
         i_rst_n           : in  std_logic;   
         
         i_wbm_ack         : in  std_logic;
         i_wbm_dat         : in  std_logic_vector;  
         i_wbs_adr         : in  std_logic_vector;
         i_wbs_cyc         : in  std_logic;
         i_wbs_dat         : in  std_logic_vector;
         i_wbs_sel         : in  std_logic_vector;
         i_wbs_stb         : in  std_logic;
         i_wbs_we          : in  std_logic;      
         
         o_int_req         : out std_logic;
         o_wbm_adr         : out std_logic_vector;
         o_wbm_bte         : out std_logic_vector;
         o_wbm_cti         : out std_logic_vector;
         o_wbm_cyc         : out std_logic;
         o_wbm_dat         : out std_logic_vector;
         o_wbm_sel         : out std_logic_vector;
         o_wbm_stb         : out std_logic;
         o_wbm_we          : out std_logic;
         o_wbs_ack         : out std_logic;      
         o_wbs_dat         : out std_logic_vector       
         );
   End Component;
      
      
   Component pcie_mfx1_top_combo 
      Port (
         ix_dec_wb_cyc : in std_logic_vector (8 - 1 downto 0) ;
         ix_hdinn0 : in std_logic ;
         ix_hdinp0 : in std_logic ;
         ix_pci_int_req : in std_logic_vector ( 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 - 1 downto 0) ;
         ix_refclkn : in std_logic ;
         ix_refclkp : in std_logic ;
         ix_rst_n : in std_logic ;
         ix_wbm_ack : in std_logic ;
         ix_wbm_dat : in std_logic_vector (32 - 1 downto 0) ;
         ix_wbs_adr : in std_logic_vector (48 - 1 downto 0) ;
         ix_wbs_bte : in std_logic_vector (1 downto 0) ;
         ix_wbs_cti : in std_logic_vector (2 downto 0) ;
         ix_wbs_cyc : in std_logic_vector (7 downto 0) ;
         ix_wbs_dat : in std_logic_vector (32 - 1 downto 0) ;
         ix_wbs_sel : in std_logic_vector ((32 / 8) - 1 downto 0) ;
         ix_wbs_stb : in std_logic ;
         ix_wbs_we : in std_logic ;
   
         ox_clk_125 : out std_logic;
         ox_dec_adr : out std_logic_vector (16 - 1 downto 0);
         ox_dec_bar_hit : out std_logic_vector (5 downto 0);
         ox_dec_func_hit : out std_logic_vector (7 downto 0);
         ox_dl_up : out std_logic;
         ox_hdoutn0 : out std_logic;
         ox_hdoutp0 : out std_logic;
         ox_ltssm_state : out std_logic_vector (3 downto 0);
         ox_rst_func_n : out std_logic_vector (7 downto 0);
         ox_rst_n : out std_logic;
         ox_wbm_adr : out std_logic_vector (16 - 1 downto 0);
         ox_wbm_bte : out std_logic_vector (1 downto 0);
         ox_wbm_cti : out std_logic_vector (2 downto 0);
         ox_wbm_cyc : out std_logic_vector (8 - 1 downto 0);
         ox_wbm_dat : out std_logic_vector (32 - 1 downto 0);
         ox_wbm_sel : out std_logic_vector ((32 / 8) - 1 downto 0);
         ox_wbm_stb : out std_logic;
         ox_wbm_we : out std_logic;
         ox_wbs_ack : out std_logic;
         ox_wbs_dat : out std_logic_vector (32 - 1 downto 0);
         ox_wbs_err : out std_logic
         );
   End Component;


   Component pciemf_subsys 
      Port (
         i_dec_wb_cyc : in std_logic_vector (8 - 1 downto 0) ;
         i_hdinn0 : in std_logic ;
         i_hdinp0 : in std_logic ;
         i_pci_int_req : in std_logic_vector ( 1 + 1 + 1 + 1 + 1 + 1 + 1 - 1 downto 0) ;
         i_refclkn : in std_logic ;
         i_refclkp : in std_logic ;
         i_rst_n : in std_logic ;
         i_wbm_ack : in std_logic ;
         i_wbm_dat : in std_logic_vector (32 - 1 downto 0) ;
         i_wbs_adr : in std_logic_vector (48 - 1 downto 0) ;
         i_wbs_bte : in std_logic_vector (1 downto 0) ;
         i_wbs_cti : in std_logic_vector (2 downto 0) ;
         i_wbs_cyc : in std_logic_vector (7 downto 0) ;
         i_wbs_dat : in std_logic_vector (32 - 1 downto 0) ;
         i_wbs_sel : in std_logic_vector ((32 / 8) - 1 downto 0) ;
         i_wbs_stb : in std_logic ;
         i_wbs_we : in std_logic ;
   
         o_clk_125 : out std_logic;
         o_dec_adr : out std_logic_vector (16 - 1 downto 0);
         o_dec_bar_hit : out std_logic_vector (5 downto 0);
         o_dec_func_hit : out std_logic_vector (7 downto 0);
         o_dl_up : out std_logic;
         o_hdoutn0 : out std_logic;
         o_hdoutp0 : out std_logic;
         o_ltssm_state : out std_logic_vector (3 downto 0);
         o_rst_func_n : out std_logic_vector (7 downto 0);
         o_rst_n : out std_logic;
         o_wbm_adr : out std_logic_vector (16 - 1 downto 0);
         o_wbm_bte : out std_logic_vector (1 downto 0);
         o_wbm_cti : out std_logic_vector (2 downto 0);
         o_wbm_cyc : out std_logic_vector (8 - 1 downto 0);
         o_wbm_dat : out std_logic_vector (32 - 1 downto 0);
         o_wbm_sel : out std_logic_vector ((32 / 8) - 1 downto 0);
         o_wbm_stb : out std_logic;
         o_wbm_we : out std_logic;
         o_wbs_ack : out std_logic;
         o_wbs_dat : out std_logic_vector (32 - 1 downto 0);
         o_wbs_err : out std_logic
         );
   End Component;
   

   Component tsls_wb_bmram
      Generic (
         g_array_sz        : positive;
         g_char_sz         : positive := 8;  
         g_mem_reset_mode  : string := "async";  
         g_tech_lib        : string := "ECP3";
         g_word_sz         : positive := 4
         );
      Port (
         i_clk       : in  std_logic;
         i_rst_n     : in  std_logic;
         
         i_wb_adr    : in  std_logic_vector;
         i_wb_bte    : in  std_logic_vector(1 downto 0); 
         i_wb_cti    : in  std_logic_vector(2 downto 0);
         i_wb_cyc    : in  std_logic;
         i_wb_dat    : in  std_logic_vector;
         i_wb_lock   : in  std_logic;
         i_wb_sel    : in  std_logic_vector;
         i_wb_stb    : in  std_logic;
         i_wb_we     : in  std_logic;
            
         o_wb_ack    : out std_logic;      
         o_wb_dat    : out std_logic_vector
         );
   End Component;
   
 
   Component tspc_wb_cfi_jxb3
      Generic (
         g_buf_rd_latency  : positive range 1 to 2 := 2;
         g_buf_words       : positive := 2048;
         g_spi_adr_sz      : positive := 24;
         g_spi_cmd_sz      : positive := 8;
         g_tech_lib        : string := "ECP3"
         );
      Port (
         i_clk_spi            : in  std_logic;
         i_clk_sys            : in  std_logic;
         i_rst_n              : in  std_logic;
         i_clr                : in  std_logic;
         
         i_spi_miso           : in  std_logic;
         i_sys_rdy            : in  std_logic;
         i_wb_dma_adr         : in  std_logic_vector;
         i_wb_dma_cti         : in  std_logic_vector(2 downto 0);
         i_wb_dma_cyc         : in  std_logic;
         i_wb_dma_din         : in  std_logic_vector(31 downto 0);
         i_wb_dma_sel         : in  std_logic_vector(3 downto 0);
         i_wb_dma_stb         : in  std_logic;
         i_wb_dma_we          : in  std_logic;         
         i_wb_reg_adr         : in  std_logic_vector;
         i_wb_reg_cyc         : in  std_logic;
         i_wb_reg_din         : in  std_logic_vector(31 downto 0);
         i_wb_reg_sel         : in  std_logic_vector(3 downto 0);
         i_wb_reg_stb         : in  std_logic;
         i_wb_reg_we          : in  std_logic;      

         o_img_has_update     : out std_logic;
         o_img_reload         : out std_logic;
         o_int_req            : out std_logic;
         o_spi_mosi           : out std_logic;
         o_spi_mosi_en        : out std_logic;
         o_spi_sclk           : out std_logic;
         o_spi_sclk_en        : out std_logic;
         o_spi_ssel           : out std_logic;
         o_wb_dma_ack         : out std_logic;
         o_wb_dma_dout        : out std_logic_vector;         
         o_wb_reg_ack         : out std_logic;
         o_wb_reg_dout        : out std_logic_vector   
         );   
   End Component; 
   
   
   Component uart_block
      Generic (
         g_nr_uarts        : natural := 6;
         g_tech_lib        : string := "ECP3"
         );
      Port (
         i_clk_sys      : in  std_logic;
         i_xclk         : in  std_logic;
         i_rst_n        : in  std_logic;

         i_uart_cts     : in  std_logic_vector(g_nr_uarts - 1 downto 0);
         i_uart_rx      : in  std_logic_vector(g_nr_uarts - 1 downto 0);
         i_wb_adr       : in  std_logic_vector;
         i_wb_cyc       : in  std_logic_vector(g_nr_uarts - 1 downto 0);
         i_wb_dat       : in  std_logic_vector;
         i_wb_sel       : in  std_logic_vector;
         i_wb_stb       : in  std_logic;
         i_wb_we        : in  std_logic;

         o_int_req      : out std_logic_vector(g_nr_uarts - 1 downto 0);
         o_uart_rts     : out std_logic_vector(g_nr_uarts - 1 downto 0);
         o_uart_tx      : out std_logic_vector(g_nr_uarts - 1 downto 0);
         o_wb_ack       : out std_logic;
         o_wb_dat       : out std_logic_vector
         );
   End Component;  
End core_mf8c_comps;
