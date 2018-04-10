library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity fifo_tb is

end fifo_tb;

architecture beh of fifo_tb is

	component fifo
		port(
			CLK : in std_logic;
			RESET : in std_logic;
			DIN : in std_logic;
			WRITE_IN : in std_logic;
			READ_IN : in std_logic;
			DOUT : out std_logic;
			EMPTY : out std_logic;
			FULL : out std_logic
			--i_o, index_o : OUT integer range 0 to 3;
			--j_o, jndex_o : OUT integer range 0 to 31
		);
	end component fifo;

--signal declaration
	signal clk_net : std_logic;
	signal rst_net : std_logic;
	signal write_net : std_logic;
	signal read_net : std_logic;
	signal din_net : std_logic;
	signal dout_net : std_logic;
	signal empty_net : std_logic;
	signal full_net : std_logic;
	--signal i_sig, index_sig : integer range 0 to 3;
	--signal j_sig, jndex_sig : integer range 0 to 31;
begin
inst_1: fifo
	port map(
		CLK => clk_net,
		RESET => rst_net,
		WRITE_IN => write_net,
		READ_IN => read_net,
		DIN => din_net,
		DOUT => dout_net,
		EMPTY => empty_net,
		FULL => full_net
		--i_o => i_sig,
		--index_o => index_sig,
		--j_o => j_sig,
		--jndex_o => jndex_sig
	);

	clk_p : process
		begin
			clk_net <= '0';
			wait for 1 ns;
			clk_net <= '1';
			wait for 1 ns;
		end process clk_p;

	data : process
		begin	
			read_net <= '0';
			write_net <= '1';
			for i in 0 to 100 loop
				din_net <= '0';
				wait for 1 ns;
				din_net <= '1';
				wait for 2 ns;
			end loop;
			read_net <= '1';
			write_net <= '0';
			wait for 72 ns;
		end process data;

	test_bench : process
		begin
			rst_net <= '0';
			wait for 1 ns;
			rst_net <= '1';
			wait for 600 ns;

			assert false
      	report "End of Simulation"
      	severity failure;

		end process test_bench;
end beh;