/* synthesis translate_off*/
`define SBP_SIMULATION
/* synthesis translate_on*/
`ifndef SBP_SIMULATION
`define SBP_SYNTHESIS
`endif

//
// Verific Verilog Description of module pcie_subsys
//
module pcie_subsys (pcie_mfx1_top_ix_dec_wb_cyc, pcie_mfx1_top_ix_ipx_rx_data, 
            pcie_mfx1_top_ix_ipx_tx_ca_cpld, pcie_mfx1_top_ix_ipx_tx_ca_cplh, 
            pcie_mfx1_top_ix_ipx_tx_ca_npd, pcie_mfx1_top_ix_ipx_tx_ca_nph, 
            pcie_mfx1_top_ix_ipx_tx_ca_pd, pcie_mfx1_top_ix_ipx_tx_ca_ph, 
            pcie_mfx1_top_ix_pci_int_req, pcie_mfx1_top_ix_wbm_dat, pcie_mfx1_top_ix_wbs_adr, 
            pcie_mfx1_top_ix_wbs_bte, pcie_mfx1_top_ix_wbs_cti, pcie_mfx1_top_ix_wbs_cyc, 
            pcie_mfx1_top_ix_wbs_dat, pcie_mfx1_top_ix_wbs_sel, pcie_mfx1_top_ox_dec_adr, 
            pcie_mfx1_top_ox_dec_bar_hit, pcie_mfx1_top_ox_dec_func_hit, 
            pcie_mfx1_top_ox_ipx_cc_npd_num, pcie_mfx1_top_ox_ipx_cc_pd_num, 
            pcie_mfx1_top_ox_ipx_tx_data, pcie_mfx1_top_ox_sys_rst_func_n, 
            pcie_mfx1_top_ox_wbm_adr, pcie_mfx1_top_ox_wbm_bte, pcie_mfx1_top_ox_wbm_cti, 
            pcie_mfx1_top_ox_wbm_cyc, pcie_mfx1_top_ox_wbm_dat, pcie_mfx1_top_ox_wbm_sel, 
            pcie_mfx1_top_ox_wbs_dat, pcie_x1_top_bus_num, pcie_x1_top_cmd_reg_out, 
            pcie_x1_top_dev_cntl_out, pcie_x1_top_dev_num, pcie_x1_top_func_num, 
            pcie_x1_top_lnk_cntl_out, pcie_x1_top_mm_enable, pcie_x1_top_msi, 
            pcie_x1_top_npd_num_vc0, pcie_x1_top_pd_num_vc0, pcie_x1_top_phy_ltssm_state, 
            pcie_x1_top_pm_power_state, pcie_x1_top_rx_bar_hit, pcie_x1_top_rx_data_vc0, 
            pcie_x1_top_rx_lbk_data, pcie_x1_top_rx_lbk_kcntl, pcie_x1_top_rxdp_dllp_val, 
            pcie_x1_top_rxdp_pmd_type, pcie_x1_top_rxdp_vsd_data, pcie_x1_top_sci_addr, 
            pcie_x1_top_sci_rddata, pcie_x1_top_sci_wrdata, pcie_x1_top_tx_ca_cpld_vc0, 
            pcie_x1_top_tx_ca_cplh_vc0, pcie_x1_top_tx_ca_npd_vc0, pcie_x1_top_tx_ca_nph_vc0, 
            pcie_x1_top_tx_ca_pd_vc0, pcie_x1_top_tx_ca_ph_vc0, pcie_x1_top_tx_data_vc0, 
            pcie_x1_top_tx_dllp_val, pcie_x1_top_tx_lbk_data, pcie_x1_top_tx_lbk_kcntl, 
            pcie_x1_top_tx_pmtype, pcie_x1_top_tx_vsd_data, pcie_mfx1_top_ix_clk_125, 
            pcie_mfx1_top_ix_ipx_dl_up, pcie_mfx1_top_ix_ipx_malf_tlp, pcie_mfx1_top_ix_ipx_rx_end, 
            pcie_mfx1_top_ix_ipx_rx_st, pcie_mfx1_top_ix_ipx_tx_rdy, pcie_mfx1_top_ix_rst_n, 
            pcie_mfx1_top_ix_wbm_ack, pcie_mfx1_top_ix_wbs_stb, pcie_mfx1_top_ix_wbs_we, 
            pcie_mfx1_top_ox_ipx_cc_processed_npd, pcie_mfx1_top_ox_ipx_cc_processed_nph, 
            pcie_mfx1_top_ox_ipx_cc_processed_pd, pcie_mfx1_top_ox_ipx_cc_processed_ph, 
            pcie_mfx1_top_ox_ipx_tx_end, pcie_mfx1_top_ox_ipx_tx_req, pcie_mfx1_top_ox_ipx_tx_st, 
            pcie_mfx1_top_ox_sys_rst_n, pcie_mfx1_top_ox_wbm_stb, pcie_mfx1_top_ox_wbm_we, 
            pcie_mfx1_top_ox_wbs_ack, pcie_mfx1_top_ox_wbs_err, pcie_refclk_refclkn, 
            pcie_refclk_refclko, pcie_refclk_refclkp, pcie_x1_top_cmpln_tout, 
            pcie_x1_top_cmpltr_abort_np, pcie_x1_top_cmpltr_abort_p, pcie_x1_top_dl_active, 
            pcie_x1_top_dl_inactive, pcie_x1_top_dl_init, pcie_x1_top_dl_up, 
            pcie_x1_top_flip_lanes, pcie_x1_top_force_disable_scr, pcie_x1_top_force_lsm_active, 
            pcie_x1_top_force_phy_status, pcie_x1_top_force_rec_ei, pcie_x1_top_hdinn0, 
            pcie_x1_top_hdinp0, pcie_x1_top_hdoutn0, pcie_x1_top_hdoutp0, 
            pcie_x1_top_hl_disable_scr, pcie_x1_top_hl_gto_cfg, pcie_x1_top_hl_gto_det, 
            pcie_x1_top_hl_gto_dis, pcie_x1_top_hl_gto_hrst, pcie_x1_top_hl_gto_l0stx, 
            pcie_x1_top_hl_gto_l0stxfts, pcie_x1_top_hl_gto_l1, pcie_x1_top_hl_gto_l2, 
            pcie_x1_top_hl_gto_lbk, pcie_x1_top_hl_gto_rcvry, pcie_x1_top_hl_snd_beacon, 
            pcie_x1_top_inta_n, pcie_x1_top_msi_enable, pcie_x1_top_no_pcie_train, 
            pcie_x1_top_np_req_pend, pcie_x1_top_npd_buf_status_vc0, pcie_x1_top_npd_processed_vc0, 
            pcie_x1_top_nph_buf_status_vc0, pcie_x1_top_nph_processed_vc0, 
            pcie_x1_top_pd_buf_status_vc0, pcie_x1_top_pd_processed_vc0, 
            pcie_x1_top_ph_buf_status_vc0, pcie_x1_top_ph_processed_vc0, 
            pcie_x1_top_phy_pol_compliance, pcie_x1_top_pll_refclki, pcie_x1_top_pme_en, 
            pcie_x1_top_pme_status, pcie_x1_top_rst_n, pcie_x1_top_rx_end_vc0, 
            pcie_x1_top_rx_malf_tlp_vc0, pcie_x1_top_rx_st_vc0, pcie_x1_top_rx_us_req_vc0, 
            pcie_x1_top_rxrefclk, pcie_x1_top_sci_en, pcie_x1_top_sci_en_dual, 
            pcie_x1_top_sci_int, pcie_x1_top_sci_rd, pcie_x1_top_sci_sel, 
            pcie_x1_top_sci_sel_dual, pcie_x1_top_sci_wrn, pcie_x1_top_serdes_pdb, 
            pcie_x1_top_serdes_rst_dual_c, pcie_x1_top_sys_clk_125, pcie_x1_top_tx_ca_cpl_recheck_vc0, 
            pcie_x1_top_tx_ca_p_recheck_vc0, pcie_x1_top_tx_dllp_sent, pcie_x1_top_tx_end_vc0, 
            pcie_x1_top_tx_lbk_rdy, pcie_x1_top_tx_nlfy_vc0, pcie_x1_top_tx_pwrup_c, 
            pcie_x1_top_tx_rdy_vc0, pcie_x1_top_tx_req_vc0, pcie_x1_top_tx_serdes_rst_c, 
            pcie_x1_top_tx_st_vc0, pcie_x1_top_unexp_cmpln, pcie_x1_top_ur_np_ext, 
            pcie_x1_top_ur_p_ext) /* synthesis sbp_module=true */ ;
    input [7:0]pcie_mfx1_top_ix_dec_wb_cyc;
    input [15:0]pcie_mfx1_top_ix_ipx_rx_data;
    input [12:0]pcie_mfx1_top_ix_ipx_tx_ca_cpld;
    input [8:0]pcie_mfx1_top_ix_ipx_tx_ca_cplh;
    input [12:0]pcie_mfx1_top_ix_ipx_tx_ca_npd;
    input [8:0]pcie_mfx1_top_ix_ipx_tx_ca_nph;
    input [12:0]pcie_mfx1_top_ix_ipx_tx_ca_pd;
    input [8:0]pcie_mfx1_top_ix_ipx_tx_ca_ph;
    input [7:0]pcie_mfx1_top_ix_pci_int_req;
    input [31:0]pcie_mfx1_top_ix_wbm_dat;
    input [47:0]pcie_mfx1_top_ix_wbs_adr;
    input [1:0]pcie_mfx1_top_ix_wbs_bte;
    input [2:0]pcie_mfx1_top_ix_wbs_cti;
    input [7:0]pcie_mfx1_top_ix_wbs_cyc;
    input [31:0]pcie_mfx1_top_ix_wbs_dat;
    input [3:0]pcie_mfx1_top_ix_wbs_sel;
    output [15:0]pcie_mfx1_top_ox_dec_adr;
    output [5:0]pcie_mfx1_top_ox_dec_bar_hit;
    output [7:0]pcie_mfx1_top_ox_dec_func_hit;
    output [7:0]pcie_mfx1_top_ox_ipx_cc_npd_num;
    output [7:0]pcie_mfx1_top_ox_ipx_cc_pd_num;
    output [15:0]pcie_mfx1_top_ox_ipx_tx_data;
    output [7:0]pcie_mfx1_top_ox_sys_rst_func_n;
    output [15:0]pcie_mfx1_top_ox_wbm_adr;
    output [1:0]pcie_mfx1_top_ox_wbm_bte;
    output [2:0]pcie_mfx1_top_ox_wbm_cti;
    output [7:0]pcie_mfx1_top_ox_wbm_cyc;
    output [31:0]pcie_mfx1_top_ox_wbm_dat;
    output [3:0]pcie_mfx1_top_ox_wbm_sel;
    output [31:0]pcie_mfx1_top_ox_wbs_dat;
    output [7:0]pcie_x1_top_bus_num;
    output [5:0]pcie_x1_top_cmd_reg_out;
    output [14:0]pcie_x1_top_dev_cntl_out;
    output [4:0]pcie_x1_top_dev_num;
    output [2:0]pcie_x1_top_func_num;
    output [7:0]pcie_x1_top_lnk_cntl_out;
    output [2:0]pcie_x1_top_mm_enable;
    input [7:0]pcie_x1_top_msi;
    input [7:0]pcie_x1_top_npd_num_vc0;
    input [7:0]pcie_x1_top_pd_num_vc0;
    output [3:0]pcie_x1_top_phy_ltssm_state;
    output [1:0]pcie_x1_top_pm_power_state;
    output [6:0]pcie_x1_top_rx_bar_hit;
    output [15:0]pcie_x1_top_rx_data_vc0;
    output [15:0]pcie_x1_top_rx_lbk_data;
    output [1:0]pcie_x1_top_rx_lbk_kcntl;
    output [1:0]pcie_x1_top_rxdp_dllp_val;
    output [2:0]pcie_x1_top_rxdp_pmd_type;
    output [23:0]pcie_x1_top_rxdp_vsd_data;
    input [5:0]pcie_x1_top_sci_addr;
    output [7:0]pcie_x1_top_sci_rddata;
    input [7:0]pcie_x1_top_sci_wrdata;
    output [12:0]pcie_x1_top_tx_ca_cpld_vc0;
    output [8:0]pcie_x1_top_tx_ca_cplh_vc0;
    output [12:0]pcie_x1_top_tx_ca_npd_vc0;
    output [8:0]pcie_x1_top_tx_ca_nph_vc0;
    output [12:0]pcie_x1_top_tx_ca_pd_vc0;
    output [8:0]pcie_x1_top_tx_ca_ph_vc0;
    input [15:0]pcie_x1_top_tx_data_vc0;
    input [1:0]pcie_x1_top_tx_dllp_val;
    input [15:0]pcie_x1_top_tx_lbk_data;
    input [1:0]pcie_x1_top_tx_lbk_kcntl;
    input [2:0]pcie_x1_top_tx_pmtype;
    input [23:0]pcie_x1_top_tx_vsd_data;
    input pcie_mfx1_top_ix_clk_125;
    input pcie_mfx1_top_ix_ipx_dl_up;
    input pcie_mfx1_top_ix_ipx_malf_tlp;
    input pcie_mfx1_top_ix_ipx_rx_end;
    input pcie_mfx1_top_ix_ipx_rx_st;
    input pcie_mfx1_top_ix_ipx_tx_rdy;
    input pcie_mfx1_top_ix_rst_n;
    input pcie_mfx1_top_ix_wbm_ack;
    input pcie_mfx1_top_ix_wbs_stb;
    input pcie_mfx1_top_ix_wbs_we;
    output pcie_mfx1_top_ox_ipx_cc_processed_npd;
    output pcie_mfx1_top_ox_ipx_cc_processed_nph;
    output pcie_mfx1_top_ox_ipx_cc_processed_pd;
    output pcie_mfx1_top_ox_ipx_cc_processed_ph;
    output pcie_mfx1_top_ox_ipx_tx_end;
    output pcie_mfx1_top_ox_ipx_tx_req;
    output pcie_mfx1_top_ox_ipx_tx_st;
    output pcie_mfx1_top_ox_sys_rst_n;
    output pcie_mfx1_top_ox_wbm_stb;
    output pcie_mfx1_top_ox_wbm_we;
    output pcie_mfx1_top_ox_wbs_ack;
    output pcie_mfx1_top_ox_wbs_err;
    input pcie_refclk_refclkn;
    output pcie_refclk_refclko;
    input pcie_refclk_refclkp;
    input pcie_x1_top_cmpln_tout;
    input pcie_x1_top_cmpltr_abort_np;
    input pcie_x1_top_cmpltr_abort_p;
    output pcie_x1_top_dl_active;
    output pcie_x1_top_dl_inactive;
    output pcie_x1_top_dl_init;
    output pcie_x1_top_dl_up;
    input pcie_x1_top_flip_lanes;
    input pcie_x1_top_force_disable_scr;
    input pcie_x1_top_force_lsm_active;
    input pcie_x1_top_force_phy_status;
    input pcie_x1_top_force_rec_ei;
    input pcie_x1_top_hdinn0;
    input pcie_x1_top_hdinp0;
    output pcie_x1_top_hdoutn0;
    output pcie_x1_top_hdoutp0;
    input pcie_x1_top_hl_disable_scr;
    input pcie_x1_top_hl_gto_cfg;
    input pcie_x1_top_hl_gto_det;
    input pcie_x1_top_hl_gto_dis;
    input pcie_x1_top_hl_gto_hrst;
    input pcie_x1_top_hl_gto_l0stx;
    input pcie_x1_top_hl_gto_l0stxfts;
    input pcie_x1_top_hl_gto_l1;
    input pcie_x1_top_hl_gto_l2;
    input pcie_x1_top_hl_gto_lbk;
    input pcie_x1_top_hl_gto_rcvry;
    input pcie_x1_top_hl_snd_beacon;
    input pcie_x1_top_inta_n;
    output pcie_x1_top_msi_enable;
    input pcie_x1_top_no_pcie_train;
    input pcie_x1_top_np_req_pend;
    input pcie_x1_top_npd_buf_status_vc0;
    input pcie_x1_top_npd_processed_vc0;
    input pcie_x1_top_nph_buf_status_vc0;
    input pcie_x1_top_nph_processed_vc0;
    input pcie_x1_top_pd_buf_status_vc0;
    input pcie_x1_top_pd_processed_vc0;
    input pcie_x1_top_ph_buf_status_vc0;
    input pcie_x1_top_ph_processed_vc0;
    output pcie_x1_top_phy_pol_compliance;
    input pcie_x1_top_pll_refclki;
    output pcie_x1_top_pme_en;
    input pcie_x1_top_pme_status;
    input pcie_x1_top_rst_n;
    output pcie_x1_top_rx_end_vc0;
    output pcie_x1_top_rx_malf_tlp_vc0;
    output pcie_x1_top_rx_st_vc0;
    output pcie_x1_top_rx_us_req_vc0;
    input pcie_x1_top_rxrefclk;
    input pcie_x1_top_sci_en;
    input pcie_x1_top_sci_en_dual;
    output pcie_x1_top_sci_int;
    input pcie_x1_top_sci_rd;
    input pcie_x1_top_sci_sel;
    input pcie_x1_top_sci_sel_dual;
    input pcie_x1_top_sci_wrn;
    output pcie_x1_top_serdes_pdb;
    output pcie_x1_top_serdes_rst_dual_c;
    output pcie_x1_top_sys_clk_125;
    output pcie_x1_top_tx_ca_cpl_recheck_vc0;
    output pcie_x1_top_tx_ca_p_recheck_vc0;
    output pcie_x1_top_tx_dllp_sent;
    input pcie_x1_top_tx_end_vc0;
    output pcie_x1_top_tx_lbk_rdy;
    input pcie_x1_top_tx_nlfy_vc0;
    output pcie_x1_top_tx_pwrup_c;
    output pcie_x1_top_tx_rdy_vc0;
    input pcie_x1_top_tx_req_vc0;
    output pcie_x1_top_tx_serdes_rst_c;
    input pcie_x1_top_tx_st_vc0;
    input pcie_x1_top_unexp_cmpln;
    input pcie_x1_top_ur_np_ext;
    input pcie_x1_top_ur_p_ext;
    
    
    pcie_mfx1_top pcie_mfx1_top_inst (.ix_dec_wb_cyc({pcie_mfx1_top_ix_dec_wb_cyc}), 
            .ix_ipx_rx_data({pcie_mfx1_top_ix_ipx_rx_data}), .ix_ipx_tx_ca_cpld({pcie_mfx1_top_ix_ipx_tx_ca_cpld}), 
            .ix_ipx_tx_ca_cplh({pcie_mfx1_top_ix_ipx_tx_ca_cplh}), .ix_ipx_tx_ca_npd({pcie_mfx1_top_ix_ipx_tx_ca_npd}), 
            .ix_ipx_tx_ca_nph({pcie_mfx1_top_ix_ipx_tx_ca_nph}), .ix_ipx_tx_ca_pd({pcie_mfx1_top_ix_ipx_tx_ca_pd}), 
            .ix_ipx_tx_ca_ph({pcie_mfx1_top_ix_ipx_tx_ca_ph}), .ix_pci_int_req({pcie_mfx1_top_ix_pci_int_req}), 
            .ix_wbm_dat({pcie_mfx1_top_ix_wbm_dat}), .ix_wbs_adr({pcie_mfx1_top_ix_wbs_adr}), 
            .ix_wbs_bte({pcie_mfx1_top_ix_wbs_bte}), .ix_wbs_cti({pcie_mfx1_top_ix_wbs_cti}), 
            .ix_wbs_cyc({pcie_mfx1_top_ix_wbs_cyc}), .ix_wbs_dat({pcie_mfx1_top_ix_wbs_dat}), 
            .ix_wbs_sel({pcie_mfx1_top_ix_wbs_sel}), .ox_dec_adr({pcie_mfx1_top_ox_dec_adr}), 
            .ox_dec_bar_hit({pcie_mfx1_top_ox_dec_bar_hit}), .ox_dec_func_hit({pcie_mfx1_top_ox_dec_func_hit}), 
            .ox_ipx_cc_npd_num({pcie_mfx1_top_ox_ipx_cc_npd_num}), .ox_ipx_cc_pd_num({pcie_mfx1_top_ox_ipx_cc_pd_num}), 
            .ox_ipx_tx_data({pcie_mfx1_top_ox_ipx_tx_data}), .ox_sys_rst_func_n({pcie_mfx1_top_ox_sys_rst_func_n}), 
            .ox_wbm_adr({pcie_mfx1_top_ox_wbm_adr}), .ox_wbm_bte({pcie_mfx1_top_ox_wbm_bte}), 
            .ox_wbm_cti({pcie_mfx1_top_ox_wbm_cti}), .ox_wbm_cyc({pcie_mfx1_top_ox_wbm_cyc}), 
            .ox_wbm_dat({pcie_mfx1_top_ox_wbm_dat}), .ox_wbm_sel({pcie_mfx1_top_ox_wbm_sel}), 
            .ox_wbs_dat({pcie_mfx1_top_ox_wbs_dat}), .ix_clk_125(pcie_mfx1_top_ix_clk_125), 
            .ix_ipx_dl_up(pcie_mfx1_top_ix_ipx_dl_up), .ix_ipx_malf_tlp(pcie_mfx1_top_ix_ipx_malf_tlp), 
            .ix_ipx_rx_end(pcie_mfx1_top_ix_ipx_rx_end), .ix_ipx_rx_st(pcie_mfx1_top_ix_ipx_rx_st), 
            .ix_ipx_tx_rdy(pcie_mfx1_top_ix_ipx_tx_rdy), .ix_rst_n(pcie_mfx1_top_ix_rst_n), 
            .ix_wbm_ack(pcie_mfx1_top_ix_wbm_ack), .ix_wbs_stb(pcie_mfx1_top_ix_wbs_stb), 
            .ix_wbs_we(pcie_mfx1_top_ix_wbs_we), .ox_ipx_cc_processed_npd(pcie_mfx1_top_ox_ipx_cc_processed_npd), 
            .ox_ipx_cc_processed_nph(pcie_mfx1_top_ox_ipx_cc_processed_nph), 
            .ox_ipx_cc_processed_pd(pcie_mfx1_top_ox_ipx_cc_processed_pd), 
            .ox_ipx_cc_processed_ph(pcie_mfx1_top_ox_ipx_cc_processed_ph), 
            .ox_ipx_tx_end(pcie_mfx1_top_ox_ipx_tx_end), .ox_ipx_tx_req(pcie_mfx1_top_ox_ipx_tx_req), 
            .ox_ipx_tx_st(pcie_mfx1_top_ox_ipx_tx_st), .ox_sys_rst_n(pcie_mfx1_top_ox_sys_rst_n), 
            .ox_wbm_stb(pcie_mfx1_top_ox_wbm_stb), .ox_wbm_we(pcie_mfx1_top_ox_wbm_we), 
            .ox_wbs_ack(pcie_mfx1_top_ox_wbs_ack), .ox_wbs_err(pcie_mfx1_top_ox_wbs_err));
    pcie_refclk pcie_refclk_inst (.refclkn(pcie_refclk_refclkn), .refclko(pcie_refclk_refclko), 
            .refclkp(pcie_refclk_refclkp));
    pcie_x1_top pcie_x1_top_inst (.bus_num({pcie_x1_top_bus_num}), .cmd_reg_out({pcie_x1_top_cmd_reg_out}), 
            .dev_cntl_out({pcie_x1_top_dev_cntl_out}), .dev_num({pcie_x1_top_dev_num}), 
            .func_num({pcie_x1_top_func_num}), .lnk_cntl_out({pcie_x1_top_lnk_cntl_out}), 
            .mm_enable({pcie_x1_top_mm_enable}), .msi({pcie_x1_top_msi}), 
            .npd_num_vc0({pcie_x1_top_npd_num_vc0}), .pd_num_vc0({pcie_x1_top_pd_num_vc0}), 
            .phy_ltssm_state({pcie_x1_top_phy_ltssm_state}), .pm_power_state({pcie_x1_top_pm_power_state}), 
            .rx_bar_hit({pcie_x1_top_rx_bar_hit}), .rx_data_vc0({pcie_x1_top_rx_data_vc0}), 
            .rx_lbk_data({pcie_x1_top_rx_lbk_data}), .rx_lbk_kcntl({pcie_x1_top_rx_lbk_kcntl}), 
            .rxdp_dllp_val({pcie_x1_top_rxdp_dllp_val}), .rxdp_pmd_type({pcie_x1_top_rxdp_pmd_type}), 
            .rxdp_vsd_data({pcie_x1_top_rxdp_vsd_data}), .sci_addr({pcie_x1_top_sci_addr}), 
            .sci_rddata({pcie_x1_top_sci_rddata}), .sci_wrdata({pcie_x1_top_sci_wrdata}), 
            .tx_ca_cpld_vc0({pcie_x1_top_tx_ca_cpld_vc0}), .tx_ca_cplh_vc0({pcie_x1_top_tx_ca_cplh_vc0}), 
            .tx_ca_npd_vc0({pcie_x1_top_tx_ca_npd_vc0}), .tx_ca_nph_vc0({pcie_x1_top_tx_ca_nph_vc0}), 
            .tx_ca_pd_vc0({pcie_x1_top_tx_ca_pd_vc0}), .tx_ca_ph_vc0({pcie_x1_top_tx_ca_ph_vc0}), 
            .tx_data_vc0({pcie_x1_top_tx_data_vc0}), .tx_dllp_val({pcie_x1_top_tx_dllp_val}), 
            .tx_lbk_data({pcie_x1_top_tx_lbk_data}), .tx_lbk_kcntl({pcie_x1_top_tx_lbk_kcntl}), 
            .tx_pmtype({pcie_x1_top_tx_pmtype}), .tx_vsd_data({pcie_x1_top_tx_vsd_data}), 
            .cmpln_tout(pcie_x1_top_cmpln_tout), .cmpltr_abort_np(pcie_x1_top_cmpltr_abort_np), 
            .cmpltr_abort_p(pcie_x1_top_cmpltr_abort_p), .dl_active(pcie_x1_top_dl_active), 
            .dl_inactive(pcie_x1_top_dl_inactive), .dl_init(pcie_x1_top_dl_init), 
            .dl_up(pcie_x1_top_dl_up), .flip_lanes(pcie_x1_top_flip_lanes), 
            .force_disable_scr(pcie_x1_top_force_disable_scr), .force_lsm_active(pcie_x1_top_force_lsm_active), 
            .force_phy_status(pcie_x1_top_force_phy_status), .force_rec_ei(pcie_x1_top_force_rec_ei), 
            .hdinn0(pcie_x1_top_hdinn0), .hdinp0(pcie_x1_top_hdinp0), .hdoutn0(pcie_x1_top_hdoutn0), 
            .hdoutp0(pcie_x1_top_hdoutp0), .hl_disable_scr(pcie_x1_top_hl_disable_scr), 
            .hl_gto_cfg(pcie_x1_top_hl_gto_cfg), .hl_gto_det(pcie_x1_top_hl_gto_det), 
            .hl_gto_dis(pcie_x1_top_hl_gto_dis), .hl_gto_hrst(pcie_x1_top_hl_gto_hrst), 
            .hl_gto_l0stx(pcie_x1_top_hl_gto_l0stx), .hl_gto_l0stxfts(pcie_x1_top_hl_gto_l0stxfts), 
            .hl_gto_l1(pcie_x1_top_hl_gto_l1), .hl_gto_l2(pcie_x1_top_hl_gto_l2), 
            .hl_gto_lbk(pcie_x1_top_hl_gto_lbk), .hl_gto_rcvry(pcie_x1_top_hl_gto_rcvry), 
            .hl_snd_beacon(pcie_x1_top_hl_snd_beacon), .inta_n(pcie_x1_top_inta_n), 
            .msi_enable(pcie_x1_top_msi_enable), .no_pcie_train(pcie_x1_top_no_pcie_train), 
            .np_req_pend(pcie_x1_top_np_req_pend), .npd_buf_status_vc0(pcie_x1_top_npd_buf_status_vc0), 
            .npd_processed_vc0(pcie_x1_top_npd_processed_vc0), .nph_buf_status_vc0(pcie_x1_top_nph_buf_status_vc0), 
            .nph_processed_vc0(pcie_x1_top_nph_processed_vc0), .pd_buf_status_vc0(pcie_x1_top_pd_buf_status_vc0), 
            .pd_processed_vc0(pcie_x1_top_pd_processed_vc0), .ph_buf_status_vc0(pcie_x1_top_ph_buf_status_vc0), 
            .ph_processed_vc0(pcie_x1_top_ph_processed_vc0), .phy_pol_compliance(pcie_x1_top_phy_pol_compliance), 
            .pll_refclki(pcie_x1_top_pll_refclki), .pme_en(pcie_x1_top_pme_en), 
            .pme_status(pcie_x1_top_pme_status), .rst_n(pcie_x1_top_rst_n), 
            .rx_end_vc0(pcie_x1_top_rx_end_vc0), .rx_malf_tlp_vc0(pcie_x1_top_rx_malf_tlp_vc0), 
            .rx_st_vc0(pcie_x1_top_rx_st_vc0), .rx_us_req_vc0(pcie_x1_top_rx_us_req_vc0), 
            .rxrefclk(pcie_x1_top_rxrefclk), .sci_en(pcie_x1_top_sci_en), 
            .sci_en_dual(pcie_x1_top_sci_en_dual), .sci_int(pcie_x1_top_sci_int), 
            .sci_rd(pcie_x1_top_sci_rd), .sci_sel(pcie_x1_top_sci_sel), 
            .sci_sel_dual(pcie_x1_top_sci_sel_dual), .sci_wrn(pcie_x1_top_sci_wrn), 
            .serdes_pdb(pcie_x1_top_serdes_pdb), .serdes_rst_dual_c(pcie_x1_top_serdes_rst_dual_c), 
            .sys_clk_125(pcie_x1_top_sys_clk_125), .tx_ca_cpl_recheck_vc0(pcie_x1_top_tx_ca_cpl_recheck_vc0), 
            .tx_ca_p_recheck_vc0(pcie_x1_top_tx_ca_p_recheck_vc0), .tx_dllp_sent(pcie_x1_top_tx_dllp_sent), 
            .tx_end_vc0(pcie_x1_top_tx_end_vc0), .tx_lbk_rdy(pcie_x1_top_tx_lbk_rdy), 
            .tx_nlfy_vc0(pcie_x1_top_tx_nlfy_vc0), .tx_pwrup_c(pcie_x1_top_tx_pwrup_c), 
            .tx_rdy_vc0(pcie_x1_top_tx_rdy_vc0), .tx_req_vc0(pcie_x1_top_tx_req_vc0), 
            .tx_serdes_rst_c(pcie_x1_top_tx_serdes_rst_c), .tx_st_vc0(pcie_x1_top_tx_st_vc0), 
            .unexp_cmpln(pcie_x1_top_unexp_cmpln), .ur_np_ext(pcie_x1_top_ur_np_ext), 
            .ur_p_ext(pcie_x1_top_ur_p_ext));
    
endmodule

