Library IEEE;
Use IEEE.std_logic_1164.all;
 
Entity pcie_mfx1_top_combo is
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
End pcie_mfx1_top_combo;
 
Architecture Rtl of pcie_mfx1_top_combo is
   constant c_tie_high       : std_logic := '1';
   constant c_tie_high_bus   : std_logic_vector(63 downto 0) := (others => '1');
   constant c_tie_low        : std_logic := '0';
   constant c_tie_low_bus    : std_logic_vector(63 downto 0) := (others => '0');

   Component pcie_x1_top_core 
      Port (
         cmpln_tout : in std_logic;
         cmpltr_abort_np : in std_logic;
         cmpltr_abort_p : in std_logic;
         force_disable_scr : in std_logic;
         force_lsm_active : in std_logic;
         force_phy_status : in std_logic;
         force_rec_ei : in std_logic;
         hl_disable_scr : in std_logic;
         hl_gto_cfg : in std_logic;
         hl_gto_det : in std_logic;
         hl_gto_dis : in std_logic;
         hl_gto_hrst : in std_logic;
         hl_gto_l0stx : in std_logic;
         hl_gto_l0stxfts : in std_logic;
         hl_gto_l1 : in std_logic;
         hl_gto_l2 : in std_logic;
         hl_gto_lbk : in std_logic;
         hl_gto_rcvry : in std_logic;
         hl_snd_beacon : in std_logic;
         inta_n : in std_logic;
         msi : in std_logic_vector ( 7 downto 0);
         no_pcie_train : in std_logic;
         np_req_pend : in std_logic;
         npd_buf_status_vc0 : in std_logic;
         npd_num_vc0 : in std_logic_vector ( 7 downto 0);
         npd_processed_vc0 : in std_logic;
         nph_buf_status_vc0 : in std_logic;
         nph_processed_vc0 : in std_logic;
         pd_buf_status_vc0 : in std_logic;
         pd_num_vc0 : in std_logic_vector ( 7 downto 0);
         pd_processed_vc0 : in std_logic;
         ph_buf_status_vc0 : in std_logic;
         ph_processed_vc0 : in std_logic;
         phy_status : in std_logic;
         pme_status : in std_logic;
         rst_n : in std_logic;
         rxp_data : in std_logic_vector ( 7 downto 0);
         rxp_data_k : in std_logic;
         rxp_elec_idle : in std_logic;
         rxp_status : in std_logic_vector ( 2 downto 0);
         rxp_valid : in std_logic;
         sys_clk_125 : in std_logic;
         sys_clk_250 : in std_logic;
         tx_data_vc0 : in std_logic_vector ( 15 downto 0);
         tx_dllp_val : in std_logic_vector ( 1 downto 0);
         tx_end_vc0 : in std_logic;
         tx_lbk_data : in std_logic_vector ( 15 downto 0);
         tx_lbk_kcntl : in std_logic_vector ( 1 downto 0);
         tx_nlfy_vc0 : in std_logic;
         tx_pmtype : in std_logic_vector ( 2 downto 0);
         tx_req_vc0 : in std_logic;
         tx_st_vc0 : in std_logic;
         tx_vsd_data : in std_logic_vector ( 23 downto 0);
         unexp_cmpln : in std_logic;
         ur_np_ext : in std_logic;
         ur_p_ext : in std_logic;
         bus_num : out std_logic_vector ( 7 downto 0) ;
         cmd_reg_out : out std_logic_vector ( 5 downto 0) ;
         dev_cntl_out : out std_logic_vector ( 14 downto 0) ;
         dev_num : out std_logic_vector ( 4 downto 0) ;
         dl_active : out std_logic ;
         dl_inactive : out std_logic ;
         dl_init : out std_logic ;
         dl_up : out std_logic ;
         func_num : out std_logic_vector ( 2 downto 0) ;
         lnk_cntl_out : out std_logic_vector ( 7 downto 0) ;
         mm_enable : out std_logic_vector ( 2 downto 0) ;
         msi_enable : out std_logic ;
         phy_ltssm_state : out std_logic_vector ( 3 downto 0) ;
         phy_pol_compliance : out std_logic ;
         pm_power_state : out std_logic_vector ( 1 downto 0) ;
         pme_en : out std_logic ;
         power_down : out std_logic_vector ( 1 downto 0) ;
         reset_n : out std_logic ;
         rx_bar_hit : out std_logic_vector ( 6 downto 0) ;
         rx_data_vc0 : out std_logic_vector ( 15 downto 0) ;
         rx_end_vc0 : out std_logic ;
         rx_lbk_data : out std_logic_vector ( 15 downto 0) ;
         rx_lbk_kcntl : out std_logic_vector ( 1 downto 0) ;
         rx_malf_tlp_vc0 : out std_logic ;
         rx_st_vc0 : out std_logic ;
         rx_tlp_rcvd : out std_logic ;
         rx_us_req_vc0 : out std_logic ;
         rxdp_dllp_val : out std_logic_vector ( 1 downto 0) ;
         rxdp_pmd_type : out std_logic_vector ( 2 downto 0) ;
         rxdp_vsd_data : out std_logic_vector ( 23 downto 0) ;
         rxp_polarity : out std_logic ;
         tx_ca_cpl_recheck_vc0 : out std_logic ;
         tx_ca_cpld_vc0 : out std_logic_vector ( 12 downto 0) ;
         tx_ca_cplh_vc0 : out std_logic_vector ( 8 downto 0) ;
         tx_ca_npd_vc0 : out std_logic_vector ( 12 downto 0) ;
         tx_ca_nph_vc0 : out std_logic_vector ( 8 downto 0) ;
         tx_ca_p_recheck_vc0 : out std_logic ;
         tx_ca_pd_vc0 : out std_logic_vector ( 12 downto 0) ;
         tx_ca_ph_vc0 : out std_logic_vector ( 8 downto 0) ;
         tx_dllp_pend : out std_logic ;
         tx_dllp_sent : out std_logic ;
         tx_lbk_rdy : out std_logic ;
         tx_rbuf_empty : out std_logic ;
         tx_rdy_vc0 : out std_logic ;
         txp_compliance : out std_logic ;
         txp_data : out std_logic_vector ( 7 downto 0) ;
         txp_data_k : out std_logic ;
         txp_detect_rx_lb : out std_logic ;
         txp_elec_idle : out std_logic
         );
   End Component;


   Component pcie_x1_top_phy 
      Port (
         PowerDown : in std_logic_vector ( 1 downto 0);
         RESET_n : in std_logic;
         RxPolarity_0 : in std_logic;
         TxCompliance_0 : in std_logic;
         TxDataK_0 : in std_logic_vector ( 0 downto 0);
         TxData_0 : in std_logic_vector ( 7 downto 0);
         TxDetectRx_Loopback : in std_logic;
         TxElecIdle_0 : in std_logic;
         ctc_disable : in std_logic;
         flip_lanes : in std_logic;
         hdinn0 : in std_logic;
         hdinp0 : in std_logic;
         phy_cfgln : in std_logic_vector ( 3 downto 0);
         phy_l0 : in std_logic;
         pll_refclki : in std_logic;
         rxrefclk : in std_logic;
         sci_addr : in std_logic_vector ( 5 downto 0);
         sci_en : in std_logic;
         sci_en_dual : in std_logic;
         sci_rd : in std_logic;
         sci_sel : in std_logic;
         sci_sel_dual : in std_logic;
         sci_wrdata : in std_logic_vector ( 7 downto 0);
         sci_wrn : in std_logic;
         sli_rst : in std_logic;
         PCLK : out std_logic ;
         PCLK_by_2 : out std_logic ;
         PhyStatus : out std_logic ;
         RxDataK_0 : out std_logic_vector ( 0 downto 0) ;
         RxData_0 : out std_logic_vector ( 7 downto 0) ;
         RxElecIdle_0 : out std_logic ;
         RxStatus_0 : out std_logic_vector ( 2 downto 0) ;
         RxValid_0 : out std_logic ;
         ffs_plol : out std_logic ;
         ffs_rlol_ch0 : out std_logic ;
         hdoutn0 : out std_logic ;
         hdoutp0 : out std_logic ;
         pcie_ip_rstn : out std_logic ;
         sci_int : out std_logic ;
         sci_rddata : out std_logic_vector ( 7 downto 0) ;
         serdes_pdb : out std_logic ;
         serdes_rst_dual_c : out std_logic ;
         tx_pwrup_c : out std_logic ;
         tx_serdes_rst_c : out std_logic
         );
   End Component;


   Component pcie_refclk 
      Port (
         refclkn : in std_logic;
         refclkp : in std_logic;
         refclko : out std_logic
         );
   End Component;


   Component pcie_mfx1_top 
      Port (
         ix_clk_125 : in std_logic;
         ix_dec_wb_cyc : in std_logic_vector ( 8 - 1 downto 0);
         ix_ipx_dl_up : in std_logic;
         ix_ipx_malf_tlp : in std_logic;
         ix_ipx_rx_data : in std_logic_vector ( 16 - 1 downto 0);
         ix_ipx_rx_end : in std_logic;
         ix_ipx_rx_st : in std_logic;
         ix_ipx_tx_ca_cpld : in std_logic_vector ( 12 downto 0);
         ix_ipx_tx_ca_cplh : in std_logic_vector ( 8 downto 0);
         ix_ipx_tx_ca_npd : in std_logic_vector ( 12 downto 0);
         ix_ipx_tx_ca_nph : in std_logic_vector ( 8 downto 0);
         ix_ipx_tx_ca_pd : in std_logic_vector ( 12 downto 0);
         ix_ipx_tx_ca_ph : in std_logic_vector ( 8 downto 0);
         ix_ipx_tx_rdy : in std_logic;
         ix_pci_int_req : in std_logic_vector ( 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 - 1 downto 0) := (others => '0');
         ix_rst_n : in std_logic;
         ix_wbm_ack : in std_logic;
         ix_wbm_dat : in std_logic_vector ( 32 - 1 downto 0);
         ix_wbs_adr : in std_logic_vector ( 48 - 1 downto 0);
         ix_wbs_bte : in std_logic_vector ( 1 downto 0);
         ix_wbs_cti : in std_logic_vector ( 2 downto 0);
         ix_wbs_cyc : in std_logic_vector ( 7 downto 0);
         ix_wbs_dat : in std_logic_vector ( 32 - 1 downto 0);
         ix_wbs_sel : in std_logic_vector ( (32 / 8) - 1 downto 0);
         ix_wbs_stb : in std_logic;
         ix_wbs_we : in std_logic;
         ox_dec_adr : out std_logic_vector ( 16 - 1 downto 0) ;
         ox_dec_bar_hit : out std_logic_vector ( 5 downto 0) ;
         ox_dec_func_hit : out std_logic_vector ( 7 downto 0) ;
         ox_ipx_cc_npd_num : out std_logic_vector ( 7 downto 0) ;
         ox_ipx_cc_pd_num : out std_logic_vector ( 7 downto 0) ;
         ox_ipx_cc_processed_npd : out std_logic ;
         ox_ipx_cc_processed_nph : out std_logic ;
         ox_ipx_cc_processed_pd : out std_logic ;
         ox_ipx_cc_processed_ph : out std_logic ;
         ox_ipx_tx_data : out std_logic_vector ( 16 - 1 downto 0) ;
         ox_ipx_tx_end : out std_logic ;
         ox_ipx_tx_req : out std_logic ;
         ox_ipx_tx_st : out std_logic ;
         ox_sys_rst_func_n : out std_logic_vector ( 7 downto 0) ;
         ox_sys_rst_n : out std_logic ;
         ox_wbm_adr : out std_logic_vector ( 16 - 1 downto 0) ;
         ox_wbm_bte : out std_logic_vector ( 1 downto 0) ;
         ox_wbm_cti : out std_logic_vector ( 2 downto 0) ;
         ox_wbm_cyc : out std_logic_vector ( 8 - 1 downto 0) ;
         ox_wbm_dat : out std_logic_vector ( 32 - 1 downto 0) ;
         ox_wbm_sel : out std_logic_vector ( (32 / 8) - 1 downto 0) ;
         ox_wbm_stb : out std_logic ;
         ox_wbm_we : out std_logic ;
         ox_wbs_ack : out std_logic ;
         ox_wbs_dat : out std_logic_vector ( 32 - 1 downto 0) ;
         ox_wbs_err : out std_logic
         );
   End Component;




   signal s_rtl_clk_125 : std_logic;
   signal s_rtl_phy_l0 : std_logic;
   signal s_rtl_sli_rst : std_logic;
   signal s_rtl_txp_data_k : std_logic_vector(0 downto 0);
   signal s_u1_dl_up : std_logic ;
   signal s_u1_ltssm_state : std_logic_vector ( 3 downto 0) ;
   signal s_u1_pipe_power_down : std_logic_vector ( 1 downto 0) ;
   signal s_u1_rx_data : std_logic_vector ( 15 downto 0) ;
   signal s_u1_rx_end : std_logic ;
   signal s_u1_malf_tlp : std_logic ;
   signal s_u1_rx_st : std_logic ;
   signal s_u1_rxp_polarity : std_logic ;
   signal s_u1_tx_ca_cpld : std_logic_vector ( 12 downto 0) ;
   signal s_u1_tx_ca_cplh : std_logic_vector ( 8 downto 0) ;
   signal s_u1_tx_ca_npd : std_logic_vector ( 12 downto 0) ;
   signal s_u1_tx_ca_nph : std_logic_vector ( 8 downto 0) ;
   signal s_u1_tx_ca_pd : std_logic_vector ( 12 downto 0) ;
   signal s_u1_tx_ca_ph : std_logic_vector ( 8 downto 0) ;
   signal s_u1_tx_rdy : std_logic ;
   signal s_u1_txp_compliance : std_logic ;
   signal s_u1_txp_data : std_logic_vector ( 7 downto 0) ;
   signal s_u1_txp_data_k : std_logic ;
   signal s_u1_txp_det_rx_lb : std_logic ;
   signal s_u1_txp_elec_idle : std_logic ;
   signal s_u2_pclk : std_logic ;
   signal s_u2_pclk_125 : std_logic ;
   signal s_u2_phy_status : std_logic ;
   signal s_u2_rxp_data_k : std_logic_vector ( 0 downto 0) ;
   signal s_u2_rxp_data : std_logic_vector ( 7 downto 0) ;
   signal s_u2_rxp_elec_idle : std_logic ;
   signal s_u2_rxp_status : std_logic_vector ( 2 downto 0) ;
   signal s_u2_rxp_valid : std_logic ;
   signal s_u2_serdes_pdb : std_logic ;
   signal s_u2_serdes_rst_dual_c : std_logic ;
   signal s_u2_tx_pwrup_c : std_logic ;
   signal s_u2_tx_serdes_rst_c : std_logic ;
   signal s_u3_refclk : std_logic ;
   signal s_u4_cc_npd_num : std_logic_vector ( 7 downto 0) ;
   signal s_u4_cc_pd_num : std_logic_vector ( 7 downto 0) ;
   signal s_u4_cc_processed_npd : std_logic ;
   signal s_u4_cc_processed_nph : std_logic ;
   signal s_u4_cc_processed_pd : std_logic ;
   signal s_u4_cc_processed_ph : std_logic ;
   signal s_u4_tx_data : std_logic_vector ( 16 - 1 downto 0) ;
   signal s_u4_tx_end : std_logic ;
   signal s_u4_tx_req : std_logic ;
   signal s_u4_tx_st : std_logic ;
   signal s_u4_sys_rst_func_n : std_logic_vector ( 7 downto 0) ;
   signal s_u4_sys_rst_n : std_logic ;

   attribute syn_black_box                         : boolean;
   attribute black_box_pad_pin                     : string;
   attribute HGROUP                                : string;

   attribute syn_black_box of pcie_x1_top_core   : component is true;
   attribute syn_black_box of pcie_mfx1_top   : component is true;

   attribute HGROUP        of U1_CORE : label is "HG_PCIE_CORE";
   attribute HGROUP        of U2_PHY  : label is "HG_PCIE_PHY";
   attribute HGROUP        of U4_MF   : label is "HG_MF_ADAPTER";


