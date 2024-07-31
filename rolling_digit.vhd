-- File        : rolling_digit.vhd
-- Description : A simple VHLD code that reads inputs "SW", does some logic,
--               then drive outputs "7-SEG". 
-- Author      : Albert Chiang
-- Tools       : Xilinx Vivado for VHDL design entry, simulation, synthesis, implementation 
--               (place & route), and bitstream generation for Basys3 Xilinx FPGA Board

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity lab2_top is
  generic (
    UPPER : natural := 20; -- 26; -- 31;
    LOWER : natural := 19 -- 25  -- 30
  );
 port ( 
        clk       : in  STD_LOGIC;
        sw        : in  STD_LOGIC_VECTOR (15 downto 0);

		btnU, btnD : in STD_LOGIC;		
		btnL : in STD_LOGIC;		
		btnR : in STD_LOGIC;		
		btnC : in STD_LOGIC;	
			
		leds    : out STD_LOGIC_VECTOR (15 downto 0);

		seg7    : out STD_LOGIC_VECTOR (6 downto 0);
		an      : out STD_LOGIC_VECTOR (3 downto 0)
	   );
end lab2_top;


architecture Behavioral of lab2_top is

signal abt : std_logic := '0';
signal wren, rden : std_logic; 
signal display_digit : std_logic_vector(3 downto 0);
-- signal tmr : std_logic_vector(31 downto 0);
signal tmr : unsigned(31 downto 0); -- '+' via use ieee.numeric_std.all;
--variable nouse : std_logic_vector(3 downto 0); -- must be in process
signal notused : unsigned (5 downto 0);
signal notused2 : unsigned (5 downto 0);
signal notused3 : unsigned (31 downto 0) := (others => '1');

begin

notused <= tmr(31 downto 26) mod "101010"; --42
notused2 <= tmr(31 downto 26) / "101010"; --42

