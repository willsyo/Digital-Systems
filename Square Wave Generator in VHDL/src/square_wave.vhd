
library ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity square_wave is

port (  H, L: IN unsigned(3 downto 0);
	CLK, RST: IN std_logic;
	WAVE: OUT std_logic);
	  
end square_wave;

architecture rtl of square_wave is

begin
	square_wave_p: process
	begin

	end process square_wave_p;
end rtl;