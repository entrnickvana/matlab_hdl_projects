

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

architecture complex_mult of mac is
  
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
        prod_re_ovf => '0',
        prod_im_ovf => '0',
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

end architecture complex_mult;

architecture conv of mac is
  
  --signal x_complex : complex;
  --signal y_complex : complex;  
  --signal s_complex : complex;
  --signal a_re : sfixed(0 downto -15);
  --signal a_im : sfixed(0 downto -15);  
  --signal b_re : sfixed(0 downto -15);
  --signal b_im : sfixed(0 downto -15);
  type fir is array(0 to 32) of c_sfix;
  type s1 is array(0 to 7) of sfixed(3 downto -15);
  type s2 is array(0 to 1) of sfixed(3 downto -15);  

  type sum_pipe is record
    stage1 : s1;
    stage2 : s2;
  end record sum_pipe;
  
  --type taps is array(0 to 32) of sfixed;
  signal filt : fir;
  --signal tap1 : c_sfix;

  constant c_sfix_rst : c_sfix := (
        a_re => (others => '0'),
        a_im => (others => '0'),
        b_re => (others => '0'),
        b_im => (others => '0'),
        prod1_re => (others => '0'),
        prod1_im => (others => '0'),
        prod2_re => (others => '0'),
        prod2_im => (others => '0'),
        prod_re_ovf => '0',
        prod_im_ovf => '0',
        sum_re => (others => '0'),
        sum_im => (others => '0'),
        sum_ovf => '0',
        c_re => (others => '0'),
        c_im => (others => '0')
      );

  type fir_taps is array(0 to 32) of sfixed(0 downto -15);
  constant half_sinc_filt : fir_taps  := (
     0 => to_sfixed(-0.0000, 0, -15),
     1 => to_sfixed(-0.0325, 0, -15),
     2 => to_sfixed(-0.0643, 0, -15),
     3 => to_sfixed(-0.0905, 0, -15),
     4 => to_sfixed(-0.1061, 0, -15),
     5 => to_sfixed(-0.1069, 0, -15),
     6 => to_sfixed(-0.0900, 0, -15),
     7 => to_sfixed(-0.0541, 0, -15),
     8 => to_sfixed( 0.0000, 0, -15),
     9 => to_sfixed( 0.0696, 0, -15),
    10 => to_sfixed( 0.1501, 0, -15),
    11 => to_sfixed( 0.2353, 0, -15),
    12 => to_sfixed( 0.3183, 0, -15),
    13 => to_sfixed( 0.3921, 0, -15),
    14 => to_sfixed( 0.4502, 0, -15),
    15 => to_sfixed( 0.4872, 0, -15),
    16 => to_sfixed( 0.5000, 0, -15),
    17 => to_sfixed( 0.4872, 0, -15),
    18 => to_sfixed( 0.4502, 0, -15),
    19 => to_sfixed( 0.3921, 0, -15),
    20 => to_sfixed( 0.3183, 0, -15),
    21 => to_sfixed( 0.2353, 0, -15),
    22 => to_sfixed( 0.1501, 0, -15),
    23 => to_sfixed( 0.0696, 0, -15),
    24 => to_sfixed( 0.0000, 0, -15),
    25 => to_sfixed(-0.0541, 0, -15),
    26 => to_sfixed(-0.0900, 0, -15),
    27 => to_sfixed(-0.1069, 0, -15),
    28 => to_sfixed(-0.1061, 0, -15),
    29 => to_sfixed(-0.0905, 0, -15),
    30 => to_sfixed(-0.0643, 0, -15),
    31 => to_sfixed(-0.0325, 0, -15),
    32 => to_sfixed(-0.0000, 0, -15)
  );                  
  
  constant sinc_filt : fir_taps := (
     0 =>  to_sfixed(-0.0000, 0, -15),
     1 =>  to_sfixed(-0.0650, 0, -15),
     2 =>  to_sfixed(-0.1286, 0, -15),
     3 =>  to_sfixed(-0.1810, 0, -15),
     4 =>  to_sfixed(-0.2122, 0, -15),
     5 =>  to_sfixed(-0.2139, 0, -15),
     6 =>  to_sfixed(-0.1801, 0, -15),
     7 =>  to_sfixed(-0.1083, 0, -15),
     8 =>  to_sfixed( 0.0000, 0, -15),
     9 =>  to_sfixed( 0.1392, 0, -15),
    10 =>  to_sfixed( 0.3001, 0, -15),
    11 =>  to_sfixed( 0.4705, 0, -15),
    12 =>  to_sfixed( 0.6366, 0, -15),
    13 =>  to_sfixed( 0.7842, 0, -15),
    14 =>  to_sfixed( 0.9003, 0, -15),
    15 =>  to_sfixed( 0.9745, 0, -15),
    16 =>  to_sfixed( 1.0000, 0, -15),
    17 =>  to_sfixed( 0.9745, 0, -15),
    18 =>  to_sfixed( 0.9003, 0, -15),
    19 =>  to_sfixed( 0.7842, 0, -15),
    20 =>  to_sfixed( 0.6366, 0, -15),
    21 =>  to_sfixed( 0.4705, 0, -15),
    22 =>  to_sfixed( 0.3001, 0, -15),
    23 =>  to_sfixed( 0.1392, 0, -15),
    24 =>  to_sfixed( 0.0000, 0, -15),
    25 =>  to_sfixed(-0.1083, 0, -15),
    26 =>  to_sfixed(-0.1801, 0, -15),
    27 =>  to_sfixed(-0.2139, 0, -15),
    28 =>  to_sfixed(-0.2122, 0, -15),
    29 =>  to_sfixed(-0.1810, 0, -15),
    30 =>  to_sfixed(-0.1286, 0, -15),
    31 =>  to_sfixed(-0.0650, 0, -15),
    32 =>  to_sfixed(-0.000, 0, -15)
  );

  signal b_taps_re : fir_taps := half_sinc_filt;
  signal b_taps_im : fir_taps := half_sinc_filt;

