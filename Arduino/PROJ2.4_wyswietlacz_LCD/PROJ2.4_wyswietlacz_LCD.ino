#include <Wire.h> 
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27,20,4);  // set the LCD address to 0x27 for a 16 chars and 2 line display

void setup()
{
  lcd.init();                      // initialize the lcd 
  lcd.init();
  // Print a message to the LCD.
  lcd.backlight();
  lcd.setCursor(6,0);
  delay(500);
  lcd.print("siema");
  lcd.setCursor(0,1);
  delay(2000);
  lcd.print("eniu");
}

void loop()
{
}
