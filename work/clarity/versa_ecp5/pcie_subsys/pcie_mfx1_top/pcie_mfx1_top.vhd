Library IEEE;
Use IEEE.std_logic_1164.all;
Entity pcie_mfx1_top is
   Port (
      ix_clk_125 : in std_logic ;
      ix_dec_wb_cyc : in std_logic_vector (8 - 1 downto 0) ;
      ix_ipx_dl_up : in std_logic ;
      ix_ipx_malf_tlp : in std_logic ;
      ix_ipx_rx_data : in std_logic_vector (16 - 1 downto 0) ;
      ix_ipx_rx_end : in std_logic ;
      ix_ipx_rx_st : in std_logic ;
      ix_ipx_tx_ca_cpld : in std_logic_vector (12 downto 0) ;
      ix_ipx_tx_ca_cplh : in std_logic_vector (8 downto 0) ;
      ix_ipx_tx_ca_npd : in std_logic_vector (12 downto 0) ;
      ix_ipx_tx_ca_nph : in std_logic_vector (8 downto 0) ;
      ix_ipx_tx_ca_pd : in std_logic_vector (12 downto 0) ;
      ix_ipx_tx_ca_ph : in std_logic_vector (8 downto 0) ;
      ix_ipx_tx_rdy : in std_logic ;
      ix_pci_int_req : in std_logic_vector ( 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 - 1 downto 0) ;
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
 
      ox_dec_adr : out std_logic_vector (16 - 1 downto 0) ;
      ox_dec_bar_hit : out std_logic_vector (5 downto 0) ;
      ox_dec_func_hit : out std_logic_vector (7 downto 0) ;
      ox_ipx_cc_npd_num : out std_logic_vector (7 downto 0) ;
      ox_ipx_cc_pd_num : out std_logic_vector (7 downto 0) ;
      ox_ipx_cc_processed_npd : out std_logic ;
      ox_ipx_cc_processed_nph : out std_logic ;
      ox_ipx_cc_processed_pd : out std_logic ;
      ox_ipx_cc_processed_ph : out std_logic ;
      ox_ipx_tx_data : out std_logic_vector (16 - 1 downto 0) ;
      ox_ipx_tx_end : out std_logic ;
      ox_ipx_tx_req : out std_logic ;
      ox_ipx_tx_st : out std_logic ;
      ox_sys_rst_func_n : out std_logic_vector (7 downto 0) ;
      ox_sys_rst_n : out std_logic ;
      ox_wbm_adr : out std_logic_vector (16 - 1 downto 0) ;
      ox_wbm_bte : out std_logic_vector (1 downto 0) ;
      ox_wbm_cti : out std_logic_vector (2 downto 0) ;
      ox_wbm_cyc : out std_logic_vector (8 - 1 downto 0) ;
      ox_wbm_dat : out std_logic_vector (32 - 1 downto 0) ;
      ox_wbm_sel : out std_logic_vector ((32 / 8) - 1 downto 0) ;
      ox_wbm_stb : out std_logic ;
      ox_wbm_we : out std_logic ;
      ox_wbs_ack : out std_logic ;
      ox_wbs_dat : out std_logic_vector (32 - 1 downto 0) ;
      ox_wbs_err : out std_logic
   );
End pcie_mfx1_top;
 