begin

  mult : process(clk, reset) is
    --variable b_taps_re : fir_taps := half_sinc_filt;
    --variable b_taps_im : fir_taps := half_sinc_filt;
    variable sum_pipe_re : sum_pipe;
    variable sum_pipe_im : sum_pipe;    
  begin
    
    if (reset = '1') then
      -- all zeros
      filt <= (others => c_sfix_rst);
    elsif(clk'event and clk = '1') then

      filt(0).a_re <= x_real;
      filt(0).a_im <= x_imag;

      filt(0).b_re <= b_taps_re(0);
      --filt(0).b_im <= b_taps_im(0);
      filt(0).b_im <= to_sfixed(0.0, 0, -15);

      for ii in 1 to 32 loop

        -- a taps are input signal and shift
        filt(ii).a_re <= filt(ii-1).a_re;
        filt(ii).a_im <= filt(ii-1).a_im;

        -- b taps 
        filt(ii).b_re <= b_taps_re(ii);
        filt(ii).b_im <= to_sfixed(0.0, 0, -15);        
        --filt(ii).b_im <= b_taps_im(ii);

        
      end loop;

      c_mult(filt( 0));
      c_mult(filt( 1));
      c_mult(filt( 2));
      c_mult(filt( 3));
      c_mult(filt( 4));
      c_mult(filt( 5));
      c_mult(filt( 6));
      c_mult(filt( 7));
      c_mult(filt( 8));
      c_mult(filt( 9));
      c_mult(filt(10));
      c_mult(filt(11));
      c_mult(filt(12));
      c_mult(filt(13));
      c_mult(filt(14));
      c_mult(filt(15));
      c_mult(filt(16));
      c_mult(filt(17));
      c_mult(filt(18));
      c_mult(filt(19));
      c_mult(filt(20));
      c_mult(filt(21));
      c_mult(filt(22));
      c_mult(filt(23));
      c_mult(filt(24));
      c_mult(filt(25));
      c_mult(filt(26));
      c_mult(filt(27));
      c_mult(filt(28));
      c_mult(filt(29));
      c_mult(filt(30));
      c_mult(filt(31));
      c_mult(filt(32));



      for kk in 0 to 7 loop

        -- Stage 1 sum pipeline, 33 -> 8
        if (kk = 7) then
          --sum_pipe_re.stage1(kk) :=   filt(kk).c_re   + filt(kk+1).c_re
          --                          + filt(kk+2).c_re + filt(kk+3).c_re + filt(kk+4).c_re;
          
          sum_pipe_re.stage1(kk) :=   filt(kk).c_re   + filt(kk+1).c_re
                                    + filt(kk+2).c_re + filt(kk+3).c_re;

          --sum_pipe_im.stage1(kk) :=   filt(kk).c_im   + filt(kk+1).c_im
          --                          + filt(kk+2).c_im + filt(kk+3).c_im + filt(kk+4).c_im;
          
          sum_pipe_im.stage1(kk) :=   filt(kk).c_im   + filt(kk+1).c_im
                                    + filt(kk+2).c_im + filt(kk+3).c_im;
          
        else
          sum_pipe_re.stage1(kk) :=   filt(kk).c_re   + filt(kk+1).c_re
                                    + filt(kk+2).c_re + filt(kk+3).c_re;

          sum_pipe_re.stage1(kk)  :=  filt(kk).c_im   + filt(kk+1).c_im
                                    + filt(kk+2).c_im + filt(kk+3).c_im;
          
        end if;
                                      
        -- stage 2 sum pipeline, 8 -> 2                              
        if(kk < 2) then
          
          sum_pipe_re.stage2(kk) :=     sum_pipe_re.stage1(kk)(0 downto -15)   + sum_pipe_re.stage1(kk+1)(0 downto -15)
                                      + sum_pipe_re.stage1(kk+2)(0 downto -15) + sum_pipe_re.stage1(kk+3)(0 downto -15);
          
          sum_pipe_im.stage2(kk) :=     sum_pipe_im.stage1(kk)(0 downto -15)   + sum_pipe_im.stage1(kk+1)(0 downto -15)
                                      + sum_pipe_im.stage1(kk+2)(0 downto -15) + sum_pipe_im.stage1(kk+3)(0 downto -15);
         
        end if;

      end loop;

      -- stage 3 sum pipelin, 2 -> 1
      s_real <= sum_pipe_re.stage2(0)(-1 downto -15) + sum_pipe_re.stage2(1)(-1 downto -15);
      s_imag <= sum_pipe_im.stage2(0)(-1 downto -15) + sum_pipe_im.stage2(1)(-1 downto -15);
        
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











