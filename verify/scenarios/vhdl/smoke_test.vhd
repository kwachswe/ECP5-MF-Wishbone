
--    Copyright Ingenieurbuero Gardiner, 2019 - 2020
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: smoke_test.vhd 158 2022-02-10 23:39:05Z  $
-- Generated   : $LastChangedDate: 2022-02-11 00:39:05 +0100 (Fri, 11 Feb 2022) $
-- Revision    : $LastChangedRevision: 158 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------
Library IEEE;
Library versa_ecp5_tb_lib;

Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;     -- provides e.g. add for std_logic_vector + constant 

Use WORK.test_case_utils.all;
Use versa_ecp5_tb_lib.dma_subsys_regs_types.all;

Package Body pcie_vhdl_test_case_pkg is
       
   procedure run_test(signal clk : in    std_logic;
                      signal sv  : inout t_bfm_stim;
                      signal rv  : in    t_bfm_resp;
                             id  : in    natural := 0) is

      constant c_xfer_sz         : natural := 16;
      
      variable v_be_mask         : std_logic_vector(3 downto 0);
      variable v_bus_nr          : natural := 0;
      variable v_pload_sel       : natural := 0;
      variable v_dev_nr          : natural := 0;
      variable v_int_count       : natural := 0;
      variable v_int_line        : std_logic_vector(31 downto 0);
      variable v_reg_val         : std_logic_vector(31 downto 0);
      variable v_spi_status_reg  : std_logic_vector(31 downto 0);
                             
   begin
      wait for 0 ns;

         -- useful for checking in the console window that the correct language 
         -- is on use
      wait for 5 ns;
      report LF & "Running VHDL Test Case smoke_test" & LF & LF;

         -- Set up the bus no, func no. and device no in the DUT
         -- The function no. should always be set to zero 
         -- (no multi-function device)
         -- This should be varied when running multiple tests to check that
         -- the user hardware is picking up the correct values from the Lattice
         -- core
      set_dut_id(sv, 2, 0, 0);
      v_bus_nr := 3;
      v_dev_nr := 0;

         -- increase the default values for credit-based flow control in the BFM
         -- (More on this in session 3. For session 2, these lines can be omitted)
      svc_ca_p(clk, sv, 7, 56);
      svc_ca_np(clk, sv, 7, 0);
      svc_ca_cplx(clk, sv, 7, 56);
            
         -- Get a bit of distance from link up   
      idle(clk, 128);
      msgd_set_slot_power_limit(clk, sv, rv, value => X"64", scale => "01");
      idle(clk, 128);

         -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         --    Setup Config Space
         -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      report LF & " --- checking Configuration Space headers ---" & LF;
      
      for ix in 0 to 7 loop
         report LF & LF & " ##- Testing Function Header for Device " & to_string(ix) & " ---";

         cfgrd0(clk, sv, rv, c_csreg_cache_line_size, X"00000000", func_nr => ix, no_compare => true);
         v_reg_val   := get_cpl_buffer(rv);

         assert (v_reg_val(23) = '1') report "*** Error: MF Device attribute not set" severity error;
                  
            -- To communicate with an end-point, the end-point resources (e.g. registers)
            -- must be mapped into PCI Express memory or I/O space
            -- This will be discussed in more detail in session 5
            -- To summarise the initialisation scenario as it runs in the real world,
            -- First, all Base address registers are written with all ones
            -- Note: the very first PCI Express communication to a device MUST be a
            -- configuration space write (sets Bus no, dev no, funcno in device)
         cfgwr0(clk, sv, rv, c_csreg_bar0, X"FFFFFFFF", func_nr => ix, cpl_wait => true);
         cfgwr0(clk, sv, rv, c_csreg_bar1, X"FFFFFFFF", func_nr => ix, cpl_wait => true);
         cfgwr0(clk, sv, rv, c_csreg_bar2, X"FFFFFFFF", func_nr => ix, cpl_wait => true);
         cfgwr0(clk, sv, rv, c_csreg_bar3, X"FFFFFFFF", func_nr => ix, cpl_wait => true);
         cfgwr0(clk, sv, rv, c_csreg_bar4, X"FFFFFFFF", func_nr => ix, cpl_wait => true);
         cfgwr0(clk, sv, rv, c_csreg_bar5, X"FFFFFFFF", func_nr => ix, cpl_wait => true);

            -- Typically, the BIOS /System SW would try and identify the device
         cfgrd0(clk, sv, rv, c_csreg_vend_id,      c_pcie_vend_dev_id_tbl(ix), func_nr => ix);
         cfgrd0(clk, sv, rv, c_csreg_subs_vend_id, c_pcie_sub_vend_sys_id_tbl(ix), func_nr => ix);
         cfgrd0(clk, sv, rv, c_csreg_rev_id,       c_pcie_classcode_tbl(ix), func_nr => ix);

            -- Typically, the BIOS /System SW would read back the Base Address registers
            -- written above to determine the resource window size (again, more on this in
            -- session 5)
         cfgrd0(clk, sv, rv, c_csreg_bar0, c_pcie_rsrc_bar0_size(ix) or c_pcie_rsrc_bar0_attribs(ix), func_nr => ix);
         cfgrd0(clk, sv, rv, c_csreg_bar1, c_pcie_rsrc_bar1_size(ix) or c_pcie_rsrc_bar1_attribs(ix), func_nr => ix);
         cfgrd0(clk, sv, rv, c_csreg_bar2, c_pcie_rsrc_bar2_size(ix) or c_pcie_rsrc_bar2_attribs(ix), func_nr => ix);
         cfgrd0(clk, sv, rv, c_csreg_bar3, c_pcie_rsrc_bar3_size(ix) or c_pcie_rsrc_bar3_attribs(ix), func_nr => ix);
         cfgrd0(clk, sv, rv, c_csreg_bar4, c_pcie_rsrc_bar4_size(ix) or c_pcie_rsrc_bar4_attribs(ix), func_nr => ix);
         cfgrd0(clk, sv, rv, c_csreg_bar5, c_pcie_rsrc_bar5_size(ix) or c_pcie_rsrc_bar5_attribs(ix), func_nr => ix);

            -- BIOS or system sw must then locate the device within the system memory map
            -- by writing a base address to the base-address register.
            -- In this program, the base address is a constant assigned at the head of the
            -- test program. To rerun the test with different BAR settings, you only need
            -- to modify the constant above.
         cfgwr0(clk, sv, rv, c_csreg_bar0, c_pcie_rsrc_bar0_tbl(ix), func_nr => ix);
         cfgrd0(clk, sv, rv, c_csreg_bar0, c_pcie_rsrc_bar0_tbl(ix) or c_pcie_rsrc_bar0_attribs(ix), func_nr => ix);

         cfgwr0(clk, sv, rv, c_csreg_bar1, c_pcie_rsrc_bar1_tbl(ix), func_nr => ix);
         cfgrd0(clk, sv, rv, c_csreg_bar1, c_pcie_rsrc_bar1_tbl(ix) or c_pcie_rsrc_bar1_attribs(ix), func_nr => ix);
                  
            -- Modern Bioses /operating systems send the Set Slot Power Limit message after
            -- initial configuration is complete. (More on this in session 3 and 4)
         msgd_set_slot_power_limit(clk, sv, rv, value => X"02", scale => "01");

            -- Test that access on non-enabled address spaces result in UR
         iowr(clk, sv, rv, c_pcie_rsrc_bar0_tbl(ix), X"2468_ACE0", cpl_sta => c_cpl_sta_ur);
         iord(clk, sv, rv, c_pcie_rsrc_bar0_tbl(ix), X"2468_ACE0", cpl_sta => c_cpl_sta_ur);
         memwr(clk, sv, rv, c_pcie_rsrc_bar0_tbl(ix), X"DEAD_BEEF");
         memrd(clk, sv, rv, c_pcie_rsrc_bar0_tbl(ix), X"9999_99EF", cpl_sta => c_cpl_sta_ur);
         wait_all_cplx_pending(clk, rv);

         report LF & "    --- Checking Capability Structures ---";
         cfgrd0(clk, sv, rv, c_csreg_command, X"00000000", func_nr => ix, no_compare => true);
         v_reg_val   := get_cpl_buffer(rv);
         assert ((v_reg_val and c_bsel_cap_list_present) = c_bsel_cap_list_present) 
                report "*** Error: Capability list present indicator not set" severity error;

         cfgrd0(clk, sv, rv, c_csreg_int_line, X"00000000", func_nr => ix, no_compare => true);
         v_int_count := to_integer(unsigned(get_cpl_buffer(rv)(15 downto 8)));
         
         if ((v_reg_val and c_bsel_cap_list_present) = c_bsel_cap_list_present) then
            cfgrd0(clk, sv, rv, c_csreg_cap_ptr, X"00000000", func_nr => ix, no_compare => true);
            v_reg_val   := get_cpl_buffer(rv) and X"0000_00FF";

            cfgrd0(clk, sv, rv, v_reg_val, X"00000000", func_nr => ix, no_compare => true);
            v_reg_val   := get_cpl_buffer(rv) and X"0000_00FF";
            assert (v_reg_val(7 downto 0) = c_pci_cap_pm) report "*** Error: PM Capability identifier not found" severity error;

            v_reg_val   := get_cpl_buffer(rv) and X"0000_FF00";
            cfgrd0(clk, sv, rv, X"00" & v_reg_val(31 downto 8), X"00000000", func_nr => ix, no_compare => true);
            v_reg_val   := get_cpl_buffer(rv) and X"0000_FFFF";
            
            if (v_int_count = 0) then
               assert (v_reg_val(7 downto 0)  = c_pci_cap_pcie_reg_set) report "*** Error: PCIe Capability Expected" severity error;
               assert (v_reg_val(15 downto 8) = X"00") report "*** Error: End of Capability List Expected" severity error;
            else
               assert (v_reg_val(7 downto 0) = c_pci_cap_msi) report "*** Error: MSI Capability Expected" severity error;

               cfgrd0(clk, sv, rv, X"00" & v_reg_val(31 downto 8), X"00000000", func_nr => ix, no_compare => true);
               v_reg_val   := get_cpl_buffer(rv) and X"0000_FFFF";

               assert (v_reg_val(7 downto 0)  = c_pci_cap_pcie_reg_set) report "*** Error: PCIe Capability Expected" severity error;
               assert (v_reg_val(15 downto 8) = X"00") report "*** Error: End of Capability List Expected" severity error;
            end if;
         end if;

         report LF & "    --- Checking Capability Structures in PCIe Space ---";
         cfgrd0(clk, sv, rv, X"100", X"00000000", func_nr => ix, no_compare => true);
         cfgwr0(clk, sv, rv, X"100", X"00000000", func_nr => ix);
                  
         report LF & "    --- Enabling Device ---";
         cfgwr0(clk, sv, rv, c_csreg_pmcsr, X"0000_0000", func_nr => ix);
         cfgwr0(clk, sv, rv, c_csreg_command, c_bsel_mem_space_en or c_bsel_io_space_en or c_bsel_bus_mst_en, func_nr => ix);

         if ((c_pcie_rsrc_bar0_attribs(ix) and X"00000001") = X"00000001") then
               -- Is IO-Space, UART
            report LF & "    Testing I/O Space Device ...";
               
            memrd(clk, sv, rv, c_pcie_rsrc_bar0_tbl(ix), X"2468_ACE0", cpl_sta => c_cpl_sta_ur);

            iowr(clk, sv, rv, std_logic_vector(unsigned(c_pcie_rsrc_bar0_tbl(ix)) + c_reg_adr_uart_mcr), 
                 X"FFFF_FF03", be_first => X"1");
            iowr(clk, sv, rv, std_logic_vector(unsigned(c_pcie_rsrc_bar0_tbl(ix)) + c_reg_adr_uart_scr), 
                 X"C000_0000", be_first => X"8");

            iowr(clk, sv, rv, std_logic_vector(unsigned(c_pcie_rsrc_bar0_tbl(ix)) + c_reg_adr_uart_lsr), 
                 X"5555_5555", be_first => X"2");
            iowr(clk, sv, rv, std_logic_vector(unsigned(c_pcie_rsrc_bar0_tbl(ix)) + c_reg_adr_uart_msr), 
                 X"5555_5555", be_first => X"4");
            
            iord(clk, sv, rv, std_logic_vector(unsigned(c_pcie_rsrc_bar0_tbl(ix)) + c_reg_adr_uart_mcr), 
                 X"FFFF_FF03", be_first => X"1");
            iord(clk, sv, rv, std_logic_vector(unsigned(c_pcie_rsrc_bar0_tbl(ix)) + c_reg_adr_uart_scr), 
                 X"C000_0000", be_first => X"8");
            iord(clk, sv, rv, std_logic_vector(unsigned(c_pcie_rsrc_bar0_tbl(ix)) + c_reg_adr_uart_mcr), 
                 X"FFFF_FF03", be_first => X"1");
            
            cfgrd0(clk, sv, rv, c_csreg_int_pin, X"00000000", no_compare => true, be_first => X"2", func_nr => ix);
            v_reg_val   := get_cpl_buffer(rv) and X"0000_FF00";
            
            report "Function " & to_string(ix) & ": Using Interrupt Pin " & to_string(to_integer(unsigned(v_reg_val(15 downto 8))));
            v_int_line  := std_logic_vector(to_unsigned(16 + to_integer(unsigned(v_reg_val(15 downto 8))), 32));
            
            cfgwr0(clk, sv, rv, c_csreg_int_line, v_int_line, be_first => X"1", func_nr => ix);
            cfgrd0(clk, sv, rv, c_csreg_int_line, v_int_line, be_first => X"1", func_nr => ix);      
            
               -- Set Loop back
            iowr(clk, sv, rv, std_logic_vector(unsigned(c_pcie_rsrc_bar0_tbl(ix)) + c_reg_adr_uart_mcr), 
                 X"0000_0010", be_first => X"1");   
            
               -- Enable All Interrupts
            iowr(clk, sv, rv, std_logic_vector(unsigned(c_pcie_rsrc_bar0_tbl(ix)) + c_reg_adr_uart_ier), 
                 X"0000_0F00", be_first => X"2");
            
            idle(clk, 1024);
            iord(clk, sv, rv, c_pcie_rsrc_bar0_tbl(ix), X"FFFF_FF03", be_first => X"4", no_compare => true);
            v_reg_val   := get_cpl_buffer(rv) and X"00FF_0000";
            assert (v_reg_val(16) = '0')
               report "Uart Interrupt not set for function " & to_string(ix)
               severity error;
               
                           -- Set DIS_INTx
            cfgwr0(clk, sv, rv, c_csreg_command, X"00000400", be_first => X"2", func_nr => ix);
            idle(clk, 1024);
            cfgrd0(clk, sv, rv, c_csreg_command, X"00000000", func_nr => ix, no_compare => true);
            v_reg_val   := get_cpl_buffer(rv) and X"FFFF_0000";
            assert (v_reg_val(19) = '1') 
               report "Interrupt Status for function " & to_string(ix) & " should be '1' even though DIS_INTx is set"
               severity error;
               -- Clear DIS_INTx
            cfgwr0(clk, sv, rv, c_csreg_command, X"00000000", be_first => X"2", func_nr => ix);
            idle(clk, 1024);
            
               -- Disable All Interrupts
            iowr(clk, sv, rv, std_logic_vector(unsigned(c_pcie_rsrc_bar0_tbl(ix)) + c_reg_adr_uart_ier), 
                 X"0000_0000", be_first => X"2");
         end if;
      end loop;

         -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         --    Test Sequence
         -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
      memwr(clk, sv, rv, c_dut_mem_rsrc_0, c_membg_4kb_0(0 to 7));
      memrd(clk, sv, rv, c_dut_mem_rsrc_0, c_membg_4kb_0(0 to 7));
    
         -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         --    DMA Test
         -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      report LF & LF & "DMA Test ...";
      sys_memwr(clk, sv, rv, X"50EA_8000", c_membg_4kb_1);
      sys_memwr(clk, sv, rv, X"5E5F_A000", c_membg_4kb_2);
      sys_memwr(clk, sv, rv, X"5523_9000", c_membg_4kb_3);

      report LF & LF & "   DMA Test: Read from System Memory";
      
      v_reg_val   := (c_bpos_int_dis_hfe => '1',
                      c_bpos_int_dis_lfe => '1',
                      c_bpos_dma_en => '1',
                      c_bpos_int_en => '1',
                      others => '0');      
      memwr(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(0)) +
                                          c_reg_adr_dma_cmd_sta), v_reg_val);  

      memrd(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(0)) +
                                          c_reg_adr_dma_cmd_sta),
                         X"0000_0000", no_compare => true);      

      memwr(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(0)) + c_adr_dma_ladr), X"0000_0000");
      
         -- Local memory is contiguous, i.e. increases linearily from the value written to c_adr_dma_ladr
         -- An interrupt is always generated when the transaction is complete
      f_write_sgdma(clk, sv, rv, c_mode_dma_rd, 
                                 sge_list => (0 => (adr_high => X"0000_0000", adr_low => X"50EA_8000", 
                                                    xfer_sz => X"0000_1000", irq => false),
                                              1 => (adr_high => X"0000_0000", adr_low => X"5E5F_A000", 
                                                    xfer_sz => X"0000_1000", irq => false),
                                              2 => (adr_high => X"0000_0000", adr_low => X"5523_9000", 
                                                    xfer_sz => X"0000_1000", irq => false)),
                                 chn_nr => 0);          
      
      idle(clk, 256);
      report "         Waiting for INT B ..."; 
      wait_legacy_int(clk, rv, INTB, 8192);
      
      loop
         memrd(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(0)) + c_adr_dma_cmd_sta), X"0000_0000", no_compare => true);
         v_reg_val  := get_cpl_buffer(rv);
         
         exit when (v_reg_val(c_bpos_dma_idle) = '1');
         
         wait for 25 us;
         idle(clk);
      end loop;

      v_reg_val   := (c_bpos_int_ack => '1',
                      others => '0'); 
      memwr(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(0)) + c_adr_dma_cmd_sta), v_reg_val, be_first => X"2");      
                      
      report LF & LF & "   DMA Test: Write to System Memory";
      memwr(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(0)) + c_adr_dma_ladr), X"0000_0000");
      
         -- Local memory is contiguous, i.e. increases linearily from the value written to c_adr_dma_ladr
         -- An interrupt is always generated when the transaction is complete      
      f_write_sgdma(clk, sv, rv, c_mode_dma_wr, 
                                 sge_list => (0 => (adr_high => X"0000_0000", adr_low => X"60EA_8000", 
                                                    xfer_sz => X"0000_1000", irq => false),
                                              1 => (adr_high => X"0000_0000", adr_low => X"6E5F_A000", 
                                                    xfer_sz => X"0000_1000", irq => false),
                                              2 => (adr_high => X"0000_0000", adr_low => X"6523_9000", 
                                                    xfer_sz => X"0000_1000", irq => false)),
                                 chn_nr => 0);          
      
      idle(clk, 256);
      report "         Waiting for INT B ..."; 
      wait_legacy_int(clk, rv, INTB, 8192);
      
      loop
         memrd(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(0)) + c_adr_dma_cmd_sta), X"0000_0000", no_compare => true);
         v_reg_val  := get_cpl_buffer(rv);
         
         exit when (v_reg_val(c_bpos_dma_idle) = '1');
         
         wait for 25 us;
         idle(clk);
      end loop;

      v_reg_val   := (c_bpos_int_ack => '1',
                      others => '0'); 
      memwr(clk, sv, rv, std_logic_vector(unsigned(c_dut_dma_rsrc(0)) + c_adr_dma_cmd_sta), v_reg_val, be_first => X"2");  
      
      report "   DMA Test: Verify in system memory"; 
      sys_memrd(clk, sv, rv, X"60EA_8000", c_membg_4kb_1(0 to 1023), log_verbose => TELL_ERR_WRN);
      sys_memrd(clk, sv, rv, X"6E5F_A000", c_membg_4kb_2(0 to 1023), log_verbose => TELL_ERR_WRN);
      sys_memrd(clk, sv, rv, X"6523_9000", c_membg_4kb_3(0 to 1023), log_verbose => TELL_ERR_WRN);
      
         -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         --    Test Completion
         -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      wait_all_cplx_pending(clk, rv);
      
      wait for 45 us;
      idle(clk, 64);
               
      show_credits(rv);
      idle(clk, 32);
      --stop(0);
   end procedure; 

End pcie_vhdl_test_case_pkg; 
