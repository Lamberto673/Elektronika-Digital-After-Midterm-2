library ieee; use ieee.std_logic_1164.all; use ieee.numeric_std.all;
entity tb_ex2 is end;
architecture sim of tb_ex2 is
  signal clk : std_logic := '0';
  signal set, rst : std_logic := '0';
  signal qd : std_logic_vector(3 downto 0);
  signal qs : signed(3 downto 0);
  signal done : boolean := false;
begin
  clk <= not clk after 5 ns when not done;
  ud: entity work.down_cnt_sset port map (clk, set, qd);
  us: entity work.signed_up_cnt_areset port map (clk, rst, qs);
  process
    variable expect_u : integer;
    variable expect_s : integer;
  begin

    wait until rising_edge(clk); wait until rising_edge(clk);
 
    wait until falling_edge(clk);
    set <= '1'; wait for 1 ns;
    assert qd /= "1111" report "2a set acted without a clock edge!" severity error;
    wait until rising_edge(clk); wait for 1 ns;
    assert qd = "1111" report "2a sync set failed" severity error;
    set <= '0';
    expect_u := 15;
    for i in 1 to 17 loop              
      wait until rising_edge(clk); wait for 1 ns;
      expect_u := (expect_u - 1) mod 16;
      assert to_integer(unsigned(qd)) = expect_u
        report "2a count wrong" severity error;
    end loop;

    rst <= '1'; wait for 1 ns;
    assert qs = 0 report "2b async reset failed" severity error;
    rst <= '0';
    expect_s := 0;
    for i in 1 to 10 loop
      wait until rising_edge(clk); wait for 1 ns;
      if expect_s = 7 then expect_s := -8; else expect_s := expect_s + 1; end if;
      report "2b q = " & integer'image(to_integer(qs));
      assert to_integer(qs) = expect_s report "2b count wrong" severity error;
    end loop;
    report "EX2 PASSED"; done <= true; wait;
  end process;
end architecture;