Library IEEE;
 
use IEEE.std_logic_1164.all;
 
use WORK.versa_ecp5_tb_pkg.all;
 
Architecture Bhv of versa_ecp5_tb is
   constant c_clk_init_wait     : time := 100 ns;
   constant c_clk_period        : time := 10 ns;
   constant c_reset_init_wait   : natural := 127;
 
   signal s_clk                 : std_logic := '0';
   signal s_rst_n               : std_logic := '0';
   signal s_stim_end_sim        : std_logic := '0';
 
Begin
   PERST_N     <= s_rst_n;
   
   DUT: versa_ecp5
      Port Map (
         GPIO_SW4_1  => GPIO_SW4_1,
         GPIO_SW4_2  => GPIO_SW4_2,
         HDIN0_N     => HDIN0_N,
         HDIN0_P     => HDIN0_P,
         PERST_N     => PERST_N,
         REFCLK_N    => REFCLK_N,
         REFCLK_P    => REFCLK_P,
         SF_MISO     => SF_MISO,
         UART_RX_0   => UART_RX_0,
         UART_RX_1   => UART_RX_1,
         UART_RX_2   => UART_RX_2,
         UART_RX_3   => UART_RX_3,
         UART_RX_4   => UART_RX_4,
         
         DL_UP       => DL_UP,
         GPIO_LED_0  => GPIO_LED_0,
         GPIO_LED_1  => GPIO_LED_1,
         GPIO_LED_2  => GPIO_LED_2,
         HDOUT0_N    => HDOUT0_N,
         HDOUT0_P    => HDOUT0_P,
         LTSSM_0     => LTSSM_0,
         LTSSM_1     => LTSSM_1,
         LTSSM_2     => LTSSM_2,
         LTSSM_3     => LTSSM_3,
         SEGL_A      => SEGL_A,
         SEGL_B      => SEGL_B,
         SEGL_C      => SEGL_C,
         SEGL_D      => SEGL_D,
         SEGL_E      => SEGL_E,
         SEGL_K      => SEGL_K,
         SEGL_P      => SEGL_P,
         SEGL_DP     => SEGL_DP,
         SF_CS_N     => SF_CS_N,
         SF_MOSI     => SF_MOSI,
         UART_TX_0   => UART_TX_0,
         UART_TX_1   => UART_TX_1,
         UART_TX_2   => UART_TX_2,
         UART_TX_3   => UART_TX_3,
         UART_TX_4   => UART_TX_4
         );
    
   --	*****************************************************************
   --    Master clock, reset and stop processes
   --	*****************************************************************
    
   Clock_P:
      -- Clock process
   process
   begin
      wait for c_clk_init_wait;
      while (s_stim_end_sim = '0') loop
         s_clk <= not s_clk;
         wait for c_clk_period / 2;
      end loop;
      wait for c_clk_period;
      assert false report LF & LF &
                          "        +++ Game Over +++" & LF & LF severity note;
      wait;
   end process;
    
   Reset_P:
   process
   begin
      s_rst_n   <= '0';
      for i in 0 to c_reset_init_wait loop
         wait until rising_edge(s_clk);
      end loop;
      s_rst_n   <= '1';
      wait;
   end process;
    
   --	*****************************************************************
    
 
   MAIN:
      -- Main Simulation process
   process
   begin
         -- Put your test-stimuli here
      wait;
   end process;
End Bhv;