Begin
   ox_dl_up <= s_u1_dl_up ;
   ox_ltssm_state <= s_u1_ltssm_state ;
   ox_clk_125 <= s_rtl_clk_125 ;
   ox_rst_func_n <= s_u4_sys_rst_func_n ;
   ox_rst_n <= s_u4_sys_rst_n ;

   --  -----------------------------------------------------
   s_rtl_clk_125 <= s_u2_pclk_125;
   s_rtl_phy_l0   <= '1' when (s_u1_ltssm_state = "0011") else '0';

   s_rtl_sli_rst  <= s_u2_serdes_rst_dual_c or s_u2_tx_serdes_rst_c or (not s_u2_serdes_pdb) or (not s_u2_tx_pwrup_c);

   s_rtl_txp_data_k(0)  <= s_u1_txp_data_k;

   U1_CORE :
   pcie_x1_top_core
      Port Map (
         cmpln_tout => c_tie_low ,
         cmpltr_abort_np => c_tie_low ,
         cmpltr_abort_p => c_tie_low ,
         force_disable_scr => c_tie_low ,
         force_lsm_active => c_tie_low ,
         force_phy_status => c_tie_low ,
         force_rec_ei => c_tie_low ,
         hl_disable_scr => c_tie_low ,
         hl_gto_cfg => c_tie_low ,
         hl_gto_det => c_tie_low ,
         hl_gto_dis => c_tie_low ,
         hl_gto_hrst => c_tie_low ,
         hl_gto_l0stx => c_tie_low ,
         hl_gto_l0stxfts => c_tie_low ,
         hl_gto_l1 => c_tie_low ,
         hl_gto_l2 => c_tie_low ,
         hl_gto_lbk => c_tie_low ,
         hl_gto_rcvry => c_tie_low ,
         hl_snd_beacon => c_tie_low ,
         inta_n => c_tie_high ,
         msi => c_tie_low_bus (7 downto 0) ,
         no_pcie_train => c_tie_low ,
         np_req_pend => c_tie_low ,
         npd_buf_status_vc0 => c_tie_low ,
         npd_num_vc0 => s_u4_cc_npd_num (7 downto 0) ,
         npd_processed_vc0 => s_u4_cc_processed_npd ,
         nph_buf_status_vc0 => c_tie_low ,
         nph_processed_vc0 => s_u4_cc_processed_nph ,
         pd_buf_status_vc0 => c_tie_low ,
         pd_num_vc0 => s_u4_cc_pd_num (7 downto 0) ,
         pd_processed_vc0 => s_u4_cc_processed_pd ,
         ph_buf_status_vc0 => c_tie_low ,
         ph_processed_vc0 => s_u4_cc_processed_ph ,
         phy_status => s_u2_phy_status ,
         pme_status => c_tie_low ,
         rst_n => ix_rst_n ,
         rxp_data => s_u2_rxp_data (7 downto 0) ,
         rxp_data_k => s_u2_rxp_data_k(0) ,
         rxp_elec_idle => s_u2_rxp_elec_idle ,
         rxp_status => s_u2_rxp_status (2 downto 0) ,
         rxp_valid => s_u2_rxp_valid ,
         sys_clk_125 => s_rtl_clk_125 ,
         sys_clk_250 => s_u2_pclk ,
         tx_data_vc0 => s_u4_tx_data (15 downto 0) ,
         tx_dllp_val => c_tie_low_bus (1 downto 0) ,
         tx_end_vc0 => s_u4_tx_end ,
         tx_lbk_data => c_tie_low_bus (15 downto 0) ,
         tx_lbk_kcntl => c_tie_low_bus (1 downto 0) ,
         tx_nlfy_vc0 => c_tie_low ,
         tx_pmtype => c_tie_low_bus (2 downto 0) ,
         tx_req_vc0 => s_u4_tx_req ,
         tx_st_vc0 => s_u4_tx_st ,
         tx_vsd_data => c_tie_low_bus (23 downto 0) ,
         unexp_cmpln => c_tie_low ,
         ur_np_ext => c_tie_low ,
         ur_p_ext => c_tie_low ,
         bus_num => open ,
         cmd_reg_out => open ,
         dev_cntl_out => open ,
         dev_num => open ,
         dl_active => open ,
         dl_inactive => open ,
         dl_init => open ,
         dl_up => s_u1_dl_up ,
         func_num => open ,
         lnk_cntl_out => open ,
         mm_enable => open ,
         msi_enable => open ,
         phy_ltssm_state => s_u1_ltssm_state (3 downto 0) ,
         phy_pol_compliance => open ,
         pm_power_state => open ,
         pme_en => open ,
         power_down => s_u1_pipe_power_down (1 downto 0) ,
         reset_n => open ,
         rx_bar_hit => open ,
         rx_data_vc0 => s_u1_rx_data (15 downto 0) ,
         rx_end_vc0 => s_u1_rx_end ,
         rx_lbk_data => open ,
         rx_lbk_kcntl => open ,
         rx_malf_tlp_vc0 => s_u1_malf_tlp ,
         rx_st_vc0 => s_u1_rx_st ,
         rx_tlp_rcvd => open ,
         rx_us_req_vc0 => open ,
         rxdp_dllp_val => open ,
         rxdp_pmd_type => open ,
         rxdp_vsd_data => open ,
         rxp_polarity => s_u1_rxp_polarity ,
         tx_ca_cpl_recheck_vc0 => open ,
         tx_ca_cpld_vc0 => s_u1_tx_ca_cpld (12 downto 0) ,
         tx_ca_cplh_vc0 => s_u1_tx_ca_cplh (8 downto 0) ,
         tx_ca_npd_vc0 => s_u1_tx_ca_npd (12 downto 0) ,
         tx_ca_nph_vc0 => s_u1_tx_ca_nph (8 downto 0) ,
         tx_ca_p_recheck_vc0 => open ,
         tx_ca_pd_vc0 => s_u1_tx_ca_pd (12 downto 0) ,
         tx_ca_ph_vc0 => s_u1_tx_ca_ph (8 downto 0) ,
         tx_dllp_pend => open ,
         tx_dllp_sent => open ,
         tx_lbk_rdy => open ,
         tx_rbuf_empty => open ,
         tx_rdy_vc0 => s_u1_tx_rdy ,
         txp_compliance => s_u1_txp_compliance ,
         txp_data => s_u1_txp_data (7 downto 0) ,
         txp_data_k => s_u1_txp_data_k ,
         txp_detect_rx_lb => s_u1_txp_det_rx_lb ,
         txp_elec_idle => s_u1_txp_elec_idle
         );

   U2_PHY :
   pcie_x1_top_phy
      Port Map (
         PowerDown => s_u1_pipe_power_down (1 downto 0) ,
         RESET_n => ix_rst_n ,
         RxPolarity_0 => s_u1_rxp_polarity ,
         TxCompliance_0 => s_u1_txp_compliance ,
         TxDataK_0 => s_rtl_txp_data_k (0 downto 0) ,
         TxData_0 => s_u1_txp_data (7 downto 0) ,
         TxDetectRx_Loopback => s_u1_txp_det_rx_lb ,
         TxElecIdle_0 => s_u1_txp_elec_idle ,
         ctc_disable => c_tie_low ,
         flip_lanes => c_tie_low ,
         hdinn0 => ix_hdinn0 ,
         hdinp0 => ix_hdinp0 ,
         phy_cfgln => c_tie_low_bus (3 downto 0) ,
         phy_l0 => s_rtl_phy_l0 ,
         pll_refclki => s_u3_refclk ,
         rxrefclk => s_u3_refclk ,
         sci_addr => c_tie_low_bus (5 downto 0) ,
         sci_en => c_tie_low ,
         sci_en_dual => c_tie_low ,
         sci_rd => c_tie_low ,
         sci_sel => c_tie_low ,
         sci_sel_dual => c_tie_low ,
         sci_wrdata => c_tie_low_bus (7 downto 0) ,
         sci_wrn => c_tie_high ,
         sli_rst => s_rtl_sli_rst ,
         PCLK => s_u2_pclk ,
         PCLK_by_2 => s_u2_pclk_125 ,
         PhyStatus => s_u2_phy_status ,
         RxDataK_0 => s_u2_rxp_data_k (0 downto 0) ,
         RxData_0 => s_u2_rxp_data (7 downto 0) ,
         RxElecIdle_0 => s_u2_rxp_elec_idle ,
         RxStatus_0 => s_u2_rxp_status (2 downto 0) ,
         RxValid_0 => s_u2_rxp_valid ,
         ffs_plol => open ,
         ffs_rlol_ch0 => open ,
         hdoutn0 => ox_hdoutn0 ,
         hdoutp0 => ox_hdoutp0 ,
         pcie_ip_rstn => open ,
         sci_int => open ,
         sci_rddata => open ,
         serdes_pdb => s_u2_serdes_pdb ,
         serdes_rst_dual_c => s_u2_serdes_rst_dual_c ,
         tx_pwrup_c => s_u2_tx_pwrup_c ,
         tx_serdes_rst_c => s_u2_tx_serdes_rst_c
         );

   U3_REFCLK :
   pcie_refclk
      Port Map (
         refclkn => ix_refclkn ,
         refclkp => ix_refclkp ,
         refclko => s_u3_refclk
         );

   U4_MF :
   pcie_mfx1_top
      Port Map (
         ix_clk_125 => s_rtl_clk_125 ,
         ix_dec_wb_cyc => ix_dec_wb_cyc (8 - 1 downto 0) ,
         ix_ipx_dl_up => s_u1_dl_up ,
         ix_ipx_malf_tlp => s_u1_malf_tlp ,
         ix_ipx_rx_data => s_u1_rx_data (16 - 1 downto 0) ,
         ix_ipx_rx_end => s_u1_rx_end ,
         ix_ipx_rx_st => s_u1_rx_st ,
         ix_ipx_tx_ca_cpld => s_u1_tx_ca_cpld (12 downto 0) ,
         ix_ipx_tx_ca_cplh => s_u1_tx_ca_cplh (8 downto 0) ,
         ix_ipx_tx_ca_npd => s_u1_tx_ca_npd (12 downto 0) ,
         ix_ipx_tx_ca_nph => s_u1_tx_ca_nph (8 downto 0) ,
         ix_ipx_tx_ca_pd => s_u1_tx_ca_pd (12 downto 0) ,
         ix_ipx_tx_ca_ph => s_u1_tx_ca_ph (8 downto 0) ,
         ix_ipx_tx_rdy => s_u1_tx_rdy ,
         ix_pci_int_req => ix_pci_int_req ( 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 - 1 downto 0) ,
         ix_rst_n => ix_rst_n ,
         ix_wbm_ack => ix_wbm_ack ,
         ix_wbm_dat => ix_wbm_dat (32 - 1 downto 0) ,
         ix_wbs_adr => ix_wbs_adr (48 - 1 downto 0) ,
         ix_wbs_bte => ix_wbs_bte (1 downto 0) ,
         ix_wbs_cti => ix_wbs_cti (2 downto 0) ,
         ix_wbs_cyc => ix_wbs_cyc (7 downto 0) ,
         ix_wbs_dat => ix_wbs_dat (32 - 1 downto 0) ,
         ix_wbs_sel => ix_wbs_sel ((32 / 8) - 1 downto 0) ,
         ix_wbs_stb => ix_wbs_stb ,
         ix_wbs_we => ix_wbs_we ,
         ox_dec_adr => ox_dec_adr (16 - 1 downto 0) ,
         ox_dec_bar_hit => ox_dec_bar_hit (5 downto 0) ,
         ox_dec_func_hit => ox_dec_func_hit (7 downto 0) ,
         ox_ipx_cc_npd_num => s_u4_cc_npd_num (7 downto 0) ,
         ox_ipx_cc_pd_num => s_u4_cc_pd_num (7 downto 0) ,
         ox_ipx_cc_processed_npd => s_u4_cc_processed_npd ,
         ox_ipx_cc_processed_nph => s_u4_cc_processed_nph ,
         ox_ipx_cc_processed_pd => s_u4_cc_processed_pd ,
         ox_ipx_cc_processed_ph => s_u4_cc_processed_ph ,
         ox_ipx_tx_data => s_u4_tx_data (16 - 1 downto 0) ,
         ox_ipx_tx_end => s_u4_tx_end ,
         ox_ipx_tx_req => s_u4_tx_req ,
         ox_ipx_tx_st => s_u4_tx_st ,
         ox_sys_rst_func_n => s_u4_sys_rst_func_n (7 downto 0) ,
         ox_sys_rst_n => s_u4_sys_rst_n ,
         ox_wbm_adr => ox_wbm_adr (16 - 1 downto 0) ,
         ox_wbm_bte => ox_wbm_bte (1 downto 0) ,
         ox_wbm_cti => ox_wbm_cti (2 downto 0) ,
         ox_wbm_cyc => ox_wbm_cyc (8 - 1 downto 0) ,
         ox_wbm_dat => ox_wbm_dat (32 - 1 downto 0) ,
         ox_wbm_sel => ox_wbm_sel ((32 / 8) - 1 downto 0) ,
         ox_wbm_stb => ox_wbm_stb ,
         ox_wbm_we => ox_wbm_we ,
         ox_wbs_ack => ox_wbs_ack ,
         ox_wbs_dat => ox_wbs_dat (32 - 1 downto 0) ,
         ox_wbs_err => ox_wbs_err
         );

End Rtl;
