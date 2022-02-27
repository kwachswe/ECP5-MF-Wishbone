Library IEEE;
Use IEEE.std_logic_1164.all;

Entity adr_decode is
   Port (
      i_dec_adr         : in  std_logic_vector;
      i_dec_bar_hit     : in  std_logic_vector(5 downto 0);
      i_dec_func_hit    : in  std_logic_vector(7 downto 0);

      o_dec_wb_cyc      : out std_logic_vector
      );      
End adr_decode;
