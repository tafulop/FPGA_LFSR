library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


----------------------------------------------------------------------------------


entity testbench is

end testbench;


----------------------------------------------------------------------------------


architecture behavioral of testbench is


    ------------------------------------------------------------------------------
    -- Constant Declarations
    ------------------------------------------------------------------------------

    -- Simulation clock period
    constant clk_period                 : time     := 10 ns;


    ------------------------------------------------------------------------------
    -- Signal Declarations
    ------------------------------------------------------------------------------

    signal enable   : std_logic;
    signal reset    : std_logic;
    signal clk      : std_logic;
    signal i_load   : std_logic;
    signal o_number : unsigned(6 downto 0);
    signal i_seed   : unsigned(6 downto 0);
    

    ------------------------------------------------------------------------------
    -- Component Declarations
    ------------------------------------------------------------------------------

    component LFSR_v1
        port (
            enable  :   std_logic;
            reset   :   std_logic;
            i_load  :   std_logic;
            clk     :   in    std_logic;
            o_number:   out   unsigned (6 downto 0);
            i_seed  :   in    unsigned (6 downto 0)
        
        );
    end component LFSR_v1;


begin


    ------------------------------------------------------------------------------
    --  Instance
    ------------------------------------------------------------------------------
    inst_LFSR_v1 : LFSR_v1
    port map (
        enable => enable,
        reset => reset,
        i_load => i_load,
        clk => clk,
        o_number => o_number,
        i_seed => i_seed
    );
    
   

    ------------------------------------------------------------------------------
    --  Clock generator
    --
    --  Process
    ------------------------------------------------------------------------------
    proc_clk_gen : process
    begin
        clk <= '0'; wait for clk_period / 2;
        clk <= '1'; wait for clk_period / 2;
    end process proc_clk_gen;


    ------------------------------------------------------------------------------
    --  Stimulus
    --
    --  Process
    ------------------------------------------------------------------------------
    proc_stimulus: process
    begin
    
        -- normal counting fom seed : 1
        enable  <=  '1';
        i_load  <=  '1';
        reset   <=  '0';
        i_seed  <=  B"0000001";
        wait for 10 us;      
        
        i_load <= '0';
        wait for 10 ms;
        
        -- reset
        reset <= '1';
        wait for 10 ms;
        reset <= '0';
        wait for 10 ms;
        
        
        -- load another seed : 0
        i_load <= '1';
        i_seed <= B"0000_000";
        wait for 20 ns;
        i_load <= '0';
        wait for 10 ms;
        
        -- disable test
        enable  <=  '0';
        wait for 10 ms;

        report "End of simulation.";
        wait;
    end process proc_stimulus;


end behavioral;