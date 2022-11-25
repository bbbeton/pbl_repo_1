#define trigPin 12
#define echoPin 11
void setup() {
Serial.begin (9600);
pinMode(trigPin, OUTPUT); //Pin, do którego podłączymy trig jako wyjście
pinMode(echoPin, INPUT); //a echo, jako wejście
pinMode(5, OUTPUT); //Wyjście dla buzzera
}
void loop() {
zakres(5,7); //Włącz alarm, jeśli w odległości od 10 do 25 cm od czujnika jest przeszkoda
delay(100);
}
int zmierzOdleglosc() {
long czas, dystans;
digitalWrite(trigPin, LOW);
delayMicroseconds(2);
digitalWrite(trigPin, HIGH);
delayMicroseconds(10);
digitalWrite(trigPin, LOW);
czas = pulseIn(echoPin, HIGH);
dystans = czas / 58;
return dystans;
}
void zakres(int a, int b) {
int jakDaleko = zmierzOdleglosc();
if ((jakDaleko > a) && (jakDaleko < b)) {
analogWrite(5, 230); //Włączamy buzzer
} else {
analogWrite(5, 0); //Wyłączamy buzzer, gdy obiekt poza zakresem
}
}
