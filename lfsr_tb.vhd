
library ieee;
use ieee.std_logic_1164.all;

architecture tb of lfsr_tb is

  -- component ports
  signal clk        : std_logic;
  signal rst        : std_logic;
  signal prog_valid : std_logic;
  signal poly_taps  : std_logic_vector(15 downto 0);
  signal init_seed  : std_logic_vector(15 downto 0);
  signal out_stream : std_logic_vector(15 downto 0); 

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture tb

  -- component instantiation
  DUT: entity work.lfsr
    port map (
      clk        => clk,
      rst        => rst,
      prog_valid => prog_valid,
      poly_taps  => poly_taps,
      init_seed  => init_seed,
      out_stream => out_stream);

  -- clock generation
  clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here

    wait until Clk = '1';
  end process WaveGen_Proc;

  

end architecture tb;

-------------------------------------------------------------------------------

configuration lfsr_tb_tb_cfg of lfsr_tb is
  for tb
  end for;
end lfsr_tb_tb_cfg;

-------------------------------------------------------------------------------
entity lfsr_tb is

end entity lfsr_tb;

-------------------------------------------------------------------------------
