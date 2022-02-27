--
--    Copyright Ing. Buero Gardiner 2017 - 2018
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_cfi_spim_pw2n_types-p.vhd 4767 2019-05-12 00:58:26Z  $
-- Generated   : $LastChangedDate: 2019-05-12 02:58:26 +0200 (Sun, 12 May 2019) $
-- Revision    : $LastChangedRevision: 4767 $
--
--------------------------------------------------------------------------------
--
-- Description :
--       i_clk          : 2x SPI Frequency
--       i_xfer_attrib  : data b"00", cmd b="01", resp b"10", cmd/resp "11"
--------------------------------------------------------------------------------

Library IEEE;
Use IEEE.std_logic_1164.all;

Package tspc_cfi_spim_pw2n_types is
   subtype t_xfer_type is std_logic_vector(1 downto 0);
   
   constant c_xa_cmd       : t_xfer_type := B"01";
   constant c_xa_cmd_resp  : t_xfer_type := B"11";
   constant c_xa_data      : t_xfer_type := B"00";
   constant c_xa_resp      : t_xfer_type := B"10";
   
End tspc_cfi_spim_pw2n_types;
