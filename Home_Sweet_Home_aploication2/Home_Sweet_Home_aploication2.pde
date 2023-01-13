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
PImage ikona_drzwi_po;
PImage ikona_drzwi;
PImage ikona_kamera;

String logo = "Home Sweet Home";
float time;
//animation step
float a;
float b;
float c;
int y;
int k;
int otwarcie_drzwi;
// colors
// background colors bright
float xb=0;
float yb=149;
float zb=255;
// background colors dark
float xd = 13;
float yd = 32;
float zd = 140;
// text colors on the background
float xc = 250; 
float yc = 250;
float zc = 250;
// button colors
float xp = 200;
float yp = 200;
float zp = 200;

String message= "Home Sweet Home";
int opcje = 3;
int wifi;

// keyboard
boolean keyboard = false;
int value;

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
  ikona_drzwi_po = loadImage("ikona_drzwi_po.png");
  ikona_drzwi = loadImage("ikona_drzwi.png");
  ikona_kamera = loadImage("ikona_kamera.png");
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
// ZAKOMENTOWANE DO CZASU PRACY NAD RESZTĄ KODU
// -------------------------------------
// if(millis()<6000)
// {
//    time=5000/30;
//  background(xb, yb, zb);
// for (int i = 0; i < letters.length + 15; i++) {
//    // Display all letters
//a=15.333333333;
//b=5.4;
//c=1.666666666;
//    if(millis()>time)
//    {
//      if(i>=15)
//      {
//        y=15;
//         for(k=i-15; k<15;k++)
//      {
//         letters[k].display(y*a+xb,y*b +yb,zb-y*c);
//         y--;
//      }
//      for(k=i-15;k>=0;k--)
//      letters[k].display(230,230,230);
//      }
//      else
//      {
//        y=1;
//      for(k=i; k>=0;k--)
//      {
//         letters[k].display(y*a+xb,y*b +yb,zb-y*c);
//         y++;
//      }
//      }
//      
//    }
//    time+=5000/30;
//  }
//  }
//  else
//  {
  // różne strony
  switch(opcje){
  case 1: 
    SiteHistoriaWejsc();
    break;
  case 2:
    SiteKamerka();
    break;
  case 3:
    OpenDoorSite();
    if(otwarcie_drzwi == 22){
      fill(9, 74, 171);
      strokeWeight(5);
      stroke(230);
      rect(380, 1100,300,300,30);
      triangle(468, 1170, 468, 1330, 609,1250);
      image(drzwi_otwarte_photo, 140, 0, 1100, 1100);
    }
    break;
  case 4:
    SiteNewMember();
    break;
  case 5:
    SiteUstawienia();
    break;
  case 6:
  SiteAddingNewMember();
  break;
  default:
    break;
  }

  } 
//} DO ODKOMENTOWANIA GDY BEDZIEMY WLACZAC OTWIERANIE APKI
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
background(xb, yb, zb);
noStroke();
dolnyPasek();
image(ikona_drzwi_po, 2*width/5, 2050, width/5, width/5);
fill(xc, yc, zc);
image(drzwi_zamkniete_photo, 140, 0, 1100, 1100);

fill(0, 149, 255);
strokeWeight(5);
stroke(xc, yc, zc);
rect(380, 1100,300,300,30);
triangle(468, 1170, 468, 1330, 609,1250);
fill(xc, yc, zc);
textSize(70);
textAlign(CENTER, BOTTOM);
text("Click here to open the door", width/2, 1500);

  // tu dodać ifa zamykajacego obrazek drzwi gdy drzwi zostana zamkniete albo uplynie czas

}

void mousePressed()
{
  //clicking options
    // historia wejść
    if ( mouseX < width/5 && mouseY > 2050) {
      opcje=1;
    } 
    // kamera
    if ( mouseX > width/5 && mouseX < 2*width/5 && mouseY > 2050) {
      opcje=2;
    } 
    // strona główna
    if ( mouseX > 2*width/5 && mouseX < 3*width/5 && mouseY > 2050) {
      opcje=3;
    }
    // adding a new member
    if ( mouseX > 3*width/5 && mouseX < 4*width/5 && mouseY > 2050) {
      opcje=4;
    } 
    // ustawienia
    if ( mouseX > 4*width/5 && mouseY > 2050) {
      opcje=5;
    }
    switch(opcje){
  case 1: 
    break;
  case 2:
    if (mouseX > width/2-400 && mouseX < width/2+400 && mouseY > height/2-350 && mouseY < height/2+350 ) {
      link("http://192.168.31.190/mjpeg/1");
    }
    break;
  case 3:
    if (mouseX > 380 && mouseX < 680 && mouseY > 1100 && mouseY < 1400 ) {
      otwarcie_drzwi = 22;
    } 
    break;
  case 4:
  //clik here to add a new member
    if (mouseX > width/3 && mouseX < 2*width/3 && mouseY > height/3 && mouseY < (height/3 + height/7) ) {
      opcje=6;
    }
    break;
  case 5:
    
    break;
  case 6:
  if (mouseX > 0 && mouseX < 50 && mouseY > 0 && mouseY < 50) {
      opcje=4;
    } 
  break;
  default:
    break;
  }
    
    }
   

