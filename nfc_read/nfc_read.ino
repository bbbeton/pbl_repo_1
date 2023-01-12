#include <SPI.h>
#include "PN532_SPI.h"
#include "PN532.h"
 
PN532_SPI pn532spi(SPI, 10);
PN532 nfc(pn532spi);
 
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
    Serial.println();
    Serial.println("Znaleziono znacznik ISO14443A");
    
    // wyswietlenie dlugosci unikatowego identyfikatora
    Serial.print("  Dlugosc: ");
    Serial.print(uidLength, DEC);
    Serial.println("B");
    
    // wyswietlenie unikatowego identyfikatora
    Serial.print("  UID: ");
    nfc.PrintHex(uid, uidLength);
 
    // wyswietlenie typu znacznika
    Serial.print("  TYP: ");
    if (uidLength == 4)
    {
      Serial.println("Mifare Classic");
      Serial.println("");
 
      Serial.println("Proba autoryzacji za pomoca klucza A");
      
      // Klucz
      uint8_t keya[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 
      // Sektor 1:
      // #7 - Sector Trailer
      // #6 - Data Block
      // #5 - Data Block
      // #4 - Data Block
      // Sektor 0:
      // #3 - Sector Trailer
      // #2 - Data Block
      // #1 - Data Block
      // #0 - Manufacturer Block
      
      // Proba uzyskania dostepu do Bloku #4 pamieci
 
      success = nfc.mifareclassic_AuthenticateBlock(uid, uidLength, 4, 0, keya);
 
      if (success)
      {
        Serial.println("Uzyskano dostep do bloku #4");
    
        uint8_t data[16];
 
        // Odczyt danych z bloku #4
        success = nfc.mifareclassic_ReadDataBlock(4, data);
 
        if (success)
        {
          Serial.println("Zawartosc bloku #4:");
          nfc.PrintHexChar(data, 16);
          Serial.println("");
          delay(1000);
        } else
        {
          Serial.println("Nie mozna odczytac zawartosci bloku #4");     
        }
      } else
      {
        Serial.println("Nie mozna uzyskac dostepu do bloku #4");  
      }
    }
  }
 
  delay(1000);
}