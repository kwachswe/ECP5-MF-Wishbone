#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file

#device options
set_option -technology ECP5UM
set_option -part LFE5UM_45F
set_option -package BG381C
set_option -speed_grade -8

#compilation/mapping options
set_option -symbolic_fsm_compiler true
set_option -resource_sharing true

#use verilog 2001 standard option
set_option -vlog_std v2001

#map options
set_option -frequency 280
set_option -maxfan 200
set_option -auto_constrain_io 1
set_option -disable_io_insertion false
set_option -retiming false; set_option -pipe false
set_option -force_gsr false
set_option -compiler_compatible 0
set_option -dup true

set_option -default_enum_encoding default

#simulation options


#timing analysis options
set_option -num_critical_paths 32


#automatic place and route (vendor) options
set_option -write_apr_constraint 1

#synplifyPro options
set_option -fix_gated_and_generated_clocks 1
set_option -update_models_cp 0
set_option -resolve_multiple_driver 0
set_option -vhdl2008 1

set_option -seqshift_no_replicate 0

#-- add_file options
set_option -hdl_define -set SBP_SYNTHESIS
set_option -include_path {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_x1_e5/x_pcie/pcie_eval/x_pcie/src/params}
set_option -include_path {C:/project/PCIe_ECP5_MF/work/diamond/versa_ecp5}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/rx_rsl/vhdl/rx_rsl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_mfx1_top/pcie_mfx1_top_combo.vhd}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_mfx1_top/pcie_mfx1_top_bb.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_refclk/pcie_refclk.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_eval/pcie_x1_top/src/params/pci_exp_params.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_x1_top.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_x1_top_core_bb.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_eval/models/ecp5um/pcie_x1_top_sync1s.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_eval/models/ecp5um/pcie_x1_top_ctc.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_eval/models/ecp5um/pcie_x1_top_pcs_softlogic.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_eval/models/ecp5um/pcie_x1_top_pcs.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_eval/models/ecp5um/pcie_x1_top_pipe.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_eval/models/ecp5um/pcie_x1_top_phy.v}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_subsys.v}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/packages/tspc_utils/vhdl/tspc_utils-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/packages/tspc_utils/vhdl/tspc_utils-pb.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/top/core_mf8c/vhdl/core_mf8c_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/packages/tspc_wbone_types/vhdl/tspc_wbone_types-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/packages/tspc_wbone_types/vhdl/tspc_wbone_types-pb.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/uart_block/vhdl/uart_block_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/tspc_dma_chan_ms/top/vhdl/tspc_dma_chan_ms_types-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/tspc_dma_chan_ms/top/vhdl/tspc_dma_chan_ms_types-pb.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/units/others/vhdl/jxb3_cfi_reg_types-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/units/others/vhdl/jxb3_cfi_reg_types-pb.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/tspc_dma_chan_ms/top/vhdl/tspc_dma_chan_ms_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/units/tspc_cfi_spim_pw2n/vhdl/tspc_cfi_spim_pw2n_types-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_fifo_sync/top/vhdl/tspc_fifo_sync_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/pcat_16550s/vhdl/pcat_16550s_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/modem_regs_16550s/vhdl/modem_regs_16550s_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/rx_16550s/vhdl/rx_16550s_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/tx_16550s/vhdl/tx_16550s_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/tx_ser_8250/vhdl/tx_ser_8250_core_types-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/rx_ser_8250/vhdl/rx_ser_8250_core_types-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/rx_ser_8250/vhdl/rx_ser_8250_core_types-pb.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/top/vhdl/dma_subsys_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/dma_subsys_regs/vhdl/dma_subsys_regs_types-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/dma_subsys_regs/vhdl/dma_subsys_regs_types-pb.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/top/vhdl/tspc_wb_cfi_jxb3_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_cdc_vec/vhdl/tspc_cdc_vec-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_cdc_vec/vhdl/tspc_cdc_vec-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/adr_decode/vhdl/adr_decode-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/adr_decode/vhdl/adr_decode-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/clock_gen/vhdl/clock_gen-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/clock_gen/vhdl/clock_gen-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/dma_subsys_regs/vhdl/dma_subsys_regs-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/dma_subsys_regs/vhdl/dma_subsys_regs-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tsls_wb_bmram/units/tspc_wb_ebr_ctl/vhdl/tspc_wb_ebr_ctl-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tsls_wb_bmram/units/tspc_wb_ebr_ctl/vhdl/tspc_wb_ebr_ctl-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tsls_wb_bmram/top/vhdl/tsls_wb_bmram-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tsls_wb_bmram/top/vhdl/tsls_wb_bmram-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/units/tspc_cfi_spim_pw2n/vhdl/tspc_cfi_spim_pw2n-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/units/tspc_cfi_spim_pw2n/vhdl/tspc_cfi_spim_pw2n-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/units/others/vhdl/jxb3_regs_ctrl-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/units/others/vhdl/jxb3_regs_ctrl-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/units/others/vhdl/jxb3_spi_dma_tgt-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/units/others/vhdl/jxb3_spi_dma_tgt-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_cdc_reg/vhdl/tspc_cdc_reg-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_cdc_reg/vhdl/tspc_cdc_reg-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/tspc_dma_chan_ms/units/vhdl/tspc_dma_chan_ms_ctl-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/tspc_dma_chan_ms/units/vhdl/tspc_dma_chan_ms_ctl-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_fifo_ctl_sync/vhdl/tspc_fifo_ctl_sync-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_fifo_ctl_sync/vhdl/tspc_fifo_ctl_sync-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_fifo_sync/tech/vhdl/tspc_fifo_sync_mem-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_fifo_sync/tech/vhdl/tspc_fifo_sync_mem-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_fifo_sync/top/vhdl/tspc_fifo_sync-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_fifo_sync/top/vhdl/tspc_fifo_sync-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/top/vhdl/tspc_wb_cfi_jxb3-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/tspc_wb_cfi_jxb3/top/vhdl/tspc_wb_cfi_jxb3-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_cdc_ack/vhdl/tspc_cdc_ack-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_cdc_ack/vhdl/tspc_cdc_ack-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/modem_regs_16550s/vhdl/modem_regs_16550s-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/modem_regs_16550s/vhdl/modem_regs_16550s-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/rx_ser_8250/vhdl/rx_ser_8250_core-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/rx_ser_8250/vhdl/rx_ser_8250_core-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/rx_16550s/vhdl/rx_16550s-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/rx_16550s/vhdl/rx_16550s-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/tx_ser_8250/vhdl/tx_ser_8250_core-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/tx_ser_8250/vhdl/tx_ser_8250_core-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_event_latch/vhdl/tspc_event_latch-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_event_latch/vhdl/tspc_event_latch-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_reg_pipeline/vhdl/tspc_reg_pipeline-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/common/units/tspc_reg_pipeline/vhdl/tspc_reg_pipeline-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/tx_16550s/vhdl/tx_16550s-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/tx_16550s/vhdl/tx_16550s-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/pcat_16550s/vhdl/pcat_16550s-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/units/pcat_16550s/vhdl/pcat_16550s-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/top/vhdl/wb_16550s-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/wb_16550s/top/vhdl/wb_16550s-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/uart_block/vhdl/uart_block-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/uart_block/vhdl/uart_block-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/tspc_dma_chan_ms/top/vhdl/tspc_dma_chan_ms-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/units/tspc_dma_chan_ms/top/vhdl/tspc_dma_chan_ms-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/top/vhdl/dma_subsys-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/units/dma_subsys/top/vhdl/dma_subsys-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/top/core_mf8c/vhdl/core_mf8c-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/top/core_mf8c/vhdl/core_mf8c-a_rtl.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/top/core_mf8c/vhdl/core_mf8c_exports-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/top/versa_ecp5/vhdl/versa_ecp5_comps-p.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/top/versa_ecp5/vhdl/versa_ecp5-e.vhd}
add_file -vhdl -lib "work" {C:/project/PCIe_ECP5_MF/soc/top/versa_ecp5/vhdl/versa_ecp5-a_rtl.vhd}
add_file -verilog -vlog_std v2001 {C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/xclk_subsys/pll_xclk_base/pll_xclk_base.v}

#-- top module name
set_option -top_module versa_ecp5

#-- set result format/file last
project -result_file {C:/project/PCIe_ECP5_MF/work/diamond/versa_ecp5/mf8c/versa_ecp5_mf8c.edi}

#-- error message log file
project -log_file {versa_ecp5_mf8c.srf}

#-- set any command lines input by customer


#-- run Synplify with 'arrange HDL file'
project -run hdl_info_gen -fileorder
project -run
