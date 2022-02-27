
    cd "C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_eval/pcie_x1_top/sim/aldec/rtl"
    workspace create pcie_space
    design create pcie_design .
    design open pcie_design
    cd "C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_eval/pcie_x1_top/sim/aldec/rtl"
    set sim_working_folder .
    #==============================================================================
    # Compile
    #==============================================================================
    vlog -v2k5 +define+RSL_SIM_MODE +define+SIM_MODE +define+USERNAME_EVAL_TOP=pcie_x1_top_eval_top  +define+DEBUG=0 +define+SIMULATE   +incdir+../../../../pcie_x1_top/testbench/top +incdir+../../../../pcie_x1_top/testbench/tests +incdir+../../../../src/params +incdir+../../../../models/ecp5um +incdir+../../../../pcie_x1_top/src/params ../../../../pcie_x1_top/src/params/pci_exp_params.v  ../../../../pcie_x1_top/testbench/top/eval_pcie.v  ../../../../pcie_x1_top/testbench/top/eval_tbtx.v  ../../../../pcie_x1_top/testbench/top/eval_tbrx.v ../../../../models/ecp5um/pcie_x1_top_ctc.v  ../../../../models/ecp5um/pcie_x1_top_sync1s.v  ../../../../models/ecp5um/pcie_x1_top_pipe.v  ../../../../models/ecp5um/pcie_x1_top_extref.v  ../../../../models/ecp5um/pcie_x1_top_pcs_softlogic.v  ../../../../models/ecp5um/pcie_x1_top_pcs.v  ../../../../models/ecp5um/pcie_x1_top_phy.v  ../../../../pcie_x1_top/src/top/pcie_x1_top_core.v  ../../../../pcie_x1_top/src/top/pcie_x1_top_beh.v ../../../../pcie_x1_top/src/top/pcie_x1_top_eval_top.v  

    #==============================================================================
    # Run
    #==============================================================================
    vsim -o2 +access +r -t 1ps pcie_design.tb_top -lib pcie_design  -L ovi_ecp5um  -L pmi_work -L pcsd_aldec_work 
    
add wave {sim:/tb_top/u1_top/rst_n}
add wave {sim:/tb_top/u1_top/sys_clk_125}
add wave {sim:/tb_top/u_tbtx[0]/tx_st}
add wave {sim:/tb_top/u_tbtx[0]/tx_end}
add wave {sim:/tb_top/u_tbtx[0]/tx_data}
add wave {sim:/tb_top/u_tbtx[0]/tx_val}
add wave {sim:/tb_top/u_tbtx[0]/tx_req}
add wave {sim:/tb_top/u_tbtx[0]/tx_rdy}
add wave {sim:/tb_top/u_tbrx[0]/rx_us_req}
add wave {sim:/tb_top/u_tbrx[0]/rx_st}
add wave {sim:/tb_top/u_tbrx[0]/rx_end}
add wave {sim:/tb_top/u_tbrx[0]/rx_data}
add wave {sim:/tb_top/u_tbrx[0]/rx_malf_tlp}
add wave sim:/tb_top/u1_top/hdoutp*
add wave sim:/tb_top/u1_top/hdoutn*
add wave sim:/tb_top/u1_top/hdinp*
add wave sim:/tb_top/u1_top/hdinn*
run -all
