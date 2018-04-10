library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity counter_tb is
end counter_tb;

architecture beh of counter_tb is

signal Clk_sig : std_logic;
signal Rst_sig : std_logic;
signal Clk_out_sig : std_logic;

component counter

port(Clk : in std_logic;
     Rst : in std_logic;
     Clk_out : out std_logic);

end component counter;

begin
counter_inst: counter port map(
Clk => Clk_sig,
Rst => Rst_sig,
Clk_out => Clk_out_sig
);

tb: process
  begin
	Clk_sig <= '0';
	Clk_sig <= '1';
	Rst_sig <= '1';
	wait for 1 ns;
	Rst_sig <= '0';

	for i in 0 to 5000 loop
		Clk_sig <= '0';
		wait for 1 ns;
		Clk_sig <= '1';
		wait for 1 ns;
	end loop;
	
	assert false
	report "End of Testbench"
	severity failure;

end process tb;

end beh;
