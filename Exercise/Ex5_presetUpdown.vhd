
library ieee; use ieee.std_logic_1164.all; use ieee.numeric_std.all;
entity up_cnt_preset is
  port (clk, load : in std_logic;
        din : in  unsigned(3 downto 0);   
        q   : out unsigned(3 downto 0));
end entity;
architecture rtl of up_cnt_preset is
  signal cnt : unsigned(3 downto 0) := (others => '0');
begin
  process (clk)
  begin
    if rising_edge(clk) then
      if load = '1' then
        cnt <= din;                  
      else
        cnt <= cnt + 1;
      end if;
    end if;
  end process;
  q <= cnt;
end architecture;

library ieee; use ieee.std_logic_1164.all; use ieee.numeric_std.all;
entity updown_cnt_aclr is
  port (clk, clr, up : in std_logic;     
        q : out unsigned(3 downto 0));
end entity;
architecture rtl of updown_cnt_aclr is
  signal cnt : unsigned(3 downto 0) := (others => '0');
begin
  process (clk, clr)
  begin
    if clr = '1' then
      cnt <= (others => '0');
    elsif rising_edge(clk) then
      if up = '1' then cnt <= cnt + 1;
      else             cnt <= cnt - 1;
      end if;
    end if;
  end process;
  q <= cnt;
end architecture;