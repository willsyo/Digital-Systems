library ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity button_counter is

port (  Clk_in, ms_in, us_in, Button, Rst : in std_logic;
	RS, RW, DB7, DB6, DB5, DB4, DB3, DB2, DB1, DB0, LCD_ON, LCD_EN, debug_LED : out std_logic);
	  
end button_counter;

architecture rtl of button_counter is
type state_t is (IDLE, Function_Set, Display_Control, Clear_Display, Entry_Mode, Return_Home, Set_Addr, Write_Char);
signal state, next_state : state_t;

signal ms_cntr : unsigned(1 downto 0);
signal us_cntr : unsigned(6 downto 0);
signal next_RS, next_RW, next_DB7, next_DB6, next_DB5, next_DB4, next_DB3, next_DB2, next_DB1, next_DB0, next_LCD_ON, next_LCD_EN, next_debug_LED : std_logic;
signal RS_o, RW_o, DB7_o, DB6_o, DB5_o, DB4_o, DB3_o, DB2_o, DB1_o, DB0_o, LCD_ON_o, LCD_EN_o, debug_LED_o : std_logic;

attribute enum_encoding : string;
attribute enum_encoding of state_t : type is "sequential";

begin
    button_sm: process(state, Button, Rst, ms_in, us_in, ms_cntr, us_cntr)
    variable wait_time : unsigned(6 downto 0);
    variable addr : unsigned (7 downto 0);
    variable char : unsigned (7 downto 0);
	 variable clk_counter : integer range 0 to 200;
    variable functionFlag : integer range 0 to 5 := 0;
    begin
	case state is

	when IDLE =>
	    next_state <= FS1;

	when FS1 => --Send Function Set instruction
		 clk_counter := 0;
	    next_RS <= '0';
	    next_RW <= '0';
	    next_DB7 <= '0';
	    next_DB6 <= '0';
	    next_DB5 <= '1';
	    next_DB4 <= '1';
	    next_DB3 <= '0';
	    next_DB2 <= '0';
	    next_DB1 <= '0';
	    next_DB0 <= '0';
		 next_LCD_EN <= '1';
	    if (clk_counter = 
	    end if;
	
	when Display_Control => --
	    next_RS <= '0';
	    next_RW <= '0';
	    next_DB7 <= '0';
	    next_DB6 <= '0';
	    next_DB5 <= '0';
	    next_DB4 <= '0';
	    next_DB3 <= '1';
	    next_DB2 <= '0';
	    next_DB1 <= '0';
	    next_DB0 <= '0';
	    next_state <= Clear_Display;

	when Clear_Display => --Send clear display instruction
	    next_RS <= '0';
	    next_RW <= '0';
	    next_DB7 <= '0';
	    next_DB6 <= '0';
	    next_DB5 <= '0';
	    next_DB4 <= '0';
	    next_DB3 <= '0';
	    next_DB2 <= '0';
	    next_DB1 <= '0';
	    next_DB0 <= '1';
	    next_state <= Entry_Mode;

	when Entry_Mode =>
	    next_RS <= '0';
	    next_RW <= '0';
	    next_DB7 <= '0';
	    next_DB6 <= '0';
	    next_DB5 <= '0';
	    next_DB4 <= '0';
	    next_DB3 <= '0';
	    next_DB2 <= '1';
	    next_DB1 <= '1';
	    next_DB0 <= '0';
		 next_LCD_ON <= '1';
	    next_state <= Return_Home;

	when Return_Home =>
	    next_RS <= '0';
	    next_RW <= '0';
	    next_DB7 <= '0';
	    next_DB6 <= '0';
	    next_DB5 <= '0';
	    next_DB4 <= '0';
	    next_DB3 <= '0';
	    next_DB2 <= '1';
	    next_DB1 <= '0';
	    next_DB0 <= '1';
	    next_debug_LED <= '1';
	    addr := "00101111";
	    char := "01010110";
	    next_state <= Set_Addr;

	when Set_Addr =>
		 next_RS <= '0';
	    next_RW <= '0';
		 next_LCD_ON <= '1';
	    next_DB7 <= addr(7);
	    next_DB6 <= addr(6);
	    next_DB5 <= addr(5);
	    next_DB4 <= addr(4);
	    next_DB3 <= addr(3);
	    next_DB2 <= addr(2);
	    next_DB1 <= addr(1);
	    next_DB0 <= addr(0);
	    next_state <= Write_Char;

	when Write_Char =>
		 next_RS <= '1';
	    next_RW <= '0';
	    next_DB7 <= char(7);
	    next_DB6 <= char(6);
	    next_DB5 <= char(5);
	    next_DB4 <= char(4);
	    next_DB3 <= char(3);
	    next_DB2 <= char(2);
	    next_DB1 <= char(1);
	    next_DB0 <= char(0);
		 next_state <= Set_Addr;

	end case;
    end process button_sm;

    button_p : process(ms_in, Rst)
    variable en_cntr : integer range 0 to 2 := 0;
    begin
	if (Rst = '0') then
		state <= IDLE;
		RS_o <= '0';
	   RW_o <= '0';
	   DB7_o <= '0';
	   DB6_o <= '0';
	   DB5_o <= '0';
	   DB4_o <= '0';
	   DB3_o <= '0';
	   DB2_o <= '0';
	   DB1_o <= '0';
	   DB0_o <= '0';
		LCD_ON_o <= '0';
		LCD_EN_o <= '0';
	 	debug_LED_o <= '0';
		
	elsif (ms_in'event and ms_in = '1') then
	    en_cntr := en_cntr + 1;
	    if (en_cntr = 2) then
		en_cntr := 0;
		LCD_EN_o <= '1';
		state <= next_state;
		RS_o <= next_RS;
	    	RW_o <= next_RW;
	   	DB7_o <= next_DB7;
	   	DB6_o <= next_DB6;
	   	DB5_o <= next_DB5;
	   	DB4_o <= next_DB4;
	   	DB3_o <= next_DB3;
	   	DB2_o <= next_DB2;
	   	DB1_o <= next_DB1;
	   	DB0_o <= next_DB0;
		LCD_ON_o <= next_LCD_ON;
		LCD_EN_o <= '0';
		debug_LED_o <= next_debug_LED;
	    end if;
	end if;
    end process button_p;
	RS <= RS_o;
	RW <= RW_o;
	DB7 <= DB7_o;
	DB6 <= DB6_o;
	DB5 <= DB5_o;
	DB4 <= DB4_o;
	DB3 <= DB3_o;
	DB2 <= DB2_o;
	DB1 <= DB1_o;
	DB0 <= DB0_o;
	LCD_ON <= LCD_ON_o;
	LCD_EN <= LCD_EN_o;
	debug_LED <= debug_LED_o;
end rtl;