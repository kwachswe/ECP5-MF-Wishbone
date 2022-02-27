--
--    Copyright Ing. Buero Gardiner 2008 - 2012
--
--------------------------------------------------------------------------------
--
-- File ID     : $Id: tspc_dma_chan_ms_types-pb.vhd 4387 2018-08-10 18:23:52Z  $
-- Generated   : $LastChangedDate: 2018-08-10 20:23:52 +0200 (Fri, 10 Aug 2018) $
-- Revision    : $LastChangedRevision: 4387 $
--
--------------------------------------------------------------------------------
--
-- Description :
--
--------------------------------------------------------------------------------
Library IEEE;
Use IEEE.numeric_std.all;

Package Body tspc_dma_chan_ms_types is

   function f_get_adr(vPack : std_logic_vector; vAdrSz : positive) return std_logic_vector is
      variable v_vPack  : std_logic_vector(vPack'length -1 downto 0);

   begin
      v_vPack  := vPack;

      if (vPack'length > vAdrSz) then
         return v_vPack(vAdrSz - 1 downto 0);
      else
         return std_logic_vector(resize(unsigned(v_vPack), vAdrSz));
      end if;
   end;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_get_flags(vPack : std_logic_vector; vAdrSz : positive) return t_tspc_dma_ms_flags is
      variable v_vPack     : std_logic_vector(vPack'length -1 downto 0);
      variable v_ret_val   : t_tspc_dma_ms_flags;
   begin
      v_vPack  := vPack;

      v_ret_val   := c_tspc_dma_ms_flags_init;

      if (vPack'length < (vAdrSz + c_nr_flag_fields)) then
         return v_ret_val;        
      end if;
                  
      v_ret_val.adr_rst    := v_vPack(vAdrSz);
      v_ret_val.dma_last   := v_vPack(vAdrSz + 1);
      v_ret_val.dma_wr     := v_vPack(vAdrSz + 2);
      v_ret_val.int_req    := v_vPack(vAdrSz + 3);

      return v_ret_val; 
   end;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_get_packed_cmd_sz(vAdrSz : positive; vXferSz : positive) return positive is
   begin
      return vAdrSz + vXferSz + c_nr_flag_fields;
   end;

      --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
   function f_get_xfer_sz(vPack : std_logic_vector; vXferSz : positive) return std_logic_vector is
      variable v_vPack  : std_logic_vector(vPack'length -1 downto 0);
      
   begin
      v_vPack  := vPack;
         
      if (vPack'length > vXferSz) then
         return v_vPack(v_vPack'left downto v_vPack'left - vXferSz + 1);
      else
         return std_logic_vector(resize(unsigned(v_vPack), vXferSz));
      end if;
   end;

         --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   function f_pack(vFlags : t_tspc_dma_ms_flags) return std_logic_vector is
      variable v_ret_val   : std_logic_vector(c_nr_flag_fields - 1 downto 0);
      
   begin
      v_ret_val(0)   := vFlags.adr_rst;
      v_ret_val(1)   := vFlags.dma_last;
      v_ret_val(2)   := vFlags.dma_wr;
      v_ret_val(3)   := vFlags.int_req;
                        
      return   v_ret_val;
   end;
   
         --    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
   function f_pack(vAdr : std_logic_vector; vFlags : t_tspc_dma_ms_flags; vSize : std_logic_vector) return std_logic_vector is
   begin
      return   vSize & f_pack(vFlags) & vAdr;
   end;

End tspc_dma_chan_ms_types;
