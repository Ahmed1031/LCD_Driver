-----Package with functions:-----------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE lcd_ssd_functions IS
		FUNCTION integer_to_ssd (SIGNAL input: NATURAL) RETURN STD_LOGIC_VECTOR;
		FUNCTION integer_to_lcd (SIGNAL input: NATURAL) RETURN STD_LOGIC_VECTOR;
END lcd_ssd_functions;
---------------------------------------------------------------------------
PACKAGE BODY lcd_ssd_functions IS
        FUNCTION integer_to_ssd (SIGNAL input: NATURAL) RETURN STD_LOGIC_VECTOR
        IS VARIABLE output: STD_LOGIC_VECTOR(6 DOWNTO 0);
          BEGIN
                CASE input IS
							 WHEN 0 => output:="0000001"; --"0" on SSD
							 WHEN 1 => output:="1001111"; --"1" on SSD
							 WHEN 2 => output:="0010010"; --"2" on SSD
							 WHEN 3 => output:="0000110"; --"3" on SSD
							 WHEN 4 => output:="1001100"; --"4" on SSD
							 WHEN 5 => output:="0100100"; --"5" on SSD
							 WHEN 6 => output:="0100000"; --"6" on SSD
							 WHEN 7 => output:="0001111"; --"7" on SSD
							 WHEN 8 => output:="0000000"; --"8" on SSD
							 WHEN 9 => output:="0000100"; --"9" on SSD
							 WHEN 10 => output:="0001000"; --"A" on SSD
							 WHEN 11 => output:="1100000"; --"b" on SSD
							 WHEN 12 => output:="0110001"; --"C" on SSD
							 WHEN 13 => output:="1000010"; --"d" on SSD
							 WHEN 14 => output:="0110000"; --"E" on SSD
							 WHEN OTHERS=>output:="0111000"; --"F" on SSD
                END CASE;
       RETURN output;
 END integer_to_ssd;
------------------------------------------------------------------------
 FUNCTION integer_to_lcd (SIGNAL input: NATURAL) RETURN STD_LOGIC_VECTOR
	IS VARIABLE output: STD_LOGIC_VECTOR(7 DOWNTO 0);
		BEGIN
			CASE input IS
					 WHEN 0 => output:="00110000"; --"0" on LCD
					 WHEN 1 => output:="00110001"; --"1" on LCD
					 WHEN 2 => output:="00110010"; --"2" on LCD
					 WHEN 3 => output:="00110011"; --"3" on LCD
					 WHEN 4 => output:="00110100"; --"4" on LCD
					 WHEN 5 => output:="00110101"; --"5" on LCD
					 WHEN 6 => output:="00110110"; --"6" on LCD
					 WHEN 7 => output:="00110111"; --"7" on LCD
					 WHEN 8 => output:="00111000"; --"8" on LCD
					 WHEN 9 => output:="00111001"; --"9" on LCD
					 WHEN 10 => output:="01000001"; --"A" on LCD
					 WHEN 11 => output:="01000010"; --"B" on LCD
					 WHEN 12 => output:="01000011"; --"C" on LCD
					 WHEN 13 => output:="01000100"; --"D" on LCD
					 WHEN 14 => output:="01000101"; --"E" on LCD
					 WHEN OTHERS=>output:="01000110"; --"F" on LCD
			END CASE;
		RETURN output;
	END integer_to_lcd;
 END lcd_ssd_functions;