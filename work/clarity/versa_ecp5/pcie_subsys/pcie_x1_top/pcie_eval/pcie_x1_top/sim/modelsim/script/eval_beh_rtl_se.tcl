
  #==============================================================================
  # Set up modelsim work library
  #==============================================================================
  cd "C:/project/PCIe_ECP5_MF/work/clarity/versa_ecp5/pcie_subsys/pcie_x1_top/pcie_eval/pcie_x1_top/sim/modelsim/rtl"
  vlib                  work
  vmap pcsd_mti_work "C:/lscc/diamond/3.12/cae_library/simulation/blackbox/pcsd_work"
  vmap ecp5u_bb "C:/lscc/diamond/3.12/cae_library/simulation/blackbox/ecp5u_black_boxes"
  vlog -refresh -quiet -work pcsd_mti_work
  vlog -refresh -quiet -work ecp5u_bb
  #==============================================================================
  # Make vlog and vsim commands
  #==============================================================================
  vlog +define+RSL_SIM_MODE +define+SIM_MODE +define+USERNAME_EVAL_TOP=pcie_x1_top_eval_top  +define+DEBUG=0 +define+SIMULATE   +incdir+../../../../pcie_x1_top/testbench/top +incdir+../../../../pcie_x1_top/testbench/tests +incdir+../../../../src/params +incdir+../../../../models/ecp5um +incdir+../../../../pcie_x1_top/src/params  -y C:/lscc/diamond/3.12/cae_library/simulation/verilog/ecp5u +libext+.v -y C:/lscc/diamond/3.12/cae_library/simulation/verilog/pmi +libext+.v  ../../../../pcie_x1_top/src/params/pci_exp_params.v  ../../../../pcie_x1_top/testbench/top/eval_pcie.v  ../../../../pcie_x1_top/testbench/top/eval_tbtx.v  ../../../../pcie_x1_top/testbench/top/eval_tbrx.v ../../../../models/ecp5um/pcie_x1_top_ctc.v  ../../../../models/ecp5um/pcie_x1_top_sync1s.v  ../../../../models/ecp5um/pcie_x1_top_pipe.v  ../../../../models/ecp5um/pcie_x1_top_extref.v  ../../../../models/ecp5um/pcie_x1_top_pcs_softlogic.v  ../../../../models/ecp5um/pcie_x1_top_pcs.v  ../../../../models/ecp5um/pcie_x1_top_phy.v  ../../../../pcie_x1_top/src/top/pcie_x1_top_core.v  ../../../../pcie_x1_top/src/top/pcie_x1_top_beh.v ../../../../pcie_x1_top/src/top/pcie_x1_top_eval_top.v  -work work

  vsim -t 1ps -c work.tb_top  -L work -L ecp5u -L pcsd_mti_work    -l  eval_pcie.log   -wlf eval_pcie.wlf 
  do ../sim.do
  
