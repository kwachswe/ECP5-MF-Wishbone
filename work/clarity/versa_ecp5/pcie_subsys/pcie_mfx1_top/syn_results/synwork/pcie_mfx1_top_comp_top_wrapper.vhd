--
-- Synopsys
-- Vhdl wrapper for top level design, written on Sun Feb 27 15:20:22 2022
--
library ieee;
use ieee.std_logic_1164.all;

entity wrapper_for_pcie_mfx1_top is
   port (
      ix_clk_125 : in std_logic;
      ix_dec_wb_cyc : in std_logic_vector(7 downto 0);
      ix_ipx_dl_up : in std_logic;
      ix_ipx_malf_tlp : in std_logic;
      ix_ipx_rx_data : in std_logic_vector(15 downto 0);
      ix_ipx_rx_end : in std_logic;
      ix_ipx_rx_st : in std_logic;
      ix_ipx_tx_ca_cpld : in std_logic_vector(12 downto 0);
      ix_ipx_tx_ca_cplh : in std_logic_vector(8 downto 0);
      ix_ipx_tx_ca_npd : in std_logic_vector(12 downto 0);
      ix_ipx_tx_ca_nph : in std_logic_vector(8 downto 0);
      ix_ipx_tx_ca_pd : in std_logic_vector(12 downto 0);
      ix_ipx_tx_ca_ph : in std_logic_vector(8 downto 0);
      ix_ipx_tx_rdy : in std_logic;
      ix_pci_int_req : in std_logic_vector(7 downto 0);
      ix_rst_n : in std_logic;
      ix_wbm_ack : in std_logic;
      ix_wbm_dat : in std_logic_vector(31 downto 0);
      ix_wbs_adr : in std_logic_vector(47 downto 0);
      ix_wbs_bte : in std_logic_vector(1 downto 0);
      ix_wbs_cti : in std_logic_vector(2 downto 0);
      ix_wbs_cyc : in std_logic_vector(7 downto 0);
      ix_wbs_dat : in std_logic_vector(31 downto 0);
      ix_wbs_sel : in std_logic_vector(3 downto 0);
      ix_wbs_stb : in std_logic;
      ix_wbs_we : in std_logic;
      ox_dec_adr : out std_logic_vector(15 downto 0);
      ox_dec_bar_hit : out std_logic_vector(5 downto 0);
      ox_dec_func_hit : out std_logic_vector(7 downto 0);
      ox_ipx_cc_npd_num : out std_logic_vector(7 downto 0);
      ox_ipx_cc_pd_num : out std_logic_vector(7 downto 0);
      ox_ipx_cc_processed_npd : out std_logic;
      ox_ipx_cc_processed_nph : out std_logic;
      ox_ipx_cc_processed_pd : out std_logic;
      ox_ipx_cc_processed_ph : out std_logic;
      ox_ipx_tx_data : out std_logic_vector(15 downto 0);
      ox_ipx_tx_end : out std_logic;
      ox_ipx_tx_req : out std_logic;
      ox_ipx_tx_st : out std_logic;
      ox_sys_rst_func_n : out std_logic_vector(7 downto 0);
      ox_sys_rst_n : out std_logic;
      ox_wbm_adr : out std_logic_vector(15 downto 0);
      ox_wbm_bte : out std_logic_vector(1 downto 0);
      ox_wbm_cti : out std_logic_vector(2 downto 0);
      ox_wbm_cyc : out std_logic_vector(7 downto 0);
      ox_wbm_dat : out std_logic_vector(31 downto 0);
      ox_wbm_sel : out std_logic_vector(3 downto 0);
      ox_wbm_stb : out std_logic;
      ox_wbm_we : out std_logic;
      ox_wbs_ack : out std_logic;
      ox_wbs_dat : out std_logic_vector(31 downto 0);
      ox_wbs_err : out std_logic
   );
end wrapper_for_pcie_mfx1_top;

architecture rtl of wrapper_for_pcie_mfx1_top is

