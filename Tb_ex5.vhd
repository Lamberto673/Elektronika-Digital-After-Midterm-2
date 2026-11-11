library ieee; use ieee.std_logic_1164.all; use ieee.numeric_std.all;
entity tb_ex5 is end;
architecture sim of tb_ex5 is
  signal clk : std_logic := '0';
  signal load, clr, up : std_logic := '0';
  signal din, qa, qb : unsigned(3 downto 0);
  signal done : boolean := false;
begin
  clk <= not clk after 5 ns when not done;
  ua: entity work.up_cnt_preset port map (clk, load, din, qa);
  ub: entity work.updown_cnt_aclr port map (clk, clr, up, qb);
  process begin

    din <= to_unsigned(13, 4); load <= '1';
    wait until rising_edge(clk); wait for 1 ns; load <= '0';
    assert qa = 13 report "5a preset failed" severity error;
    for e in 14 to 17 loop
      wait until rising_edge(clk); wait for 1 ns;
      assert to_integer(qa) = e mod 16 report "5a count wrong" severity error;
    end loop;

    clr <= '1'; wait for 1 ns;
    assert qb = 0 report "5b async clear failed" severity error;
    clr <= '0'; up <= '1';
    for i in 1 to 3 loop wait until rising_edge(clk); wait for 1 ns; end loop;
    assert qb = 3 report "5b up failed" severity error;
    up <= '0';
    for i in 1 to 5 loop wait until rising_edge(clk); wait for 1 ns; end loop;
    assert qb = 14 report "5b down/wrap failed" severity error;
    report "EX5 PASSED"; done <= true; wait;
  end process;
end architecture;