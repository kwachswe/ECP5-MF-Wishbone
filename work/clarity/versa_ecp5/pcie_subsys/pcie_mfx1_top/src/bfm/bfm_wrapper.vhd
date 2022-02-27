Library IEEE;
Use IEEE.std_logic_1164.all;
 
Entity pcie_x1_top_phy is
   Port (
       PowerDown : in std_logic_vector (1 downto 0) ;
       RESET_n : in std_logic ;
       RxPolarity_0 : in std_logic ;
       TxCompliance_0 : in std_logic ;
       TxDataK_0 : in std_logic_vector (0 downto 0) ;
       TxData_0 : in std_logic_vector (7 downto 0) ;
       TxDetectRx_Loopback : in std_logic ;
       TxElecIdle_0 : in std_logic ;
       ctc_disable : in std_logic ;
       flip_lanes : in std_logic ;
       hdinn0 : in std_logic ;
       hdinp0 : in std_logic ;
       phy_cfgln : in std_logic_vector (3 downto 0) ;
       phy_l0 : in std_logic ;
       pll_refclki : in std_logic ;
       rxrefclk : in std_logic ;
       sci_addr : in std_logic_vector (5 downto 0) ;
       sci_en : in std_logic ;
       sci_en_dual : in std_logic ;
       sci_rd : in std_logic ;
       sci_sel : in std_logic ;
       sci_sel_dual : in std_logic ;
       sci_wrdata : in std_logic_vector (7 downto 0) ;
       sci_wrn : in std_logic ;
       sli_rst : in std_logic ;
 
       PCLK : out std_logic;
       PCLK_by_2 : out std_logic;
       PhyStatus : out std_logic;
       RxDataK_0 : out std_logic_vector (0 downto 0);
       RxData_0 : out std_logic_vector (7 downto 0);
       RxElecIdle_0 : out std_logic;
       RxStatus_0 : out std_logic_vector (2 downto 0);
       RxValid_0 : out std_logic;
       ffs_plol : out std_logic;
       ffs_rlol_ch0 : out std_logic;
       hdoutn0 : out std_logic;
       hdoutp0 : out std_logic;
       pcie_ip_rstn : out std_logic;
       sci_int : out std_logic;
       sci_rddata : out std_logic_vector (7 downto 0);
       serdes_pdb : out std_logic;
       serdes_rst_dual_c : out std_logic;
       tx_pwrup_c : out std_logic;
       tx_serdes_rst_c : out std_logic
      );
End pcie_x1_top_phy;
 
 
Library pcie_bfm_lib;
 
