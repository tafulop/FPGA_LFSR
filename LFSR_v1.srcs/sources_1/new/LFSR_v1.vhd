----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2015 03:39:17 PM
-- Design Name: 
-- Module Name: LFSR_v1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LFSR_v1 is

    Generic (width : integer := 63);

    Port ( 
           enable   : in    std_logic;
           reset    : in    std_logic;
           i_load   : in    std_logic;
           clk      : in    std_logic;
           o_number : out   unsigned (width -1 downto 0);
           i_seed   : in    unsigned (width -1 downto 0)      );
end LFSR_v1;



architecture Behavioral of LFSR_v1 is

signal internal_number : unsigned(width -1 downto 0);
signal feedback     :   std_logic;

    
begin

    next_number : process(clk, reset)
        
        begin 
        
            if rising_edge(clk) then      
                
                -- run only if enable set to 1
                if (enable = '1') then
                    
                    -- reset handling
                    if(reset = '0') then
                    
                        -- loading the seed
                        if(i_load = '1') then
                            internal_number <= i_seed;
                        else
                            -- create the next random number
                            internal_number <= internal_number(width - 2 downto 0) & (internal_number(62) xnor internal_number(61)); 
                             
                        end if;
                    elsif (enable = '1') then
                        -- reset internal number to
                        internal_number <= (OTHERS => '1');                     
                    end if;
                    
                    o_number <= internal_number; 
                    
                end if;
                
            end if;
            
        end process next_number;

end Behavioral;
