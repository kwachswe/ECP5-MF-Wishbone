--VHDL instantiation template

component pcie_subsys is
    port (pcie_mfx1_top_ix_dec_wb_cyc: in std_logic_vector(7 downto 0);
        pcie_mfx1_top_ix_ipx_rx_data: in std_logic_vector(15 downto 0);
        pcie_mfx1_top_ix_ipx_tx_ca_cpld: in std_logic_vector(12 downto 0);
        pcie_mfx1_top_ix_ipx_tx_ca_cplh: in std_logic_vector(8 downto 0);
        pcie_mfx1_top_ix_ipx_tx_ca_npd: in std_logic_vector(12 downto 0);
        pcie_mfx1_top_ix_ipx_tx_ca_nph: in std_logic_vector(8 downto 0);
        pcie_mfx1_top_ix_ipx_tx_ca_pd: in std_logic_vector(12 downto 0);
        pcie_mfx1_top_ix_ipx_tx_ca_ph: in std_logic_vector(8 downto 0);
        pcie_mfx1_top_ix_pci_int_req: in std_logic_vector(7 downto 0);
        pcie_mfx1_top_ix_wbm_dat: in std_logic_vector(31 downto 0);
        pcie_mfx1_top_ix_wbs_adr: in std_logic_vector(47 downto 0);
        pcie_mfx1_top_ix_wbs_bte: in std_logic_vector(1 downto 0);
        pcie_mfx1_top_ix_wbs_cti: in std_logic_vector(2 downto 0);
        pcie_mfx1_top_ix_wbs_cyc: in std_logic_vector(7 downto 0);
        pcie_mfx1_top_ix_wbs_dat: in std_logic_vector(31 downto 0);
        pcie_mfx1_top_ix_wbs_sel: in std_logic_vector(3 downto 0);
        pcie_mfx1_top_ox_dec_adr: out std_logic_vector(15 downto 0);
        pcie_mfx1_top_ox_dec_bar_hit: out std_logic_vector(5 downto 0);
        pcie_mfx1_top_ox_dec_func_hit: out std_logic_vector(7 downto 0);
        pcie_mfx1_top_ox_ipx_cc_npd_num: out std_logic_vector(7 downto 0);
        pcie_mfx1_top_ox_ipx_cc_pd_num: out std_logic_vector(7 downto 0);
        pcie_mfx1_top_ox_ipx_tx_data: out std_logic_vector(15 downto 0);
        pcie_mfx1_top_ox_sys_rst_func_n: out std_logic_vector(7 downto 0);
        pcie_mfx1_top_ox_wbm_adr: out std_logic_vector(15 downto 0);
        pcie_mfx1_top_ox_wbm_bte: out std_logic_vector(1 downto 0);
        pcie_mfx1_top_ox_wbm_cti: out std_logic_vector(2 downto 0);
        pcie_mfx1_top_ox_wbm_cyc: out std_logic_vector(7 downto 0);
        pcie_mfx1_top_ox_wbm_dat: out std_logic_vector(31 downto 0);
        pcie_mfx1_top_ox_wbm_sel: out std_logic_vector(3 downto 0);
        pcie_mfx1_top_ox_wbs_dat: out std_logic_vector(31 downto 0);
        pcie_x1_top_bus_num: out std_logic_vector(7 downto 0);
        pcie_x1_top_cmd_reg_out: out std_logic_vector(5 downto 0);
        pcie_x1_top_dev_cntl_out: out std_logic_vector(14 downto 0);
        pcie_x1_top_dev_num: out std_logic_vector(4 downto 0);
        pcie_x1_top_func_num: out std_logic_vector(2 downto 0);
        pcie_x1_top_lnk_cntl_out: out std_logic_vector(7 downto 0);
        pcie_x1_top_mm_enable: out std_logic_vector(2 downto 0);
        pcie_x1_top_msi: in std_logic_vector(7 downto 0);
        pcie_x1_top_npd_num_vc0: in std_logic_vector(7 downto 0);
        pcie_x1_top_pd_num_vc0: in std_logic_vector(7 downto 0);
        pcie_x1_top_phy_ltssm_state: out std_logic_vector(3 downto 0);
        pcie_x1_top_pm_power_state: out std_logic_vector(1 downto 0);
        pcie_x1_top_rx_bar_hit: out std_logic_vector(6 downto 0);
        pcie_x1_top_rx_data_vc0: out std_logic_vector(15 downto 0);
        pcie_x1_top_rx_lbk_data: out std_logic_vector(15 downto 0);
        pcie_x1_top_rx_lbk_kcntl: out std_logic_vector(1 downto 0);
        pcie_x1_top_rxdp_dllp_val: out std_logic_vector(1 downto 0);
        pcie_x1_top_rxdp_pmd_type: out std_logic_vector(2 downto 0);
        pcie_x1_top_rxdp_vsd_data: out std_logic_vector(23 downto 0);
        pcie_x1_top_sci_addr: in std_logic_vector(5 downto 0);
        pcie_x1_top_sci_rddata: out std_logic_vector(7 downto 0);
        pcie_x1_top_sci_wrdata: in std_logic_vector(7 downto 0);
        pcie_x1_top_tx_ca_cpld_vc0: out std_logic_vector(12 downto 0);
        pcie_x1_top_tx_ca_cplh_vc0: out std_logic_vector(8 downto 0);
        pcie_x1_top_tx_ca_npd_vc0: out std_logic_vector(12 downto 0);
        pcie_x1_top_tx_ca_nph_vc0: out std_logic_vector(8 downto 0);
        pcie_x1_top_tx_ca_pd_vc0: out std_logic_vector(12 downto 0);
        pcie_x1_top_tx_ca_ph_vc0: out std_logic_vector(8 downto 0);
        pcie_x1_top_tx_data_vc0: in std_logic_vector(15 downto 0);
        pcie_x1_top_tx_dllp_val: in std_logic_vector(1 downto 0);
        pcie_x1_top_tx_lbk_data: in std_logic_vector(15 downto 0);
        pcie_x1_top_tx_lbk_kcntl: in std_logic_vector(1 downto 0);
        pcie_x1_top_tx_pmtype: in std_logic_vector(2 downto 0);
        pcie_x1_top_tx_vsd_data: in std_logic_vector(23 downto 0);
        pcie_mfx1_top_ix_clk_125: in std_logic;
        pcie_mfx1_top_ix_ipx_dl_up: in std_logic;
        pcie_mfx1_top_ix_ipx_malf_tlp: in std_logic;
        pcie_mfx1_top_ix_ipx_rx_end: in std_logic;
        pcie_mfx1_top_ix_ipx_rx_st: in std_logic;
        pcie_mfx1_top_ix_ipx_tx_rdy: in std_logic;
        pcie_mfx1_top_ix_rst_n: in std_logic;
        pcie_mfx1_top_ix_wbm_ack: in std_logic;
        pcie_mfx1_top_ix_wbs_stb: in std_logic;
        pcie_mfx1_top_ix_wbs_we: in std_logic;
        pcie_mfx1_top_ox_ipx_cc_processed_npd: out std_logic;
        pcie_mfx1_top_ox_ipx_cc_processed_nph: out std_logic;
        pcie_mfx1_top_ox_ipx_cc_processed_pd: out std_logic;
        pcie_mfx1_top_ox_ipx_cc_processed_ph: out std_logic;
        pcie_mfx1_top_ox_ipx_tx_end: out std_logic;
        pcie_mfx1_top_ox_ipx_tx_req: out std_logic;
        pcie_mfx1_top_ox_ipx_tx_st: out std_logic;
        pcie_mfx1_top_ox_sys_rst_n: out std_logic;
        pcie_mfx1_top_ox_wbm_stb: out std_logic;
        pcie_mfx1_top_ox_wbm_we: out std_logic;
        pcie_mfx1_top_ox_wbs_ack: out std_logic;
        pcie_mfx1_top_ox_wbs_err: out std_logic;
        pcie_refclk_refclkn: in std_logic;
        pcie_refclk_refclko: out std_logic;
        pcie_refclk_refclkp: in std_logic;
        pcie_x1_top_cmpln_tout: in std_logic;
        pcie_x1_top_cmpltr_abort_np: in std_logic;
        pcie_x1_top_cmpltr_abort_p: in std_logic;
        pcie_x1_top_dl_active: out std_logic;
        pcie_x1_top_dl_inactive: out std_logic;
        pcie_x1_top_dl_init: out std_logic;
        pcie_x1_top_dl_up: out std_logic;
        pcie_x1_top_flip_lanes: in std_logic;
        pcie_x1_top_force_disable_scr: in std_logic;
        pcie_x1_top_force_lsm_active: in std_logic;
        pcie_x1_top_force_phy_status: in std_logic;
        pcie_x1_top_force_rec_ei: in std_logic;
        pcie_x1_top_hdinn0: in std_logic;
        pcie_x1_top_hdinp0: in std_logic;
        pcie_x1_top_hdoutn0: out std_logic;
        pcie_x1_top_hdoutp0: out std_logic;
        pcie_x1_top_hl_disable_scr: in std_logic;
        pcie_x1_top_hl_gto_cfg: in std_logic;
        pcie_x1_top_hl_gto_det: in std_logic;
        pcie_x1_top_hl_gto_dis: in std_logic;
        pcie_x1_top_hl_gto_hrst: in std_logic;
        pcie_x1_top_hl_gto_l0stx: in std_logic;
        pcie_x1_top_hl_gto_l0stxfts: in std_logic;
        pcie_x1_top_hl_gto_l1: in std_logic;
        pcie_x1_top_hl_gto_l2: in std_logic;
        pcie_x1_top_hl_gto_lbk: in std_logic;
        pcie_x1_top_hl_gto_rcvry: in std_logic;
        pcie_x1_top_hl_snd_beacon: in std_logic;
        pcie_x1_top_inta_n: in std_logic;
        pcie_x1_top_msi_enable: out std_logic;
        pcie_x1_top_no_pcie_train: in std_logic;
        pcie_x1_top_np_req_pend: in std_logic;
        pcie_x1_top_npd_buf_status_vc0: in std_logic;
        pcie_x1_top_npd_processed_vc0: in std_logic;
        pcie_x1_top_nph_buf_status_vc0: in std_logic;
        pcie_x1_top_nph_processed_vc0: in std_logic;
        pcie_x1_top_pd_buf_status_vc0: in std_logic;
        pcie_x1_top_pd_processed_vc0: in std_logic;
        pcie_x1_top_ph_buf_status_vc0: in std_logic;
        pcie_x1_top_ph_processed_vc0: in std_logic;
        pcie_x1_top_phy_pol_compliance: out std_logic;
        pcie_x1_top_pll_refclki: in std_logic;
        pcie_x1_top_pme_en: out std_logic;
        pcie_x1_top_pme_status: in std_logic;
        pcie_x1_top_rst_n: in std_logic;
        pcie_x1_top_rx_end_vc0: out std_logic;
        pcie_x1_top_rx_malf_tlp_vc0: out std_logic;
        pcie_x1_top_rx_st_vc0: out std_logic;
        pcie_x1_top_rx_us_req_vc0: out std_logic;
        pcie_x1_top_rxrefclk: in std_logic;
        pcie_x1_top_sci_en: in std_logic;
        pcie_x1_top_sci_en_dual: in std_logic;
        pcie_x1_top_sci_int: out std_logic;
        pcie_x1_top_sci_rd: in std_logic;
        pcie_x1_top_sci_sel: in std_logic;
        pcie_x1_top_sci_sel_dual: in std_logic;
        pcie_x1_top_sci_wrn: in std_logic;
        pcie_x1_top_serdes_pdb: out std_logic;
        pcie_x1_top_serdes_rst_dual_c: out std_logic;
        pcie_x1_top_sys_clk_125: out std_logic;
        pcie_x1_top_tx_ca_cpl_recheck_vc0: out std_logic;
        pcie_x1_top_tx_ca_p_recheck_vc0: out std_logic;
        pcie_x1_top_tx_dllp_sent: out std_logic;
        pcie_x1_top_tx_end_vc0: in std_logic;
        pcie_x1_top_tx_lbk_rdy: out std_logic;
        pcie_x1_top_tx_nlfy_vc0: in std_logic;
        pcie_x1_top_tx_pwrup_c: out std_logic;
        pcie_x1_top_tx_rdy_vc0: out std_logic;
        pcie_x1_top_tx_req_vc0: in std_logic;
        pcie_x1_top_tx_serdes_rst_c: out std_logic;
        pcie_x1_top_tx_st_vc0: in std_logic;
        pcie_x1_top_unexp_cmpln: in std_logic;
        pcie_x1_top_ur_np_ext: in std_logic;
        pcie_x1_top_ur_p_ext: in std_logic
    );
    
