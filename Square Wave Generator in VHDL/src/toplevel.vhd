library ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity toplevel is 
	port( Clk, Clk_in, ms_in, us_in, Button, Rst : in std_logic;
	      RS, RW, DB7, DB6, DB5, DB4, DB3, DB2, DB1, DB0, LCD_ON, LCD_EN, debug_LED : out std_logic);
end toplevel;

architecture rtl of toplevel is

component counter

port( Clk : in std_logic;
      Rst : in std_logic;
      sec_out, ms_out, us_out : out std_logic
     );

end component counter;

component button_counter is

port (  Clk_in, ms_in, us_in, Button, Rst : in std_logic;
	RS, RW, DB7, DB6, DB5, DB4, DB3, DB2, DB1, DB0, LCD_ON, LCD_EN, debug_LED : out std_logic);

end component button_counter;

signal sec_net: std_logic;
signal ms_net: std_logic;
signal us_net: std_logic;

begin
	counter_inst : counter port map ( Clk => Clk,
					  Rst => rst,
					  sec_out => sec_net,
					  ms_out => ms_net,
					  us_out => us_net
					);

	button_counter_inst : button_counter port map ( Button => Button,
							Rst => Rst,
							Clk_in => sec_net,
							ms_in => ms_net,
							us_in => us_net,
							RS => RS, 
 							RW => RW, 
							DB7 => DB7, 
							DB6 => DB6, 
							DB5 => DB5, 
							DB4 => DB4, 
							DB3 => DB3, 
							DB2 => DB2, 
							DB1 => DB1, 
							DB0 => DB0, 
							LCD_ON => LCD_ON, 
							LCD_EN => LCD_EN, 
							debug_LED => debug_LED
					    	      );
end rtl;
