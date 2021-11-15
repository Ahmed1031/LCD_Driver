------Main code:---------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.lcd_ssd_functions.all;
-------------------------------------------------------------------------
ENTITY lcd_driver IS
GENERIC (clk_divider: POSITIVE := 50_000); --50MHz to 500Hz
PORT (
    CLOCK_50	: in std_logic;
	KEY		  	: in std_logic_vector (3 downto 0);  -- pulled high / KEY and Button are the same 
	SW			: IN NATURAL RANGE 0 TO 15; -- pulled high

   -- Seven Segment display 
   HEX0S       : out std_logic_vector (6 downto 0);
   
   -- Red LED's
   LEDR        : OUT NATURAL RANGE 0 TO 15;
   
   -- LCD signals 	
   LCD_BLON  : OUT STD_LOGIC;
   LCD_RW    : OUT STD_LOGIC;
   LCD_EN    : OUT STD_LOGIC;
   LCD_RS    : OUT STD_LOGIC;
   LCD_ON    : OUT STD_LOGIC;
   LCD_DATA  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
 END lcd_driver;
 -------------------------------------------------------------------------
ARCHITECTURE led_ssd_lcd_driver OF lcd_driver IS

TYPE state IS (FunctionSet1, FunctionSet2, FunctionSet3, FunctionSet4,
ClearDisplay, DisplayControl, EntryMode, WriteData, ReturnHome);

SIGNAL pr_state, nx_state: state;

SIGNAL LCD_DATAi: STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
-----Part 1: LED driver:----------------------
LEDR <= SW;
-----Part 2: SSD driver:----------------------
HEX0S <= integer_to_ssd(SW);
-----Part 3: LCD driver (FSM-based):----------
--Get LCD character:
LCD_DATAi <= integer_to_lcd(SW);
--Turn LCD and its backlight ON:
LCD_ON <= '1'; 
LCD_BLON <= '1';
--Clock generator for LCD(LCD_EN=500Hz):
PROCESS (CLOCK_50)
   VARIABLE count: INTEGER RANGE 0 TO clk_divider;
BEGIN
     IF rising_edge(CLOCK_50) THEN
        count := count + 1;
         IF (count=clk_divider) THEN
            LCD_EN <= NOT LCD_EN;
            count := 0;
         END IF;
END IF;
END PROCESS;
------------------------
 --Lower section of FSM:
 PROCESS (LCD_EN)
 BEGIN
     IF (LCD_EN'EVENT AND LCD_EN='1') THEN
        pr_state <= nx_state;
  END IF;
 END PROCESS;
 --Upper section of FSM:
 PROCESS (pr_state, LCD_DATA)
 BEGIN
      CASE pr_state IS
					 ---Initialize LCD:
					 WHEN FunctionSet1 =>
					 LCD_RS<='0'; 
					 LCD_RW<='0';
					 LCD_DATA <= lcd_functn_set1;
					 nx_state <= FunctionSet2;
					 
					 WHEN FunctionSet2 =>
					 LCD_RS<='0'; 
					 LCD_RW<='0';
					 LCD_DATA <= lcd_functn_set1;
					 nx_state <= FunctionSet3;
					 
					 WHEN FunctionSet3 =>
					 LCD_RS<='0';
					 LCD_RW<='0';
					 LCD_DATA <= lcd_functn_set1;
					 nx_state <= FunctionSet4;
					 
					 WHEN FunctionSet4 =>
					 LCD_RS<='0';
					 LCD_RW<='0';
					 LCD_DATA <= lcd_functn_set4;
					 nx_state <= ClearDisplay;
					 
					 WHEN ClearDisplay =>
					 LCD_RS<='0';
					 LCD_RW<='0';
					 LCD_DATA <= lcd_clr_display;
					 nx_state <= DisplayControl;
					 
					 WHEN DisplayControl =>
					 LCD_RS<='0';
					 LCD_RW<='0';
					 LCD_DATA <= lcd_display_cntrl;
					 nx_state <= EntryMode;
					 
					 WHEN EntryMode =>
					 LCD_RS<='0';
					 LCD_RW<='0';
					 LCD_DATA <= lcd_entry_mode;
					 nx_state <= WriteData;
					 
					 WHEN WriteData =>
					 LCD_RS<='1';
					 LCD_RW<='0';
                     LCD_DATA <= LCD_DATAi;
                     nx_state <=ReturnHome;
					 
					 WHEN ReturnHome =>
					 LCD_RS<='0';
					 LCD_RW<='0';
					 LCD_DATA <= lcd_return_home;
					 nx_state <= WriteData;
            END CASE;
      END PROCESS;
 END led_ssd_lcd_driver;
					 
					 
					 
					 
					 
	