end component pcie_subsys; -- sbp_module=true 
_inst: pcie_subsys port map (pcie_x1_top_bus_num => __,pcie_x1_top_cmd_reg_out => __,
            pcie_x1_top_dev_cntl_out => __,pcie_x1_top_dev_num => __,pcie_x1_top_func_num => __,
            pcie_x1_top_lnk_cntl_out => __,pcie_x1_top_mm_enable => __,pcie_x1_top_msi => __,
            pcie_x1_top_npd_num_vc0 => __,pcie_x1_top_pd_num_vc0 => __,pcie_x1_top_phy_ltssm_state => __,
            pcie_x1_top_pm_power_state => __,pcie_x1_top_rx_bar_hit => __,
            pcie_x1_top_rx_data_vc0 => __,pcie_x1_top_rx_lbk_data => __,pcie_x1_top_rx_lbk_kcntl => __,
            pcie_x1_top_rxdp_dllp_val => __,pcie_x1_top_rxdp_pmd_type => __,
            pcie_x1_top_rxdp_vsd_data => __,pcie_x1_top_sci_addr => __,pcie_x1_top_sci_rddata => __,
            pcie_x1_top_sci_wrdata => __,pcie_x1_top_tx_ca_cpld_vc0 => __,
            pcie_x1_top_tx_ca_cplh_vc0 => __,pcie_x1_top_tx_ca_npd_vc0 => __,
            pcie_x1_top_tx_ca_nph_vc0 => __,pcie_x1_top_tx_ca_pd_vc0 => __,
            pcie_x1_top_tx_ca_ph_vc0 => __,pcie_x1_top_tx_data_vc0 => __,pcie_x1_top_tx_dllp_val => __,
            pcie_x1_top_tx_lbk_data => __,pcie_x1_top_tx_lbk_kcntl => __,pcie_x1_top_tx_pmtype => __,
            pcie_x1_top_tx_vsd_data => __,pcie_x1_top_cmpln_tout => __,pcie_x1_top_cmpltr_abort_np => __,
            pcie_x1_top_cmpltr_abort_p => __,pcie_x1_top_dl_active => __,pcie_x1_top_dl_inactive => __,
            pcie_x1_top_dl_init => __,pcie_x1_top_dl_up => __,pcie_x1_top_flip_lanes => __,
            pcie_x1_top_force_disable_scr => __,pcie_x1_top_force_lsm_active => __,
            pcie_x1_top_force_phy_status => __,pcie_x1_top_force_rec_ei => __,
            pcie_x1_top_hdinn0 => __,pcie_x1_top_hdinp0 => __,pcie_x1_top_hdoutn0 => __,
            pcie_x1_top_hdoutp0 => __,pcie_x1_top_hl_disable_scr => __,pcie_x1_top_hl_gto_cfg => __,
            pcie_x1_top_hl_gto_det => __,pcie_x1_top_hl_gto_dis => __,pcie_x1_top_hl_gto_hrst => __,
            pcie_x1_top_hl_gto_l0stx => __,pcie_x1_top_hl_gto_l0stxfts => __,
            pcie_x1_top_hl_gto_l1 => __,pcie_x1_top_hl_gto_l2 => __,pcie_x1_top_hl_gto_lbk => __,
            pcie_x1_top_hl_gto_rcvry => __,pcie_x1_top_hl_snd_beacon => __,
            pcie_x1_top_inta_n => __,pcie_x1_top_msi_enable => __,pcie_x1_top_no_pcie_train => __,
            pcie_x1_top_np_req_pend => __,pcie_x1_top_npd_buf_status_vc0 => __,
            pcie_x1_top_npd_processed_vc0 => __,pcie_x1_top_nph_buf_status_vc0 => __,
            pcie_x1_top_nph_processed_vc0 => __,pcie_x1_top_pd_buf_status_vc0 => __,
            pcie_x1_top_pd_processed_vc0 => __,pcie_x1_top_ph_buf_status_vc0 => __,
            pcie_x1_top_ph_processed_vc0 => __,pcie_x1_top_phy_pol_compliance => __,
            pcie_x1_top_pll_refclki => __,pcie_x1_top_pme_en => __,pcie_x1_top_pme_status => __,
            pcie_x1_top_rst_n => __,pcie_x1_top_rx_end_vc0 => __,pcie_x1_top_rx_malf_tlp_vc0 => __,
            pcie_x1_top_rx_st_vc0 => __,pcie_x1_top_rx_us_req_vc0 => __,pcie_x1_top_rxrefclk => __,
            pcie_x1_top_sci_en => __,pcie_x1_top_sci_en_dual => __,pcie_x1_top_sci_int => __,
            pcie_x1_top_sci_rd => __,pcie_x1_top_sci_sel => __,pcie_x1_top_sci_sel_dual => __,
            pcie_x1_top_sci_wrn => __,pcie_x1_top_serdes_pdb => __,pcie_x1_top_serdes_rst_dual_c => __,
            pcie_x1_top_sys_clk_125 => __,pcie_x1_top_tx_ca_cpl_recheck_vc0 => __,
            pcie_x1_top_tx_ca_p_recheck_vc0 => __,pcie_x1_top_tx_dllp_sent => __,
            pcie_x1_top_tx_end_vc0 => __,pcie_x1_top_tx_lbk_rdy => __,pcie_x1_top_tx_nlfy_vc0 => __,
            pcie_x1_top_tx_pwrup_c => __,pcie_x1_top_tx_rdy_vc0 => __,pcie_x1_top_tx_req_vc0 => __,
            pcie_x1_top_tx_serdes_rst_c => __,pcie_x1_top_tx_st_vc0 => __,
            pcie_x1_top_unexp_cmpln => __,pcie_x1_top_ur_np_ext => __,pcie_x1_top_ur_p_ext => __,
            pcie_refclk_refclkn => __,pcie_refclk_refclko => __,pcie_refclk_refclkp => __,
            pcie_mfx1_top_ix_dec_wb_cyc => __,pcie_mfx1_top_ix_ipx_rx_data => __,
            pcie_mfx1_top_ix_ipx_tx_ca_cpld => __,pcie_mfx1_top_ix_ipx_tx_ca_cplh => __,
            pcie_mfx1_top_ix_ipx_tx_ca_npd => __,pcie_mfx1_top_ix_ipx_tx_ca_nph => __,
            pcie_mfx1_top_ix_ipx_tx_ca_pd => __,pcie_mfx1_top_ix_ipx_tx_ca_ph => __,
            pcie_mfx1_top_ix_pci_int_req => __,pcie_mfx1_top_ix_wbm_dat => __,
            pcie_mfx1_top_ix_wbs_adr => __,pcie_mfx1_top_ix_wbs_bte => __,
            pcie_mfx1_top_ix_wbs_cti => __,pcie_mfx1_top_ix_wbs_cyc => __,
            pcie_mfx1_top_ix_wbs_dat => __,pcie_mfx1_top_ix_wbs_sel => __,
            pcie_mfx1_top_ox_dec_adr => __,pcie_mfx1_top_ox_dec_bar_hit => __,
            pcie_mfx1_top_ox_dec_func_hit => __,pcie_mfx1_top_ox_ipx_cc_npd_num => __,
            pcie_mfx1_top_ox_ipx_cc_pd_num => __,pcie_mfx1_top_ox_ipx_tx_data => __,
            pcie_mfx1_top_ox_sys_rst_func_n => __,pcie_mfx1_top_ox_wbm_adr => __,
            pcie_mfx1_top_ox_wbm_bte => __,pcie_mfx1_top_ox_wbm_cti => __,
            pcie_mfx1_top_ox_wbm_cyc => __,pcie_mfx1_top_ox_wbm_dat => __,
            pcie_mfx1_top_ox_wbm_sel => __,pcie_mfx1_top_ox_wbs_dat => __,
            pcie_mfx1_top_ix_clk_125 => __,pcie_mfx1_top_ix_ipx_dl_up => __,
            pcie_mfx1_top_ix_ipx_malf_tlp => __,pcie_mfx1_top_ix_ipx_rx_end => __,
            pcie_mfx1_top_ix_ipx_rx_st => __,pcie_mfx1_top_ix_ipx_tx_rdy => __,
            pcie_mfx1_top_ix_rst_n => __,pcie_mfx1_top_ix_wbm_ack => __,pcie_mfx1_top_ix_wbs_stb => __,
            pcie_mfx1_top_ix_wbs_we => __,pcie_mfx1_top_ox_ipx_cc_processed_npd => __,
            pcie_mfx1_top_ox_ipx_cc_processed_nph => __,pcie_mfx1_top_ox_ipx_cc_processed_pd => __,
            pcie_mfx1_top_ox_ipx_cc_processed_ph => __,pcie_mfx1_top_ox_ipx_tx_end => __,
            pcie_mfx1_top_ox_ipx_tx_req => __,pcie_mfx1_top_ox_ipx_tx_st => __,
            pcie_mfx1_top_ox_sys_rst_n => __,pcie_mfx1_top_ox_wbm_stb => __,
            pcie_mfx1_top_ox_wbm_we => __,pcie_mfx1_top_ox_wbs_ack => __,pcie_mfx1_top_ox_wbs_err => __);
