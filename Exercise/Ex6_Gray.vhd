
library ieee; use ieee.std_logic_1164.all;
entity gray_case is
  port (clk, rst : in std_logic;
        g : out std_logic_vector(2 downto 0));
end entity;
architecture rtl of gray_case is
  signal s : std_logic_vector(2 downto 0) := "000";
begin
  process (clk, rst)
  begin
    if rst = '1' then
      s <= "000";
    elsif rising_edge(clk) then
      case s is
        when "000"  => s <= "001";
        when "001"  => s <= "011";  
        when "011"  => s <= "010";
        when "010"  => s <= "110";   
        when "110"  => s <= "111";  
        when "111"  => s <= "101";   
        when "101"  => s <= "100"; 
        when "100"  => s <= "000";  
        when others => s <= "000";
      end case;
    end if;
  end process;
  g <= s;
end architecture;

library ieee; use ieee.std_logic_1164.all; use ieee.numeric_std.all;
entity gray_bin is
  port (clk, rst : in std_logic;
        g : out std_logic_vector(2 downto 0));
end entity;
architecture rtl of gray_bin is
  signal b : unsigned(2 downto 0) := "000";
begin
  process (clk, rst)
  begin
    if rst = '1' then
      b <= "000";
    elsif rising_edge(clk) then
      b <= b + 1;
    end if;
  end process;
  g <= std_logic_vector(b xor shift_right(b, 1));   
end architecture;