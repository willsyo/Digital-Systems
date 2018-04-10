library ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sr_latch is

port (  S, R : IN std_logic;
	Q, nQ : OUT std_logic);
	  
end sr_latch;

architecture rtl of sr_latch is
signal Q_net, nQ_net : std_logic;
begin
	sr_latch_p: process(S, R)
	begin
		Q_net <= S nand nQ_net;
		nQ_net <= R nand Q_net;
	end process sr_latch_p;
	Q <= Q_net;
	nQ <= nQ_net;
end rtl;

