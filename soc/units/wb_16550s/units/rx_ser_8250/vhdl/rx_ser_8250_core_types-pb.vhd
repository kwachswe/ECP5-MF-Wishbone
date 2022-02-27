
--    
--    Copyright Ingenieurbuero Gardiner, 2007 - 2021
--       https://www.ib-gardiner.eu
--       techsupport@ib-gardiner.eu
--
--    All Rights Reserved
--     
--------------------------------------------------------------------------------
--
-- File ID     : $Id: rx_ser_8250_core_types-pb.vhd 5378 2021-12-13 00:15:46Z  $
-- Generated   : $LastChangedDate: 2021-12-13 01:15:46 +0100 (Mon, 13 Dec 2021) $
-- Revision    : $LastChangedRevision: 5378 $
--
--------------------------------------------------------------------------------
--
-- Description : 
--
--------------------------------------------------------------------------------

Library IEEE;
 
Use IEEE.numeric_std.all;

Package Body rx_ser_8250_core_types is
   function f_get_word_size (ws  : std_logic_vector; 
                             pe  : std_logic; 
                             stp : std_logic := '0') return natural is
      variable v_field_en  : std_logic_vector(1 downto 0);                          
      variable v_word_size : natural;                          
   begin
      v_field_en  := pe & stp;
      v_word_size := to_integer(unsigned(ws));
      case v_word_size is
         when c_word_size_int_5 =>
            case v_field_en is
               when "00" =>
                  return 7;
               when "01" | "10" =>
                  return 8;
               when others =>
                  return 9;
            end case;
            
         when c_word_size_int_6 =>
            case v_field_en is
               when "00" =>
                  return 8;
               when "01" | "10" =>
                  return 9;
               when others =>
                  return 10;
            end case;
            
         when c_word_size_int_7 =>
            case v_field_en is
               when "00" =>
                  return 9;
               when "01" | "10" =>
                  return 10;
               when others =>
                  return 11;
            end case;
            
         when others =>
            case v_field_en is
               when "00" =>
                  return 10;
               when "01" | "10" =>
                  return 11;
               when others =>
                  return 12;
            end case;
      end case;
   end function;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_get_word_size (ws  : std_logic_vector; 
                             pe  : std_logic; 
                             stp : std_logic := '0') return std_logic_vector is
   begin
      return std_logic_vector(to_unsigned(f_get_word_size(ws, pe, stp), 4));
   end function;
End rx_ser_8250_core_types;