component pcie_mfx1_top
 port (
   ix_clk_125 : in std_logic;
   ix_dec_wb_cyc : in std_logic_vector (7 downto 0);
   ix_ipx_dl_up : in std_logic;
   ix_ipx_malf_tlp : in std_logic;
   ix_ipx_rx_data : in std_logic_vector (15 downto 0);
   ix_ipx_rx_end : in std_logic;
   ix_ipx_rx_st : in std_logic;
   ix_ipx_tx_ca_cpld : in std_logic_vector (12 downto 0);
   ix_ipx_tx_ca_cplh : in std_logic_vector (8 downto 0);
   ix_ipx_tx_ca_npd : in std_logic_vector (12 downto 0);
   ix_ipx_tx_ca_nph : in std_logic_vector (8 downto 0);
   ix_ipx_tx_ca_pd : in std_logic_vector (12 downto 0);
   ix_ipx_tx_ca_ph : in std_logic_vector (8 downto 0);
   ix_ipx_tx_rdy : in std_logic;
   ix_pci_int_req : in std_logic_vector (7 downto 0);
   ix_rst_n : in std_logic;
   ix_wbm_ack : in std_logic;
   ix_wbm_dat : in std_logic_vector (31 downto 0);
   ix_wbs_adr : in std_logic_vector (47 downto 0);
   ix_wbs_bte : in std_logic_vector (1 downto 0);
   ix_wbs_cti : in std_logic_vector (2 downto 0);
   ix_wbs_cyc : in std_logic_vector (7 downto 0);
   ix_wbs_dat : in std_logic_vector (31 downto 0);
   ix_wbs_sel : in std_logic_vector (3 downto 0);
   ix_wbs_stb : in std_logic;
   ix_wbs_we : in std_logic;
   ox_dec_adr : out std_logic_vector (15 downto 0);
   ox_dec_bar_hit : out std_logic_vector (5 downto 0);
   ox_dec_func_hit : out std_logic_vector (7 downto 0);
   ox_ipx_cc_npd_num : out std_logic_vector (7 downto 0);
   ox_ipx_cc_pd_num : out std_logic_vector (7 downto 0);
   ox_ipx_cc_processed_npd : out std_logic;
   ox_ipx_cc_processed_nph : out std_logic;
   ox_ipx_cc_processed_pd : out std_logic;
   ox_ipx_cc_processed_ph : out std_logic;
   ox_ipx_tx_data : out std_logic_vector (15 downto 0);
   ox_ipx_tx_end : out std_logic;
   ox_ipx_tx_req : out std_logic;
   ox_ipx_tx_st : out std_logic;
   ox_sys_rst_func_n : out std_logic_vector (7 downto 0);
   ox_sys_rst_n : out std_logic;
   ox_wbm_adr : out std_logic_vector (15 downto 0);
   ox_wbm_bte : out std_logic_vector (1 downto 0);
   ox_wbm_cti : out std_logic_vector (2 downto 0);
   ox_wbm_cyc : out std_logic_vector (7 downto 0);
   ox_wbm_dat : out std_logic_vector (31 downto 0);
   ox_wbm_sel : out std_logic_vector (3 downto 0);
   ox_wbm_stb : out std_logic;
   ox_wbm_we : out std_logic;
   ox_wbs_ack : out std_logic;
   ox_wbs_dat : out std_logic_vector (31 downto 0);
   ox_wbs_err : out std_logic
 );
end component;

signal tmp_ix_clk_125 : std_logic;
signal tmp_ix_dec_wb_cyc : std_logic_vector (7 downto 0);
signal tmp_ix_ipx_dl_up : std_logic;
signal tmp_ix_ipx_malf_tlp : std_logic;
signal tmp_ix_ipx_rx_data : std_logic_vector (15 downto 0);
signal tmp_ix_ipx_rx_end : std_logic;
signal tmp_ix_ipx_rx_st : std_logic;
signal tmp_ix_ipx_tx_ca_cpld : std_logic_vector (12 downto 0);
signal tmp_ix_ipx_tx_ca_cplh : std_logic_vector (8 downto 0);
signal tmp_ix_ipx_tx_ca_npd : std_logic_vector (12 downto 0);
signal tmp_ix_ipx_tx_ca_nph : std_logic_vector (8 downto 0);
signal tmp_ix_ipx_tx_ca_pd : std_logic_vector (12 downto 0);
signal tmp_ix_ipx_tx_ca_ph : std_logic_vector (8 downto 0);
signal tmp_ix_ipx_tx_rdy : std_logic;
signal tmp_ix_pci_int_req : std_logic_vector (7 downto 0);
signal tmp_ix_rst_n : std_logic;
signal tmp_ix_wbm_ack : std_logic;
signal tmp_ix_wbm_dat : std_logic_vector (31 downto 0);
signal tmp_ix_wbs_adr : std_logic_vector (47 downto 0);
signal tmp_ix_wbs_bte : std_logic_vector (1 downto 0);
signal tmp_ix_wbs_cti : std_logic_vector (2 downto 0);
signal tmp_ix_wbs_cyc : std_logic_vector (7 downto 0);
signal tmp_ix_wbs_dat : std_logic_vector (31 downto 0);
signal tmp_ix_wbs_sel : std_logic_vector (3 downto 0);
signal tmp_ix_wbs_stb : std_logic;
signal tmp_ix_wbs_we : std_logic;
signal tmp_ox_dec_adr : std_logic_vector (15 downto 0);
signal tmp_ox_dec_bar_hit : std_logic_vector (5 downto 0);
signal tmp_ox_dec_func_hit : std_logic_vector (7 downto 0);
signal tmp_ox_ipx_cc_npd_num : std_logic_vector (7 downto 0);
signal tmp_ox_ipx_cc_pd_num : std_logic_vector (7 downto 0);
signal tmp_ox_ipx_cc_processed_npd : std_logic;
signal tmp_ox_ipx_cc_processed_nph : std_logic;
signal tmp_ox_ipx_cc_processed_pd : std_logic;
signal tmp_ox_ipx_cc_processed_ph : std_logic;
signal tmp_ox_ipx_tx_data : std_logic_vector (15 downto 0);
signal tmp_ox_ipx_tx_end : std_logic;
signal tmp_ox_ipx_tx_req : std_logic;
signal tmp_ox_ipx_tx_st : std_logic;
signal tmp_ox_sys_rst_func_n : std_logic_vector (7 downto 0);
signal tmp_ox_sys_rst_n : std_logic;
signal tmp_ox_wbm_adr : std_logic_vector (15 downto 0);
signal tmp_ox_wbm_bte : std_logic_vector (1 downto 0);
signal tmp_ox_wbm_cti : std_logic_vector (2 downto 0);
signal tmp_ox_wbm_cyc : std_logic_vector (7 downto 0);
signal tmp_ox_wbm_dat : std_logic_vector (31 downto 0);
signal tmp_ox_wbm_sel : std_logic_vector (3 downto 0);
signal tmp_ox_wbm_stb : std_logic;
signal tmp_ox_wbm_we : std_logic;
signal tmp_ox_wbs_ack : std_logic;
signal tmp_ox_wbs_dat : std_logic_vector (31 downto 0);
signal tmp_ox_wbs_err : std_logic;

