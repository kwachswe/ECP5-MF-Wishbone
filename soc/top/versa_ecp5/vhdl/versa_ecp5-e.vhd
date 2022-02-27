
--    
--    Copyright Ingenieurbuero Gardiner, 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--   
--------------------------------------------------------------------------------
--
-- File ID    : $Id: versa_ecp5-e.vhd 111 2022-01-17 23:03:43Z  $
-- Generated  : $LastChangedDate: 2022-01-18 00:03:43 +0100 (Tue, 18 Jan 2022) $
-- Revision   : $LastChangedRevision: 111 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.std_logic_1164.all;

Entity versa_ecp5 is
   Port (
      GPIO_SW4_1              : in  std_logic;
      GPIO_SW4_2              : in  std_logic;
      HDIN0_N                 : in  std_logic;
      HDIN0_P                 : in  std_logic;
      PERST_N                 : in  std_logic;
      REFCLK_N                : in  std_logic;
      REFCLK_P                : in  std_logic;
      SF_MISO                 : in  std_logic;
      UART_RX_0               : in  std_logic;
      UART_RX_1               : in  std_logic;
      UART_RX_2               : in  std_logic;
      UART_RX_3               : in  std_logic;
      UART_RX_4               : in  std_logic;

      DL_UP                   : out std_logic;
      GPIO_LED_0              : out std_logic;
      GPIO_LED_1              : out std_logic;
      GPIO_LED_2              : out std_logic;                        
      HDOUT0_N                : out std_logic;
      HDOUT0_P                : out std_logic;
      LTSSM_0                 : out std_logic;
      LTSSM_1                 : out std_logic;
      LTSSM_2                 : out std_logic;
      LTSSM_3                 : out std_logic;
      SEGL_A                  : out std_logic;
      SEGL_B                  : out std_logic;
      SEGL_C                  : out std_logic;
      SEGL_D                  : out std_logic;
      SEGL_E                  : out std_logic;
      SEGL_K                  : out std_logic;
      SEGL_P                  : out std_logic;
      SEGL_DP                 : out std_logic;   
      SF_CS_N                 : out std_logic;
      SF_MOSI                 : out std_logic;      
      UART_TX_0               : out std_logic;
      UART_TX_1               : out std_logic;
      UART_TX_2               : out std_logic;
      UART_TX_3               : out std_logic;
      UART_TX_4               : out std_logic
      );
      
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      --       Summary of Options
      --          For IO_TYPE, please consult the documentation
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   attribute DIFFRESISTOR  : string;
   attribute DRIVE         : string;   -- 20, 16, 12 (def.), 8, 4
   attribute EQ_CAL        : string;
   attribute IO_TYPE       : string;   -- LVCMOS25 (def.), LVTTL33, LVCMOS33,
                                       -- LVCMOS12, LVCMOS15, LVCMOS18 (etc.)
   attribute LOC           : string;
   attribute PULLMODE      : string;   -- UP, DOWN, NONE
   attribute SLEWRATE      : string;   -- FAST, SLOW
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   attribute IO_TYPE of GPIO_SW4_1     : signal is "LVCMOS25";
   attribute IO_TYPE of PERST_N        : signal is "LVCMOS33";
               
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   attribute LOC of GPIO_SW4_1         : signal is "H2";  -- SW3.1
   attribute LOC of GPIO_SW4_2         : signal is "K3";  -- SW3.2
   attribute LOC of PERST_N            : signal is "A6";

   attribute LOC of SF_MISO            : signal is "V2";
   
   attribute LOC of DL_UP              : signal is "E18";  
   attribute LOC of GPIO_LED_0         : signal is "D18";  -- L0
   attribute LOC of GPIO_LED_1         : signal is "D17";  -- POLL 
   attribute LOC of GPIO_LED_2         : signal is "E16";  -- PLL 
   attribute LOC of LTSSM_0            : signal is "F16";  -- USER0      
   attribute LOC of LTSSM_1            : signal is "E17";  -- USER1
   attribute LOC of LTSSM_2            : signal is "F18";  -- USER2 
   attribute LOC of LTSSM_3            : signal is "F17";  -- USER3 
   attribute LOC of SEGL_A             : signal is "M20";  
   attribute LOC of SEGL_B             : signal is "L18";  
   attribute LOC of SEGL_C             : signal is "M19";  
   attribute LOC of SEGL_D             : signal is "L16";  
   attribute LOC of SEGL_E             : signal is "L17";  
   attribute LOC of SEGL_K             : signal is "P17";  
   attribute LOC of SEGL_P             : signal is "R17";  
   attribute LOC of SEGL_DP            : signal is "U1";
   
   attribute LOC of SF_CS_N            : signal is "R2";
   attribute LOC of SF_MOSI            : signal is "W2";   
   
      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   attribute PULLMODE of PERST_N       : signal is "UP";

   attribute PULLMODE of UART_RX_0     : signal is "UP";
   attribute PULLMODE of UART_RX_1     : signal is "UP";
   attribute PULLMODE of UART_RX_2     : signal is "UP";
   attribute PULLMODE of UART_RX_3     : signal is "UP";
   attribute PULLMODE of UART_RX_4     : signal is "UP";
End versa_ecp5;
