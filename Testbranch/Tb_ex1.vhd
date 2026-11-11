library ieee; use ieee.std_logic_1164.all;
entity tb_ex1 is end;
architecture sim of tb_ex1 is
  signal clk : std_logic := '0';
  signal clr, set, en : std_logic := '0';
  signal d, qa, qb : std_logic_vector(3 downto 0) := "0000";
  signal done : boolean := false;
begin
  clk <= not clk after 5 ns when not done;
  ua: entity work.reg4_negedge_aclr port map (clk, clr, d, qa);
  ub: entity work.reg_posedge_aset_en generic map (4) port map (clk, set, en, d, qb);
  process begin
    
    d <= "1010"; wait until rising_edge(clk); wait for 1 ns;
    assert qa /= "1010" report "1a loaded on rising edge!" severity error;
    wait until falling_edge(clk); wait for 1 ns;
    assert qa = "1010" report "1a no load on falling edge" severity error;

    wait for 1 ns; clr <= '1'; wait for 1 ns;
    assert qa = "0000" report "1a async clear failed" severity error;
    clr <= '0';
   
    set <= '1'; wait for 1 ns;
    assert qb = "1111" report "1b async set failed" severity error;
    set <= '0';

    d <= "0101"; en <= '0'; wait until rising_edge(clk); wait for 1 ns;
    assert qb = "1111" report "1b loaded while en=0" severity error;
    en <= '1'; wait until rising_edge(clk); wait for 1 ns;
    assert qb = "0101" report "1b no load with en=1" severity error;
    report "EX1 PASSED"; done <= true; wait;
  end process;
end architecture;