-- display_digit <= SW(3 downto 0);
 -- upper <= x"12";
 
 seg7      <=  "1000000" when display_digit = x"0" else 
               "1111001" when display_digit = x"1" else 
               "0100100" when display_digit = x"2" else 
               "0110000" when display_digit = x"3" else 
               "0011001" when display_digit = x"4" else 
               "0010010" when display_digit = x"5" else 
               "0000010" when display_digit = x"6" else 
               "1111000" when display_digit = x"7" else 
               "0000000" when display_digit = x"8" else 
               "0010000" when display_digit = x"9" else 
               "0001000" when display_digit = x"A" else 
               "0000011" when display_digit = x"B" else 
               "1000110" when display_digit = x"C" else 
               "0100001" when display_digit = x"D" else 
               "0000110" when display_digit = x"E" else 
               "0001110" when display_digit = x"F";
  
  -- an <= (0=>'0', others=>'1'); --Note: this only shows up on display 0
  -- an <= "1110";
  


  proces_main_loop : process(clk) -- , rst) 
  
  
  -- signal sfo : unsigned (3 downto 0);  -- not legal
  variable nouse : std_logic_vector(3 downto 0); -- variable must be in process



  begin

     if (rising_edge(clk)) then
     
          tmr <= tmr + 1; -- keep timer going, XDC period is 10NS
          

          
          -- start of timer bit slicing
          
          ----- PHASE A -----
   
          if (tmr(UPPER downto LOWER) = "00" ) then
          
             display_digit <= x"5";
             an <= "1110";
              
             if (sw(1 downto 0)  = "00") then
                display_digit <= x"0";
                an <= "0000";
             elsif (sw(1 downto 0)  = "01") then
                display_digit <= x"0";
                an <= "0111";
             elsif (sw(1 downto 0)  = "10") then
                display_digit <= x"0";
                an <= "0111";
             case tmr(UPPER+10 downto UPPER+5) is 
                -- =========== START ================
                    when "000000" =>
                       display_digit <=  x"0";
                       an <= "0111";
                    when "000001" =>
                       display_digit <=  x"0";
                       an <= "1011";
                    when "000010" =>
                       display_digit <=  x"0";
                       an <= "1101";
                    when "000011" =>
                       display_digit <=  x"0";
                       an <= "1110";
                    when "000100" =>
                       display_digit <=  x"1";
                       an <= "0111";
                    when "000101" =>
                       display_digit <=  x"1";
                       an <= "1011";
                    when "000110" =>
                       display_digit <=  x"1";
                       an <= "1101";
                    when "000111" =>
                       display_digit <=  x"1";
                       an <= "1110";
                    when "001000" =>
                       display_digit <=  x"2";
                       an <= "0111";
                    when "001001" =>
                       display_digit <=  x"2";
                       an <= "1011";
                    when "001010" =>
                       display_digit <=  x"2";
                       an <= "1101";
                    when "001011" =>
                       display_digit <=  x"2";
                       an <= "1110";
                    when "001100" =>
                       display_digit <=  x"3";
                       an <= "0111";
                    when "001101" =>
                       display_digit <=  x"3";
                       an <= "1011";
                    when "001110" =>
                       display_digit <=  x"3";
                       an <= "1101";
                    when "001111" =>
                       display_digit <=  x"3";
                       an <= "1110";
                    when "010000" =>
                       display_digit <=  x"4";
                       an <= "0111";
                    when "010001" =>
                       display_digit <=  x"4";
                       an <= "1011";
                    when "010010" =>
                       display_digit <=  x"4";
                       an <= "1101";
                    when "010011" =>
                       display_digit <=  x"4";
                       an <= "1110";
                    when "010100" =>
                       display_digit <=  x"5";
                       an <= "0111";
                    when "010101" =>
                       display_digit <=  x"5";
                       an <= "1011";
                    when "010110" =>
                       display_digit <=  x"5";
                       an <= "1101";
                    when "010111" =>
                       display_digit <=  x"5";
                       an <= "1110";
                    when "011000" =>
                       display_digit <=  x"6";
                       an <= "0111";
                    when "011001" =>
                       display_digit <=  x"6";
                       an <= "1011";
                    when "011010" =>
                       display_digit <=  x"6";
                       an <= "1101";
                    when "011011" =>
                       display_digit <=  x"6";
                       an <= "1110";
                    when "011100" =>
                       display_digit <=  x"7";
                       an <= "0111";
                    when "011101" =>
                       display_digit <=  x"7";
                       an <= "1011";
                    when "011110" =>
                       display_digit <=  x"7";
                       an <= "1101";
                    when "011111" =>
                       display_digit <=  x"7";
                       an <= "1110";
                    when "100000" =>
                       display_digit <=  x"8";
                       an <= "0111";
                    when "100001" =>
                       display_digit <=  x"8";
                       an <= "1011";
                    when "100010" =>
                       display_digit <=  x"8";
                       an <= "1101";
                    when "100011" =>
                       display_digit <=  x"8";
                       an <= "1110";
                    when "100100" =>
                       display_digit <=  x"9";
                       an <= "0111";
                    when "100101" =>
                       display_digit <=  x"9";
                       an <= "1011";
                    when "100110" =>
                       display_digit <=  x"9";
                       an <= "1101";
                    when "100111" =>
                       display_digit <=  x"9";
                       an <= "1110";
                    when "101000" =>
                       display_digit <=  x"a";
                       an <= "0111";
                    when "101001" =>
                       display_digit <=  x"a";
                       an <= "1011";
                    when "101010" =>
                       display_digit <=  x"a";
                       an <= "1101";
                    when "101011" =>
                       display_digit <=  x"a";
                       an <= "1110";
                    when "101100" =>
                       display_digit <=  x"b";
                       an <= "0111";
                    when "101101" =>
                       display_digit <=  x"b";
                       an <= "1011";
                    when "101110" =>
                       display_digit <=  x"b";
                       an <= "1101";
                    when "101111" =>
                       display_digit <=  x"b";
                       an <= "1110";
                    when "110000" =>
                       display_digit <=  x"c";
                       an <= "0111";
                    when "110001" =>
                       display_digit <=  x"c";
                       an <= "1011";
                    when "110010" =>
                       display_digit <=  x"c";
                       an <= "1101";
                    when "110011" =>
                       display_digit <=  x"c";
                       an <= "1110";
                    when "110100" =>
                       display_digit <=  x"d";
                       an <= "0111";
                    when "110101" =>
                       display_digit <=  x"d";
                       an <= "1011";
                    when "110110" =>
                       display_digit <=  x"d";
                       an <= "1101";
                    when "110111" =>
                       display_digit <=  x"d";
                       an <= "1110";
                    when "111000" =>
                       display_digit <=  x"e";
                       an <= "0111";
                    when "111001" =>
                       display_digit <=  x"e";
                       an <= "1011";
                    when "111010" =>
                       display_digit <=  x"e";
                       an <= "1101";
                    when "111011" =>
                       display_digit <=  x"e";
                       an <= "1110";
                    when "111100" =>
                       display_digit <=  x"f";
                       an <= "0111";
                    when "111101" =>
                       display_digit <=  x"f";
                       an <= "1011";
                    when "111110" =>
                       display_digit <=  x"f";
                       an <= "1101";
                    when "111111" =>
                       display_digit <=  x"f";
                       an <= "1110";
                    when others =>           
                       display_digit <=  x"e";
                       an <= "0000";
   
      
   
   
                  
                -- =========== END ================

            end case;
         elsif (sw(1 downto 0)  = "11") then

             display_digit <= x"0";
             an <= "0000";
         end if; -- SW = "00"

             
          ----- PHASE B -----
                 
          elsif (tmr(UPPER downto LOWER) = "01" ) then

             display_digit <= x"7";
             an <= "1101";
             if (sw(1 downto 0)  = "00") then
                display_digit <= x"0"; -- should be 0, but 
                an <= "0000";
             elsif (sw(1 downto 0)  = "01") then
                display_digit <= x"1";
                an <= "1011";
             elsif (sw(1 downto 0)  = "10") then
             --   display_digit <= x"0";
                an <= "1111";

             elsif (sw(1 downto 0)  = "11") then
                display_digit <= x"0";
                an <= "0000";

             else
               display_digit <= x"E";
               an <= "0000";                 
             end if;              
               
              
          ----- PHASE C -----
              
          elsif (tmr(UPPER downto LOWER) = "10" ) then
             display_digit <= x"0";
             an <= "1011";  
               
               
             if (sw(1 downto 0)  = "00") then
                display_digit <= x"0";
                an <= "0000";
             elsif (sw(1 downto 0)  = "01") then
                display_digit <= x"2";
                an <= "1101";
             elsif (sw(1 downto 0)  = "10") then
                an <= "1111";
             elsif (sw(1 downto 0) = "11") then 
                display_digit <= x"0";
                an <= "0000";
             else
               display_digit <= x"E";
               an <= "0000";             
             end if;

          ----- PHASE D -----
          elsif (tmr(UPPER downto LOWER) = "11" ) then
                              
            if (sw(1 downto 0)  = "00") then
                display_digit <= x"0";
                an <= "0000";
             elsif (sw(1 downto 0)  = "01") then
                display_digit <= x"3";
                an <= "1110";
             elsif (sw(1 downto 0)  = "10") then
              --  display_digit <= x"0";
                an <= "1111";
            elsif (sw(1 downto 0)  = "11") then
                display_digit <= x"0";
                an <= "0000";                
             else
               display_digit <= x"E";
               an <= "0000";                                    
             end if;              
                              


          end if; -- tmr bit slice
       end if; --clk

  end process; --  process_main_loop
  
  process_modulo : process(clk) begin
       if (rising_edge(clk)) then
          if (notused(0) = '1') then
               leds(0) <= '1';
          else
               leds(0) <= '0';
          end if; -- notused(0)

       end if; --clk

  end process;


  process_div : process(clk) begin
       if (rising_edge(clk)) then
          if (notused2(0) = '1') then
               leds(1) <= '1';
          else
               leds(1) <= '0';
          end if; -- notused(0)

       end if; --clk

  end process;

  process_case_led2 : process(clk) begin
       if (rising_edge(clk)) then
          case (tmr(UPPER-1 downto LOWER-1)) is
             when "00" => 
                leds(2) <= '0';
                leds(3) <= '1';
               
             when "01" =>
                leds(2) <= '1';
                leds(3) <= '0';
                
             when "10" =>
                 leds(2) <= '0';
                 leds(2) <= '1';
             when "11" =>
                leds(2) <= '1';
                leds(2) <= '0';
             when others =>
                leds(2) <= '1';
                leds(3) <= '1';
                leds(4) <= '1'; 
          end case;


       end if; --clk

  end process; 
   
end Behavioral;
