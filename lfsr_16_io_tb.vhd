library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity lfsr_16_io_tb is
end lfsr_16_io_tb;

architecture tb_io of lfsr_16_io_tb is

   signal clk_tb        : std_logic := '0';
   signal rst_tb        : std_logic;
   signal shft_reg_tb   : std_logic_vector(15 downto 0);
   signal prog_taps_tb  : std_logic_vector(15 downto 0);
   signal out_sig_tb    : std_logic_vector(15 downto 0);
   signal eof           : std_logic := '0';

   constant clk_period : time := 5 ns;
   constant C_FILE_NAME : string := "DataIn.dat";
   constant C_DATA1_W : integer := 16;
   constant C_DATA3_W : integer := 1000;

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
--stimulus
shft_reg_tb <= "0001000100011111";
rst_tb <= '1', '0' AFTER 23 ns;
--rst_tb <= '0', '1' AFTER 23 ns, '0' AFTER 23 ns;

  --p_dump : process(rst_tb, clk_tb) 
  p_dump : process
    variable row : line;
    variable v_data_write: integer;
    file fptr : text;
    variable file_line : line;
    variable fstatus : file_open_status;
    variable var_data1 : std_logic_vector(C_DATA1_W-1 downto 0);
    variable var_data2 : integer;    
    variable var_data3 : std_logic_vector(C_DATA3_W-1 downto 0);    

    --file file_handler : text open write_mode is
    --  "lfsr_output.dat"
  begin

    var_data1 := (others => '0');
    var_data2 := 0;
    eof       <= '0';

    wait until rst_tb = '0';
    file_open(fstatus, fptr, C_FILE_NAME, write_mode);
    
    while( var_data2 < 1000) loop
      wait until clk_tb = '1';

      var_data1 := out_sig_tb;
      var_data2 := var_data2 + 1;  --increment
      --write(file_line, out_sig_tb, left, 16);
      write(file_line, to_integer(unsigned(out_sig_tb)), left, 16);      
      writeline(fptr, file_line);
    end loop;

    wait until rising_edge(clk_tb);
    eof <= '1';
    file_close(fptr);
    wait;

  end process p_dump;

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
	
end architecture tb_io;