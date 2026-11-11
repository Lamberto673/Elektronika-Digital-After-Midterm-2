
library ieee; use ieee.std_logic_1164.all;
entity siso_shl8_load is
  port (clk, load, sin : in std_logic;
        pin  : in  std_logic_vector(7 downto 0);   
        sout : out std_logic);
end entity;
architecture rtl of siso_shl8_load is
  signal r : std_logic_vector(7 downto 0) := (others => '0');
begin
  process (clk)
  begin
    if rising_edge(clk) then
      if load = '1' then
        r <= pin;                        
      else
        r <= r(6 downto 0) & sin;         
      end if;
    end if;
  end process;
  sout <= r(7);                            
end architecture;


library ieee; use ieee.std_logic_1164.all;
entity shift_lr8_sipo is
  port (clk, dir, sin : in std_logic;      
        q : out std_logic_vector(7 downto 0));
end entity;
architecture rtl of shift_lr8_sipo is
  signal r : std_logic_vector(7 downto 0) := (others => '0');
begin
  process (clk)
  begin
    if rising_edge(clk) then
      if dir = '0' then
        r <= r(6 downto 0) & sin;        
      else
        r <= sin & r(7 downto 1);          
      end if;
    end if;
  end process;
  q <= r;                                 
end architecture;