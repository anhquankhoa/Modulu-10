library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Modulu10 is 
    port (
        clk  : in  std_logic; 
        Qout : out std_logic_vector(3 downto 0);
	ena  : in std_logic;
	rstn : in std_logic
    );
end Modulu10;

architecture main of Modulu10 is

    signal temp : std_logic_vector (3 downto 0) := "0000";
    signal temptt : std_logic_vector (3 downto 0) := "0001";	
    component TFlipFlop is
        port ( 
            T   : in  std_logic;
            clk : in  std_logic;
            Q   : out std_logic
        );
    end component;

begin
	temptt(1) <=  not temp(3) and temp(0);   --T1
	temptt(2) <= temp(1) and temp(0);	 --T2
	temptt(3) <= (temp(2) and temp(1) and temp(0)) or (temp(3) and temp(0)); --T3
    -- G?i các flip-flop T bên ngoài process
    FF0: TFlipFlop port map ( T => temptt(0), clk => clk, Q => temp(0) );
    FF1: TFlipFlop port map ( T => temptt(1) , clk => clk, Q => temp(1) );
    FF2: TFlipFlop port map ( T => temptt(2) , clk => clk, Q => temp(2) );
    FF3: TFlipFlop port map ( T => temptt(3) , clk => clk, Q => temp(3) );

    -- Xu?t k?t qu?
process(clk)
begin 
if (clk'event and clk ='1') then
if (rstn = '0') then
Qout <= "0000"; 
elsif (ena = '1') then
    Qout <= temp;
end if; 
end if;

end process;
end main;
