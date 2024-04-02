

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lfsr is
  port(
    clk        : in std_logic;
    rst        : in std_logic;
    prog_valid : in std_logic;
    poly_taps  : in std_logic_vector(15 downto 0);
    init_seed  : in std_logic_vector(15 downto 0);
    out_stream : out std_logic);
       
end entity lfsr;

architecture behav of lfsr is

  signal shift_reg       : std_logic_vector(15 downto 0);
  signal shift_reg_next  : std_logic_vector(15 downto 0);  
  signal poly_taps_reg   : std_logic_vector(15 downto 0);
  signal init_seed_reg   : std_logic_vector(15 downto 0);
  
  begin 

  gen_prbs : process(clk, rst)
  begin
    if(rst = '1') then
      
      shift_reg <= (others => '0');
      poly_taps_reg <= (others => '0');
      init_seed_reg <= (others => '0');
      out_stream <= '0';
      
    elsif clk'event and clk = '1' then

      out_stream <= shift_reg(0);

      shift_reg <= shift_reg_next;
      poly_taps_reg <= poly_taps_reg;
      init_seed_reg <= init_seed_reg;                                                                   

      --Program Polynomial
      if (prog_valid = '1') then
         poly_taps_reg <= poly_taps;
         init_seed_reg <= init_seed;
         shift_reg <= init_seed;
      end if;
        
    end if;
    
  end process;

  shift_reg_next(0)   <= shift_reg(1)  when poly_taps_reg(0)  = '0' else shift_reg(1) xor shift_reg(0);
  shift_reg_next(1)   <= shift_reg(2)  when poly_taps_reg(1)  = '0' else shift_reg(2) xor shift_reg(0);
  shift_reg_next(2)   <= shift_reg(3)  when poly_taps_reg(2)  = '0' else shift_reg(3) xor shift_reg(0);
  shift_reg_next(3)   <= shift_reg(4)  when poly_taps_reg(3)  = '0' else shift_reg(4) xor shift_reg(0);
  shift_reg_next(4)   <= shift_reg(5)  when poly_taps_reg(4)  = '0' else shift_reg(5) xor shift_reg(0);
  shift_reg_next(5)   <= shift_reg(6)  when poly_taps_reg(5)  = '0' else shift_reg(6) xor shift_reg(0);
  shift_reg_next(6)   <= shift_reg(7)  when poly_taps_reg(6)  = '0' else shift_reg(7) xor shift_reg(0);
  shift_reg_next(7)   <= shift_reg(8)  when poly_taps_reg(7)  = '0' else shift_reg(8) xor shift_reg(0);
  shift_reg_next(8)   <= shift_reg(9)  when poly_taps_reg(8)  = '0' else shift_reg(9) xor shift_reg(0);
  shift_reg_next(9)   <= shift_reg(10) when poly_taps_reg(9)  = '0' else shift_reg(9) xor shift_reg(0);
  shift_reg_next(10)  <= shift_reg(11) when poly_taps_reg(10) = '0' else shift_reg(9) xor shift_reg(0);
  shift_reg_next(11)  <= shift_reg(12) when poly_taps_reg(11) = '0' else shift_reg(9) xor shift_reg(0);
  shift_reg_next(12)  <= shift_reg(13) when poly_taps_reg(12) = '0' else shift_reg(9) xor shift_reg(0);
  shift_reg_next(13)  <= shift_reg(14) when poly_taps_reg(13) = '0' else shift_reg(9) xor shift_reg(0);
  shift_reg_next(14)  <= shift_reg(15) when poly_taps_reg(14) = '0' else shift_reg(9) xor shift_reg(0);
  shift_reg_next(15)  <= shift_reg(0);


  --shift_reg_next(15)  <= shift_reg(0)  when poly_taps_reg(15) = '0' else shift_reg(9) xor shift_reg(0);
  

end architecture behav;


