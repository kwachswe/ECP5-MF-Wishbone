
--
--    Copyright Ingenieurbuero Gardiner, 2018
--
--    All Rights Reserved
--
--       This proprietary software may be used only as authorised in a licensing,
--       product development or training agreement.
--
--       Copies may only be made to the extent permitted by such an aforementioned
--       agreement. This entire notice above must be reproduced on
--       all copies.
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_wb_cfi_jxb3-e.vhd 4888 2019-08-01 16:57:42Z  $
-- Generated   : $LastChangedDate: 2019-08-01 18:57:42 +0200 (Thu, 01 Aug 2019) $
-- Revision    : $LastChangedRevision: 4888 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--    g_spi_adr_sz   : Size of address passed to external SPI component
--   
--    g_spi_cmd_sz   : Size of command passed to external SPI component
--
--       -----------------------------------------------------------------------
--    Writing over the DMA interface accesses SPI directly. The address map is 1:1,
--    SPI accesses are autonomously initiated.
--
--    Writing over the register interface access the SPI buffer indirectly. The 
--    upper half of i_wb_reg_adr targets the data-transfer buffer
--
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Entity tspc_wb_cfi_jxb3 is
   Generic (
      g_buf_rd_latency  : positive range 1 to 2 := 2;
      g_buf_words       : positive := 2048;
      g_spi_adr_sz      : positive := 24;
      g_spi_cmd_sz      : positive := 8;
      g_tech_lib        : string := "ECP3"
      );
   Port (
      i_clk_spi            : in  std_logic;
      i_clk_sys            : in  std_logic;
      i_rst_n              : in  std_logic;
      i_clr                : in  std_logic;
      
      i_spi_miso           : in  std_logic;
      i_sys_rdy            : in  std_logic;
      i_wb_dma_adr         : in  std_logic_vector;
      i_wb_dma_cti         : in  std_logic_vector(2 downto 0);
      i_wb_dma_cyc         : in  std_logic;
      i_wb_dma_din         : in  std_logic_vector(31 downto 0);
      i_wb_dma_sel         : in  std_logic_vector(3 downto 0);
      i_wb_dma_stb         : in  std_logic;
      i_wb_dma_we          : in  std_logic;         
      i_wb_reg_adr         : in  std_logic_vector;
      i_wb_reg_cyc         : in  std_logic;
      i_wb_reg_din         : in  std_logic_vector(31 downto 0);
      i_wb_reg_sel         : in  std_logic_vector(3 downto 0);
      i_wb_reg_stb         : in  std_logic;
      i_wb_reg_we          : in  std_logic;      

      o_img_has_update     : out std_logic;
      o_img_reload         : out std_logic;
      o_int_req            : out std_logic;
      o_spi_mosi           : out std_logic;
      o_spi_mosi_en        : out std_logic;
      o_spi_sclk           : out std_logic;
      o_spi_sclk_en        : out std_logic;
      o_spi_ssel           : out std_logic;
      o_wb_dma_ack         : out std_logic;
      o_wb_dma_dout        : out std_logic_vector;         
      o_wb_reg_ack         : out std_logic;
      o_wb_reg_dout        : out std_logic_vector   
      );
End tspc_wb_cfi_jxb3;
