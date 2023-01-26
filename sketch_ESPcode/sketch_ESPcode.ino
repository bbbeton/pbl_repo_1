#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <OSCMessage.h>
#include <OSCBundle.h>
#include <OSCData.h>
#include <SPI.h>
#include <PN532_SPI.h>
#include <PN532.h>
// #include <LiquidCrystal_I2C.h>
#include "baza.h"

#define czujnikOtwarciaPIN 0
#define elektromagnesPIN 4
#define nfcPIN 2
#define buzzerPIN 15
#define KOD_OTWARCIA_DRZWI 22
#define KOD_ZAMKNIECIA_DRZWI 13

char ssid[] = "UPC8199300";
char pass[] = "Wu8hmrQbwcbh";

// LiquidCrystal_I2C lcd(0x27,20,4);

//WiFiServer server(80);
WiFiUDP Udp;
IPAddress remoteLocation;

const unsigned int localPort = 8888;
const unsigned int remotePort = 9999;

OSCErrorCode error;
int temp = 0;

PN532_SPI pn532spi(SPI,nfcPIN);
PN532 nfc(pn532spi);

byte UID[] = {0x00,0x00,0x00,0x00};

char name[] = "a";
char surname[] = "b";

KARTA *header = allocate(name,surname,UID);

void setup()
{
  Serial.begin(115200);

  // lcd.init();
  // lcd.backlight();
  // lcd.print("Zamkniete");
  
  byte UID1[] = {0x53,0xC4,0xB1,0x0B};

  
  char name1[] = "Igor";
  char surname1[] = "Uchnast";

  
  KARTA *KARTA1 = allocate(name1,surname1,UID1);
  
  add_to_list(header,KARTA1);

  pinMode(czujnikOtwarciaPIN, INPUT_PULLUP);
  pinMode(elektromagnesPIN, OUTPUT);

  digitalWrite(czujnikOtwarciaPIN, LOW);
  digitalWrite(elektromagnesPIN, HIGH);


  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, pass);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.println("Starting UDP");
  Udp.begin(localPort);
  Serial.print("Local port: ");
  Serial.println(Udp.localPort());

  // Inicjalizacja czytnika NFC
  nfc.begin();

  // Pobranie wersji firmware
  uint32_t versiondata = nfc.getFirmwareVersion();

  // Jesli nie udalo sie pobrac, to nie jest to modul PN53x
  if (!versiondata)
  {
    Serial.print("Nie odnaleziono modulu PN53x");
    while (1);
  }

  // Wyswietlenie wersji ukladu PN5xx
  Serial.print("Znaleziono uklad PN5");
  Serial.println((versiondata >> 24) & 0xFF, HEX);

  // Wyswietlenie wersji firmware
  Serial.print("Firmware: ");
  Serial.print((versiondata >> 16) & 0xFF, DEC);
  Serial.print('.');
  Serial.println((versiondata >> 8) & 0xFF, DEC);

  // Konfiguracja modulu do odczytu znacznikow RFID
  nfc.SAMConfig();

  Serial.println("Oczekiwanie na znacznik...");
}

void intFromMessage(OSCMessage &msg)
{
  temp = msg.getInt(0);
  Serial.print("/int: ");
  Serial.println(temp);
}

void receiveMessage()
{
  OSCMessage msg;
  int size = Udp.parsePacket();
  if (size > 0)
  {
    while (size--)
    {
      msg.fill(Udp.read());
    }
    if (!msg.hasError())
    {
      msg.dispatch("/int", intFromMessage);
    }
    else
    {
      error = msg.getError();
      Serial.print("error: ");
      Serial.println(error);
    }
  }
  remoteLocation = Udp.remoteIP();
}

void openDoor()
{
  if (temp == KOD_OTWARCIA_DRZWI)
  {
    digitalWrite(elektromagnesPIN, LOW);
    Serial.println("Zapraszamy");
    // lcd.clear();
    // lcd.print("Zapraszamy");
    delay(3000);
    temp = 0;
  }
  if (digitalRead(czujnikOtwarciaPIN) == HIGH)
  {
    digitalWrite(elektromagnesPIN,LOW);
  }
  if (digitalRead(czujnikOtwarciaPIN) == LOW)
  {
    digitalWrite(elektromagnesPIN, HIGH);
    // lcd.clear();
    // lcd.print("Zamkniete");
    if (WiFi.status() == WL_CONNECTED)
    {
      OSCMessage msg("/sensor");
      msg.add(KOD_ZAMKNIECIA_DRZWI);
      Udp.beginPacket(remoteLocation, remotePort);
      msg.send(Udp);
      Udp.endPacket();
      msg.empty();
    }
  }
}

void NFCread() 
{
  // Status
  uint8_t success;

  // Bufor przechowujacy unikatowy identyfikator
  uint8_t uid[] = {0, 0, 0, 0};

  // Dlugosc unikatowego identyfikatora.
  uint8_t uidLength;

  // Proba odczytania znacznika
  success = nfc.readPassiveTargetID(PN532_MIFARE_ISO14443A, uid, &uidLength);

  KARTA *KLIENT;

  // Jesli sukces odczytu
  if (success)
  {
    Serial.println(uid[0]);
    Serial.println(uid[1]);
    Serial.println(uid[2]);
    Serial.println(uid[3]);
    KLIENT = find_by_UID(header,uid);
    if (KLIENT != NULL) 
    {
      //algorytm wejscia
      digitalWrite(elektromagnesPIN,LOW);
      Serial.println("SUKCES");
      Serial.println("Zapraszamy");
      Serial.println(KLIENT->name);
      Serial.println(KLIENT->surname);
      // lcd.clear();
      // lcd.print("Zapraszamy");
      // lcd.setCursor(0,1);
      // if(strlen(KLIENT->name) + strlen(KLIENT->surname) + 1 > 16)
      // {
      //   lcd.print(KLIENT->name);
      // }
      // else
      // {
      //   lcd.print(KLIENT->name);
      //   lcd.setCursor(strlen(KLIENT->name) + 1, 1);
      //   lcd.print(KLIENT->surname);
      // }
      delay(3000);
      if (digitalRead(czujnikOtwarciaPIN) == HIGH)
      {
        digitalWrite(elektromagnesPIN,HIGH);
      }
      if (digitalRead(czujnikOtwarciaPIN) == LOW)
      {
        digitalWrite(elektromagnesPIN, HIGH);
        Serial.println("Zamkniete");
        // lcd.clear();
        // lcd.print("Zamkniete");
      }
    }
    else 
    {
      // lcd.clear();
      // lcd.print("SPIERDALAJ");
      Serial.println("SPIERDALAJ");
      digitalWrite(buzzerPIN,HIGH);
      delay(5000);
      Serial.println("Zamkniete");
      // lcd.clear();
      // lcd.print("Zamkniete");
      digitalWrite(buzzerPIN,LOW);
    }
  }
}

void loop()
{
  receiveMessage();
  openDoor();
  NFCread();
}