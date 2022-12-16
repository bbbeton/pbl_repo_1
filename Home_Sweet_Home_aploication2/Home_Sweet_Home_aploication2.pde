PFont myFont;
PImage drzwi_zamkniete_photo;
PImage drzwi_otwarte_photo; 
PImage ustawienia_przed_photo;
PImage ustawienia_po_photo;
PImage kamera_przed_photo;
PImage kamera_po_photo;
PImage newMember_przed_photo;
PImage newMember_po_photo;
PImage historia_przed_photo;
PImage historia_po_photo;

String logo = "Home Sweet Home";
float time;
//animation step
float a;
float b;
float c;
int y;
int k;
//bacground
float xb=0;
float yb=149;
float zb=255;
String message= "Home Sweet Home";
Letter[] letters;
void setup() {
  orientation(PORTRAIT); 
  fullScreen();
  fill(0);
  background(xb, yb, zb);
  drzwi_zamkniete_photo = loadImage("drzwi_zamkniete.png");
  drzwi_otwarte_photo = loadImage("drzwi_otwarte.png");
  ustawienia_przed_photo = loadImage("ustawienia_przed.png");
  ustawienia_po_photo = loadImage("ustawienia_po.png");
  kamera_przed_photo = loadImage("kamera_przed.png");
  kamera_po_photo = loadImage("kamera_po.png");
  newMember_przed_photo = loadImage("newMember_przed.png");
  newMember_po_photo = loadImage("newMember_po.png");
  historia_przed_photo = loadImage("log_wejsc_przed.png");
  historia_po_photo = loadImage("log_wejsc_po.png");
  myFont = loadFont("Bauhaus93-120.vlw"); //czcionka
  textFont(myFont);
  // Create the array the same size as the String
  letters = new Letter[message.length()];
  // Initialize Letters at the correct x location
  int x = 60;
  for (int i = 0; i < message.length(); i++) {
   letters[i] = new Letter(x,1100,message.charAt(i));
   x += textWidth(message.charAt(i));
  }
}
void draw() {
 if(millis()<6000)
 {
    time=5000/30;
  background(xb, yb, zb);
 for (int i = 0; i < letters.length + 15; i++) {
    // Display all letters
a=15.333333333;
b=5.4;
c=1.666666666;
    if(millis()>time)
    {
      if(i>=15)
      {
        y=15;
         for(k=i-15; k<15;k++)
      {
         letters[k].display(y*a+xb,y*b +yb,zb-y*c);
         y--;
      }
      for(k=i-15;k>=0;k--)
      letters[k].display(230,230,230);
      }
      else
      {
        y=1;
      for(k=i; k>=0;k--)
      {
         letters[k].display(y*a+xb,y*b +yb,zb-y*c);
         y++;
      }
      }
      
    }
    time+=5000/30;
  }
 
 }
 else
 {
  OpenDoorSite();
  int opcje = clickingOptions();
  // różne strony
  switch(opcje){
  case 1: 
    SiteHistoriaWejsc();
    break;
  case 2:
    SiteKamerka();
    break;
  case 3:
    SiteNewMember();
    break;
  case 4:
    SiteUstawienia();
    break;
  default:
    break;
}
 }
  
}

class Letter {
  char letter;
  // The object knows its original "home" location
  float homex,homey;
  // As well as its current location
  float x,y;

  Letter (float x_, float y_, char letter_) {
    homex = x = x_;
    homey = y = y_;
    letter = letter_;
  }

  // Display the letter
  void display(float a,float b,float c) {
      fill(a,b,c);
    text(letter,x,y);
  }
}
 void OpenDoorSite()
{
background(0, 149, 255);
noStroke();
fill(230,230,230);
image(drzwi_zamkniete_photo, 140, 0, 1100, 1100);
dolnyPasek();

fill(0, 149, 255);
strokeWeight(5);
stroke(230);
rect(380, 1100,300,300,30);
triangle(468, 1170, 468, 1330, 609,1250);

fill(230);
textSize(70);
text("Click here to open the door", 100, 1500);

  if (mousePressed) {
  //clik here to open a door
    if (mouseX > 380 && mouseX < 680 && mouseY > 1100 && mouseY < 1400 ) {
      fill(9, 74, 171);
      strokeWeight(5);
      stroke(230);
      rect(380, 1100,300,300,30);
      triangle(468, 1170, 468, 1330, 609,1250);
      image(drzwi_otwarte_photo, 140, 0, 1100, 1100);
    } 
    int opcje = clickingOptions();
  }
}

int clickingOptions()
{
  //clicking options
    // historia wejść
    if ( mouseX < width/5 && mouseY > 2050) {
      
      noStroke();
      fill(150);
      image(historia_po_photo, 0, 2050, width/5, width/5);
      return 1;
    } 
    // kamera
    if ( mouseX > width/5 && mouseX < 2*width/5 && mouseY > 2050) {
      noStroke();
      fill(150);
      image(kamera_po_photo, width/5, 2050, width/5, width/5);
      return 2;
    } 
    // adding a new member
    if ( mouseX > 3*width/5 && mouseX < 4*width/5 && mouseY > 2050) {
      noStroke();
      fill(150);
      image(newMember_po_photo, 3*width/5, 2050, width/5, width/5);
      return 3;
    } 
    // ustawienia
    if ( mouseX > 4*width/5 && mouseY > 2050) {
      noStroke();
      fill(150);
      image(ustawienia_po_photo, 4*width/5, 2050, width/5, width/5);
      return 4;
    } 
    else
    return 0;
}
void dolnyPasek(){
  rect(0, 2050, 0, 0, 0);
  image(historia_przed_photo, 0, 2050, width/5, width/5);
  image(kamera_przed_photo, width/5, 2050, width/5, width/5);
  image(newMember_przed_photo, 3*width/5, 2050, width/5, width/5);
  image(ustawienia_przed_photo, 4*width/5, 2050, width/5, width/5);
}
// historia wejsc strona 1
void SiteHistoriaWejsc(){
  background(0, 149, 255);
  dolnyPasek();
  int opcje = clickingOptions();
  
}
// kamerka strona 2
void SiteKamerka(){
  background(0, 149, 255);
  dolnyPasek();
  int opcje = clickingOptions();
  
}
// nowy czlonek strona 3
void SiteNewMember(){
  background(0, 149, 255);
  dolnyPasek();
  int opcje = clickingOptions();
  
}
// ustawienia strona 4
void SiteUstawienia(){
  background(0, 149, 255);
  dolnyPasek();
  int opcje = clickingOptions();
  
}
