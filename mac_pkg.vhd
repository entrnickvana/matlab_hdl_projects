
library ieee;
--use ieee.math_complex.all;
use ieee.math_real.all;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

--use IEEE.std_logic_1164.all;
--use IEEE.std_logic_textio.all;
--use IEEE.std_logic_arith.all;
--use IEEE.numeric_bit.all;
--use IEEE.numeric_std.all;
library std;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;


Package mac_pkg is

  type sig_rom is array (0 to 1023) of sfixed(0 downto -15);
  type lin_vector is array(0 to 1, 0 to 1023) of real;
  type lin_vect_sfix is array(0 to 1, 0 to 1023) of sfixed(0 downto -15);
  impure function time_sig_arr(a, b, stp : real) return lin_vector;
  impure function sin_wav(a : lin_vector) return lin_vect_sfix;
  impure function sin_rom(sin_wav : sig_rom) return sig_rom;
  
  type c_sfix is record
    a_re : sfixed(0 downto -15);
    a_im : sfixed(0 downto -15);
    b_re : sfixed(0 downto -15);
    b_im : sfixed(0 downto -15);
    prod1_re : sfixed(0 downto -31);
    prod1_im : sfixed(0 downto -31);
    prod2_re : sfixed(0 downto -31);
    prod2_im : sfixed(0 downto -31);
    prod1_ovf : std_logic;    
    prod2_ovf : std_logic;    
    sum_re : sfixed(1 downto -15);
    sum_im : sfixed(1 downto -15);
    sum_ovf : std_logic;
    c_re : sfixed(0 downto -15);
    c_im : sfixed(0 downto -15);
  end record c_sfix;

  procedure c_mult(signal c : inout c_sfix);  
  
  --type  complex_mult is record
  --  a : comp_sfix(0 downto -15);
  --  prod_ab : comp_sfix(0 downto -31);
  --  sum : comp_sfix(1 downto -15);
  --  prod_ovf : std_logic;    
  --  sum_ovf : std_logic;
  --  b : comp_sfix(0 downto -15);
  --  c : comp_sfix(0 downto -31);
  --end record complex_mult;

end package mac_pkg;

package body mac_pkg is

  procedure c_mult(signal c : inout c_sfix) is
    begin
    -- real products
    c.prod1_re <= c.a_re*c.b_re;
    c.prod2_re <= c.a_im*c.b_im;

    -- real sum
    c.sum_re <= c.prod1_re - c.prod2_re;

    -- imag products  
    c.prod1_im <= c.a_re*c.b_im;
    c.prod2_im <= c.a_im*c.b_re;

    -- imag sum
    c.sum_im <= c.prod1_im + c.prod2_im;  
    
  end procedure;
  
  function dummy(sin_len : integer) return boolean is
    begin
    return true;
    
  end function dummy;


  --type sig_rom is array (0 to 1023) of sfixed(0 downto -15);
  --type lin_vector is array(0 to 1, 0 to 1023) of real;
  --type lin_vect_sfix is array(0 to 1, 0 to 1023) of sfixed(0 downto -15);  

  impure function time_sig_arr(a, b, stp : real) return lin_vector is
    variable sig1 : lin_vector;
    begin
      sig1(0, 0) := 0.0;
      for ii in 1 to 1023 loop
        sig1(0, ii) := sig1(0, ii-1) + stp;
        sig1(1, ii) := SIN(MATH_2_PI*sig1(0,ii));
      end loop;
    return sig1;
  end function time_sig_arr;

  impure function sin_wav(a : lin_vector) return lin_vect_sfix is
    variable sfix_vect : lin_vect_sfix;
    begin
      for ii in 1 to 1023 loop
        sfix_vect(0,ii) := to_sfixed(a(0,ii), 0, -15);
        sfix_vect(1,ii) := to_sfixed(a(1,ii), 0, -15);
      end loop;
    return sfix_vect;
  end function sin_wav;

  --function lin_space_real(a : real, b : real, )

  --function lin_space_real(a : real, b : real, step_sz : real, n : integer) return lin_vector is
  --  variable lin_length : integer := to_integer(floor((b-a)/step_sz));
  --  variable lin_vect : lin_vector(0 to 1023);
  --begin
  --
  --    lin_vect(0) := a;
  --    for ii in 1 to n loop
  --      lin_vect(ii) := lin_vect(ii-1) + step_size;
  --    end loop;
  --
  --end function lin_space_real;
  
  impure function sin_rom(sin_wav : sig_rom) return sig_rom is
    variable sig1 : sig_rom;
    constant aa : real := 0.0;
    begin

     for ii in 0 to 1023 loop
       sig1(ii) := to_sfixed(aa, 0, -15);
     end loop;
     return sig1;
  end function sin_rom;
  
  --function quantization_sgn(nbit : integer; max_abs : real; dval : real) return std_logic_vector is
  --variable temp    : std_logic_vector(nbit-1 downto 0):=(others=>'0');
  --constant scale   : real :=(2.0**(real(nbit-1)))/max_abs;
  --constant minq    : integer := -(2**(nbit-1));
  --constant maxq    : integer := +(2**(nbit-1))-1;
  --variable itemp   : integer := 0;
  --begin
  --  if(nbit>0) then
  --    if (dval>=0.0) then 
  --      itemp := +(integer(+dval*scale+0.49));
  --    else 
  --      itemp := -(integer(-dval*scale+0.49));
  --    end if;
  --    if(itemp<minq) then itemp := minq; end if;
  --    if(itemp>maxq) then itemp := maxq; end if;
  --  end if;
  --  temp := std_logic_vector(to_signed(itemp,nbit));
  --  return temp;
  --end quantization_sgn;    
  
  

end package body mac_pkg;
