
Library IEEE;
Use IEEE.std_logic_1164.all;
Use WORK.tspc_dma_chan_ms_types.all;

Package dma_subsys_comps is
   
   Component dma_subsys_regs
      Port (
         i_clk                : in  std_logic;
         i_rst_n              : in  std_logic;   

         i_dma_ev_int_req     : in  std_logic;
         i_dma_hfifo_count    : in  std_logic_vector;
         i_dma_lfifo_count    : in  std_logic_vector;       
         i_dma_sta            : in  t_tspc_dma_ms_sta;
         i_dma_xfer_pos       : in  std_logic_vector;      
         i_wb_adr             : in  std_logic_vector;
         i_wb_cyc             : in  std_logic;
         i_wb_dat             : in  std_logic_vector;
         i_wb_sel             : in  std_logic_vector;
         i_wb_stb             : in  std_logic;
         i_wb_we              : in  std_logic;      

         o_dma_chh_adr        : out std_logic_vector;
         o_dma_chl_adr        : out std_logic_vector;
         o_dma_ctl            : out t_tspc_dma_ms_ctl;
         o_dma_xfer_flags     : out t_tspc_dma_ms_flags;
         o_dma_xfer_sz        : out std_logic_vector;          
         o_int_req            : out std_logic;
         o_wb_ack             : out std_logic;      
         o_wb_dat             : out std_logic_vector        
         );
   End Component;

   
   Component tspc_dma_chan_ms
      Generic (
         g_dma_burst_words_rd_hc : positive := 32;
         g_dma_burst_words_rd_lc : positive := 32;
         g_dma_burst_words_wr_hc : positive := 32;
         g_dma_burst_words_wr_lc : positive := 32;
         g_fifo_mem_words_dp     : positive := 512;
         g_fifo_mem_words_hc     : positive := 512;
         g_fifo_mem_words_lc     : positive := 512;
         g_tech_lib              : string := "ECP5"
         );
      Port (
         i_clk                : in  std_logic;
         i_rst_n              : in  std_logic;

         i_dma_chh_adr        : in  std_logic_vector;
         i_dma_chl_adr        : in  std_logic_vector;
         i_dma_ctl            : in  t_tspc_dma_ms_ctl;
         i_dma_xfer_flags     : in  t_tspc_dma_ms_flags;
         i_dma_xfer_sz        : in  std_logic_vector;
         i_tick_timeout       : in  std_logic;
         i_wbmh_ack           : in  std_logic;
         i_wbmh_dat           : in  std_logic_vector;
         i_wbml_ack           : in  std_logic;
         i_wbml_dat           : in  std_logic_vector;

         o_chh_cfifo_count    : out std_logic_vector;
         o_chl_cfifo_count    : out std_logic_vector;
         o_dma_sta            : out t_tspc_dma_ms_sta;
         o_dma_xfer_pos       : out std_logic_vector;
         o_ev_int_req         : out std_logic;
         o_wbmh_adr           : out std_logic_vector;
         o_wbmh_bte           : out std_logic_vector;
         o_wbmh_cti           : out std_logic_vector;
         o_wbmh_cyc           : out std_logic;
         o_wbmh_dat           : out std_logic_vector;
         o_wbmh_sel           : out std_logic_vector;
         o_wbmh_stb           : out std_logic;
         o_wbmh_we            : out std_logic;
         o_wbml_adr           : out std_logic_vector;
         o_wbml_bte           : out std_logic_vector;
         o_wbml_cti           : out std_logic_vector;
         o_wbml_cyc           : out std_logic;
         o_wbml_dat           : out std_logic_vector;
         o_wbml_sel           : out std_logic_vector;
         o_wbml_stb           : out std_logic;
         o_wbml_we            : out std_logic
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
   
End dma_subsys_comps;   
