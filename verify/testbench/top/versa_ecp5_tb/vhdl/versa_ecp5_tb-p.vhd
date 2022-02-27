Library IEEE;
 
use IEEE.std_logic_1164.all;

Package versa_ecp5_tb_pkg is
   signal GPIO_SW4_1 : std_logic := '0';
   signal GPIO_SW4_2 : std_logic := '0';
   signal HDIN0_N    : std_logic := '0';
   signal HDIN0_P    : std_logic := '1';
   signal PERST_N    : std_logic := '0';
   signal REFCLK_N   : std_logic := '0';
   signal REFCLK_P   : std_logic := '0';
   signal SF_MISO    : std_logic := '0';
   signal UART_RX_0  : std_logic := '0';
   signal UART_RX_1  : std_logic := '0';
   signal UART_RX_2  : std_logic := '0';
   signal UART_RX_3  : std_logic := '0';
   signal UART_RX_4  : std_logic := '0';
   signal DL_UP      : std_logic;
   signal GPIO_LED_0 : std_logic;
   signal GPIO_LED_1 : std_logic;
   signal GPIO_LED_2 : std_logic;
   signal HDOUT0_N   : std_logic;
   signal HDOUT0_P   : std_logic;
   signal LTSSM_0    : std_logic;
   signal LTSSM_1    : std_logic;
   signal LTSSM_2    : std_logic;
   signal LTSSM_3    : std_logic;
   signal SEGL_A     : std_logic;
   signal SEGL_B     : std_logic;
   signal SEGL_C     : std_logic;
   signal SEGL_D     : std_logic;
   signal SEGL_E     : std_logic;
   signal SEGL_K     : std_logic;
   signal SEGL_P     : std_logic;
   signal SEGL_DP    : std_logic;
   signal SF_CS_N    : std_logic;
   signal SF_MOSI    : std_logic;
   signal UART_TX_0  : std_logic;
   signal UART_TX_1  : std_logic;
   signal UART_TX_2  : std_logic;
   signal UART_TX_3  : std_logic;
   signal UART_TX_4  : std_logic;

   Component versa_ecp5
      Port (
         GPIO_SW4_1  : in std_logic;
         GPIO_SW4_2  : in std_logic;
         HDIN0_N     : in std_logic;
         HDIN0_P     : in std_logic;
         PERST_N     : in std_logic;
         REFCLK_N    : in std_logic;
         REFCLK_P    : in std_logic;
         SF_MISO     : in std_logic;
         UART_RX_0   : in std_logic;
         UART_RX_1   : in std_logic;
         UART_RX_2   : in std_logic;
         UART_RX_3   : in std_logic;
         UART_RX_4   : in std_logic;
         
         DL_UP       : out std_logic;
         GPIO_LED_0  : out std_logic;
         GPIO_LED_1  : out std_logic;
         GPIO_LED_2  : out std_logic;
         HDOUT0_N    : out std_logic;
         HDOUT0_P    : out std_logic;
         LTSSM_0     : out std_logic;
         LTSSM_1     : out std_logic;
         LTSSM_2     : out std_logic;
         LTSSM_3     : out std_logic;
         SEGL_A      : out std_logic;
         SEGL_B      : out std_logic;
         SEGL_C      : out std_logic;
         SEGL_D      : out std_logic;
         SEGL_E      : out std_logic;
         SEGL_K      : out std_logic;
         SEGL_P      : out std_logic;
         SEGL_DP     : out std_logic;
         SF_CS_N     : out std_logic;
         SF_MOSI     : out std_logic;
         UART_TX_0   : out std_logic;
         UART_TX_1   : out std_logic;
         UART_TX_2   : out std_logic;
         UART_TX_3   : out std_logic;
         UART_TX_4   : out std_logic
         );
   End Component;
End versa_ecp5_tb_pkg;
