int pin = 11;
int pot = A1;
int a; 
void setup() {
  pinMode(pin, OUTPUT);
  pinMode(pot, INPUT);
  Serial.begin(9600);
}

void loop() {
  a = analogRead(pot);
  analogWrite(pin,a/4);
  
}
