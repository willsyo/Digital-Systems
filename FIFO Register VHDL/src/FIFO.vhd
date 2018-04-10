library ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FIFO is

port (	WRITE_in, READ_in, DIN, CLK, RESET : IN std_logic;
	DOUT, EMPTY, FULL : OUT std_logic);
	--i_o, index_o : OUT integer range 0 to 3;
	--j_o, jndex_o : OUT integer range 0 to 31);
	type dword_array_t is array(3 downto 0) of std_logic_vector(31 downto 0);
end FIFO;

architecture rtl of FIFO is
signal reg: dword_array_t;
signal fFlag, eFlag : std_logic;
begin
	FIFO_p: process (CLK, RESET, WRITE_in, READ_in)
	variable i, i_index : integer range 0 to 3 := 3;
	variable j, j_index : integer range 0 to 31 := 31;
	begin

	    if (RESET = '0') then
		reg <= ((others => '0') , (others => '0'), (others => '0'), (others => '0'));
		eFlag <= '1'; fFlag <= '0'; DOUT <= '0'; i := 3; i_index := 3; j := 31; j_index := 31;
	    elsif (CLK'event and CLK = '1') then

		if (WRITE_in = '1' and fFlag = '0') then
		    eFlag <= '0';
		    reg(i)(j) <= DIN;

		    if (i = 0 and j = 0) then
			fFlag <= '1';
		    elsif (j = 0) then
			i := i - 1; j := 31;
		    else
			j := j - 1;
		    end if;
		    
		elsif (READ_in = '1' and eFlag = '0') then
		    
		    if (i_index >= i) then
			DOUT <= reg(i_index)(j_index);
			
			if (i_index = 0 and j_index = 0) then
			    eFlag <= '1';
			elsif (j_index = 0) then
			    i_index := i_index - 1; j_index := 31;
			else
			    j_index := j_index - 1;
			end if;
			
		    end if;
		
		end if;

	    end if;
	--i_o <= i; j_o <= j;
	--index_o <= i_index; jndex_o <= j_index;
	end process FIFO_p;
	EMPTY <= eFlag;
	FULL <= fFlag;

end rtl;
