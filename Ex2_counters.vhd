
library ieee; use ieee.std_logic_1164.all; use ieee.numeric_std.all;
entity down_cnt_sset is
  port (clk, set : in std_logic;
        q : out std_logic_vector(3 downto 0));
end entity;
architecture rtl of down_cnt_sset is
  signal cnt : unsigned(3 downto 0) := (others => '0');
begin
  process (clk)                     
  begin
    if rising_edge(clk) then
      if set = '1' then
        cnt <= "1111";              
      else
        cnt <= cnt - 1;      
      end if;
    end if;
  end process;
  q <= std_logic_vector(cnt);
end architecture;

library ieee; use ieee.std_logic_1164.all; use ieee.numeric_std.all;
entity signed_up_cnt_areset is
  port (clk, rst : in std_logic;
        q : out signed(3 downto 0));    
end entity;
architecture rtl of signed_up_cnt_areset is
  signal cnt : signed(3 downto 0) := (others => '0');
begin
  process (clk, rst)
  begin
    if rst = '1' then
      cnt <= (others => '0');
    elsif rising_edge(clk) then
      cnt <= cnt + 1;                  
    end if;
  end process;
  q <= cnt;
end architecture;