library ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is

port (Clk : in std_logic;
      Rst : in std_logic;
      Clk_out : out std_logic);
	  
end counter;

architecture rtl of counter is
signal clk_cntr : unsigned(25 downto 0);

begin
	counter_p: process(Clk, Rst)
	begin
		if (Rst = '0') then
		    clk_cntr <= (others => '0');
		elsif (Clk'event and Clk = '1') then
		    clk_cntr <= clk_cntr + 1;
		    if (clk_cntr = 50000000) then
			    clk_cntr <= (others => '0');
		    end if;
		end if;
	end process counter_p;
	Clk_out <= clk_cntr(25);
end rtl;
