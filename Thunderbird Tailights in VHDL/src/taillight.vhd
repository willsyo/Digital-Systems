library ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity taillight is

port (  Clk, rst, hazard, left_in, right_in : in std_logic;
        LA_o, LB_o, LC_o, RA_o, RB_o, RC_o : out std_logic
      );

end taillight;

architecture rtl of taillight is
type state_t is (hazON, hazOFF, IDLE, LA, LB, LC, LOFF, RA, RB, RC, ROFF);
signal state, next_state : state_t;
signal LA_out, LB_out, LC_out, RA_out, RB_out, RC_out, next_LA, next_LB, next_LC, next_RA, next_RB, next_RC : std_logic;

attribute enum_encoding : string;
attribute enum_encoding of state_t : type is "sequential";

begin
	taillight_sm: process(hazard, left_in, right_in, state)
	begin
	case state is

	    when IDLE => --All switches off
			  next_state <= IDLE;
	        if (hazard = '1') then
				next_state <= hazON;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			elsif (left_in = '1') then
				next_state <= LA;
				next_LA <= '1';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (right_in = '1') then
				next_state <= RA;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '1';
				next_RB <= '0';
				next_RC <= '0';
			else
				next_state <= state;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;

	    when hazON => --Hazard lights, blink ON
			next_state <= IDLE;
			if (hazard = '1') then
				next_state <= hazOFF;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (left_in = '1') then
				next_state <= LA;
				next_LA <= '1';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (right_in = '1') then
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '1';
				next_RB <= '0';
				next_RC <= '0';
			else
				next_state <= IDLE;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;

	    when hazOFF => --Hazard lights, blink OFF
			next_state <= IDLE;
			if (hazard = '1') then
				next_state <= hazON;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			else
				next_state <= IDLE;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;
		 
		when LA => --Left light, first LED ON
		next_state <= IDLE;
			if (hazard = '1') then
				next_state <= IDLE;
				next_state <= hazON;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			elsif (left_in = '1') then
				next_state <= LB;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (right_in = '1') then
				next_state <= RA;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '1';
				next_RB <= '0';
				next_RC <= '0';
			else
				next_state <= IDLE;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;
			
		when LB => --Left light, second LED ON
			next_state <= IDLE;
			if (hazard = '1') then
				next_state <= hazON;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			elsif (left_in = '1') then
				next_state <= LC;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (right_in = '1') then
				next_state <= RA;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '1';
				next_RB <= '0';
				next_RC <= '0';
			else
				next_state <= IDLE;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;
			
		when LC => --Left light, third LED ON
			next_state <= IDLE;
			if (hazard = '1') then
				next_state <= hazON;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			elsif (left_in = '1') then
				next_state <= LOFF;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (right_in = '1') then
				next_state <= RA;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '1';
				next_RB <= '0';
				next_RC <= '0';
			else
				next_state <= IDLE;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;
			
		when LOFF => --Left light, all LEDs OFF
			next_state <= IDLE;
			if (hazard = '1') then
				next_state <= hazON;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			elsif (left_in = '1') then
				next_state <= LA;
				next_LA <= '1';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (right_in = '1') then
				next_state <= RA;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '1';
				next_RB <= '0';
				next_RC <= '0';
			else
				next_state <= IDLE;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;
			
		when RA => --Right light, first LED ON
			next_state <= IDLE;
			if (hazard = '1') then
				next_state <= hazON;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			elsif (left_in = '1') then
				next_state <= LA;
				next_LA <= '1';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (right_in = '1') then
				next_state <= RB;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '0';
			else
				next_state <= IDLE;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;
			
		when RB => --Right light, second LED ON
			next_state <= IDLE;
			if (hazard = '1') then
				next_state <= hazON;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			elsif (left_in = '1') then
				next_state <= LA;
				next_LA <= '1';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (right_in = '1') then
				next_state <= RC;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			else
				next_state <= IDLE;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;
			
		when RC => --Right light, third LED ON
			next_state <= IDLE;
			if (hazard = '1') then
				next_state <= hazON;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			elsif (left_in = '1') then
				next_state <= LA;
				next_LA <= '1';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (right_in = '1') then
				next_state <= ROFF;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			else
				next_state <= IDLE;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;
			
		when ROFF => --Right light, all LEDs OFF
			next_state <= IDLE;
			if (hazard = '1') then
				next_state <= hazON;
				next_LA <= '1';
				next_LB <= '1';
				next_LC <= '1';
				next_RA <= '1';
				next_RB <= '1';
				next_RC <= '1';
			elsif (left_in = '1') then
				next_state <= LA;
				next_LA <= '1';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			elsif (right_in = '1') then
				next_state <= RA;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '1';
				next_RB <= '0';
				next_RC <= '0';
			else
				next_state <= IDLE;
				next_LA <= '0';
				next_LB <= '0';
				next_LC <= '0';
				next_RA <= '0';
				next_RB <= '0';
				next_RC <= '0';
			end if;
		 
	    when others =>
		   next_state <= IDLE;
			next_LA <= '0';
			next_LB <= '0';
			next_LC <= '0';
			next_RA <= '0';
			next_RB <= '0';
			next_RC <= '0';

	end case;
	end process;

	taillight_p: process(Clk, rst)
	begin
	    if (rst = '0') then
		    state <= IDLE;
		    LA_out <= '0';
		    LB_out <= '0';
		    LC_out <= '0';
		    RA_out <= '0';
		    RB_out <= '0';
		    RC_out <= '0';
	    elsif (Clk = '1' and Clk'event) then
		    state <= next_state;
		    LA_out <= next_LA;
		    LB_out <= next_LB;
		    LC_out <= next_LC;
		    RA_out <= next_RA;
		    RB_out <= next_RB;
		    RC_out <= next_RC;
	    end if;
	end process;

	LA_o <= LA_out;
	LB_o <= LB_out;
	LC_o <= LC_out;
	RA_o <= RA_out;
	RB_o <= RB_out;
	RC_o <= RC_out;

end rtl;