Architecture Bhv of pcie_x1_top_phy is
   constant c_tie_high       : std_logic := '1';
   constant c_tie_low        : std_logic := '0';
   constant c_tie_low_bus    : std_logic_vector(15 downto 0) := (others => '0');

   signal s_refclk_n         : std_logic;
   signal s_refclk_p         : std_logic;

   Component pcs_pipe_top 
      Port (
         PowerDown : in std_logic_vector ( 1 downto 0);
         RESET_n : in std_logic;
         RxPolarity_0 : in std_logic;
         RxPolarity_1 : in std_logic := '0';
         RxPolarity_2 : in std_logic := '0';
         RxPolarity_3 : in std_logic := '0';
         TxCompliance_0 : in std_logic;
         TxCompliance_1 : in std_logic := '0';
         TxCompliance_2 : in std_logic := '0';
         TxCompliance_3 : in std_logic := '0';
         TxDataK_0 : in std_logic_vector ( 0 downto 0);
         TxDataK_1 : in std_logic_vector ( 0 downto 0) := "0";
         TxDataK_2 : in std_logic_vector ( 0 downto 0) := "0";
         TxDataK_3 : in std_logic_vector ( 0 downto 0) := "0";
         TxData_0 : in std_logic_vector ( 7 downto 0);
         TxData_1 : in std_logic_vector ( 7 downto 0) := "00000000";
         TxData_2 : in std_logic_vector ( 7 downto 0) := "00000000";
         TxData_3 : in std_logic_vector ( 7 downto 0) := "00000000";
         TxDetectRx_Loopback : in std_logic;
         TxElecIdle_0 : in std_logic;
         TxElecIdle_1 : in std_logic := '0';
         TxElecIdle_2 : in std_logic := '0';
         TxElecIdle_3 : in std_logic := '0';
         ctc_disable : in std_logic;
         ffc_quad_rst : in std_logic := '0';
         flip_lanes : in std_logic := '0';
         hdinn0 : in std_logic;
         hdinn1 : in std_logic := '0';
         hdinn2 : in std_logic := '0';
         hdinn3 : in std_logic := '0';
         hdinp0 : in std_logic;
         hdinp1 : in std_logic := '0';
         hdinp2 : in std_logic := '0';
         hdinp3 : in std_logic := '0';
         phy_cfgln : in std_logic_vector ( 3 downto 0);
         phy_l0 : in std_logic := '0';
         phy_ltssm_state : in std_logic_vector ( 3 downto 0) := (others => '0');
         refclkn : in std_logic;
         refclkp : in std_logic;
         sciaddress : in std_logic_vector ( 5 downto 0);
         scien_0 : in std_logic;
         scien_1 : in std_logic := '0';
         scien_2 : in std_logic := '0';
         scien_3 : in std_logic := '0';
         scienaux : in std_logic;
         scird : in std_logic;
         scisel_0 : in std_logic;
         scisel_1 : in std_logic := '0';
         scisel_2 : in std_logic := '0';
         scisel_3 : in std_logic := '0';
         sciselaux : in std_logic;
         sciwritedata : in std_logic_vector ( 7 downto 0);
         sciwstn : in std_logic;
         PCLK : out std_logic ;
         PCLK_by_2 : out std_logic ;
         PhyStatus : out std_logic ;
         RxDataK_0 : out std_logic_vector ( 0 downto 0) ;
         RxDataK_1 : out std_logic_vector ( 0 downto 0) ;
         RxDataK_2 : out std_logic_vector ( 0 downto 0) ;
         RxDataK_3 : out std_logic_vector ( 0 downto 0) ;
         RxData_0 : out std_logic_vector ( 7 downto 0) ;
         RxData_1 : out std_logic_vector ( 7 downto 0) ;
         RxData_2 : out std_logic_vector ( 7 downto 0) ;
         RxData_3 : out std_logic_vector ( 7 downto 0) ;
         RxElecIdle_0 : out std_logic ;
         RxElecIdle_1 : out std_logic ;
         RxElecIdle_2 : out std_logic ;
         RxElecIdle_3 : out std_logic ;
         RxStatus_0 : out std_logic_vector ( 2 downto 0) ;
         RxStatus_1 : out std_logic_vector ( 2 downto 0) ;
         RxStatus_2 : out std_logic_vector ( 2 downto 0) ;
         RxStatus_3 : out std_logic_vector ( 2 downto 0) ;
         RxValid_0 : out std_logic ;
         RxValid_1 : out std_logic ;
         RxValid_2 : out std_logic ;
         RxValid_3 : out std_logic ;
         ffs_plol : out std_logic ;
         ffs_rlol_ch0 : out std_logic ;
         hdoutn0 : out std_logic ;
         hdoutn1 : out std_logic ;
         hdoutn2 : out std_logic ;
         hdoutn3 : out std_logic ;
         hdoutp0 : out std_logic ;
         hdoutp1 : out std_logic ;
         hdoutp2 : out std_logic ;
         hdoutp3 : out std_logic ;
         pcie_ip_rstn : out std_logic ;
         scireaddata : out std_logic_vector ( 7 downto 0)
         );
   End Component;



   for all : pcs_pipe_top
       use entity pcie_bfm_lib.pcs_pipe_top(Bhv);