Architecture Rtl of pcie_mfx1_top is
      constant gx_cs_f0_bar0_size : string := "8" ;
      constant gx_cs_f0_bar0_is_64_bit : integer := 0 ;
      constant gx_cs_f0_bar0_is_io_space : integer := 1 ;
      constant gx_cs_f0_bar0_is_prefetchable : integer := 1 ;
      constant gx_cs_f0_bar1_size : string := "NONE" ;
      constant gx_cs_f0_bar1_is_io_space : integer := 0 ;
      constant gx_cs_f0_bar1_is_prefetchable : integer := 1 ;
      constant gx_cs_f0_bar2_size : string := "NONE" ;
      constant gx_cs_f0_bar2_is_64_bit : integer := 0 ;
      constant gx_cs_f0_bar2_is_io_space : integer := 0 ;
      constant gx_cs_f0_bar2_is_prefetchable : integer := 1 ;
      constant gx_cs_f0_bar3_size : string := "NONE" ;
      constant gx_cs_f0_bar3_is_io_space : integer := 0 ;
      constant gx_cs_f0_bar3_is_prefetchable : integer := 1 ;
      constant gx_cs_f0_bar4_size : string := "NONE" ;
      constant gx_cs_f0_bar4_is_64_bit : integer := 0 ;
      constant gx_cs_f0_bar4_is_io_space : integer := 0 ;
      constant gx_cs_f0_bar4_is_prefetchable : integer := 1 ;
      constant gx_cs_f0_bar5_size : string := "NONE" ;
      constant gx_cs_f0_bar5_is_io_space : integer := 0 ;
      constant gx_cs_f0_bar5_is_prefetchable : integer := 1 ;
      constant gx_cs_f0_class_code : natural := 16#070002# ;
      constant gx_cs_f0_device_id : natural := 16#8C01# ;
      constant gx_cs_f0_int_count : natural := 1 ;
      constant gx_cs_f0_int_pin : string := "INTA" ;
      constant gx_cs_f0_revision_id : natural := 16#01# ;
      constant gx_cs_f0_subsystem_id : natural := 16#8C01# ;
      constant gx_cs_f1_bar0_size : string := "8" ;
      constant gx_cs_f1_bar0_is_64_bit : integer := 0 ;
      constant gx_cs_f1_bar0_is_io_space : integer := 1 ;
      constant gx_cs_f1_bar0_is_prefetchable : integer := 1 ;
      constant gx_cs_f1_bar1_size : string := "NONE" ;
      constant gx_cs_f1_bar1_is_io_space : integer := 0 ;
      constant gx_cs_f1_bar1_is_prefetchable : integer := 1 ;
      constant gx_cs_f1_bar2_size : string := "NONE" ;
      constant gx_cs_f1_bar2_is_64_bit : integer := 0 ;
      constant gx_cs_f1_bar2_is_io_space : integer := 0 ;
      constant gx_cs_f1_bar2_is_prefetchable : integer := 1 ;
      constant gx_cs_f1_bar3_size : string := "NONE" ;
      constant gx_cs_f1_bar3_is_io_space : integer := 0 ;
      constant gx_cs_f1_bar3_is_prefetchable : integer := 1 ;
      constant gx_cs_f1_bar4_size : string := "NONE" ;
      constant gx_cs_f1_bar4_is_64_bit : integer := 0 ;
      constant gx_cs_f1_bar4_is_io_space : integer := 0 ;
      constant gx_cs_f1_bar4_is_prefetchable : integer := 1 ;
      constant gx_cs_f1_bar5_size : string := "NONE" ;
      constant gx_cs_f1_bar5_is_io_space : integer := 0 ;
      constant gx_cs_f1_bar5_is_prefetchable : integer := 1 ;
      constant gx_cs_f1_class_code : natural := 16#070002# ;
      constant gx_cs_f1_device_id : natural := 16#8C01# ;
      constant gx_cs_f1_int_count : natural := 1 ;
      constant gx_cs_f1_int_pin : string := "INTB" ;
      constant gx_cs_f1_present : integer := 1 ;
      constant gx_cs_f1_revision_id : natural := 16#01# ;
      constant gx_cs_f1_subsystem_id : natural := 16#8C01# ;
      constant gx_cs_f2_bar0_size : string := "8" ;
      constant gx_cs_f2_bar0_is_64_bit : integer := 0 ;
      constant gx_cs_f2_bar0_is_io_space : integer := 1 ;
      constant gx_cs_f2_bar0_is_prefetchable : integer := 1 ;
      constant gx_cs_f2_bar1_size : string := "NONE" ;
      constant gx_cs_f2_bar1_is_io_space : integer := 0 ;
      constant gx_cs_f2_bar1_is_prefetchable : integer := 1 ;
      constant gx_cs_f2_bar2_size : string := "NONE" ;
      constant gx_cs_f2_bar2_is_64_bit : integer := 0 ;
      constant gx_cs_f2_bar2_is_io_space : integer := 0 ;
      constant gx_cs_f2_bar2_is_prefetchable : integer := 1 ;
      constant gx_cs_f2_bar3_size : string := "NONE" ;
      constant gx_cs_f2_bar3_is_io_space : integer := 0 ;
      constant gx_cs_f2_bar3_is_prefetchable : integer := 1 ;
      constant gx_cs_f2_bar4_size : string := "NONE" ;
      constant gx_cs_f2_bar4_is_64_bit : integer := 0 ;
      constant gx_cs_f2_bar4_is_io_space : integer := 0 ;
      constant gx_cs_f2_bar4_is_prefetchable : integer := 1 ;
      constant gx_cs_f2_bar5_size : string := "NONE" ;
      constant gx_cs_f2_bar5_is_io_space : integer := 0 ;
      constant gx_cs_f2_bar5_is_prefetchable : integer := 1 ;
      constant gx_cs_f2_class_code : natural := 16#070002# ;
      constant gx_cs_f2_device_id : natural := 16#8C01# ;
      constant gx_cs_f2_int_count : natural := 1 ;
      constant gx_cs_f2_int_pin : string := "INTC" ;
      constant gx_cs_f2_present : integer := 1 ;
      constant gx_cs_f2_revision_id : natural := 16#01# ;
      constant gx_cs_f2_subsystem_id : natural := 16#8C01# ;
      constant gx_cs_f3_bar0_size : string := "8" ;
      constant gx_cs_f3_bar0_is_64_bit : integer := 0 ;
      constant gx_cs_f3_bar0_is_io_space : integer := 1 ;
      constant gx_cs_f3_bar0_is_prefetchable : integer := 1 ;
      constant gx_cs_f3_bar1_size : string := "NONE" ;
      constant gx_cs_f3_bar1_is_io_space : integer := 0 ;
      constant gx_cs_f3_bar1_is_prefetchable : integer := 1 ;
      constant gx_cs_f3_bar2_size : string := "NONE" ;
      constant gx_cs_f3_bar2_is_64_bit : integer := 0 ;
      constant gx_cs_f3_bar2_is_io_space : integer := 0 ;
      constant gx_cs_f3_bar2_is_prefetchable : integer := 1 ;
      constant gx_cs_f3_bar3_size : string := "NONE" ;
      constant gx_cs_f3_bar3_is_io_space : integer := 0 ;
      constant gx_cs_f3_bar3_is_prefetchable : integer := 1 ;
      constant gx_cs_f3_bar4_size : string := "NONE" ;
      constant gx_cs_f3_bar4_is_64_bit : integer := 0 ;
      constant gx_cs_f3_bar4_is_io_space : integer := 0 ;
      constant gx_cs_f3_bar4_is_prefetchable : integer := 1 ;
      constant gx_cs_f3_bar5_size : string := "NONE" ;
      constant gx_cs_f3_bar5_is_io_space : integer := 0 ;
      constant gx_cs_f3_bar5_is_prefetchable : integer := 1 ;
      constant gx_cs_f3_class_code : natural := 16#070002# ;
      constant gx_cs_f3_device_id : natural := 16#8C01# ;
      constant gx_cs_f3_int_count : natural := 1 ;
      constant gx_cs_f3_int_pin : string := "INTD" ;
      constant gx_cs_f3_present : integer := 1 ;
      constant gx_cs_f3_revision_id : natural := 16#01# ;
      constant gx_cs_f3_subsystem_id : natural := 16#8C01# ;
      constant gx_cs_f4_bar0_size : string := "8" ;
      constant gx_cs_f4_bar0_is_64_bit : integer := 0 ;
      constant gx_cs_f4_bar0_is_io_space : integer := 1 ;
      constant gx_cs_f4_bar0_is_prefetchable : integer := 1 ;
      constant gx_cs_f4_bar1_size : string := "NONE" ;
      constant gx_cs_f4_bar1_is_io_space : integer := 0 ;
      constant gx_cs_f4_bar1_is_prefetchable : integer := 1 ;
      constant gx_cs_f4_bar2_size : string := "NONE" ;
      constant gx_cs_f4_bar2_is_64_bit : integer := 0 ;
      constant gx_cs_f4_bar2_is_io_space : integer := 0 ;
      constant gx_cs_f4_bar2_is_prefetchable : integer := 1 ;
      constant gx_cs_f4_bar3_size : string := "NONE" ;
      constant gx_cs_f4_bar3_is_io_space : integer := 0 ;
      constant gx_cs_f4_bar3_is_prefetchable : integer := 1 ;
      constant gx_cs_f4_bar4_size : string := "NONE" ;
      constant gx_cs_f4_bar4_is_64_bit : integer := 0 ;
      constant gx_cs_f4_bar4_is_io_space : integer := 0 ;
      constant gx_cs_f4_bar4_is_prefetchable : integer := 1 ;
      constant gx_cs_f4_bar5_size : string := "NONE" ;
      constant gx_cs_f4_bar5_is_io_space : integer := 0 ;
      constant gx_cs_f4_bar5_is_prefetchable : integer := 1 ;
      constant gx_cs_f4_class_code : natural := 16#070002# ;
      constant gx_cs_f4_device_id : natural := 16#8C01# ;
      constant gx_cs_f4_int_count : natural := 1 ;
      constant gx_cs_f4_int_pin : string := "INTA" ;
      constant gx_cs_f4_present : integer := 1 ;
      constant gx_cs_f4_revision_id : natural := 16#01# ;
      constant gx_cs_f4_subsystem_id : natural := 16#8C01# ;
      constant gx_cs_f5_bar0_size : string := "4K" ;
      constant gx_cs_f5_bar0_is_64_bit : integer := 0 ;
      constant gx_cs_f5_bar0_is_io_space : integer := 0 ;
      constant gx_cs_f5_bar0_is_prefetchable : integer := 0 ;
      constant gx_cs_f5_bar1_size : string := "NONE" ;
      constant gx_cs_f5_bar1_is_io_space : integer := 0 ;
      constant gx_cs_f5_bar1_is_prefetchable : integer := 1 ;
      constant gx_cs_f5_bar2_size : string := "NONE" ;
      constant gx_cs_f5_bar2_is_64_bit : integer := 0 ;
      constant gx_cs_f5_bar2_is_io_space : integer := 0 ;
      constant gx_cs_f5_bar2_is_prefetchable : integer := 1 ;
      constant gx_cs_f5_bar3_size : string := "NONE" ;
      constant gx_cs_f5_bar3_is_io_space : integer := 0 ;
      constant gx_cs_f5_bar3_is_prefetchable : integer := 1 ;
      constant gx_cs_f5_bar4_size : string := "NONE" ;
      constant gx_cs_f5_bar4_is_64_bit : integer := 0 ;
      constant gx_cs_f5_bar4_is_io_space : integer := 0 ;
      constant gx_cs_f5_bar4_is_prefetchable : integer := 1 ;
      constant gx_cs_f5_bar5_size : string := "NONE" ;
      constant gx_cs_f5_bar5_is_io_space : integer := 0 ;
      constant gx_cs_f5_bar5_is_prefetchable : integer := 1 ;
      constant gx_cs_f5_class_code : natural := 16#FF0000# ;
      constant gx_cs_f5_device_id : natural := 16#8C05# ;
      constant gx_cs_f5_int_count : natural := 1 ;
      constant gx_cs_f5_int_pin : string := "INTB" ;
      constant gx_cs_f5_present : integer := 1 ;
      constant gx_cs_f5_revision_id : natural := 16#01# ;
      constant gx_cs_f5_subsystem_id : natural := 16#8C05# ;
      constant gx_cs_f6_bar0_size : string := "4K" ;
      constant gx_cs_f6_bar0_is_64_bit : integer := 0 ;
      constant gx_cs_f6_bar0_is_io_space : integer := 0 ;
      constant gx_cs_f6_bar0_is_prefetchable : integer := 0 ;
      constant gx_cs_f6_bar1_size : string := "NONE" ;
      constant gx_cs_f6_bar1_is_io_space : integer := 0 ;
      constant gx_cs_f6_bar1_is_prefetchable : integer := 1 ;
      constant gx_cs_f6_bar2_size : string := "NONE" ;
      constant gx_cs_f6_bar2_is_64_bit : integer := 0 ;
      constant gx_cs_f6_bar2_is_io_space : integer := 0 ;
      constant gx_cs_f6_bar2_is_prefetchable : integer := 1 ;
      constant gx_cs_f6_bar3_size : string := "NONE" ;
      constant gx_cs_f6_bar3_is_io_space : integer := 0 ;
      constant gx_cs_f6_bar3_is_prefetchable : integer := 1 ;
      constant gx_cs_f6_bar4_size : string := "NONE" ;
      constant gx_cs_f6_bar4_is_64_bit : integer := 0 ;
      constant gx_cs_f6_bar4_is_io_space : integer := 0 ;
      constant gx_cs_f6_bar4_is_prefetchable : integer := 1 ;
      constant gx_cs_f6_bar5_size : string := "NONE" ;
      constant gx_cs_f6_bar5_is_io_space : integer := 0 ;
      constant gx_cs_f6_bar5_is_prefetchable : integer := 1 ;
      constant gx_cs_f6_class_code : natural := 16#FF0000# ;
      constant gx_cs_f6_device_id : natural := 16#8C06# ;
      constant gx_cs_f6_int_count : natural := 1 ;
      constant gx_cs_f6_int_pin : string := "INTC" ;
      constant gx_cs_f6_present : integer := 1 ;
      constant gx_cs_f6_revision_id : natural := 16#01# ;
      constant gx_cs_f6_subsystem_id : natural := 16#8C06# ;
      constant gx_cs_f7_bar0_size : string := "4K" ;
      constant gx_cs_f7_bar0_is_64_bit : integer := 0 ;
      constant gx_cs_f7_bar0_is_io_space : integer := 0 ;
      constant gx_cs_f7_bar0_is_prefetchable : integer := 0 ;
      constant gx_cs_f7_bar1_size : string := "NONE" ;
      constant gx_cs_f7_bar1_is_io_space : integer := 0 ;
      constant gx_cs_f7_bar1_is_prefetchable : integer := 1 ;
      constant gx_cs_f7_bar2_size : string := "NONE" ;
      constant gx_cs_f7_bar2_is_64_bit : integer := 0 ;
      constant gx_cs_f7_bar2_is_io_space : integer := 0 ;
      constant gx_cs_f7_bar2_is_prefetchable : integer := 1 ;
      constant gx_cs_f7_bar3_size : string := "NONE" ;
      constant gx_cs_f7_bar3_is_io_space : integer := 0 ;
      constant gx_cs_f7_bar3_is_prefetchable : integer := 1 ;
      constant gx_cs_f7_bar4_size : string := "NONE" ;
      constant gx_cs_f7_bar4_is_64_bit : integer := 0 ;
      constant gx_cs_f7_bar4_is_io_space : integer := 0 ;
      constant gx_cs_f7_bar4_is_prefetchable : integer := 1 ;
      constant gx_cs_f7_bar5_size : string := "NONE" ;
      constant gx_cs_f7_bar5_is_io_space : integer := 0 ;
      constant gx_cs_f7_bar5_is_prefetchable : integer := 1 ;
      constant gx_cs_f7_class_code : natural := 16#FF0000# ;
      constant gx_cs_f7_device_id : natural := 16#8C07# ;
      constant gx_cs_f7_int_count : natural := 1 ;
      constant gx_cs_f7_int_pin : string := "INTD" ;
      constant gx_cs_f7_present : integer := 1 ;
      constant gx_cs_f7_revision_id : natural := 16#01# ;
      constant gx_cs_f7_subsystem_id : natural := 16#8C07# ;
      constant gx_cs_subsystem_vendor_id : natural := 16#1204# ;
      constant gx_cs_vendor_id : natural := 16#1204# ;
      constant gx_ipx_data_sz : natural := 16 ;
      constant gx_nr_wb_tgts : positive := 8 ;
      constant gx_pcie_gen2 : integer := 0 ;
      constant gx_tech_lib : string := "ECP5UM" ;
      constant gx_wbm_data_sz : positive := 32 ;
      constant gx_wbs_data_sz : positive := 32 ;
      constant gx_wbm_adr_sz : positive := 16 ;
      constant gx_wbs_adr_sz : positive := 48 ;
 
   Component pcie_mfdev_subsys 
      Generic (
      gx_cs_f0_bar0_size : string := "NONE" ;
      gx_cs_f0_bar0_is_64_bit : integer := 0 ;
      gx_cs_f0_bar0_is_io_space : integer := 0 ;
      gx_cs_f0_bar0_is_prefetchable : integer := 1 ;
      gx_cs_f0_bar1_size : string := "NONE" ;
      gx_cs_f0_bar1_is_io_space : integer := 0 ;
      gx_cs_f0_bar1_is_prefetchable : integer := 1 ;
      gx_cs_f0_bar2_size : string := "NONE" ;
      gx_cs_f0_bar2_is_64_bit : integer := 0 ;
      gx_cs_f0_bar2_is_io_space : integer := 0 ;
      gx_cs_f0_bar2_is_prefetchable : integer := 1 ;
      gx_cs_f0_bar3_size : string := "NONE" ;
      gx_cs_f0_bar3_is_io_space : integer := 0 ;
      gx_cs_f0_bar3_is_prefetchable : integer := 1 ;
      gx_cs_f0_bar4_size : string := "NONE" ;
      gx_cs_f0_bar4_is_64_bit : integer := 0 ;
      gx_cs_f0_bar4_is_io_space : integer := 0 ;
      gx_cs_f0_bar4_is_prefetchable : integer := 1 ;
      gx_cs_f0_bar5_size : string := "NONE" ;
      gx_cs_f0_bar5_is_io_space : integer := 0 ;
      gx_cs_f0_bar5_is_prefetchable : integer := 1 ;
      gx_cs_f0_class_code : natural := 16#000000# ;
      gx_cs_f0_device_id : natural := 16#0000# ;
      gx_cs_f0_int_count : natural := 1 ;
      gx_cs_f0_int_pin : string := "INTA" ;
      gx_cs_f0_revision_id : natural := 16#00# ;
      gx_cs_f0_subsystem_id : natural := 16#0000# ;
      gx_cs_f1_bar0_size : string := "NONE" ;
      gx_cs_f1_bar0_is_64_bit : integer := 0 ;
      gx_cs_f1_bar0_is_io_space : integer := 0 ;
      gx_cs_f1_bar0_is_prefetchable : integer := 1 ;
      gx_cs_f1_bar1_size : string := "NONE" ;
      gx_cs_f1_bar1_is_io_space : integer := 0 ;
      gx_cs_f1_bar1_is_prefetchable : integer := 1 ;
      gx_cs_f1_bar2_size : string := "NONE" ;
      gx_cs_f1_bar2_is_64_bit : integer := 0 ;
      gx_cs_f1_bar2_is_io_space : integer := 0 ;
      gx_cs_f1_bar2_is_prefetchable : integer := 1 ;
      gx_cs_f1_bar3_size : string := "NONE" ;
      gx_cs_f1_bar3_is_io_space : integer := 0 ;
      gx_cs_f1_bar3_is_prefetchable : integer := 1 ;
      gx_cs_f1_bar4_size : string := "NONE" ;
      gx_cs_f1_bar4_is_64_bit : integer := 0 ;
      gx_cs_f1_bar4_is_io_space : integer := 0 ;
      gx_cs_f1_bar4_is_prefetchable : integer := 1 ;
      gx_cs_f1_bar5_size : string := "NONE" ;
      gx_cs_f1_bar5_is_io_space : integer := 0 ;
      gx_cs_f1_bar5_is_prefetchable : integer := 1 ;
      gx_cs_f1_class_code : natural := 16#000000# ;
      gx_cs_f1_device_id : natural := 16#0000# ;
      gx_cs_f1_int_count : natural := 0 ;
      gx_cs_f1_int_pin : string := "INTA" ;
      gx_cs_f1_present : integer := 0 ;
      gx_cs_f1_revision_id : natural := 16#00# ;
      gx_cs_f1_subsystem_id : natural := 16#0000# ;
      gx_cs_f2_bar0_size : string := "NONE" ;
      gx_cs_f2_bar0_is_64_bit : integer := 0 ;
      gx_cs_f2_bar0_is_io_space : integer := 0 ;
      gx_cs_f2_bar0_is_prefetchable : integer := 1 ;
      gx_cs_f2_bar1_size : string := "NONE" ;
      gx_cs_f2_bar1_is_io_space : integer := 0 ;
      gx_cs_f2_bar1_is_prefetchable : integer := 1 ;
      gx_cs_f2_bar2_size : string := "NONE" ;
      gx_cs_f2_bar2_is_64_bit : integer := 0 ;
      gx_cs_f2_bar2_is_io_space : integer := 0 ;
      gx_cs_f2_bar2_is_prefetchable : integer := 1 ;
      gx_cs_f2_bar3_size : string := "NONE" ;
      gx_cs_f2_bar3_is_io_space : integer := 0 ;
      gx_cs_f2_bar3_is_prefetchable : integer := 1 ;
      gx_cs_f2_bar4_size : string := "NONE" ;
      gx_cs_f2_bar4_is_64_bit : integer := 0 ;
      gx_cs_f2_bar4_is_io_space : integer := 0 ;
      gx_cs_f2_bar4_is_prefetchable : integer := 1 ;
      gx_cs_f2_bar5_size : string := "NONE" ;
      gx_cs_f2_bar5_is_io_space : integer := 0 ;
      gx_cs_f2_bar5_is_prefetchable : integer := 1 ;
      gx_cs_f2_class_code : natural := 16#000000# ;
      gx_cs_f2_device_id : natural := 16#0000# ;
      gx_cs_f2_int_count : natural := 0 ;
      gx_cs_f2_int_pin : string := "INTA" ;
      gx_cs_f2_present : integer := 0 ;
      gx_cs_f2_revision_id : natural := 16#00# ;
      gx_cs_f2_subsystem_id : natural := 16#0000# ;
      gx_cs_f3_bar0_size : string := "NONE" ;
      gx_cs_f3_bar0_is_64_bit : integer := 0 ;
      gx_cs_f3_bar0_is_io_space : integer := 0 ;
      gx_cs_f3_bar0_is_prefetchable : integer := 1 ;
      gx_cs_f3_bar1_size : string := "NONE" ;
      gx_cs_f3_bar1_is_io_space : integer := 0 ;
      gx_cs_f3_bar1_is_prefetchable : integer := 1 ;
      gx_cs_f3_bar2_size : string := "NONE" ;
      gx_cs_f3_bar2_is_64_bit : integer := 0 ;
      gx_cs_f3_bar2_is_io_space : integer := 0 ;
      gx_cs_f3_bar2_is_prefetchable : integer := 1 ;
      gx_cs_f3_bar3_size : string := "NONE" ;
      gx_cs_f3_bar3_is_io_space : integer := 0 ;
      gx_cs_f3_bar3_is_prefetchable : integer := 1 ;
      gx_cs_f3_bar4_size : string := "NONE" ;
      gx_cs_f3_bar4_is_64_bit : integer := 0 ;
      gx_cs_f3_bar4_is_io_space : integer := 0 ;
      gx_cs_f3_bar4_is_prefetchable : integer := 1 ;
      gx_cs_f3_bar5_size : string := "NONE" ;
      gx_cs_f3_bar5_is_io_space : integer := 0 ;
      gx_cs_f3_bar5_is_prefetchable : integer := 1 ;
      gx_cs_f3_class_code : natural := 16#000000# ;
      gx_cs_f3_device_id : natural := 16#0000# ;
      gx_cs_f3_int_count : natural := 0 ;
      gx_cs_f3_int_pin : string := "INTA" ;
      gx_cs_f3_present : integer := 0 ;
      gx_cs_f3_revision_id : natural := 16#00# ;
      gx_cs_f3_subsystem_id : natural := 16#0000# ;
      gx_cs_f4_bar0_size : string := "NONE" ;
      gx_cs_f4_bar0_is_64_bit : integer := 0 ;
      gx_cs_f4_bar0_is_io_space : integer := 0 ;
      gx_cs_f4_bar0_is_prefetchable : integer := 1 ;
      gx_cs_f4_bar1_size : string := "NONE" ;
      gx_cs_f4_bar1_is_io_space : integer := 0 ;
      gx_cs_f4_bar1_is_prefetchable : integer := 1 ;
      gx_cs_f4_bar2_size : string := "NONE" ;
      gx_cs_f4_bar2_is_64_bit : integer := 0 ;
      gx_cs_f4_bar2_is_io_space : integer := 0 ;
      gx_cs_f4_bar2_is_prefetchable : integer := 1 ;
      gx_cs_f4_bar3_size : string := "NONE" ;
      gx_cs_f4_bar3_is_io_space : integer := 0 ;
      gx_cs_f4_bar3_is_prefetchable : integer := 1 ;
      gx_cs_f4_bar4_size : string := "NONE" ;
      gx_cs_f4_bar4_is_64_bit : integer := 0 ;
      gx_cs_f4_bar4_is_io_space : integer := 0 ;
      gx_cs_f4_bar4_is_prefetchable : integer := 1 ;
      gx_cs_f4_bar5_size : string := "NONE" ;
      gx_cs_f4_bar5_is_io_space : integer := 0 ;
      gx_cs_f4_bar5_is_prefetchable : integer := 1 ;
      gx_cs_f4_class_code : natural := 16#000000# ;
      gx_cs_f4_device_id : natural := 16#0000# ;
      gx_cs_f4_int_count : natural := 0 ;
      gx_cs_f4_int_pin : string := "INTA" ;
      gx_cs_f4_present : integer := 0 ;
      gx_cs_f4_revision_id : natural := 16#00# ;
      gx_cs_f4_subsystem_id : natural := 16#0000# ;
      gx_cs_f5_bar0_size : string := "NONE" ;
      gx_cs_f5_bar0_is_64_bit : integer := 0 ;
      gx_cs_f5_bar0_is_io_space : integer := 0 ;
      gx_cs_f5_bar0_is_prefetchable : integer := 1 ;
      gx_cs_f5_bar1_size : string := "NONE" ;
      gx_cs_f5_bar1_is_io_space : integer := 0 ;
      gx_cs_f5_bar1_is_prefetchable : integer := 1 ;
      gx_cs_f5_bar2_size : string := "NONE" ;
      gx_cs_f5_bar2_is_64_bit : integer := 0 ;
      gx_cs_f5_bar2_is_io_space : integer := 0 ;
      gx_cs_f5_bar2_is_prefetchable : integer := 1 ;
      gx_cs_f5_bar3_size : string := "NONE" ;
      gx_cs_f5_bar3_is_io_space : integer := 0 ;
      gx_cs_f5_bar3_is_prefetchable : integer := 1 ;
      gx_cs_f5_bar4_size : string := "NONE" ;
      gx_cs_f5_bar4_is_64_bit : integer := 0 ;
      gx_cs_f5_bar4_is_io_space : integer := 0 ;
      gx_cs_f5_bar4_is_prefetchable : integer := 1 ;
      gx_cs_f5_bar5_size : string := "NONE" ;
      gx_cs_f5_bar5_is_io_space : integer := 0 ;
      gx_cs_f5_bar5_is_prefetchable : integer := 1 ;
      gx_cs_f5_class_code : natural := 16#000000# ;
      gx_cs_f5_device_id : natural := 16#0000# ;
      gx_cs_f5_int_count : natural := 0 ;
      gx_cs_f5_int_pin : string := "INTA" ;
      gx_cs_f5_present : integer := 0 ;
      gx_cs_f5_revision_id : natural := 16#00# ;
      gx_cs_f5_subsystem_id : natural := 16#0000# ;
      gx_cs_f6_bar0_size : string := "NONE" ;
      gx_cs_f6_bar0_is_64_bit : integer := 0 ;
      gx_cs_f6_bar0_is_io_space : integer := 0 ;
      gx_cs_f6_bar0_is_prefetchable : integer := 1 ;
      gx_cs_f6_bar1_size : string := "NONE" ;
      gx_cs_f6_bar1_is_io_space : integer := 0 ;
      gx_cs_f6_bar1_is_prefetchable : integer := 1 ;
      gx_cs_f6_bar2_size : string := "NONE" ;
      gx_cs_f6_bar2_is_64_bit : integer := 0 ;
      gx_cs_f6_bar2_is_io_space : integer := 0 ;
      gx_cs_f6_bar2_is_prefetchable : integer := 1 ;
      gx_cs_f6_bar3_size : string := "NONE" ;
      gx_cs_f6_bar3_is_io_space : integer := 0 ;
      gx_cs_f6_bar3_is_prefetchable : integer := 1 ;
      gx_cs_f6_bar4_size : string := "NONE" ;
      gx_cs_f6_bar4_is_64_bit : integer := 0 ;
      gx_cs_f6_bar4_is_io_space : integer := 0 ;
      gx_cs_f6_bar4_is_prefetchable : integer := 1 ;
      gx_cs_f6_bar5_size : string := "NONE" ;
      gx_cs_f6_bar5_is_io_space : integer := 0 ;
      gx_cs_f6_bar5_is_prefetchable : integer := 1 ;
      gx_cs_f6_class_code : natural := 16#000000# ;
      gx_cs_f6_device_id : natural := 16#0000# ;
      gx_cs_f6_int_count : natural := 0 ;
      gx_cs_f6_int_pin : string := "INTA" ;
      gx_cs_f6_present : integer := 0 ;
      gx_cs_f6_revision_id : natural := 16#00# ;
      gx_cs_f6_subsystem_id : natural := 16#0000# ;
      gx_cs_f7_bar0_size : string := "NONE" ;
      gx_cs_f7_bar0_is_64_bit : integer := 0 ;
      gx_cs_f7_bar0_is_io_space : integer := 0 ;
      gx_cs_f7_bar0_is_prefetchable : integer := 1 ;
      gx_cs_f7_bar1_size : string := "NONE" ;
      gx_cs_f7_bar1_is_io_space : integer := 0 ;
      gx_cs_f7_bar1_is_prefetchable : integer := 1 ;
      gx_cs_f7_bar2_size : string := "NONE" ;
      gx_cs_f7_bar2_is_64_bit : integer := 0 ;
      gx_cs_f7_bar2_is_io_space : integer := 0 ;
      gx_cs_f7_bar2_is_prefetchable : integer := 1 ;
      gx_cs_f7_bar3_size : string := "NONE" ;
      gx_cs_f7_bar3_is_io_space : integer := 0 ;
      gx_cs_f7_bar3_is_prefetchable : integer := 1 ;
      gx_cs_f7_bar4_size : string := "NONE" ;
      gx_cs_f7_bar4_is_64_bit : integer := 0 ;
      gx_cs_f7_bar4_is_io_space : integer := 0 ;
      gx_cs_f7_bar4_is_prefetchable : integer := 1 ;
      gx_cs_f7_bar5_size : string := "NONE" ;
      gx_cs_f7_bar5_is_io_space : integer := 0 ;
      gx_cs_f7_bar5_is_prefetchable : integer := 1 ;
      gx_cs_f7_class_code : natural := 16#000000# ;
      gx_cs_f7_device_id : natural := 16#0000# ;
      gx_cs_f7_int_count : natural := 0 ;
      gx_cs_f7_int_pin : string := "INTA" ;
      gx_cs_f7_present : integer := 0 ;
      gx_cs_f7_revision_id : natural := 16#00# ;
      gx_cs_f7_subsystem_id : natural := 16#0000# ;
      gx_cs_subsystem_vendor_id : natural := 16#0000# ;
      gx_cs_vendor_id : natural := 16#0000# ;
      gx_ipx_data_sz : natural := 16 ;
      gx_nr_wb_tgts : positive := 1 ;
      gx_pcie_gen2 : integer := 0 ;
      gx_tech_lib : string := "ECP3" ;
      gx_wbm_data_sz : positive := 8 ;
      gx_wbs_data_sz : positive := 8 ;
      gx_wbm_adr_sz : positive := 1 ;
      gx_wbs_adr_sz : positive := 1
      );
   Port (
      ix_clk_125 : in std_logic ;
      ix_rst_n : in std_logic ;
      ix_dec_wb_cyc : in std_logic_vector (gx_nr_wb_tgts - 1 downto 0) ;
      ix_ipx_dl_up : in std_logic ;
      ix_ipx_malf_tlp : in std_logic ;
      ix_ipx_pcie_linkw : in std_logic_vector (2 downto 0) := (others => '0') ;
      ix_ipx_pcie_rate : in std_logic := '0' ;
      ix_ipx_rx_data : in std_logic_vector (gx_ipx_data_sz - 1 downto 0) ;
      ix_ipx_rx_dwen : in std_logic := '0' ;
      ix_ipx_rx_end : in std_logic ;
      ix_ipx_rx_st : in std_logic ;
      ix_ipx_tx_ca_cpld : in std_logic_vector (12 downto 0) ;
      ix_ipx_tx_ca_cplh : in std_logic_vector (8 downto 0) ;
      ix_ipx_tx_ca_npd : in std_logic_vector (12 downto 0) ;
      ix_ipx_tx_ca_nph : in std_logic_vector (8 downto 0) ;
      ix_ipx_tx_ca_pd : in std_logic_vector (12 downto 0) ;
      ix_ipx_tx_ca_ph : in std_logic_vector (8 downto 0) ;
      ix_ipx_tx_rdy : in std_logic ;
      ix_ipx_tx_val : in std_logic := '1' ;
      ix_pci_int_req : in std_logic_vector ( gx_cs_f7_int_count + gx_cs_f6_int_count + gx_cs_f5_int_count + gx_cs_f4_int_count + gx_cs_f3_int_count + gx_cs_f2_int_count + gx_cs_f1_int_count + gx_cs_f0_int_count - 1 downto 0) ;
      ix_pci_rsz_f0_bar0 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f0_bar1 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f0_bar2 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f0_bar3 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f0_bar4 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f0_bar5 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f1_bar0 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f1_bar1 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f1_bar2 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f1_bar3 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f1_bar4 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f1_bar5 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f2_bar0 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f2_bar1 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f2_bar2 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f2_bar3 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f2_bar4 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f2_bar5 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f3_bar0 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f3_bar1 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f3_bar2 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f3_bar3 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f3_bar4 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f3_bar5 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f4_bar0 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f4_bar1 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f4_bar2 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f4_bar3 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f4_bar4 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f4_bar5 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f5_bar0 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f5_bar1 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f5_bar2 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f5_bar3 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f5_bar4 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f5_bar5 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f6_bar0 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f6_bar1 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f6_bar2 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f6_bar3 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f6_bar4 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f6_bar5 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f7_bar0 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f7_bar1 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f7_bar2 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f7_bar3 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f7_bar4 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_pci_rsz_f7_bar5 : in std_logic_vector (31 downto 0) := (others => '0') ;
      ix_wbm_ack : in std_logic ;
      ix_wbm_dat : in std_logic_vector (gx_wbm_data_sz - 1 downto 0) ;
      ix_wbm_err : in std_logic := '0' ;
      ix_wbs_adr : in std_logic_vector (gx_wbs_adr_sz - 1 downto 0) ;
      ix_wbs_bte : in std_logic_vector (1 downto 0) ;
      ix_wbs_cti : in std_logic_vector (2 downto 0) ;
      ix_wbs_cyc : in std_logic_vector (7 downto 0) ;
      ix_wbs_dat : in std_logic_vector (gx_wbs_data_sz - 1 downto 0) ;
      ix_wbs_sel : in std_logic_vector ((gx_wbs_data_sz / 8) - 1 downto 0) ;
      ix_wbs_stb : in std_logic ;
      ix_wbs_we : in std_logic ;
 
      ox_dec_adr : out std_logic_vector (gx_wbm_adr_sz - 1 downto 0) ;
      ox_dec_bar_hit : out std_logic_vector (5 downto 0) ;
      ox_dec_func_hit : out std_logic_vector (7 downto 0) ;
      ox_ipx_cc_npd_num : out std_logic_vector (7 downto 0) ;
      ox_ipx_cc_pd_num : out std_logic_vector (7 downto 0) ;
      ox_ipx_cc_processed_npd : out std_logic ;
      ox_ipx_cc_processed_nph : out std_logic ;
      ox_ipx_cc_processed_pd : out std_logic ;
      ox_ipx_cc_processed_ph : out std_logic ;
      ox_ipx_tx_data : out std_logic_vector (gx_ipx_data_sz - 1 downto 0) ;
      ox_ipx_tx_dwen : out std_logic ;
      ox_ipx_tx_end : out std_logic ;
      ox_ipx_tx_req : out std_logic ;
      ox_ipx_tx_st : out std_logic ;
      ox_wbm_adr : out std_logic_vector (gx_wbm_adr_sz - 1 downto 0) ;
      ox_wbm_bte : out std_logic_vector (1 downto 0) ;
      ox_wbm_cti : out std_logic_vector (2 downto 0) ;
      ox_wbm_cyc : out std_logic_vector (gx_nr_wb_tgts - 1 downto 0) ;
      ox_wbm_dat : out std_logic_vector (gx_wbm_data_sz - 1 downto 0) ;
      ox_wbm_sel : out std_logic_vector ((gx_wbm_data_sz / 8) - 1 downto 0) ;
      ox_wbm_stb : out std_logic ;
      ox_wbm_we : out std_logic ;
      ox_wbs_ack : out std_logic ;
      ox_wbs_dat : out std_logic_vector (gx_wbs_data_sz - 1 downto 0) ;
      ox_wbs_err : out std_logic ;
      ox_sys_rst_n : out std_logic ;
      ox_sys_rst_func_n : out std_logic_vector (7 downto 0)
   );
   End Component;
  
