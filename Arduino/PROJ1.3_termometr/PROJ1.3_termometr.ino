int lm35 = A0;
double a;
void setup() {
  pinMode(lm35,INPUT);
  Serial.begin(9600);
}

void loop() {
  delay(500);
  a=analogRead(lm35);
  Serial.println(a*((5000/1024.0)/10));
}
