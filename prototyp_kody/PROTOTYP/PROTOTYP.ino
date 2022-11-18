#include <SPI.h>
#include <MFRC522.h>
#include <Wire.h> 
#include <LiquidCrystal_I2C.h>
#include <Servo.h>
#define servo 6
#define foto  A3

Servo serwomechanizm;
LiquidCrystal_I2C lcd(0x27,20,4);
#define czas_trwania 1000
const byte UID[] = {0xC0, 0x55, 0x3F, 0xA6}; //karta
const byte UID2[]= {0x95, 0x1A, 0x25, 0xD9}; //pestka
MFRC522 rfid(10, 9);
MFRC522::MIFARE_Key key;
boolean stan = false;
unsigned long czas;
float pozycjaServo = 180;
int odczytanaWartosc = 0;


void setup() {
  Serial.begin(9600);
  SPI.begin();
  rfid.PCD_Init();
  pinMode(2, OUTPUT);
  lcd.init();
  lcd.backlight();
  lcd.print("Zamkniete");
  pinMode(3, OUTPUT);
  serwomechanizm.attach(servo);
  serwomechanizm.write(pozycjaServo);
}

void loop() {
  odczytanaWartosc= analogRead(foto);
  analogWrite(3, 0);
  if (rfid.PICC_IsNewCardPresent() && rfid.PICC_ReadCardSerial())
  {
    if ((rfid.uid.uidByte[0] == UID[0] && 
        rfid.uid.uidByte[1] == UID[1] &&
        rfid.uid.uidByte[2] == UID[2] &&
        rfid.uid.uidByte[3] == UID[3])||(rfid.uid.uidByte[0] == UID2[0] && 
        rfid.uid.uidByte[1] == UID2[1] &&
        rfid.uid.uidByte[2] == UID2[2] &&
        rfid.uid.uidByte[3] == UID2[3]))
    {
      Serial.println("Poprawny");
      stan = true;
      lcd.clear();
      if (rfid.uid.uidByte[0] == UID[0] && 
        rfid.uid.uidByte[1] == UID[1] &&
        rfid.uid.uidByte[2] == UID[2] &&
        rfid.uid.uidByte[3] == UID[3]){
          lcd.clear();
          lcd.print("Zapraszam");
          lcd.setCursor(0,1);
          lcd.print("Panie Antoni");
          serwomechanizm.write(-180);
      pozycjaServo -= 180;
      delay(3000);
        }else{
          lcd.clear();
          lcd.print("Zapraszam");
          lcd.setCursor(0,1);
          lcd.print("Panie Pawle");
          serwomechanizm.write(-180);
      pozycjaServo -= 180;
      delay(3000);
        }
      czas = millis() + czas_trwania;
    } else
    {
      Serial.println("Niepoprawny");
      stan = false;
      lcd.clear();
      lcd.print("Nieautoryzowane");
      lcd.setCursor(0,1);
      lcd.print("wejscie");
      analogWrite(3,230);
      delay(2000);
      lcd.clear();
      lcd.print("Zamkniete");
    }
    rfid.PICC_HaltA();
    rfid.PCD_StopCrypto1();
  }
 odczytanaWartosc= analogRead(foto);

  if (odczytanaWartosc < 60){
    stan = false;
    lcd.clear();
    lcd.print("Zamkniete");
    delay(500); 
    if (pozycjaServo == 0){
      serwomechanizm.write(180);
      pozycjaServo += 180;
  }
  
  }
  digitalWrite(2, stan)  ;
}
