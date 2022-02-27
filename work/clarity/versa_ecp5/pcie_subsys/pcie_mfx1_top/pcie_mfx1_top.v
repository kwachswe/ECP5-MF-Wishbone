module pcie_mfx1_top (
input wire ix_clk_125 ,
input wire [8 - 1 : 0] ix_dec_wb_cyc ,
input wire ix_ipx_dl_up ,
input wire ix_ipx_malf_tlp ,
input wire [16 - 1 : 0] ix_ipx_rx_data ,
input wire ix_ipx_rx_end ,
input wire ix_ipx_rx_st ,
input wire [12 : 0] ix_ipx_tx_ca_cpld ,
input wire [8 : 0] ix_ipx_tx_ca_cplh ,
input wire [12 : 0] ix_ipx_tx_ca_npd ,
input wire [8 : 0] ix_ipx_tx_ca_nph ,
input wire [12 : 0] ix_ipx_tx_ca_pd ,
input wire [8 : 0] ix_ipx_tx_ca_ph ,
input wire ix_ipx_tx_rdy ,
input wire [ 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 - 1 : 0] ix_pci_int_req ,
input wire ix_rst_n ,
input wire ix_wbm_ack ,
input wire [32 - 1 : 0] ix_wbm_dat ,
input wire [48 - 1 : 0] ix_wbs_adr ,
input wire [1 : 0] ix_wbs_bte ,
input wire [2 : 0] ix_wbs_cti ,
input wire [7 : 0] ix_wbs_cyc ,
input wire [32 - 1 : 0] ix_wbs_dat ,
input wire [(32 / 8) - 1 : 0] ix_wbs_sel ,
input wire ix_wbs_stb ,
input wire ix_wbs_we ,
output wire [16 - 1 : 0] ox_dec_adr ,
output wire [5 : 0] ox_dec_bar_hit ,
output wire [7 : 0] ox_dec_func_hit ,
output wire [7 : 0] ox_ipx_cc_npd_num ,
output wire [7 : 0] ox_ipx_cc_pd_num ,
output wire ox_ipx_cc_processed_npd ,
output wire ox_ipx_cc_processed_nph ,
output wire ox_ipx_cc_processed_pd ,
output wire ox_ipx_cc_processed_ph ,
output wire [16 - 1 : 0] ox_ipx_tx_data ,
output wire ox_ipx_tx_end ,
output wire ox_ipx_tx_req ,
output wire ox_ipx_tx_st ,
output wire [7 : 0] ox_sys_rst_func_n ,
output wire ox_sys_rst_n ,
output wire [16 - 1 : 0] ox_wbm_adr ,
output wire [1 : 0] ox_wbm_bte ,
output wire [2 : 0] ox_wbm_cti ,
output wire [8 - 1 : 0] ox_wbm_cyc ,
output wire [32 - 1 : 0] ox_wbm_dat ,
output wire [(32 / 8) - 1 : 0] ox_wbm_sel ,
output wire ox_wbm_stb ,
output wire ox_wbm_we ,
output wire ox_wbs_ack ,
output wire [32 - 1 : 0] ox_wbs_dat ,
output wire ox_wbs_err
   );
      localparam gx_cs_f0_bar0_size = "8" ;
      localparam gx_cs_f0_bar0_is_64_bit = 0 ;
      localparam gx_cs_f0_bar0_is_io_space = 1 ;
      localparam gx_cs_f0_bar0_is_prefetchable = 1 ;
      localparam gx_cs_f0_bar1_size = "NONE" ;
      localparam gx_cs_f0_bar1_is_io_space = 0 ;
      localparam gx_cs_f0_bar1_is_prefetchable = 1 ;
      localparam gx_cs_f0_bar2_size = "NONE" ;
      localparam gx_cs_f0_bar2_is_64_bit = 0 ;
      localparam gx_cs_f0_bar2_is_io_space = 0 ;
      localparam gx_cs_f0_bar2_is_prefetchable = 1 ;
      localparam gx_cs_f0_bar3_size = "NONE" ;
      localparam gx_cs_f0_bar3_is_io_space = 0 ;
      localparam gx_cs_f0_bar3_is_prefetchable = 1 ;
      localparam gx_cs_f0_bar4_size = "NONE" ;
      localparam gx_cs_f0_bar4_is_64_bit = 0 ;
      localparam gx_cs_f0_bar4_is_io_space = 0 ;
      localparam gx_cs_f0_bar4_is_prefetchable = 1 ;
      localparam gx_cs_f0_bar5_size = "NONE" ;
      localparam gx_cs_f0_bar5_is_io_space = 0 ;
      localparam gx_cs_f0_bar5_is_prefetchable = 1 ;
      localparam gx_cs_f0_class_code = 'h070002 ;
      localparam gx_cs_f0_device_id = 'h8C01 ;
      localparam gx_cs_f0_int_count = 1 ;
      localparam gx_cs_f0_int_pin = "INTA" ;
      localparam gx_cs_f0_revision_id = 'h01 ;
      localparam gx_cs_f0_subsystem_id = 'h8C01 ;
      localparam gx_cs_f1_bar0_size = "8" ;
      localparam gx_cs_f1_bar0_is_64_bit = 0 ;
      localparam gx_cs_f1_bar0_is_io_space = 1 ;
      localparam gx_cs_f1_bar0_is_prefetchable = 1 ;
      localparam gx_cs_f1_bar1_size = "NONE" ;
      localparam gx_cs_f1_bar1_is_io_space = 0 ;
      localparam gx_cs_f1_bar1_is_prefetchable = 1 ;
      localparam gx_cs_f1_bar2_size = "NONE" ;
      localparam gx_cs_f1_bar2_is_64_bit = 0 ;
      localparam gx_cs_f1_bar2_is_io_space = 0 ;
      localparam gx_cs_f1_bar2_is_prefetchable = 1 ;
      localparam gx_cs_f1_bar3_size = "NONE" ;
      localparam gx_cs_f1_bar3_is_io_space = 0 ;
      localparam gx_cs_f1_bar3_is_prefetchable = 1 ;
      localparam gx_cs_f1_bar4_size = "NONE" ;
      localparam gx_cs_f1_bar4_is_64_bit = 0 ;
      localparam gx_cs_f1_bar4_is_io_space = 0 ;
      localparam gx_cs_f1_bar4_is_prefetchable = 1 ;
      localparam gx_cs_f1_bar5_size = "NONE" ;
      localparam gx_cs_f1_bar5_is_io_space = 0 ;
      localparam gx_cs_f1_bar5_is_prefetchable = 1 ;
      localparam gx_cs_f1_class_code = 'h070002 ;
      localparam gx_cs_f1_device_id = 'h8C01 ;
      localparam gx_cs_f1_int_count = 1 ;
      localparam gx_cs_f1_int_pin = "INTB" ;
      localparam gx_cs_f1_present = 1 ;
      localparam gx_cs_f1_revision_id = 'h01 ;
      localparam gx_cs_f1_subsystem_id = 'h8C01 ;
      localparam gx_cs_f2_bar0_size = "8" ;
      localparam gx_cs_f2_bar0_is_64_bit = 0 ;
      localparam gx_cs_f2_bar0_is_io_space = 1 ;
      localparam gx_cs_f2_bar0_is_prefetchable = 1 ;
      localparam gx_cs_f2_bar1_size = "NONE" ;
      localparam gx_cs_f2_bar1_is_io_space = 0 ;
      localparam gx_cs_f2_bar1_is_prefetchable = 1 ;
      localparam gx_cs_f2_bar2_size = "NONE" ;
      localparam gx_cs_f2_bar2_is_64_bit = 0 ;
      localparam gx_cs_f2_bar2_is_io_space = 0 ;
      localparam gx_cs_f2_bar2_is_prefetchable = 1 ;
      localparam gx_cs_f2_bar3_size = "NONE" ;
      localparam gx_cs_f2_bar3_is_io_space = 0 ;
      localparam gx_cs_f2_bar3_is_prefetchable = 1 ;
      localparam gx_cs_f2_bar4_size = "NONE" ;
      localparam gx_cs_f2_bar4_is_64_bit = 0 ;
      localparam gx_cs_f2_bar4_is_io_space = 0 ;
      localparam gx_cs_f2_bar4_is_prefetchable = 1 ;
      localparam gx_cs_f2_bar5_size = "NONE" ;
      localparam gx_cs_f2_bar5_is_io_space = 0 ;
      localparam gx_cs_f2_bar5_is_prefetchable = 1 ;
      localparam gx_cs_f2_class_code = 'h070002 ;
      localparam gx_cs_f2_device_id = 'h8C01 ;
      localparam gx_cs_f2_int_count = 1 ;
      localparam gx_cs_f2_int_pin = "INTC" ;
      localparam gx_cs_f2_present = 1 ;
      localparam gx_cs_f2_revision_id = 'h01 ;
      localparam gx_cs_f2_subsystem_id = 'h8C01 ;
      localparam gx_cs_f3_bar0_size = "8" ;
      localparam gx_cs_f3_bar0_is_64_bit = 0 ;
      localparam gx_cs_f3_bar0_is_io_space = 1 ;
      localparam gx_cs_f3_bar0_is_prefetchable = 1 ;
      localparam gx_cs_f3_bar1_size = "NONE" ;
      localparam gx_cs_f3_bar1_is_io_space = 0 ;
      localparam gx_cs_f3_bar1_is_prefetchable = 1 ;
      localparam gx_cs_f3_bar2_size = "NONE" ;
      localparam gx_cs_f3_bar2_is_64_bit = 0 ;
      localparam gx_cs_f3_bar2_is_io_space = 0 ;
      localparam gx_cs_f3_bar2_is_prefetchable = 1 ;
      localparam gx_cs_f3_bar3_size = "NONE" ;
      localparam gx_cs_f3_bar3_is_io_space = 0 ;
      localparam gx_cs_f3_bar3_is_prefetchable = 1 ;
      localparam gx_cs_f3_bar4_size = "NONE" ;
      localparam gx_cs_f3_bar4_is_64_bit = 0 ;
      localparam gx_cs_f3_bar4_is_io_space = 0 ;
      localparam gx_cs_f3_bar4_is_prefetchable = 1 ;
      localparam gx_cs_f3_bar5_size = "NONE" ;
      localparam gx_cs_f3_bar5_is_io_space = 0 ;
      localparam gx_cs_f3_bar5_is_prefetchable = 1 ;
      localparam gx_cs_f3_class_code = 'h070002 ;
      localparam gx_cs_f3_device_id = 'h8C01 ;
      localparam gx_cs_f3_int_count = 1 ;
      localparam gx_cs_f3_int_pin = "INTD" ;
      localparam gx_cs_f3_present = 1 ;
      localparam gx_cs_f3_revision_id = 'h01 ;
      localparam gx_cs_f3_subsystem_id = 'h8C01 ;
      localparam gx_cs_f4_bar0_size = "8" ;
      localparam gx_cs_f4_bar0_is_64_bit = 0 ;
      localparam gx_cs_f4_bar0_is_io_space = 1 ;
      localparam gx_cs_f4_bar0_is_prefetchable = 1 ;
      localparam gx_cs_f4_bar1_size = "NONE" ;
      localparam gx_cs_f4_bar1_is_io_space = 0 ;
      localparam gx_cs_f4_bar1_is_prefetchable = 1 ;
      localparam gx_cs_f4_bar2_size = "NONE" ;
      localparam gx_cs_f4_bar2_is_64_bit = 0 ;
      localparam gx_cs_f4_bar2_is_io_space = 0 ;
      localparam gx_cs_f4_bar2_is_prefetchable = 1 ;
      localparam gx_cs_f4_bar3_size = "NONE" ;
      localparam gx_cs_f4_bar3_is_io_space = 0 ;
      localparam gx_cs_f4_bar3_is_prefetchable = 1 ;
      localparam gx_cs_f4_bar4_size = "NONE" ;
      localparam gx_cs_f4_bar4_is_64_bit = 0 ;
      localparam gx_cs_f4_bar4_is_io_space = 0 ;
      localparam gx_cs_f4_bar4_is_prefetchable = 1 ;
      localparam gx_cs_f4_bar5_size = "NONE" ;
      localparam gx_cs_f4_bar5_is_io_space = 0 ;
      localparam gx_cs_f4_bar5_is_prefetchable = 1 ;
      localparam gx_cs_f4_class_code = 'h070002 ;
      localparam gx_cs_f4_device_id = 'h8C01 ;
      localparam gx_cs_f4_int_count = 1 ;
      localparam gx_cs_f4_int_pin = "INTA" ;
      localparam gx_cs_f4_present = 1 ;
      localparam gx_cs_f4_revision_id = 'h01 ;
      localparam gx_cs_f4_subsystem_id = 'h8C01 ;
      localparam gx_cs_f5_bar0_size = "4K" ;
      localparam gx_cs_f5_bar0_is_64_bit = 0 ;
      localparam gx_cs_f5_bar0_is_io_space = 0 ;
      localparam gx_cs_f5_bar0_is_prefetchable = 0 ;
      localparam gx_cs_f5_bar1_size = "NONE" ;
      localparam gx_cs_f5_bar1_is_io_space = 0 ;
      localparam gx_cs_f5_bar1_is_prefetchable = 1 ;
      localparam gx_cs_f5_bar2_size = "NONE" ;
      localparam gx_cs_f5_bar2_is_64_bit = 0 ;
      localparam gx_cs_f5_bar2_is_io_space = 0 ;
      localparam gx_cs_f5_bar2_is_prefetchable = 1 ;
      localparam gx_cs_f5_bar3_size = "NONE" ;
      localparam gx_cs_f5_bar3_is_io_space = 0 ;
      localparam gx_cs_f5_bar3_is_prefetchable = 1 ;
      localparam gx_cs_f5_bar4_size = "NONE" ;
      localparam gx_cs_f5_bar4_is_64_bit = 0 ;
      localparam gx_cs_f5_bar4_is_io_space = 0 ;
      localparam gx_cs_f5_bar4_is_prefetchable = 1 ;
      localparam gx_cs_f5_bar5_size = "NONE" ;
      localparam gx_cs_f5_bar5_is_io_space = 0 ;
      localparam gx_cs_f5_bar5_is_prefetchable = 1 ;
      localparam gx_cs_f5_class_code = 'hFF0000 ;
      localparam gx_cs_f5_device_id = 'h8C05 ;
      localparam gx_cs_f5_int_count = 1 ;
      localparam gx_cs_f5_int_pin = "INTB" ;
      localparam gx_cs_f5_present = 1 ;
      localparam gx_cs_f5_revision_id = 'h01 ;
      localparam gx_cs_f5_subsystem_id = 'h8C05 ;
      localparam gx_cs_f6_bar0_size = "4K" ;
      localparam gx_cs_f6_bar0_is_64_bit = 0 ;
      localparam gx_cs_f6_bar0_is_io_space = 0 ;
      localparam gx_cs_f6_bar0_is_prefetchable = 0 ;
      localparam gx_cs_f6_bar1_size = "NONE" ;
      localparam gx_cs_f6_bar1_is_io_space = 0 ;
      localparam gx_cs_f6_bar1_is_prefetchable = 1 ;
      localparam gx_cs_f6_bar2_size = "NONE" ;
      localparam gx_cs_f6_bar2_is_64_bit = 0 ;
      localparam gx_cs_f6_bar2_is_io_space = 0 ;
      localparam gx_cs_f6_bar2_is_prefetchable = 1 ;
      localparam gx_cs_f6_bar3_size = "NONE" ;
      localparam gx_cs_f6_bar3_is_io_space = 0 ;
      localparam gx_cs_f6_bar3_is_prefetchable = 1 ;
      localparam gx_cs_f6_bar4_size = "NONE" ;
      localparam gx_cs_f6_bar4_is_64_bit = 0 ;
      localparam gx_cs_f6_bar4_is_io_space = 0 ;
      localparam gx_cs_f6_bar4_is_prefetchable = 1 ;
      localparam gx_cs_f6_bar5_size = "NONE" ;
      localparam gx_cs_f6_bar5_is_io_space = 0 ;
      localparam gx_cs_f6_bar5_is_prefetchable = 1 ;
      localparam gx_cs_f6_class_code = 'hFF0000 ;
      localparam gx_cs_f6_device_id = 'h8C06 ;
      localparam gx_cs_f6_int_count = 1 ;
      localparam gx_cs_f6_int_pin = "INTC" ;
      localparam gx_cs_f6_present = 1 ;
      localparam gx_cs_f6_revision_id = 'h01 ;
      localparam gx_cs_f6_subsystem_id = 'h8C06 ;
      localparam gx_cs_f7_bar0_size = "4K" ;
      localparam gx_cs_f7_bar0_is_64_bit = 0 ;
      localparam gx_cs_f7_bar0_is_io_space = 0 ;
      localparam gx_cs_f7_bar0_is_prefetchable = 0 ;
      localparam gx_cs_f7_bar1_size = "NONE" ;
      localparam gx_cs_f7_bar1_is_io_space = 0 ;
      localparam gx_cs_f7_bar1_is_prefetchable = 1 ;
      localparam gx_cs_f7_bar2_size = "NONE" ;
      localparam gx_cs_f7_bar2_is_64_bit = 0 ;
      localparam gx_cs_f7_bar2_is_io_space = 0 ;
      localparam gx_cs_f7_bar2_is_prefetchable = 1 ;
      localparam gx_cs_f7_bar3_size = "NONE" ;
      localparam gx_cs_f7_bar3_is_io_space = 0 ;
      localparam gx_cs_f7_bar3_is_prefetchable = 1 ;
      localparam gx_cs_f7_bar4_size = "NONE" ;
      localparam gx_cs_f7_bar4_is_64_bit = 0 ;
      localparam gx_cs_f7_bar4_is_io_space = 0 ;
      localparam gx_cs_f7_bar4_is_prefetchable = 1 ;
      localparam gx_cs_f7_bar5_size = "NONE" ;
      localparam gx_cs_f7_bar5_is_io_space = 0 ;
      localparam gx_cs_f7_bar5_is_prefetchable = 1 ;
      localparam gx_cs_f7_class_code = 'hFF0000 ;
      localparam gx_cs_f7_device_id = 'h8C07 ;
      localparam gx_cs_f7_int_count = 1 ;
      localparam gx_cs_f7_int_pin = "INTD" ;
      localparam gx_cs_f7_present = 1 ;
      localparam gx_cs_f7_revision_id = 'h01 ;
      localparam gx_cs_f7_subsystem_id = 'h8C07 ;
      localparam gx_cs_subsystem_vendor_id = 'h1204 ;
      localparam gx_cs_vendor_id = 'h1204 ;
      localparam gx_ipx_data_sz = 16 ;
      localparam gx_nr_wb_tgts = 8 ;
      localparam gx_pcie_gen2 = 0 ;
      localparam gx_tech_lib = "ECP5UM" ;
      localparam gx_wbm_data_sz = 32 ;
      localparam gx_wbs_data_sz = 32 ;
      localparam gx_wbm_adr_sz = 16 ;
      localparam gx_wbs_adr_sz = 48 ;
 
   pcie_mfdev_subsys #(
     .gx_cs_f0_bar0_size(gx_cs_f0_bar0_size),
     .gx_cs_f0_bar0_is_64_bit(gx_cs_f0_bar0_is_64_bit),
     .gx_cs_f0_bar0_is_io_space(gx_cs_f0_bar0_is_io_space),
     .gx_cs_f0_bar0_is_prefetchable(gx_cs_f0_bar0_is_prefetchable),
     .gx_cs_f0_bar1_size(gx_cs_f0_bar1_size),
     .gx_cs_f0_bar1_is_io_space(gx_cs_f0_bar1_is_io_space),
     .gx_cs_f0_bar1_is_prefetchable(gx_cs_f0_bar1_is_prefetchable),
     .gx_cs_f0_bar2_size(gx_cs_f0_bar2_size),
     .gx_cs_f0_bar2_is_64_bit(gx_cs_f0_bar2_is_64_bit),
     .gx_cs_f0_bar2_is_io_space(gx_cs_f0_bar2_is_io_space),
     .gx_cs_f0_bar2_is_prefetchable(gx_cs_f0_bar2_is_prefetchable),
     .gx_cs_f0_bar3_size(gx_cs_f0_bar3_size),
     .gx_cs_f0_bar3_is_io_space(gx_cs_f0_bar3_is_io_space),
     .gx_cs_f0_bar3_is_prefetchable(gx_cs_f0_bar3_is_prefetchable),
     .gx_cs_f0_bar4_size(gx_cs_f0_bar4_size),
     .gx_cs_f0_bar4_is_64_bit(gx_cs_f0_bar4_is_64_bit),
     .gx_cs_f0_bar4_is_io_space(gx_cs_f0_bar4_is_io_space),
     .gx_cs_f0_bar4_is_prefetchable(gx_cs_f0_bar4_is_prefetchable),
     .gx_cs_f0_bar5_size(gx_cs_f0_bar5_size),
     .gx_cs_f0_bar5_is_io_space(gx_cs_f0_bar5_is_io_space),
     .gx_cs_f0_bar5_is_prefetchable(gx_cs_f0_bar5_is_prefetchable),
     .gx_cs_f0_class_code(gx_cs_f0_class_code),
     .gx_cs_f0_device_id(gx_cs_f0_device_id),
     .gx_cs_f0_int_count(gx_cs_f0_int_count),
     .gx_cs_f0_int_pin(gx_cs_f0_int_pin),
     .gx_cs_f0_revision_id(gx_cs_f0_revision_id),
     .gx_cs_f0_subsystem_id(gx_cs_f0_subsystem_id),
     .gx_cs_f1_bar0_size(gx_cs_f1_bar0_size),
     .gx_cs_f1_bar0_is_64_bit(gx_cs_f1_bar0_is_64_bit),
     .gx_cs_f1_bar0_is_io_space(gx_cs_f1_bar0_is_io_space),
     .gx_cs_f1_bar0_is_prefetchable(gx_cs_f1_bar0_is_prefetchable),
     .gx_cs_f1_bar1_size(gx_cs_f1_bar1_size),
     .gx_cs_f1_bar1_is_io_space(gx_cs_f1_bar1_is_io_space),
     .gx_cs_f1_bar1_is_prefetchable(gx_cs_f1_bar1_is_prefetchable),
     .gx_cs_f1_bar2_size(gx_cs_f1_bar2_size),
     .gx_cs_f1_bar2_is_64_bit(gx_cs_f1_bar2_is_64_bit),
     .gx_cs_f1_bar2_is_io_space(gx_cs_f1_bar2_is_io_space),
     .gx_cs_f1_bar2_is_prefetchable(gx_cs_f1_bar2_is_prefetchable),
     .gx_cs_f1_bar3_size(gx_cs_f1_bar3_size),
     .gx_cs_f1_bar3_is_io_space(gx_cs_f1_bar3_is_io_space),
     .gx_cs_f1_bar3_is_prefetchable(gx_cs_f1_bar3_is_prefetchable),
     .gx_cs_f1_bar4_size(gx_cs_f1_bar4_size),
     .gx_cs_f1_bar4_is_64_bit(gx_cs_f1_bar4_is_64_bit),
     .gx_cs_f1_bar4_is_io_space(gx_cs_f1_bar4_is_io_space),
     .gx_cs_f1_bar4_is_prefetchable(gx_cs_f1_bar4_is_prefetchable),
     .gx_cs_f1_bar5_size(gx_cs_f1_bar5_size),
     .gx_cs_f1_bar5_is_io_space(gx_cs_f1_bar5_is_io_space),
     .gx_cs_f1_bar5_is_prefetchable(gx_cs_f1_bar5_is_prefetchable),
     .gx_cs_f1_class_code(gx_cs_f1_class_code),
     .gx_cs_f1_device_id(gx_cs_f1_device_id),
     .gx_cs_f1_int_count(gx_cs_f1_int_count),
     .gx_cs_f1_int_pin(gx_cs_f1_int_pin),
     .gx_cs_f1_present(gx_cs_f1_present),
     .gx_cs_f1_revision_id(gx_cs_f1_revision_id),
     .gx_cs_f1_subsystem_id(gx_cs_f1_subsystem_id),
     .gx_cs_f2_bar0_size(gx_cs_f2_bar0_size),
     .gx_cs_f2_bar0_is_64_bit(gx_cs_f2_bar0_is_64_bit),
     .gx_cs_f2_bar0_is_io_space(gx_cs_f2_bar0_is_io_space),
     .gx_cs_f2_bar0_is_prefetchable(gx_cs_f2_bar0_is_prefetchable),
     .gx_cs_f2_bar1_size(gx_cs_f2_bar1_size),
     .gx_cs_f2_bar1_is_io_space(gx_cs_f2_bar1_is_io_space),
     .gx_cs_f2_bar1_is_prefetchable(gx_cs_f2_bar1_is_prefetchable),
     .gx_cs_f2_bar2_size(gx_cs_f2_bar2_size),
     .gx_cs_f2_bar2_is_64_bit(gx_cs_f2_bar2_is_64_bit),
     .gx_cs_f2_bar2_is_io_space(gx_cs_f2_bar2_is_io_space),
     .gx_cs_f2_bar2_is_prefetchable(gx_cs_f2_bar2_is_prefetchable),
     .gx_cs_f2_bar3_size(gx_cs_f2_bar3_size),
     .gx_cs_f2_bar3_is_io_space(gx_cs_f2_bar3_is_io_space),
     .gx_cs_f2_bar3_is_prefetchable(gx_cs_f2_bar3_is_prefetchable),
     .gx_cs_f2_bar4_size(gx_cs_f2_bar4_size),
     .gx_cs_f2_bar4_is_64_bit(gx_cs_f2_bar4_is_64_bit),
     .gx_cs_f2_bar4_is_io_space(gx_cs_f2_bar4_is_io_space),
     .gx_cs_f2_bar4_is_prefetchable(gx_cs_f2_bar4_is_prefetchable),
     .gx_cs_f2_bar5_size(gx_cs_f2_bar5_size),
     .gx_cs_f2_bar5_is_io_space(gx_cs_f2_bar5_is_io_space),
     .gx_cs_f2_bar5_is_prefetchable(gx_cs_f2_bar5_is_prefetchable),
     .gx_cs_f2_class_code(gx_cs_f2_class_code),
     .gx_cs_f2_device_id(gx_cs_f2_device_id),
     .gx_cs_f2_int_count(gx_cs_f2_int_count),
     .gx_cs_f2_int_pin(gx_cs_f2_int_pin),
     .gx_cs_f2_present(gx_cs_f2_present),
     .gx_cs_f2_revision_id(gx_cs_f2_revision_id),
     .gx_cs_f2_subsystem_id(gx_cs_f2_subsystem_id),
     .gx_cs_f3_bar0_size(gx_cs_f3_bar0_size),
     .gx_cs_f3_bar0_is_64_bit(gx_cs_f3_bar0_is_64_bit),
     .gx_cs_f3_bar0_is_io_space(gx_cs_f3_bar0_is_io_space),
     .gx_cs_f3_bar0_is_prefetchable(gx_cs_f3_bar0_is_prefetchable),
     .gx_cs_f3_bar1_size(gx_cs_f3_bar1_size),
     .gx_cs_f3_bar1_is_io_space(gx_cs_f3_bar1_is_io_space),
     .gx_cs_f3_bar1_is_prefetchable(gx_cs_f3_bar1_is_prefetchable),
     .gx_cs_f3_bar2_size(gx_cs_f3_bar2_size),
     .gx_cs_f3_bar2_is_64_bit(gx_cs_f3_bar2_is_64_bit),
     .gx_cs_f3_bar2_is_io_space(gx_cs_f3_bar2_is_io_space),
     .gx_cs_f3_bar2_is_prefetchable(gx_cs_f3_bar2_is_prefetchable),
     .gx_cs_f3_bar3_size(gx_cs_f3_bar3_size),
     .gx_cs_f3_bar3_is_io_space(gx_cs_f3_bar3_is_io_space),
     .gx_cs_f3_bar3_is_prefetchable(gx_cs_f3_bar3_is_prefetchable),
     .gx_cs_f3_bar4_size(gx_cs_f3_bar4_size),
     .gx_cs_f3_bar4_is_64_bit(gx_cs_f3_bar4_is_64_bit),
     .gx_cs_f3_bar4_is_io_space(gx_cs_f3_bar4_is_io_space),
     .gx_cs_f3_bar4_is_prefetchable(gx_cs_f3_bar4_is_prefetchable),
     .gx_cs_f3_bar5_size(gx_cs_f3_bar5_size),
     .gx_cs_f3_bar5_is_io_space(gx_cs_f3_bar5_is_io_space),
     .gx_cs_f3_bar5_is_prefetchable(gx_cs_f3_bar5_is_prefetchable),
     .gx_cs_f3_class_code(gx_cs_f3_class_code),
     .gx_cs_f3_device_id(gx_cs_f3_device_id),
     .gx_cs_f3_int_count(gx_cs_f3_int_count),
     .gx_cs_f3_int_pin(gx_cs_f3_int_pin),
     .gx_cs_f3_present(gx_cs_f3_present),
     .gx_cs_f3_revision_id(gx_cs_f3_revision_id),
     .gx_cs_f3_subsystem_id(gx_cs_f3_subsystem_id),
     .gx_cs_f4_bar0_size(gx_cs_f4_bar0_size),
     .gx_cs_f4_bar0_is_64_bit(gx_cs_f4_bar0_is_64_bit),
     .gx_cs_f4_bar0_is_io_space(gx_cs_f4_bar0_is_io_space),
     .gx_cs_f4_bar0_is_prefetchable(gx_cs_f4_bar0_is_prefetchable),
     .gx_cs_f4_bar1_size(gx_cs_f4_bar1_size),
     .gx_cs_f4_bar1_is_io_space(gx_cs_f4_bar1_is_io_space),
     .gx_cs_f4_bar1_is_prefetchable(gx_cs_f4_bar1_is_prefetchable),
     .gx_cs_f4_bar2_size(gx_cs_f4_bar2_size),
     .gx_cs_f4_bar2_is_64_bit(gx_cs_f4_bar2_is_64_bit),
     .gx_cs_f4_bar2_is_io_space(gx_cs_f4_bar2_is_io_space),
     .gx_cs_f4_bar2_is_prefetchable(gx_cs_f4_bar2_is_prefetchable),
     .gx_cs_f4_bar3_size(gx_cs_f4_bar3_size),
     .gx_cs_f4_bar3_is_io_space(gx_cs_f4_bar3_is_io_space),
     .gx_cs_f4_bar3_is_prefetchable(gx_cs_f4_bar3_is_prefetchable),
     .gx_cs_f4_bar4_size(gx_cs_f4_bar4_size),
     .gx_cs_f4_bar4_is_64_bit(gx_cs_f4_bar4_is_64_bit),
     .gx_cs_f4_bar4_is_io_space(gx_cs_f4_bar4_is_io_space),
     .gx_cs_f4_bar4_is_prefetchable(gx_cs_f4_bar4_is_prefetchable),
     .gx_cs_f4_bar5_size(gx_cs_f4_bar5_size),
     .gx_cs_f4_bar5_is_io_space(gx_cs_f4_bar5_is_io_space),
     .gx_cs_f4_bar5_is_prefetchable(gx_cs_f4_bar5_is_prefetchable),
     .gx_cs_f4_class_code(gx_cs_f4_class_code),
     .gx_cs_f4_device_id(gx_cs_f4_device_id),
     .gx_cs_f4_int_count(gx_cs_f4_int_count),
     .gx_cs_f4_int_pin(gx_cs_f4_int_pin),
     .gx_cs_f4_present(gx_cs_f4_present),
     .gx_cs_f4_revision_id(gx_cs_f4_revision_id),
     .gx_cs_f4_subsystem_id(gx_cs_f4_subsystem_id),
     .gx_cs_f5_bar0_size(gx_cs_f5_bar0_size),
     .gx_cs_f5_bar0_is_64_bit(gx_cs_f5_bar0_is_64_bit),
     .gx_cs_f5_bar0_is_io_space(gx_cs_f5_bar0_is_io_space),
     .gx_cs_f5_bar0_is_prefetchable(gx_cs_f5_bar0_is_prefetchable),
     .gx_cs_f5_bar1_size(gx_cs_f5_bar1_size),
     .gx_cs_f5_bar1_is_io_space(gx_cs_f5_bar1_is_io_space),
     .gx_cs_f5_bar1_is_prefetchable(gx_cs_f5_bar1_is_prefetchable),
     .gx_cs_f5_bar2_size(gx_cs_f5_bar2_size),
     .gx_cs_f5_bar2_is_64_bit(gx_cs_f5_bar2_is_64_bit),
     .gx_cs_f5_bar2_is_io_space(gx_cs_f5_bar2_is_io_space),
     .gx_cs_f5_bar2_is_prefetchable(gx_cs_f5_bar2_is_prefetchable),
     .gx_cs_f5_bar3_size(gx_cs_f5_bar3_size),
     .gx_cs_f5_bar3_is_io_space(gx_cs_f5_bar3_is_io_space),
     .gx_cs_f5_bar3_is_prefetchable(gx_cs_f5_bar3_is_prefetchable),
     .gx_cs_f5_bar4_size(gx_cs_f5_bar4_size),
     .gx_cs_f5_bar4_is_64_bit(gx_cs_f5_bar4_is_64_bit),
     .gx_cs_f5_bar4_is_io_space(gx_cs_f5_bar4_is_io_space),
     .gx_cs_f5_bar4_is_prefetchable(gx_cs_f5_bar4_is_prefetchable),
     .gx_cs_f5_bar5_size(gx_cs_f5_bar5_size),
     .gx_cs_f5_bar5_is_io_space(gx_cs_f5_bar5_is_io_space),
     .gx_cs_f5_bar5_is_prefetchable(gx_cs_f5_bar5_is_prefetchable),
     .gx_cs_f5_class_code(gx_cs_f5_class_code),
     .gx_cs_f5_device_id(gx_cs_f5_device_id),
     .gx_cs_f5_int_count(gx_cs_f5_int_count),
     .gx_cs_f5_int_pin(gx_cs_f5_int_pin),
     .gx_cs_f5_present(gx_cs_f5_present),
     .gx_cs_f5_revision_id(gx_cs_f5_revision_id),
     .gx_cs_f5_subsystem_id(gx_cs_f5_subsystem_id),
     .gx_cs_f6_bar0_size(gx_cs_f6_bar0_size),
     .gx_cs_f6_bar0_is_64_bit(gx_cs_f6_bar0_is_64_bit),
     .gx_cs_f6_bar0_is_io_space(gx_cs_f6_bar0_is_io_space),
     .gx_cs_f6_bar0_is_prefetchable(gx_cs_f6_bar0_is_prefetchable),
     .gx_cs_f6_bar1_size(gx_cs_f6_bar1_size),
     .gx_cs_f6_bar1_is_io_space(gx_cs_f6_bar1_is_io_space),
     .gx_cs_f6_bar1_is_prefetchable(gx_cs_f6_bar1_is_prefetchable),
     .gx_cs_f6_bar2_size(gx_cs_f6_bar2_size),
     .gx_cs_f6_bar2_is_64_bit(gx_cs_f6_bar2_is_64_bit),
     .gx_cs_f6_bar2_is_io_space(gx_cs_f6_bar2_is_io_space),
     .gx_cs_f6_bar2_is_prefetchable(gx_cs_f6_bar2_is_prefetchable),
     .gx_cs_f6_bar3_size(gx_cs_f6_bar3_size),
     .gx_cs_f6_bar3_is_io_space(gx_cs_f6_bar3_is_io_space),
     .gx_cs_f6_bar3_is_prefetchable(gx_cs_f6_bar3_is_prefetchable),
     .gx_cs_f6_bar4_size(gx_cs_f6_bar4_size),
     .gx_cs_f6_bar4_is_64_bit(gx_cs_f6_bar4_is_64_bit),
     .gx_cs_f6_bar4_is_io_space(gx_cs_f6_bar4_is_io_space),
     .gx_cs_f6_bar4_is_prefetchable(gx_cs_f6_bar4_is_prefetchable),
     .gx_cs_f6_bar5_size(gx_cs_f6_bar5_size),
     .gx_cs_f6_bar5_is_io_space(gx_cs_f6_bar5_is_io_space),
     .gx_cs_f6_bar5_is_prefetchable(gx_cs_f6_bar5_is_prefetchable),
     .gx_cs_f6_class_code(gx_cs_f6_class_code),
     .gx_cs_f6_device_id(gx_cs_f6_device_id),
     .gx_cs_f6_int_count(gx_cs_f6_int_count),
     .gx_cs_f6_int_pin(gx_cs_f6_int_pin),
     .gx_cs_f6_present(gx_cs_f6_present),
     .gx_cs_f6_revision_id(gx_cs_f6_revision_id),
     .gx_cs_f6_subsystem_id(gx_cs_f6_subsystem_id),
     .gx_cs_f7_bar0_size(gx_cs_f7_bar0_size),
     .gx_cs_f7_bar0_is_64_bit(gx_cs_f7_bar0_is_64_bit),
     .gx_cs_f7_bar0_is_io_space(gx_cs_f7_bar0_is_io_space),
     .gx_cs_f7_bar0_is_prefetchable(gx_cs_f7_bar0_is_prefetchable),
     .gx_cs_f7_bar1_size(gx_cs_f7_bar1_size),
     .gx_cs_f7_bar1_is_io_space(gx_cs_f7_bar1_is_io_space),
     .gx_cs_f7_bar1_is_prefetchable(gx_cs_f7_bar1_is_prefetchable),
     .gx_cs_f7_bar2_size(gx_cs_f7_bar2_size),
     .gx_cs_f7_bar2_is_64_bit(gx_cs_f7_bar2_is_64_bit),
     .gx_cs_f7_bar2_is_io_space(gx_cs_f7_bar2_is_io_space),
     .gx_cs_f7_bar2_is_prefetchable(gx_cs_f7_bar2_is_prefetchable),
     .gx_cs_f7_bar3_size(gx_cs_f7_bar3_size),
     .gx_cs_f7_bar3_is_io_space(gx_cs_f7_bar3_is_io_space),
     .gx_cs_f7_bar3_is_prefetchable(gx_cs_f7_bar3_is_prefetchable),
     .gx_cs_f7_bar4_size(gx_cs_f7_bar4_size),
     .gx_cs_f7_bar4_is_64_bit(gx_cs_f7_bar4_is_64_bit),
     .gx_cs_f7_bar4_is_io_space(gx_cs_f7_bar4_is_io_space),
     .gx_cs_f7_bar4_is_prefetchable(gx_cs_f7_bar4_is_prefetchable),
     .gx_cs_f7_bar5_size(gx_cs_f7_bar5_size),
     .gx_cs_f7_bar5_is_io_space(gx_cs_f7_bar5_is_io_space),
     .gx_cs_f7_bar5_is_prefetchable(gx_cs_f7_bar5_is_prefetchable),
     .gx_cs_f7_class_code(gx_cs_f7_class_code),
     .gx_cs_f7_device_id(gx_cs_f7_device_id),
     .gx_cs_f7_int_count(gx_cs_f7_int_count),
     .gx_cs_f7_int_pin(gx_cs_f7_int_pin),
     .gx_cs_f7_present(gx_cs_f7_present),
     .gx_cs_f7_revision_id(gx_cs_f7_revision_id),
     .gx_cs_f7_subsystem_id(gx_cs_f7_subsystem_id),
     .gx_cs_subsystem_vendor_id(gx_cs_subsystem_vendor_id),
     .gx_cs_vendor_id(gx_cs_vendor_id),
     .gx_ipx_data_sz(gx_ipx_data_sz),
     .gx_nr_wb_tgts(gx_nr_wb_tgts),
     .gx_pcie_gen2(gx_pcie_gen2),
     .gx_tech_lib(gx_tech_lib),
     .gx_wbm_data_sz(gx_wbm_data_sz),
     .gx_wbs_data_sz(gx_wbs_data_sz),
     .gx_wbm_adr_sz(gx_wbm_adr_sz),
     .gx_wbs_adr_sz(gx_wbs_adr_sz)
      )
   U1_PCIE_SUBS (
      .ix_clk_125(ix_clk_125),
      .ix_dec_wb_cyc(ix_dec_wb_cyc),
      .ix_ipx_dl_up(ix_ipx_dl_up),
      .ix_ipx_malf_tlp(ix_ipx_malf_tlp),
      .ix_ipx_rx_data(ix_ipx_rx_data),
      .ix_ipx_rx_end(ix_ipx_rx_end),
      .ix_ipx_rx_st(ix_ipx_rx_st),
      .ix_ipx_tx_ca_cpld(ix_ipx_tx_ca_cpld),
      .ix_ipx_tx_ca_cplh(ix_ipx_tx_ca_cplh),
      .ix_ipx_tx_ca_npd(ix_ipx_tx_ca_npd),
      .ix_ipx_tx_ca_nph(ix_ipx_tx_ca_nph),
      .ix_ipx_tx_ca_pd(ix_ipx_tx_ca_pd),
      .ix_ipx_tx_ca_ph(ix_ipx_tx_ca_ph),
      .ix_ipx_tx_rdy(ix_ipx_tx_rdy),
      .ix_pci_int_req(ix_pci_int_req),
      .ix_rst_n(ix_rst_n),
      .ix_wbm_ack(ix_wbm_ack),
      .ix_wbm_dat(ix_wbm_dat),
      .ix_wbs_adr(ix_wbs_adr),
      .ix_wbs_bte(ix_wbs_bte),
      .ix_wbs_cti(ix_wbs_cti),
      .ix_wbs_cyc(ix_wbs_cyc),
      .ix_wbs_dat(ix_wbs_dat),
      .ix_wbs_sel(ix_wbs_sel),
      .ix_wbs_stb(ix_wbs_stb),
      .ix_wbs_we(ix_wbs_we),
      .ox_dec_adr(ox_dec_adr),
      .ox_dec_bar_hit(ox_dec_bar_hit),
      .ox_dec_func_hit(ox_dec_func_hit),
      .ox_ipx_cc_npd_num(ox_ipx_cc_npd_num),
      .ox_ipx_cc_pd_num(ox_ipx_cc_pd_num),
      .ox_ipx_cc_processed_npd(ox_ipx_cc_processed_npd),
      .ox_ipx_cc_processed_nph(ox_ipx_cc_processed_nph),
      .ox_ipx_cc_processed_pd(ox_ipx_cc_processed_pd),
      .ox_ipx_cc_processed_ph(ox_ipx_cc_processed_ph),
      .ox_ipx_tx_data(ox_ipx_tx_data),
      .ox_ipx_tx_end(ox_ipx_tx_end),
      .ox_ipx_tx_req(ox_ipx_tx_req),
      .ox_ipx_tx_st(ox_ipx_tx_st),
      .ox_sys_rst_func_n(ox_sys_rst_func_n),
      .ox_sys_rst_n(ox_sys_rst_n),
      .ox_wbm_adr(ox_wbm_adr),
      .ox_wbm_bte(ox_wbm_bte),
      .ox_wbm_cti(ox_wbm_cti),
      .ox_wbm_cyc(ox_wbm_cyc),
      .ox_wbm_dat(ox_wbm_dat),
      .ox_wbm_sel(ox_wbm_sel),
      .ox_wbm_stb(ox_wbm_stb),
      .ox_wbm_we(ox_wbm_we),
      .ox_wbs_ack(ox_wbs_ack),
      .ox_wbs_dat(ox_wbs_dat),
      .ox_wbs_err(ox_wbs_err)
   );
endmodule