begin

tmp_ix_clk_125 <= ix_clk_125;

tmp_ix_dec_wb_cyc <= ix_dec_wb_cyc;

tmp_ix_ipx_dl_up <= ix_ipx_dl_up;

tmp_ix_ipx_malf_tlp <= ix_ipx_malf_tlp;

tmp_ix_ipx_rx_data <= ix_ipx_rx_data;

tmp_ix_ipx_rx_end <= ix_ipx_rx_end;

tmp_ix_ipx_rx_st <= ix_ipx_rx_st;

tmp_ix_ipx_tx_ca_cpld <= ix_ipx_tx_ca_cpld;

tmp_ix_ipx_tx_ca_cplh <= ix_ipx_tx_ca_cplh;

tmp_ix_ipx_tx_ca_npd <= ix_ipx_tx_ca_npd;

tmp_ix_ipx_tx_ca_nph <= ix_ipx_tx_ca_nph;

tmp_ix_ipx_tx_ca_pd <= ix_ipx_tx_ca_pd;

tmp_ix_ipx_tx_ca_ph <= ix_ipx_tx_ca_ph;

tmp_ix_ipx_tx_rdy <= ix_ipx_tx_rdy;

tmp_ix_pci_int_req <= ix_pci_int_req;

tmp_ix_rst_n <= ix_rst_n;

tmp_ix_wbm_ack <= ix_wbm_ack;

tmp_ix_wbm_dat <= ix_wbm_dat;

tmp_ix_wbs_adr <= ix_wbs_adr;

tmp_ix_wbs_bte <= ix_wbs_bte;

tmp_ix_wbs_cti <= ix_wbs_cti;

tmp_ix_wbs_cyc <= ix_wbs_cyc;

tmp_ix_wbs_dat <= ix_wbs_dat;

tmp_ix_wbs_sel <= ix_wbs_sel;

tmp_ix_wbs_stb <= ix_wbs_stb;

tmp_ix_wbs_we <= ix_wbs_we;

ox_dec_adr <= tmp_ox_dec_adr;

ox_dec_bar_hit <= tmp_ox_dec_bar_hit;

ox_dec_func_hit <= tmp_ox_dec_func_hit;

ox_ipx_cc_npd_num <= tmp_ox_ipx_cc_npd_num;

ox_ipx_cc_pd_num <= tmp_ox_ipx_cc_pd_num;

ox_ipx_cc_processed_npd <= tmp_ox_ipx_cc_processed_npd;

ox_ipx_cc_processed_nph <= tmp_ox_ipx_cc_processed_nph;

ox_ipx_cc_processed_pd <= tmp_ox_ipx_cc_processed_pd;

ox_ipx_cc_processed_ph <= tmp_ox_ipx_cc_processed_ph;

ox_ipx_tx_data <= tmp_ox_ipx_tx_data;

ox_ipx_tx_end <= tmp_ox_ipx_tx_end;

ox_ipx_tx_req <= tmp_ox_ipx_tx_req;

ox_ipx_tx_st <= tmp_ox_ipx_tx_st;

ox_sys_rst_func_n <= tmp_ox_sys_rst_func_n;

