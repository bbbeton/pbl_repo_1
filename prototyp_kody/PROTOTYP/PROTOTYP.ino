INDX( 	 �:Q           (   8   �        .cl.id;                           ��     ��7!�S��7!�S��7!�S��7!� @      �9               m i r o s l a w _ p a j a k _ m a p a _ p o d r o z y . x l s x d o c               ��     ��7!�S��7!�S��7!�S��7!� @      �9              M I R O S L ~ 1 . X L S   n a               ��     ��7!���7!���7!���7!� @      �>              $O p i n i e   l u d z i   n a   t e m a t   p r o t o t y p u . d o c x                     ��     ��7!���7!���7!���7!� @      �>              O P I N I E ~ 1 . D O C                     x       ��     p Z     ��     ��7!���7!���7!���7!� @      �>              O P I N I E ~ 1 . D O C                     ��     ��7!���7!���7!���7!� @      �>              O P I N I E ~ 1 . D O C                     e[0] == UID[0] && 
        rfid.uid.uidByte[1] == UID[1] &&
        rfid.uid.uidByte[2] == UID[2] &&
        rfid.uid.uidByte[3] == UID[3]){
          lcd lear();
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
}

void zlakarta(){
  Seria println("Niepoprawny");
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

void loop() {
  odczytanaWartosc= analogRead(foto);
  analogWrite(3, 0);
  if (rfid.PICC_IsNewCardPresent() && rfid.PICC_ReadCardSerial())
  {
    if ((rfid.uid.uidByte[0] == UID[0] && 
        rfid.uid.uidByte[1] == UID[1] &&
        rfid.u .uidByte[2] == UID[2] &&
        rfid.uid.uidByte[3] == UID[3])||(rfid.uid.uidByte[0] == UID2[0] && 
        rfid.uid.uidByte[1] == UID2[1] &&
        rfid.uid.uidByte[2] == UID2[2] &&
        rfid.uid.uidByte[3] == UID2[3]))
    {
      wejscie();
    } else
    {
      zlakarta();
    }
    rfid.PICC_HaltA();
    rfid.PCD_StopCrypto1();
  }
 odczytanaWartosc= analogRead(foto);

  if (odczytanaWartosc < 60){
    stan = false;
    lcd.clear();
    lcd.print("Zamkniete");
    delay(500) 
    if (pozycjaServo == 0){
      serwomechanizm.write(180);
      pozycjaServo += 180;
  }
  
  }
  digitalWrite(2, stan)  ;
}
