library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lfsr_16_tb is
end lfsr_16_tb;

architecture tb of lfsr_16_tb is

   signal clk_tb        : std_logic := '0';
   signal rst_tb        : std_logic;
   signal shft_reg_tb   : std_logic_vector(15 downto 0);
   signal prog_taps_tb  : std_logic_vector(15 downto 0);
   signal out_sig_tb    : std_logic_vector(15 downto 0);

   constant clk_period : time := 5 ns;

begin

  UUT : entity work.lfsr_16
    port map(
      clk        => clk_tb,        --in
      rst        => rst_tb,        --in
      shft_reg   => shft_reg_tb,   --in
      prog_taps  => prog_taps_tb,  --in
      out_sig    => out_sig_tb);   --out

      -- Clock process definitions( clock with 50% duty cycle is generated here.
   clk_process : process
   begin
        clk_tb <= '0';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clk_tb <= '1';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
   end process;

--   tap_process : process
--   begin
--        rst_tb <= '0';
--        shft_reg_tb <= "0001000100011111";
--        wait for 10*clk_period;  --for 0.5 ns signal is '0'.
--        rst_tb <= '1';
--        shft_reg_tb <= "0001000100011111";        
--        wait for 10*clk_period;  --for 0.5 ns signal is '0'.
--        rst_tb <= '0';
--        shft_reg_tb <= "0001000100011111";        
--        wait for 10*clk_period;  --for 0.5 ns signal is '0'.
--        shft_reg_tb <= "0001000100011111";
--   end process;

--Stimulus
shft_reg_tb <= "0001000100011111";
rst_tb <= '1', '0' AFTER 23 ns;
--rst_tb <= '0', '1' AFTER 23 ns, '0' AFTER 23 ns;

	
end architecture tb;