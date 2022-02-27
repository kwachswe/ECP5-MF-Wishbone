--VHDL instantiation template

component xclk_subsys is
    port (pll_clk_base_CLKI: in std_logic;
        pll_clk_base_CLKOP: out std_logic;
        pll_clk_base_CLKOS: out std_logic;
        pll_clk_base_CLKOS2: out std_logic;
        pll_clk_base_LOCK: out std_logic;
        pll_clk_base_RST: in std_logic
    );
    
end component xclk_subsys; -- sbp_module=true 
_inst: xclk_subsys port map (pll_clk_base_CLKI => __,pll_clk_base_CLKOP => __,
            pll_clk_base_CLKOS => __,pll_clk_base_CLKOS2 => __,pll_clk_base_LOCK => __,
            pll_clk_base_RST => __);
