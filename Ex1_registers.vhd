library ieee; use ieee.std_logic_1164.all;
entity reg4_negedge_aclr is
  port (clk, clr : in std_logic;
        d   : in  std_logic_vector(3 downto 0);
        q   : out std_logic_vector(3 downto 0));
end entity;
architecture rtl of reg4_negedge_aclr is
begin
  process (clk, clr)                     
  begin
    if clr = '1' then
      q <= (others => '0');    
    elsif falling_edge(clk) then        
      q <= d;
    end if;
  end process;
end architecture;


library ieee; use ieee.std_logic_1164.all;
entity reg_posedge_aset_en is
  generic (N : positive := 4);
  port (clk, set, en : in std_logic;
        d : in  std_logic_vector(N-1 downto 0);
        q : out std_logic_vector(N-1 downto 0));
end entity;
architecture rtl of reg_posedge_aset_en is
begin
  process (clk, set)
  begin
    if set = '1' then
      q <= (others => '1');             
    elsif rising_edge(clk) then
      if en = '1' then               
        q <= d;                          
      end if;
    end if;
  end process;
end architecture;