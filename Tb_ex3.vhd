library ieee; use ieee.std_logic_1164.all; use ieee.numeric_std.all;
entity tb_ex3 is end;
architecture sim of tb_ex3 is
  signal clk : std_logic := '0';
  signal clr : std_logic := '0';
  signal b, a : unsigned(3 downto 0);
  signal done : boolean := false;
  type arr is array (1 to 6) of integer;
  constant EXP : arr := (3, 6, 9, 12, 15, 2);  
begin
  clk <= not clk after 5 ns when not done;
  dut: entity work.accumulator4 port map (clk, clr, b, a);
  process begin
    b <= to_unsigned(3, 4);
    clr <= '1'; wait for 2 ns; clr <= '0';
    assert a = 0 report "clear failed" severity error;
    for i in 1 to 6 loop
      wait until rising_edge(clk); wait for 1 ns;
      report "clock " & integer'image(i) & ": A = " & integer'image(to_integer(a));
      assert to_integer(a) = EXP(i) report "accumulator wrong" severity error;
    end loop;
    report "EX3 PASSED"; done <= true; wait;
  end process;
end architecture;