Begin
   U1_BFM :
   pcs_pipe_top
      Port Map (
         PowerDown => PowerDown (1 downto 0) ,
         RESET_n => RESET_n ,
         RxPolarity_0 => RxPolarity_0 ,
         RxPolarity_1 => c_tie_low ,
         RxPolarity_2 => c_tie_low ,
         RxPolarity_3 => c_tie_low ,
         TxCompliance_0 => TxCompliance_0 ,
         TxCompliance_1 => c_tie_low ,
         TxCompliance_2 => c_tie_low ,
         TxCompliance_3 => c_tie_low ,
         TxDataK_0 => TxDataK_0 (0 downto 0) ,
         TxDataK_1 => c_tie_low_bus (0 downto 0) ,
         TxDataK_2 => c_tie_low_bus (0 downto 0) ,
         TxDataK_3 => c_tie_low_bus (0 downto 0) ,
         TxData_0 => TxData_0 (7 downto 0) ,
         TxData_1 => c_tie_low_bus (7 downto 0) ,
         TxData_2 => c_tie_low_bus (7 downto 0) ,
         TxData_3 => c_tie_low_bus (7 downto 0) ,
         TxDetectRx_Loopback => TxDetectRx_Loopback ,
         TxElecIdle_0 => TxElecIdle_0 ,
         TxElecIdle_1 => c_tie_low ,
         TxElecIdle_2 => c_tie_low ,
         TxElecIdle_3 => c_tie_low ,
         ctc_disable => ctc_disable ,
         ffc_quad_rst => c_tie_low ,
         flip_lanes => flip_lanes ,
         hdinn0 => hdinn0 ,
         hdinn1 => c_tie_low ,
         hdinn2 => c_tie_low ,
         hdinn3 => c_tie_low ,
         hdinp0 => hdinp0 ,
         hdinp1 => c_tie_low ,
         hdinp2 => c_tie_low ,
         hdinp3 => c_tie_low ,
         phy_cfgln => phy_cfgln (3 downto 0) ,
         phy_l0 => phy_l0 ,
         phy_ltssm_state => c_tie_low_bus (3 downto 0) ,
         refclkn => s_refclk_n ,
         refclkp => s_refclk_p ,
         sciaddress => c_tie_low_bus (5 downto 0) ,
         scien_0 => c_tie_low ,
         scien_1 => c_tie_low ,
         scien_2 => c_tie_low ,
         scien_3 => c_tie_low ,
         scienaux => c_tie_low ,
         scird => c_tie_low ,
         scisel_0 => c_tie_low ,
         scisel_1 => c_tie_low ,
         scisel_2 => c_tie_low ,
         scisel_3 => c_tie_low ,
         sciselaux => c_tie_low ,
         sciwritedata => c_tie_low_bus (7 downto 0) ,
         sciwstn => c_tie_high ,
         PCLK => PCLK ,
         PCLK_by_2 => PCLK_by_2 ,
         PhyStatus => PhyStatus ,
         RxDataK_0 => RxDataK_0 (0 downto 0) ,
         RxDataK_1 => open ,
         RxDataK_2 => open ,
         RxDataK_3 => open ,
         RxData_0 => RxData_0 (7 downto 0) ,
         RxData_1 => open ,
         RxData_2 => open ,
         RxData_3 => open ,
         RxElecIdle_0 => RxElecIdle_0 ,
         RxElecIdle_1 => open ,
         RxElecIdle_2 => open ,
         RxElecIdle_3 => open ,
         RxStatus_0 => RxStatus_0 (2 downto 0) ,
         RxStatus_1 => open ,
         RxStatus_2 => open ,
         RxStatus_3 => open ,
         RxValid_0 => RxValid_0 ,
         RxValid_1 => open ,
         RxValid_2 => open ,
         RxValid_3 => open ,
         ffs_plol => ffs_plol ,
         ffs_rlol_ch0 => ffs_rlol_ch0 ,
         hdoutn0 => hdoutn0 ,
         hdoutn1 => open ,
         hdoutn2 => open ,
         hdoutn3 => open ,
         hdoutp0 => hdoutp0 ,
         hdoutp1 => open ,
         hdoutp2 => open ,
         hdoutp3 => open ,
         pcie_ip_rstn => pcie_ip_rstn ,
         scireaddata => open
         );

End Bhv;
