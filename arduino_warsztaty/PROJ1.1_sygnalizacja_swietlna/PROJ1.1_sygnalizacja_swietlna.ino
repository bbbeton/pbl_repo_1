int RED = 11;
int YLW = 10;
int GRN = 9;

void setup() {
  Serial.begin(9600);
  pinMode(RED, OUTPUT);
  pinMode(YLW, OUTPUT);
  pinMode(GRN, OUTPUT);
}
int jasnosc1=0;
int jasnosc2=0;
int jasnosc3=0;
void loop() {
  
  if(Serial.available()>2){
    jasnosc1 = Serial.read();
    jasnosc2 = Serial.read();
    jasnosc3 = Serial.read();
  
  }
    analogWrite(RED,jasnosc1);
    delay(2000);
    analogWrite(YLW, jasnosc2);
    delay(2000);
    analogWrite(RED, 0);
    analogWrite(YLW, 0);
    analogWrite(GRN, jasnosc3);
    delay(2000);
    analogWrite(GRN, 0);
    analogWrite(YLW, jasnosc2);
    delay(2000);
    analogWrite(YLW, 0); 
}
