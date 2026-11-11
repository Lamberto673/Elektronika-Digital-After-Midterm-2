library ieee; use ieee.std_logic_1164.all; use ieee.numeric_std.all;
entity tb_ex6 is end;
architecture sim of tb_ex6 is
  signal clk : std_logic := '0';
  signal rst : std_logic := '1';
  signal g_case, g_bin : std_logic_vector(2 downto 0);
  signal done : boolean := false;
  type seq_t is array (0 to 7) of integer;
  constant SEQ : seq_t := (0, 1, 3, 2, 6, 7, 5, 4);
begin
  clk <= not clk after 5 ns when not done;
  ua: entity work.gray_case port map (clk, rst, g_case);
  ub: entity work.gray_bin  port map (clk, rst, g_bin);
  process begin
    wait for 2 ns; rst <= '0';
    for i in 0 to 16 loop         
      report "step " & integer'image(i) & ": case=" & to_string(g_case)
             & " bin=" & to_string(g_bin);
      assert g_case = g_bin report "case and binary versions differ" severity error;
      assert to_integer(unsigned(g_case)) = SEQ(i mod 8)
        report "wrong Gray sequence" severity error;
      wait until rising_edge(clk); wait for 1 ns;
    end loop;
    report "EX6 PASSED"; done <= true; wait;
  end process;
end architecture;