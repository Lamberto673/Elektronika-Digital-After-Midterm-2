library ieee; use ieee.std_logic_1164.all;
entity tb_ex4 is end;
architecture sim of tb_ex4 is
  signal clk : std_logic := '0';
  signal load, sin, sout, dir, sin2 : std_logic := '0';
  signal pin, q : std_logic_vector(7 downto 0);
  signal done : boolean := false;
  constant PAT : std_logic_vector(7 downto 0) := "10110010";
  constant SEQ : std_logic_vector(3 downto 0) := "1101";
begin
  clk <= not clk after 5 ns when not done;
  ua: entity work.siso_shl8_load port map (clk, load, sin, pin, sout);
  ub: entity work.shift_lr8_sipo port map (clk, dir, sin2, q);
  process begin

    pin <= PAT; load <= '1';
    wait until rising_edge(clk); wait for 1 ns; load <= '0';
    for i in 7 downto 0 loop
      assert sout = PAT(i) report "4a serial out wrong" severity error;
      wait until rising_edge(clk); wait for 1 ns;
    end loop;
    -- 4b: shift in 1,1,0,1 to the left -> q = "00001101"
    dir <= '0';
    for i in 3 downto 0 loop
      sin2 <= SEQ(i);                 -- MSB first
      wait until rising_edge(clk); wait for 1 ns;
    end loop;
    report "4b after left shifts: q = " & to_string(q);
    assert q = "00001101" report "4b left shift wrong" severity error;
    -- shift right twice with sin = 0 -> "00000011"
    dir <= '1'; sin2 <= '0';
    for i in 1 to 2 loop wait until rising_edge(clk); wait for 1 ns; end loop;
    report "4b after 2 right shifts: q = " & to_string(q);
    assert q = "00000011" report "4b right shift wrong" severity error;
    report "EX4 PASSED"; done <= true; wait;
  end process;
end architecture;