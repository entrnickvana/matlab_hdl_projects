-------------------------------------------------------------------------------
-- Title      : Testbench for design "mac"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : mac_tb.vhd
-- Author     :   <Nicholas@DESKTOP-L73B000>
-- Company    : 
-- Created    : 2024-04-01
-- Last update: 2024-04-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-04-01  1.0      Nicholas	Created
-------------------------------------------------------------------------------

library ieee;
--use ieee.math_complex.all;
use ieee.math_real.all;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;
library work;
use work.mac_pkg.all;

-------------------------------------------------------------------------------

entity mac_tb is

end entity mac_tb;

-------------------------------------------------------------------------------

architecture tb of mac_tb is

  -- component ports
  signal clk    : std_logic := '0';
  signal reset  : std_logic := '0';
  signal x_real : u_sfixed(0 downto -15);
  signal y_real : u_sfixed(0 downto -15);
  signal x_imag : u_sfixed(0 downto -15);
  signal y_imag : u_sfixed(0 downto -15);
  signal s_real : u_sfixed(0 downto -15);
  signal s_imag : u_sfixed(0 downto -15);
  signal ovf    : std_logic;


begin  -- architecture tb

  -- component instantiation
  DUT: entity work.mac(conv)
    port map (
      clk    => clk,
      reset  => reset,
      x_real => x_real,
      y_real => y_real,
      x_imag => x_imag,
      y_imag => y_imag,
      s_real => s_real,
      s_imag => s_imag,
      ovf    => ovf);

  -- clock generation
  clk <= not clk after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
    variable x_re_in : u_sfixed(0 downto -15);
    variable y_re_in : u_sfixed(0 downto -15);
    variable sig1 : lin_vector := time_sig_arr(0.0, 12.0*3.14, 0.02653);
    variable sig1_sfix : lin_vect_sfix := sin_wav(sig1);
    variable pulse : integer := 0;
    variable mod16_ii : integer := 0;
    type pulse_arr is array(0 to 15) of real;
    variable cnt : integer := 0;
    variable sym_arr : pulse_arr := (
         0 => 1.0,
         1 => 1.0,
         2 => 1.0,
         3 => 1.0,
         4 => -1.0,
         5 => 1.0,
         6 => 1.0,
         7 => 1.0,
         8 => 1.0,
         9 => -1.0,
        10 => 1.0,
        11 => 1.0,
        12 => -1.0,
        13 => -1.0,
        14 => 1.0,
        15 => 1.0
      );
      

  begin

    wait for 33 ns;
    reset <= '0';
    wait for 33 ns;
    reset <= '1';
    wait for 33 ns;
    reset <= '0';
    --wait for 1 ns; -- 100 ns in
    --wait for 200 ns;
      

    for ii in 1 to 4096 loop

      -- Sin wave
      --x_real <= sig1_sfix(1, ii);
      mod16_ii := ii mod 16;

      if (ii mod 8) = 0 then
        cnt := 0 when (cnt = 15) else cnt + 1;          
      end if;
        
      if (ii = 0) then
        cnt := 0;
      end if;

      -- Data impulses
      x_real <= to_sfixed(sym_arr(cnt), 0, -15) when (ii mod 8) = 0 else to_sfixed(0.0, 0, -15);
      x_imag <= to_sfixed(0.0, 0, -15);
      
      y_real <= to_sfixed(0.0, 0, -15);
      y_imag <= to_sfixed(0.0, 0, -15);        
      --if (ii mod 256) > 128 then
      --  y_real <= to_sfixed(1.0, 0, -15);
      --end if;
       
      wait for 10 ns;
    end loop;
    -- insert signal assignments here

    wait until clk = '1';
  end process WaveGen_Proc;

  

end architecture tb;

-------------------------------------------------------------------------------

configuration mac_tb_tb_cfg of mac_tb is
  for tb
  end for;
end mac_tb_tb_cfg;

-------------------------------------------------------------------------------
