#define LM35 A0
 
void setup(){
  Serial.begin(9600);
  analogReference(INTERNAL);
}
 
void loop(){
  //Przeliczenie odczytu ADC na temperaturę zgodnie z opisem z kursu
  float temperatura = ((analogRead(LM35) * 1.1) / 1023.0) * 100;
 
  //Wyslanie przez UART aktualnej temperatury
  Serial.print("Aktualna temperatura: ");
  Serial.print(temperatura);
  Serial.println("*C");
 
  delay(200);
}
