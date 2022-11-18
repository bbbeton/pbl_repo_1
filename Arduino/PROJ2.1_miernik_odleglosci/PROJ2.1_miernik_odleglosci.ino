#define trigPin 12
#define echoPin 11
void setup() {
  Serial.begin (9600);
  pinMode(trigPin, OUTPUT); //Pin, do którego podłączymy trig jako wyjście
  pinMode(echoPin, INPUT); //a echo, jako wejście
}
void loop() {
  Serial.print(zmierzOdleglosc());
  Serial.println(" mm");
  delay(10);
}
// FUNKCJA MIERZACA ODLEGLOSC W CM
int zmierzOdleglosc() {
  long czas, dystans;
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  czas = pulseIn(echoPin, HIGH);
  dystans = czas / 5,8;
  return dystans;
}
