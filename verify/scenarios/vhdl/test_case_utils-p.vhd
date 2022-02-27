
--    Copyright Ingenieurbuero Gardiner, 2019 - 2020
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: test_case_utils-p.vhd 156 2022-02-10 23:35:17Z  $
-- Generated   : $LastChangedDate: 2022-02-11 00:35:17 +0100 (Fri, 11 Feb 2022) $
-- Revision    : $LastChangedRevision: 156 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Use WORK.bfm_lspcie_rc_constants_pkg.all;
Use WORK.bfm_lspcie_rc_tlm_lib_pkg.all;
Use WORK.bfm_lspcie_rc_types_pkg.all;
Use WORK.bfm_random_data_pkg.all;

Package test_case_utils is
   type t_dma_sge is 
      record
         adr_high    : t_dword;
         adr_low     : t_dword;
         irq         : boolean;
         xfer_sz     : t_dword;
      end record;
      
   type t_dma_sge_list is array (natural range <>) of t_dma_sge;
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   constant c_all_ones                 : std_logic_vector(31 downto 0) := (others => '0');
   constant c_all_zero                 : std_logic_vector(31 downto 0) := (others => '0');
   constant c_any_value                : std_logic_vector(31 downto 0) := (others => '0');
   
   constant c_mode_dma_rd        : boolean := false;
   constant c_mode_dma_wr        : boolean := true;
   
   constant c_pcie_classcode_tbl       : t_slv32_array(7 downto 0)   := (0 => X"07000201",
                                                                           1 => X"07000201",                  
                                                                           2 => X"07000201",                  
                                                                           3 => X"07000201",                  
                                                                           4 => X"07000201",                  
                                                                           5 => X"FF000001",                  
                                                                           6 => X"FF000001",                  
                                                                           7 => X"FF000001");

   constant c_pcie_rsrc_bar0_attribs   : t_slv32_array(7 downto 0)   := (0 => X"00000001",
                                                                           1 => X"00000001",                  
                                                                           2 => X"00000001",                  
                                                                           3 => X"00000001",                  
                                                                           4 => X"00000001",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar0_size      : t_slv32_array(7 downto 0)   := (0 => X"FFFFFFF8",
                                                                           1 => X"FFFFFFF8",                  
                                                                           2 => X"FFFFFFF8",                  
                                                                           3 => X"FFFFFFF8",                  
                                                                           4 => X"FFFFFFF8",                  
                                                                           5 => X"FFFFF000",                  
                                                                           6 => X"FFFFF000",                  
                                                                           7 => X"FFFFF000");

   constant c_pcie_rsrc_bar0_tbl       : t_slv32_array(7 downto 0)   := (0 => X"12345FD0",
                                                                           1 => X"12345FD8",                  
                                                                           2 => X"87654FE0",                  
                                                                           3 => X"87654FE8",                  
                                                                           4 => X"13579FF0",                  
                                                                           5 => X"FEDCB000",                  
                                                                           6 => X"7ABCD000",                  
                                                                           7 => X"7ABCC000");

   constant c_pcie_rsrc_bar1_attribs   : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar1_size      : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar1_tbl       : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar2_attribs   : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar2_size      : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar2_tbl       : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar3_attribs   : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar3_size      : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar3_tbl       : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar4_attribs   : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar4_size      : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar4_tbl       : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar5_attribs   : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar5_size      : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");

   constant c_pcie_rsrc_bar5_tbl       : t_slv32_array(7 downto 0)   := (0 => X"00000000",
                                                                           1 => X"00000000",                  
                                                                           2 => X"00000000",                  
                                                                           3 => X"00000000",                  
                                                                           4 => X"00000000",                  
                                                                           5 => X"00000000",                  
                                                                           6 => X"00000000",                  
                                                                           7 => X"00000000");
                                                                           
   constant c_pcie_sub_vend_sys_id_tbl : t_slv32_array(7 downto 0)   := (0 => X"8C011204",
                                                                           1 => X"8C011204",                  
                                                                           2 => X"8C011204",                  
                                                                           3 => X"8C011204",                  
                                                                           4 => X"8C011204",                  
                                                                           5 => X"8C051204",                  
                                                                           6 => X"8C061204",                  
                                                                           7 => X"8C071204");                                                                           

   constant c_pcie_vend_dev_id_tbl     : t_slv32_array(7 downto 0)   := (0 => X"8C011204",
                                                                           1 => X"8C011204",                  
                                                                           2 => X"8C011204",                  
                                                                           3 => X"8C011204",                  
                                                                           4 => X"8C011204",                  
                                                                           5 => X"8C051204",                  
                                                                           6 => X"8C061204",                  
                                                                           7 => X"8C071204");

   constant c_reg_adr_dma_cmd_sta      : natural := 16#00000000#;
   constant c_reg_adr_dma_xfer_sz      : natural := 16#00000004#;
   constant c_reg_adr_dma_haddr_low    : natural := 16#00000008#;
   constant c_reg_adr_dma_haddr_high   : natural := 16#0000000C#;
   constant c_reg_adr_dma_laddr        : natural := 16#00000014#;
   constant c_reg_adr_dma_fifo_count   : natural := 16#0000001C#;
   constant c_reg_adr_dma_xfer_attribs : natural := 16#00000010#;
   
   constant c_reg_adr_uart_rbr         : natural := 0;
   constant c_reg_adr_uart_thr         : natural := 0;
   constant c_reg_adr_uart_ier         : natural := 1;
   constant c_reg_adr_uart_iir         : natural := 2;   -- (Read)
   constant c_reg_adr_uart_fcr         : natural := 2;   -- (Write)
   constant c_reg_adr_uart_lcr         : natural := 3;
   constant c_reg_adr_uart_mcr         : natural := 4;
   constant c_reg_adr_uart_lsr         : natural := 5;
   constant c_reg_adr_uart_msr         : natural := 6;
   constant c_reg_adr_uart_scr         : natural := 7;
   constant c_reg_adr_uart_dll         : natural := 0;
   constant c_reg_adr_uart_dlm         : natural := 1;      
   
   constant c_dut_dma_rsrc             : t_slv32_array(0 downto 0)  := (0 => c_pcie_rsrc_bar0_tbl(5));
   
   constant c_dut_mem_rsrc_0           : std_logic_vector(31 downto 0)  := c_pcie_rsrc_bar0_tbl(6);     
      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
   procedure f_write_sgdma(signal clk        : in    std_logic;
                           signal sv         : inout t_bfm_stim;
                           signal rv         : in    t_bfm_resp;
                                  dma_wr     : in    boolean;
                                  sge_list   : in    t_dma_sge_list; 
                                  chn_nr     : in    natural := 0;
                                  no_close   : in    boolean := false);      
End test_case_utils;