void dolnyPasek(){
  rect(0, 2050, 0, 0, 0);
  image(historia_przed_photo, 0, 2050, width/5, width/5);
  image(kamera_przed_photo, width/5, 2050, width/5, width/5);
  image(ikona_drzwi, 2*width/5, 2050, width/5, width/5);
  image(newMember_przed_photo, 3*width/5, 2050, width/5, width/5);
  image(ustawienia_przed_photo, 4*width/5, 2050, width/5, width/5);
}
// historia wejsc strona 1
void SiteHistoriaWejsc(){
  background(xb, yb, zb);
  dolnyPasek();
  image(historia_po_photo, 0, 2050, width/5, width/5);
  fill(xc, yc, zc);
  rect(width/7, width/7, 5*width/7, 5*height/7, 15);
  // wstawiamy liste kto wchodzil 

}
// kamerka strona 2
void SiteKamerka(){
  background(xb, yb, zb);
  dolnyPasek();
  image(kamera_po_photo, width/5, 2050, width/5, width/5);
  // tu trzeba dodać link do strony z widokiem z kamerki
  fill(250);
  textSize(100);
  text("Click the icon to see camera view",100,100,850,500);
  image(ikona_kamera,width/2-500, height/2-500, 1000, 1000);
  
  
}
// nowy czlonek strona 4
void SiteNewMember(){
  background(xb, yb, zb);
  dolnyPasek();
  image(newMember_po_photo, 3*width/5, 2050, width/5, width/5);
  fill(230);
  rect(width/3, height/3, width/3, height/7, 15);
  textSize(70);
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("Add", (width/2), (height/3 + 100 ));
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("a new", (width/2), (height/3 + 200));
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("member", (width/2), (height/3 + 300));
  fill(255);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("Hello!", (width/2), (100));
  fill(255);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  textSize(60);
  text("Do you want to let someone", (width/2), (200));
  fill(255);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  textSize(60);
  text("have access to your house?", (width/2), (300));
  fill(255);
  textAlign(CENTER, BOTTOM);
  textSize(60);
  line(0, 120, width, 120);
  text("First you have to pair their device", (width/2), (400));
  fill(255);
  textAlign(CENTER, BOTTOM);
  textSize(60);
  line(0, 120, width, 120);
  text("to the aplication!", (width/2), (500));
  
}
// ustawienia strona 5
void SiteUstawienia() {
  background(xb, yb, zb);
  dolnyPasek();
  image(ustawienia_po_photo, 4*width/5, 2050, width/5, width/5);
  textSize(60);
  fill(xc, yc, zc);
  text("Change to bright/ dark color theme", width/2,  (100));
  fill(0, 149, 255);
  rect(width/3, height/3, width/6, height/5, 10);
  fill(xd, yd, zd);
  rect(width/2, height/3, width/6, height/5, 10);
  // po kliknieciu zmiana koloru
  // bright
  if (mouseX > (width/3) && mouseX < (width/2) && mouseY > (height/3) && mouseY < (height/3 + height/5) ){
    xb = 0;
    yb = 149;
    zb = 255;
  }
  // dark
  if (mouseX > (width/2) && mouseX < (2*width/3) && mouseY > (height/3) && mouseY < (height/3 + height/5) ){
    xb = 13;
    yb = 32;
    zb = 140;
  }
  // ZMIANA TRYBU NA JASNY CIEMNY
  // po kliknieciu jej wartość się zmienia 
  // deafult - (0, 149, 255) dark -  bright - 
}
void SiteAddingNewMember() {
  background(xb, yb, zb);
  // tutaj zeby sie cofnac trzeba kliknac strzaleczke w lewym gornym rogu
  fill(xc, yc, zc);
  textSize(50);
  text("Provide the number of the new user", (width/2), (100));
  fill(xc, yc, zc);
  rect(width/8, 150, 3*width/4, 100, 10);
  text("Provide the name of the new user", (width/2), (500));
  fill(xc, yc, zc);
  rect(width/8, 550, 3*width/4, 100, 10);
  text("Provide the surname of the new user", (width/2), (900));
  fill(xc, yc, zc);
  rect(width/8, 950, 3*width/4, 100, 10);
  // otwieranie klawiatury
  if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 150 && mouseY < 250 ){
    keyboardPressed();
    text(key, width/8, 150);
}

//  }
//  if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 550 && mouseY < 550){

//  }
//  if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 950 && mouseY < 1050 ){

//  }

  
  
  // rysowanie strzałeczki with geometric shapes
  fill(xp, yp, zp);
  rect(30, 50, 50, 10, 0);
  triangle(60, 30, 50, 50, 100, 0);
}

void keyboardPressed() {
  if (!keyboard) {
    openKeyboard();
    keyboard = true;
  } else {
    closeKeyboard();
    keyboard = false;
  }
}

void keyPressed() {
  if (value == 0) {
    value = 255;
  } else {
    value = 0;
  }
}
