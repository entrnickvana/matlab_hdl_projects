

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.math_complex.all;

entity vit_enc is
generic (
  rate : real := 0.5);
port (
  clk : in std_logic;
  rst : in std_logic;
  data_i : in std_logic;
  data_o : out std_logic_vector(1 downto 0));
  
end entity vit_enc;

architecture behav of vit_enc is

  signal st : std_logic_vector(1 downto 0);
  begin

  conv_enc: process (clk) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        data_o <= (others => '0');
        st     <= (others => '0');
      else
        st(1 downto 0) <= st(1) & data_i;
        data_o(0)      <= (st(1) xor st(0)) xor data_i;
        data_o(1)      <= st(1) xor data_i;        
      end if;
    end if;
  end process conv_enc;

end architecture behav;