Begin
   U1_PCIE_SUBS:
   pcie_mfdev_subsys
      Generic Map (
     gx_cs_f0_bar0_size  => gx_cs_f0_bar0_size,
     gx_cs_f0_bar0_is_64_bit  => gx_cs_f0_bar0_is_64_bit,
     gx_cs_f0_bar0_is_io_space  => gx_cs_f0_bar0_is_io_space,
     gx_cs_f0_bar0_is_prefetchable  => gx_cs_f0_bar0_is_prefetchable,
     gx_cs_f0_bar1_size  => gx_cs_f0_bar1_size,
     gx_cs_f0_bar1_is_io_space  => gx_cs_f0_bar1_is_io_space,
     gx_cs_f0_bar1_is_prefetchable  => gx_cs_f0_bar1_is_prefetchable,
     gx_cs_f0_bar2_size  => gx_cs_f0_bar2_size,
     gx_cs_f0_bar2_is_64_bit  => gx_cs_f0_bar2_is_64_bit,
     gx_cs_f0_bar2_is_io_space  => gx_cs_f0_bar2_is_io_space,
     gx_cs_f0_bar2_is_prefetchable  => gx_cs_f0_bar2_is_prefetchable,
     gx_cs_f0_bar3_size  => gx_cs_f0_bar3_size,
     gx_cs_f0_bar3_is_io_space  => gx_cs_f0_bar3_is_io_space,
     gx_cs_f0_bar3_is_prefetchable  => gx_cs_f0_bar3_is_prefetchable,
     gx_cs_f0_bar4_size  => gx_cs_f0_bar4_size,
     gx_cs_f0_bar4_is_64_bit  => gx_cs_f0_bar4_is_64_bit,
     gx_cs_f0_bar4_is_io_space  => gx_cs_f0_bar4_is_io_space,
     gx_cs_f0_bar4_is_prefetchable  => gx_cs_f0_bar4_is_prefetchable,
     gx_cs_f0_bar5_size  => gx_cs_f0_bar5_size,
     gx_cs_f0_bar5_is_io_space  => gx_cs_f0_bar5_is_io_space,
     gx_cs_f0_bar5_is_prefetchable  => gx_cs_f0_bar5_is_prefetchable,
     gx_cs_f0_class_code  => gx_cs_f0_class_code,
     gx_cs_f0_device_id  => gx_cs_f0_device_id,
     gx_cs_f0_int_count  => gx_cs_f0_int_count,
     gx_cs_f0_int_pin  => gx_cs_f0_int_pin,
     gx_cs_f0_revision_id  => gx_cs_f0_revision_id,
     gx_cs_f0_subsystem_id  => gx_cs_f0_subsystem_id,
     gx_cs_f1_bar0_size  => gx_cs_f1_bar0_size,
     gx_cs_f1_bar0_is_64_bit  => gx_cs_f1_bar0_is_64_bit,
     gx_cs_f1_bar0_is_io_space  => gx_cs_f1_bar0_is_io_space,
     gx_cs_f1_bar0_is_prefetchable  => gx_cs_f1_bar0_is_prefetchable,
     gx_cs_f1_bar1_size  => gx_cs_f1_bar1_size,
     gx_cs_f1_bar1_is_io_space  => gx_cs_f1_bar1_is_io_space,
     gx_cs_f1_bar1_is_prefetchable  => gx_cs_f1_bar1_is_prefetchable,
     gx_cs_f1_bar2_size  => gx_cs_f1_bar2_size,
     gx_cs_f1_bar2_is_64_bit  => gx_cs_f1_bar2_is_64_bit,
     gx_cs_f1_bar2_is_io_space  => gx_cs_f1_bar2_is_io_space,
     gx_cs_f1_bar2_is_prefetchable  => gx_cs_f1_bar2_is_prefetchable,
     gx_cs_f1_bar3_size  => gx_cs_f1_bar3_size,
     gx_cs_f1_bar3_is_io_space  => gx_cs_f1_bar3_is_io_space,
     gx_cs_f1_bar3_is_prefetchable  => gx_cs_f1_bar3_is_prefetchable,
     gx_cs_f1_bar4_size  => gx_cs_f1_bar4_size,
     gx_cs_f1_bar4_is_64_bit  => gx_cs_f1_bar4_is_64_bit,
     gx_cs_f1_bar4_is_io_space  => gx_cs_f1_bar4_is_io_space,
     gx_cs_f1_bar4_is_prefetchable  => gx_cs_f1_bar4_is_prefetchable,
     gx_cs_f1_bar5_size  => gx_cs_f1_bar5_size,
     gx_cs_f1_bar5_is_io_space  => gx_cs_f1_bar5_is_io_space,
     gx_cs_f1_bar5_is_prefetchable  => gx_cs_f1_bar5_is_prefetchable,
     gx_cs_f1_class_code  => gx_cs_f1_class_code,
     gx_cs_f1_device_id  => gx_cs_f1_device_id,
     gx_cs_f1_int_count  => gx_cs_f1_int_count,
     gx_cs_f1_int_pin  => gx_cs_f1_int_pin,
     gx_cs_f1_present  => gx_cs_f1_present,
     gx_cs_f1_revision_id  => gx_cs_f1_revision_id,
     gx_cs_f1_subsystem_id  => gx_cs_f1_subsystem_id,
     gx_cs_f2_bar0_size  => gx_cs_f2_bar0_size,
     gx_cs_f2_bar0_is_64_bit  => gx_cs_f2_bar0_is_64_bit,
     gx_cs_f2_bar0_is_io_space  => gx_cs_f2_bar0_is_io_space,
     gx_cs_f2_bar0_is_prefetchable  => gx_cs_f2_bar0_is_prefetchable,
     gx_cs_f2_bar1_size  => gx_cs_f2_bar1_size,
     gx_cs_f2_bar1_is_io_space  => gx_cs_f2_bar1_is_io_space,
     gx_cs_f2_bar1_is_prefetchable  => gx_cs_f2_bar1_is_prefetchable,
     gx_cs_f2_bar2_size  => gx_cs_f2_bar2_size,
     gx_cs_f2_bar2_is_64_bit  => gx_cs_f2_bar2_is_64_bit,
     gx_cs_f2_bar2_is_io_space  => gx_cs_f2_bar2_is_io_space,
     gx_cs_f2_bar2_is_prefetchable  => gx_cs_f2_bar2_is_prefetchable,
     gx_cs_f2_bar3_size  => gx_cs_f2_bar3_size,
     gx_cs_f2_bar3_is_io_space  => gx_cs_f2_bar3_is_io_space,
     gx_cs_f2_bar3_is_prefetchable  => gx_cs_f2_bar3_is_prefetchable,
     gx_cs_f2_bar4_size  => gx_cs_f2_bar4_size,
     gx_cs_f2_bar4_is_64_bit  => gx_cs_f2_bar4_is_64_bit,
     gx_cs_f2_bar4_is_io_space  => gx_cs_f2_bar4_is_io_space,
     gx_cs_f2_bar4_is_prefetchable  => gx_cs_f2_bar4_is_prefetchable,
     gx_cs_f2_bar5_size  => gx_cs_f2_bar5_size,
     gx_cs_f2_bar5_is_io_space  => gx_cs_f2_bar5_is_io_space,
     gx_cs_f2_bar5_is_prefetchable  => gx_cs_f2_bar5_is_prefetchable,
     gx_cs_f2_class_code  => gx_cs_f2_class_code,
     gx_cs_f2_device_id  => gx_cs_f2_device_id,
     gx_cs_f2_int_count  => gx_cs_f2_int_count,
     gx_cs_f2_int_pin  => gx_cs_f2_int_pin,
     gx_cs_f2_present  => gx_cs_f2_present,
     gx_cs_f2_revision_id  => gx_cs_f2_revision_id,
     gx_cs_f2_subsystem_id  => gx_cs_f2_subsystem_id,
     gx_cs_f3_bar0_size  => gx_cs_f3_bar0_size,
     gx_cs_f3_bar0_is_64_bit  => gx_cs_f3_bar0_is_64_bit,
     gx_cs_f3_bar0_is_io_space  => gx_cs_f3_bar0_is_io_space,
     gx_cs_f3_bar0_is_prefetchable  => gx_cs_f3_bar0_is_prefetchable,
     gx_cs_f3_bar1_size  => gx_cs_f3_bar1_size,
     gx_cs_f3_bar1_is_io_space  => gx_cs_f3_bar1_is_io_space,
     gx_cs_f3_bar1_is_prefetchable  => gx_cs_f3_bar1_is_prefetchable,
     gx_cs_f3_bar2_size  => gx_cs_f3_bar2_size,
     gx_cs_f3_bar2_is_64_bit  => gx_cs_f3_bar2_is_64_bit,
     gx_cs_f3_bar2_is_io_space  => gx_cs_f3_bar2_is_io_space,
     gx_cs_f3_bar2_is_prefetchable  => gx_cs_f3_bar2_is_prefetchable,
     gx_cs_f3_bar3_size  => gx_cs_f3_bar3_size,
     gx_cs_f3_bar3_is_io_space  => gx_cs_f3_bar3_is_io_space,
     gx_cs_f3_bar3_is_prefetchable  => gx_cs_f3_bar3_is_prefetchable,
     gx_cs_f3_bar4_size  => gx_cs_f3_bar4_size,
     gx_cs_f3_bar4_is_64_bit  => gx_cs_f3_bar4_is_64_bit,
     gx_cs_f3_bar4_is_io_space  => gx_cs_f3_bar4_is_io_space,
     gx_cs_f3_bar4_is_prefetchable  => gx_cs_f3_bar4_is_prefetchable,
     gx_cs_f3_bar5_size  => gx_cs_f3_bar5_size,
     gx_cs_f3_bar5_is_io_space  => gx_cs_f3_bar5_is_io_space,
     gx_cs_f3_bar5_is_prefetchable  => gx_cs_f3_bar5_is_prefetchable,
     gx_cs_f3_class_code  => gx_cs_f3_class_code,
     gx_cs_f3_device_id  => gx_cs_f3_device_id,
     gx_cs_f3_int_count  => gx_cs_f3_int_count,
     gx_cs_f3_int_pin  => gx_cs_f3_int_pin,
     gx_cs_f3_present  => gx_cs_f3_present,
     gx_cs_f3_revision_id  => gx_cs_f3_revision_id,
     gx_cs_f3_subsystem_id  => gx_cs_f3_subsystem_id,
     gx_cs_f4_bar0_size  => gx_cs_f4_bar0_size,
     gx_cs_f4_bar0_is_64_bit  => gx_cs_f4_bar0_is_64_bit,
     gx_cs_f4_bar0_is_io_space  => gx_cs_f4_bar0_is_io_space,
     gx_cs_f4_bar0_is_prefetchable  => gx_cs_f4_bar0_is_prefetchable,
     gx_cs_f4_bar1_size  => gx_cs_f4_bar1_size,
     gx_cs_f4_bar1_is_io_space  => gx_cs_f4_bar1_is_io_space,
     gx_cs_f4_bar1_is_prefetchable  => gx_cs_f4_bar1_is_prefetchable,
     gx_cs_f4_bar2_size  => gx_cs_f4_bar2_size,
     gx_cs_f4_bar2_is_64_bit  => gx_cs_f4_bar2_is_64_bit,
     gx_cs_f4_bar2_is_io_space  => gx_cs_f4_bar2_is_io_space,
     gx_cs_f4_bar2_is_prefetchable  => gx_cs_f4_bar2_is_prefetchable,
     gx_cs_f4_bar3_size  => gx_cs_f4_bar3_size,
     gx_cs_f4_bar3_is_io_space  => gx_cs_f4_bar3_is_io_space,
     gx_cs_f4_bar3_is_prefetchable  => gx_cs_f4_bar3_is_prefetchable,
     gx_cs_f4_bar4_size  => gx_cs_f4_bar4_size,
     gx_cs_f4_bar4_is_64_bit  => gx_cs_f4_bar4_is_64_bit,
     gx_cs_f4_bar4_is_io_space  => gx_cs_f4_bar4_is_io_space,
     gx_cs_f4_bar4_is_prefetchable  => gx_cs_f4_bar4_is_prefetchable,
     gx_cs_f4_bar5_size  => gx_cs_f4_bar5_size,
     gx_cs_f4_bar5_is_io_space  => gx_cs_f4_bar5_is_io_space,
     gx_cs_f4_bar5_is_prefetchable  => gx_cs_f4_bar5_is_prefetchable,
     gx_cs_f4_class_code  => gx_cs_f4_class_code,
     gx_cs_f4_device_id  => gx_cs_f4_device_id,
     gx_cs_f4_int_count  => gx_cs_f4_int_count,
     gx_cs_f4_int_pin  => gx_cs_f4_int_pin,
     gx_cs_f4_present  => gx_cs_f4_present,
     gx_cs_f4_revision_id  => gx_cs_f4_revision_id,
     gx_cs_f4_subsystem_id  => gx_cs_f4_subsystem_id,
     gx_cs_f5_bar0_size  => gx_cs_f5_bar0_size,
     gx_cs_f5_bar0_is_64_bit  => gx_cs_f5_bar0_is_64_bit,
     gx_cs_f5_bar0_is_io_space  => gx_cs_f5_bar0_is_io_space,
     gx_cs_f5_bar0_is_prefetchable  => gx_cs_f5_bar0_is_prefetchable,
     gx_cs_f5_bar1_size  => gx_cs_f5_bar1_size,
     gx_cs_f5_bar1_is_io_space  => gx_cs_f5_bar1_is_io_space,
     gx_cs_f5_bar1_is_prefetchable  => gx_cs_f5_bar1_is_prefetchable,
     gx_cs_f5_bar2_size  => gx_cs_f5_bar2_size,
     gx_cs_f5_bar2_is_64_bit  => gx_cs_f5_bar2_is_64_bit,
     gx_cs_f5_bar2_is_io_space  => gx_cs_f5_bar2_is_io_space,
     gx_cs_f5_bar2_is_prefetchable  => gx_cs_f5_bar2_is_prefetchable,
     gx_cs_f5_bar3_size  => gx_cs_f5_bar3_size,
     gx_cs_f5_bar3_is_io_space  => gx_cs_f5_bar3_is_io_space,
     gx_cs_f5_bar3_is_prefetchable  => gx_cs_f5_bar3_is_prefetchable,
     gx_cs_f5_bar4_size  => gx_cs_f5_bar4_size,
     gx_cs_f5_bar4_is_64_bit  => gx_cs_f5_bar4_is_64_bit,
     gx_cs_f5_bar4_is_io_space  => gx_cs_f5_bar4_is_io_space,
     gx_cs_f5_bar4_is_prefetchable  => gx_cs_f5_bar4_is_prefetchable,
     gx_cs_f5_bar5_size  => gx_cs_f5_bar5_size,
     gx_cs_f5_bar5_is_io_space  => gx_cs_f5_bar5_is_io_space,
     gx_cs_f5_bar5_is_prefetchable  => gx_cs_f5_bar5_is_prefetchable,
     gx_cs_f5_class_code  => gx_cs_f5_class_code,
     gx_cs_f5_device_id  => gx_cs_f5_device_id,
     gx_cs_f5_int_count  => gx_cs_f5_int_count,
     gx_cs_f5_int_pin  => gx_cs_f5_int_pin,
     gx_cs_f5_present  => gx_cs_f5_present,
     gx_cs_f5_revision_id  => gx_cs_f5_revision_id,
     gx_cs_f5_subsystem_id  => gx_cs_f5_subsystem_id,
     gx_cs_f6_bar0_size  => gx_cs_f6_bar0_size,
     gx_cs_f6_bar0_is_64_bit  => gx_cs_f6_bar0_is_64_bit,
     gx_cs_f6_bar0_is_io_space  => gx_cs_f6_bar0_is_io_space,
     gx_cs_f6_bar0_is_prefetchable  => gx_cs_f6_bar0_is_prefetchable,
     gx_cs_f6_bar1_size  => gx_cs_f6_bar1_size,
     gx_cs_f6_bar1_is_io_space  => gx_cs_f6_bar1_is_io_space,
     gx_cs_f6_bar1_is_prefetchable  => gx_cs_f6_bar1_is_prefetchable,
     gx_cs_f6_bar2_size  => gx_cs_f6_bar2_size,
     gx_cs_f6_bar2_is_64_bit  => gx_cs_f6_bar2_is_64_bit,
     gx_cs_f6_bar2_is_io_space  => gx_cs_f6_bar2_is_io_space,
     gx_cs_f6_bar2_is_prefetchable  => gx_cs_f6_bar2_is_prefetchable,
     gx_cs_f6_bar3_size  => gx_cs_f6_bar3_size,
     gx_cs_f6_bar3_is_io_space  => gx_cs_f6_bar3_is_io_space,
     gx_cs_f6_bar3_is_prefetchable  => gx_cs_f6_bar3_is_prefetchable,
     gx_cs_f6_bar4_size  => gx_cs_f6_bar4_size,
     gx_cs_f6_bar4_is_64_bit  => gx_cs_f6_bar4_is_64_bit,
     gx_cs_f6_bar4_is_io_space  => gx_cs_f6_bar4_is_io_space,
     gx_cs_f6_bar4_is_prefetchable  => gx_cs_f6_bar4_is_prefetchable,
     gx_cs_f6_bar5_size  => gx_cs_f6_bar5_size,
     gx_cs_f6_bar5_is_io_space  => gx_cs_f6_bar5_is_io_space,
     gx_cs_f6_bar5_is_prefetchable  => gx_cs_f6_bar5_is_prefetchable,
     gx_cs_f6_class_code  => gx_cs_f6_class_code,
     gx_cs_f6_device_id  => gx_cs_f6_device_id,
     gx_cs_f6_int_count  => gx_cs_f6_int_count,
     gx_cs_f6_int_pin  => gx_cs_f6_int_pin,
     gx_cs_f6_present  => gx_cs_f6_present,
     gx_cs_f6_revision_id  => gx_cs_f6_revision_id,
     gx_cs_f6_subsystem_id  => gx_cs_f6_subsystem_id,
     gx_cs_f7_bar0_size  => gx_cs_f7_bar0_size,
     gx_cs_f7_bar0_is_64_bit  => gx_cs_f7_bar0_is_64_bit,
     gx_cs_f7_bar0_is_io_space  => gx_cs_f7_bar0_is_io_space,
     gx_cs_f7_bar0_is_prefetchable  => gx_cs_f7_bar0_is_prefetchable,
     gx_cs_f7_bar1_size  => gx_cs_f7_bar1_size,
     gx_cs_f7_bar1_is_io_space  => gx_cs_f7_bar1_is_io_space,
     gx_cs_f7_bar1_is_prefetchable  => gx_cs_f7_bar1_is_prefetchable,
     gx_cs_f7_bar2_size  => gx_cs_f7_bar2_size,
     gx_cs_f7_bar2_is_64_bit  => gx_cs_f7_bar2_is_64_bit,
     gx_cs_f7_bar2_is_io_space  => gx_cs_f7_bar2_is_io_space,
     gx_cs_f7_bar2_is_prefetchable  => gx_cs_f7_bar2_is_prefetchable,
     gx_cs_f7_bar3_size  => gx_cs_f7_bar3_size,
     gx_cs_f7_bar3_is_io_space  => gx_cs_f7_bar3_is_io_space,
     gx_cs_f7_bar3_is_prefetchable  => gx_cs_f7_bar3_is_prefetchable,
     gx_cs_f7_bar4_size  => gx_cs_f7_bar4_size,
     gx_cs_f7_bar4_is_64_bit  => gx_cs_f7_bar4_is_64_bit,
     gx_cs_f7_bar4_is_io_space  => gx_cs_f7_bar4_is_io_space,
     gx_cs_f7_bar4_is_prefetchable  => gx_cs_f7_bar4_is_prefetchable,
     gx_cs_f7_bar5_size  => gx_cs_f7_bar5_size,
     gx_cs_f7_bar5_is_io_space  => gx_cs_f7_bar5_is_io_space,
     gx_cs_f7_bar5_is_prefetchable  => gx_cs_f7_bar5_is_prefetchable,
     gx_cs_f7_class_code  => gx_cs_f7_class_code,
     gx_cs_f7_device_id  => gx_cs_f7_device_id,
     gx_cs_f7_int_count  => gx_cs_f7_int_count,
     gx_cs_f7_int_pin  => gx_cs_f7_int_pin,
     gx_cs_f7_present  => gx_cs_f7_present,
     gx_cs_f7_revision_id  => gx_cs_f7_revision_id,
     gx_cs_f7_subsystem_id  => gx_cs_f7_subsystem_id,
     gx_cs_subsystem_vendor_id  => gx_cs_subsystem_vendor_id,
     gx_cs_vendor_id  => gx_cs_vendor_id,
     gx_ipx_data_sz  => gx_ipx_data_sz,
     gx_nr_wb_tgts  => gx_nr_wb_tgts,
     gx_pcie_gen2  => gx_pcie_gen2,
     gx_tech_lib  => gx_tech_lib,
     gx_wbm_data_sz  => gx_wbm_data_sz,
     gx_wbs_data_sz  => gx_wbs_data_sz,
     gx_wbm_adr_sz  => gx_wbm_adr_sz,
     gx_wbs_adr_sz  => gx_wbs_adr_sz
      ) 
   Port Map (
      ix_clk_125  => ix_clk_125,
      ix_dec_wb_cyc  => ix_dec_wb_cyc,
      ix_ipx_dl_up  => ix_ipx_dl_up,
      ix_ipx_malf_tlp  => ix_ipx_malf_tlp,
      ix_ipx_rx_data  => ix_ipx_rx_data,
      ix_ipx_rx_end  => ix_ipx_rx_end,
      ix_ipx_rx_st  => ix_ipx_rx_st,
      ix_ipx_tx_ca_cpld  => ix_ipx_tx_ca_cpld,
      ix_ipx_tx_ca_cplh  => ix_ipx_tx_ca_cplh,
      ix_ipx_tx_ca_npd  => ix_ipx_tx_ca_npd,
      ix_ipx_tx_ca_nph  => ix_ipx_tx_ca_nph,
      ix_ipx_tx_ca_pd  => ix_ipx_tx_ca_pd,
      ix_ipx_tx_ca_ph  => ix_ipx_tx_ca_ph,
      ix_ipx_tx_rdy  => ix_ipx_tx_rdy,
      ix_pci_int_req  => ix_pci_int_req,
      ix_rst_n  => ix_rst_n,
      ix_wbm_ack  => ix_wbm_ack,
      ix_wbm_dat  => ix_wbm_dat,
      ix_wbs_adr  => ix_wbs_adr,
      ix_wbs_bte  => ix_wbs_bte,
      ix_wbs_cti  => ix_wbs_cti,
      ix_wbs_cyc  => ix_wbs_cyc,
      ix_wbs_dat  => ix_wbs_dat,
      ix_wbs_sel  => ix_wbs_sel,
      ix_wbs_stb  => ix_wbs_stb,
      ix_wbs_we  => ix_wbs_we,
 
      ox_dec_adr  => ox_dec_adr,
      ox_dec_bar_hit  => ox_dec_bar_hit,
      ox_dec_func_hit  => ox_dec_func_hit,
      ox_ipx_cc_npd_num  => ox_ipx_cc_npd_num,
      ox_ipx_cc_pd_num  => ox_ipx_cc_pd_num,
      ox_ipx_cc_processed_npd  => ox_ipx_cc_processed_npd,
      ox_ipx_cc_processed_nph  => ox_ipx_cc_processed_nph,
      ox_ipx_cc_processed_pd  => ox_ipx_cc_processed_pd,
      ox_ipx_cc_processed_ph  => ox_ipx_cc_processed_ph,
      ox_ipx_tx_data  => ox_ipx_tx_data,
      ox_ipx_tx_end  => ox_ipx_tx_end,
      ox_ipx_tx_req  => ox_ipx_tx_req,
      ox_ipx_tx_st  => ox_ipx_tx_st,
      ox_sys_rst_func_n  => ox_sys_rst_func_n,
      ox_sys_rst_n  => ox_sys_rst_n,
      ox_wbm_adr  => ox_wbm_adr,
      ox_wbm_bte  => ox_wbm_bte,
      ox_wbm_cti  => ox_wbm_cti,
      ox_wbm_cyc  => ox_wbm_cyc,
      ox_wbm_dat  => ox_wbm_dat,
      ox_wbm_sel  => ox_wbm_sel,
      ox_wbm_stb  => ox_wbm_stb,
      ox_wbm_we  => ox_wbm_we,
      ox_wbs_ack  => ox_wbs_ack,
      ox_wbs_dat  => ox_wbs_dat,
      ox_wbs_err  => ox_wbs_err
      );
End Rtl;
