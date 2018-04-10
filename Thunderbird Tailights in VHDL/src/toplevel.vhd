library ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity toplevel is 
	port( Clk, rst, hazard, left_in, right_in : in std_logic;
	      LA_o, LB_o, LC_o, RA_o, RB_o, RC_o : out std_logic);
end toplevel;

architecture rtl of toplevel is

component counter

port( Clk : in std_logic;
      Rst : in std_logic;
      Clk_out : out std_logic
     );

end component counter;

component taillight

port (  Clk, rst, hazard, left_in, right_in : in std_logic;
		LA_o, LB_o, LC_o, RA_o, RB_o, RC_o : out std_logic
      );

end component taillight;

signal clk_net: std_logic;

begin
	counter_inst : counter port map ( Clk => Clk,
									  Rst => rst,
									  Clk_out => clk_net
									);

	taillight_inst : taillight port map ( Clk => clk_net,
										  rst => rst,
										  hazard => hazard,
										  left_in => left_in,
										  right_in => right_in,
										  LA_o => LA_o,
										  LB_o => LB_o,
										  LC_o => LC_o,
										  RA_o => RA_o,
										  RB_o => RB_o,
										  RC_o => RC_o
										);
end rtl;