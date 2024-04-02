

library ieee;
--use ieee.math_complex.all;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

library work;
use work.mac_pkg.all;

entity mac is
  port( clk    : in std_logic;
        reset  : in std_logic;
        x_real : in u_sfixed(0 downto -15);
        y_real : in u_sfixed(0 downto -15);
        x_imag : in u_sfixed(0 downto -15);
        y_imag : in u_sfixed(0 downto -15);
        s_real : out u_sfixed(0 downto -15);
        s_imag : out u_sfixed(0 downto -15);
        ovf    : out std_logic
  	  );

end entity;

architecture behav of mac is
  
  --signal x_complex : complex;
  --signal y_complex : complex;  
  --signal s_complex : complex;
  signal a_re : sfixed(0 downto -15);
  signal b_re : sfixed(0 downto -15);
  signal c_re : sfixed(0 downto -31);

begin
  
  mult : process(clk, reset) is
  begin
    
    if (reset = '1') then
      a_re <= (others => '0');
      b_re <= (others => '0');
      c_re <= (others => '0');

    elsif(clk'event and clk = '1') then
      
      a_re <= x_real;
      b_re <= y_real;

      c_re <= a_re*b_re;
      s_real <= c_re(0 downto -15);

      -- If operand signs don't match and result isn't neg, overflow
      --ovf <= '1' when ((a_re(0) xor b_re(0)) and c_re(0)) = '1' else '0';
      ovf <= '1';
      
    end if;
  end process mult;
  --_complex(to_real(x_real), to_real(y_imag));
  --_complex(to_real(y_real), to_real(y_imag));  
  --
  --ehavior : process (clk) is
  -- variable input_x : complex(0.0, 0.0);
  -- variable input_y : complex(0.0, 0.0);    
  -- variable real_product_1 : complex;
  --
  --egin
  --nd process behavior;

end architecture behav;

architecture conv of mac is
  
  --signal x_complex : complex;
  --signal y_complex : complex;  
  --signal s_complex : complex;
  --signal a_re : sfixed(0 downto -15);
  --signal a_im : sfixed(0 downto -15);  
  --signal b_re : sfixed(0 downto -15);
  --signal b_im : sfixed(0 downto -15);
  signal tap1 : c_sfix;

  constant c_sfix_rst : c_sfix := (
        a_re => (others => '0'),
        a_im => (others => '0'),
        b_re => (others => '0'),
        b_im => (others => '0'),
        prod1_re => (others => '0'),
        prod1_im => (others => '0'),
        prod2_re => (others => '0'),
        prod2_im => (others => '0'),
        prod1_ovf => '0',
        prod2_ovf => '0',
        sum_re => (others => '0'),
        sum_im => (others => '0'),
        sum_ovf => '0',
        c_re => (others => '0'),
        c_im => (others => '0')
      );
  

begin

  mult : process(clk, reset) is
  begin
    
    if (reset = '1') then
      -- all zeros
      tap1 <= c_sfix_rst;
    elsif(clk'event and clk = '1') then

      tap1.a_re <= x_real;
      tap1.a_im <= x_imag;
      tap1.b_re <= y_real;
      tap1.b_im <= y_imag;

      -- Single complex multiply
      c_mult(tap1);
      s_real <= tap1.c_re;
      s_imag <= tap1.c_im;
      
            
      -- If operand signs don't match and result isn't neg, overflow
      --ovf <= '1' when ((a_re(0) xor b_re(0)) and c_re(0)) = '1' else '0';
      ovf <= '1';
      
    end if;
  end process mult;
  --_complex(to_real(x_real), to_real(y_imag));
  --_complex(to_real(y_real), to_real(y_imag));  
  --
  --ehavior : process (clk) is
  -- variable input_x : complex(0.0, 0.0);
  -- variable input_y : complex(0.0, 0.0);    
  -- variable real_product_1 : complex;
  --
  --egin
  --nd process behavior;

end architecture conv;











