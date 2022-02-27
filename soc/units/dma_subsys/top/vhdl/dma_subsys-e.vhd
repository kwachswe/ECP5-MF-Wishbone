
Library IEEE;
Use IEEE.std_logic_1164.all;

Entity dma_subsys is
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
End dma_subsys;
