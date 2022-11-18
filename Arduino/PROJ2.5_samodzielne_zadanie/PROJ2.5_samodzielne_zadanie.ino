unsigned long czasaktualny = 0;
unsigned long zapamietanyczas = 0;
int stanLED=LOW;
#define dioda 6
#define trigPin 12
#define echoPin 11
void setup(){
  pinMode(trigPin,OUTPUT);
  pinMode(echoPin,INPUT);
  pinMode(dioda,OUTPUT);
}
void loop(){
  zakres(5,7);
}
int zmierzodleglosc{
  long czas, dystans;
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  czas = pulseIn(ehoPin,HIGH);
  dystans = czas/58
}
void zakres(int a, int b){
  int jakdaleko = zmierzodleglosc();
  if ((jakDaleko > a) && (jakDaleko < b)) {
  
}
