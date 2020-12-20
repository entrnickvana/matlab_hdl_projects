
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lfsr is
  port(
    clk       : in std_logic;
    rst       : in std_logic;
    shft_reg  : in std_logic_vector(15 downto 0);
    prog_taps : in std_logic_vector(15 downto 0);
    out_sig   : out std_logic_vector(15 downto 0));
end lsfr;

architecture behav of lfsr is
  signal feedback  : std_logic;
  signal nxt_state : std_logic_vector(15 downto 0);
  begin

    shift1 : process (clk, rst)
    begin
      if ( rst = '1' ) then
        shft_reg(0) <= (0 => '1', others => '0');
      elsif rising_edge(clk) then
        shft_reg <= nxt_state;
      end if;
    end process;

    nxt_state(13) <= shft_reg(14) xor shft_reg(0);
    nxt_state(12) <= shft_reg(13) xor shft_reg(0);
    nxt_state(10) <= shft_reg(11) xor shft_reg(0);
    nxt_state(15) <= shft_reg(0);

    out_sig <= shft_reg;
      
end  behav;

