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

    signal clk     : std_logic;
    signal i_load   : std_logic;
    signal o_number : unsigned(7 downto 0);
    signal i_seed : unsigned(7 downto 0);
    

    ------------------------------------------------------------------------------
    -- Component Declarations
    ------------------------------------------------------------------------------

    component LFSR_v1
        port (
            i_load : std_logic;
            clk : in std_logic;
            o_number : out   unsigned (7 downto 0);
            i_seed   : in    unsigned (7 downto 0)
        
        );
    end component LFSR_v1;


begin


    ------------------------------------------------------------------------------
    --  Instance
    ------------------------------------------------------------------------------
    inst_LFSR_v1 : LFSR_v1
    port map (
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
        i_load <= '1';
        i_seed <= X"02";
        wait for 20 ns;
        
        i_load <= '0';
        wait for 20 ns;
        
        i_load <= '0';
        wait for 20 ns;

        report "End of simulation.";
        wait;
    end process proc_stimulus;


end behavioral;