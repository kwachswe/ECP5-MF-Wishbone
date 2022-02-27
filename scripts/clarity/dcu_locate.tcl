global env

puts "Locate RefClk/DCU. Perform DRC. Running ..."
sbp_resource place -rsc {pcie_subsys/pcie_x1_top/DCUCHANNEL/Lane0} -id 5
sbp_resource place -rsc {pcie_subsys/pcie_refclk/EXTREF/EXTREF} -id 3
sbp_design save
sbp_design drc
sbp_design gen

puts "\nDone."
