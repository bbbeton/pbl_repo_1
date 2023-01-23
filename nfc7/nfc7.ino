#include <SPI.h>
#include <PN532_SPI.h>
#include "PN532.h"
 
PN532_SPI pn532spi(SPI, 10);
PN532 nfc(pn532spi);

const byte UID1[] = {0x53, 0xC4, 0xB1, 0x0B};

const byte UID2[]= {0x83, 0xC9, 0xB6, 0x0D};
int nfcread=0;
 
void setup(void)
{
  // Inicjalizacja portu szeregowego
  Serial.begin(115200);
 
  // Inicjalizacja czytnika NFC
  nfc.begin();
 
  // Pobranie wersji firmware
  uint32_t versiondata = nfc.getFirmwareVersion();
 
  // Jesli nie udalo sie pobrac, to nie jest to modul PN53x
  if (!versiondata)
  {
    Serial.print("Nie odnaleziono modlu PN53x");
    while(1);
  }
 
  // Wyswietlenie wersji ukladu PN5xx
  Serial.print("Znaleziono uklad PN5");
  Serial.println((versiondata>>24) & 0xFF, HEX);
 
  // Wyswietlenie wersji firmware
  Serial.print("Firmware: ");
  Serial.print((versiondata>>16) & 0xFF, DEC);
  Serial.print('.');
  Serial.println((versiondata>>8) & 0xFF, DEC);
 
  // Konfiguracja modulu do odczytu znacznikow RFID
  nfc.SAMConfig();
 
  Serial.println("Oczekiwanie na znacznik...");
}
 
void loop(void)
{
nfcread=nfcread1();
 
  delay(1000);
}


int nfcread1()
{
   // Status
  uint8_t success;                          
 
  // Bufor przechowujacy unikatowy identyfikator
  uint8_t uid[] = { 0, 0, 0, 0, 0, 0, 0 };
 
  // Dlugosc unikatowego identyfikatora.
  uint8_t uidLength;                        
 
  // Proba odczytania znacznika  
  success = nfc.readPassiveTargetID(PN532_MIFARE_ISO14443A, uid, &uidLength);
 
  // Jesli sukces odczytu
  if (success)
  {
 
    if(uid[0]==UID1[0]&&uid[1]==UID1[1]&&uid[2]==UID1[2]&&uid[3]==UID1[3]
    ||uid[0]==UID2[0]&&uid[1]==UID2[1]&&uid[2]==UID2[2]&&uid[3]==UID2[3])
    {
      //algorytm wejscia
    Serial.println("zapraszamy");
    return 1;
    }
    else
    {
      Serial.println("zły czip");
      return 2;
    }
  }
  return 0;
}
