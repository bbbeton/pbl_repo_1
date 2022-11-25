double napiecie=0;
double odczytanawartosc=0;
void setup() {
  pinMode(A1,INPUT);
  Serial.begin(9600);
  analogReference(INTERNAL);
}

void loop() {
  odczytanawartosc=analogRead(A1);
  napiecie=odczytanawartosc*(1.1/1023.0*1000.0);
  Serial.println(napiecie);
  Serial.println(odczytanawartosc);
  delay(1000);
  
}