ox_sys_rst_n <= tmp_ox_sys_rst_n;

ox_wbm_adr <= tmp_ox_wbm_adr;

ox_wbm_bte <= tmp_ox_wbm_bte;

ox_wbm_cti <= tmp_ox_wbm_cti;

ox_wbm_cyc <= tmp_ox_wbm_cyc;

ox_wbm_dat <= tmp_ox_wbm_dat;

ox_wbm_sel <= tmp_ox_wbm_sel;

ox_wbm_stb <= tmp_ox_wbm_stb;

ox_wbm_we <= tmp_ox_wbm_we;

ox_wbs_ack <= tmp_ox_wbs_ack;

ox_wbs_dat <= tmp_ox_wbs_dat;

ox_wbs_err <= tmp_ox_wbs_err;



u1:   pcie_mfx1_top port map (
		ix_clk_125 => tmp_ix_clk_125,
		ix_dec_wb_cyc => tmp_ix_dec_wb_cyc,
		ix_ipx_dl_up => tmp_ix_ipx_dl_up,
		ix_ipx_malf_tlp => tmp_ix_ipx_malf_tlp,
		ix_ipx_rx_data => tmp_ix_ipx_rx_data,
		ix_ipx_rx_end => tmp_ix_ipx_rx_end,
		ix_ipx_rx_st => tmp_ix_ipx_rx_st,
		ix_ipx_tx_ca_cpld => tmp_ix_ipx_tx_ca_cpld,
		ix_ipx_tx_ca_cplh => tmp_ix_ipx_tx_ca_cplh,
		ix_ipx_tx_ca_npd => tmp_ix_ipx_tx_ca_npd,
		ix_ipx_tx_ca_nph => tmp_ix_ipx_tx_ca_nph,
		ix_ipx_tx_ca_pd => tmp_ix_ipx_tx_ca_pd,
		ix_ipx_tx_ca_ph => tmp_ix_ipx_tx_ca_ph,
		ix_ipx_tx_rdy => tmp_ix_ipx_tx_rdy,
		ix_pci_int_req => tmp_ix_pci_int_req,
		ix_rst_n => tmp_ix_rst_n,
		ix_wbm_ack => tmp_ix_wbm_ack,
		ix_wbm_dat => tmp_ix_wbm_dat,
		ix_wbs_adr => tmp_ix_wbs_adr,
		ix_wbs_bte => tmp_ix_wbs_bte,
		ix_wbs_cti => tmp_ix_wbs_cti,
		ix_wbs_cyc => tmp_ix_wbs_cyc,
		ix_wbs_dat => tmp_ix_wbs_dat,
		ix_wbs_sel => tmp_ix_wbs_sel,
		ix_wbs_stb => tmp_ix_wbs_stb,
		ix_wbs_we => tmp_ix_wbs_we,
		ox_dec_adr => tmp_ox_dec_adr,
		ox_dec_bar_hit => tmp_ox_dec_bar_hit,
		ox_dec_func_hit => tmp_ox_dec_func_hit,
		ox_ipx_cc_npd_num => tmp_ox_ipx_cc_npd_num,
		ox_ipx_cc_pd_num => tmp_ox_ipx_cc_pd_num,
		ox_ipx_cc_processed_npd => tmp_ox_ipx_cc_processed_npd,
		ox_ipx_cc_processed_nph => tmp_ox_ipx_cc_processed_nph,
		ox_ipx_cc_processed_pd => tmp_ox_ipx_cc_processed_pd,
		ox_ipx_cc_processed_ph => tmp_ox_ipx_cc_processed_ph,
		ox_ipx_tx_data => tmp_ox_ipx_tx_data,
		ox_ipx_tx_end => tmp_ox_ipx_tx_end,
		ox_ipx_tx_req => tmp_ox_ipx_tx_req,
		ox_ipx_tx_st => tmp_ox_ipx_tx_st,
		ox_sys_rst_func_n => tmp_ox_sys_rst_func_n,
		ox_sys_rst_n => tmp_ox_sys_rst_n,
		ox_wbm_adr => tmp_ox_wbm_adr,
		ox_wbm_bte => tmp_ox_wbm_bte,
		ox_wbm_cti => tmp_ox_wbm_cti,
		ox_wbm_cyc => tmp_ox_wbm_cyc,
		ox_wbm_dat => tmp_ox_wbm_dat,
		ox_wbm_sel => tmp_ox_wbm_sel,
		ox_wbm_stb => tmp_ox_wbm_stb,
		ox_wbm_we => tmp_ox_wbm_we,
		ox_wbs_ack => tmp_ox_wbs_ack,
		ox_wbs_dat => tmp_ox_wbs_dat,
		ox_wbs_err => tmp_ox_wbs_err
       );
end rtl;
