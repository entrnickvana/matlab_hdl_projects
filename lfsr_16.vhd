
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lfsr_16 is

  port(
    clk       : in std_logic;
    rst       : in std_logic;
    shft_reg  : in std_logic_vector(15 downto 0);
    prog_taps : in std_logic_vector(15 downto 0);
    out_sig   : out std_logic_vector(15 downto 0));

end lfsr_16;


architecture behav of lfsr_16 is

  --signal feedback  : std_logic;
  signal nxt_state : std_logic_vector(15 downto 0);
  signal shft_reg_int : std_logic_vector(15 downto 0);

  begin

    shift1 : process (clk, rst)
    begin
      if ( rst = '1' ) then
        shft_reg_int <= shft_reg;
      elsif ( rising_edge(clk) ) then
        shft_reg_int <= nxt_state;
      end if;        
    end process;
    

    nxt_state(0)  <= shft_reg_int(1);
    nxt_state(1)  <= shft_reg_int(2);
    nxt_state(2)  <= shft_reg_int(3);
    nxt_state(3)  <= shft_reg_int(4);
    nxt_state(4)  <= shft_reg_int(5);
    nxt_state(5)  <= shft_reg_int(6);
    nxt_state(6)  <= shft_reg_int(7);
    nxt_state(7)  <= shft_reg_int(8);
    nxt_state(8)  <= shft_reg_int(9);
    nxt_state(9)  <= shft_reg_int(10);
    --nxt_state(10) <= shft_reg_int(11);
    nxt_state(11) <= shft_reg_int(12);
    --nxt_state(12) <= shft_reg_int(13);
    --nxt_state(13) <= shft_reg_int(14);
    nxt_state(14) <= shft_reg_int(15);
    --nxt_state(15) <= shft_reg_int(0);

    nxt_state(10) <= shft_reg_int(11) xor shft_reg_int(0);
    nxt_state(12) <= shft_reg_int(13) xor shft_reg_int(0);
    nxt_state(13) <= shft_reg_int(14) xor shft_reg_int(0);    
    nxt_state(15) <= shft_reg_int(0);

    out_sig <= shft_reg_int;      

end  behav;

