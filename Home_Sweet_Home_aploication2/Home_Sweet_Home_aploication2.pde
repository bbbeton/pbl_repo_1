import oscP5.*;
import netP5.*;

PFont myFont;
PImage drzwi_zamkniete_photo;
PImage drzwi_zamkniete_photo_dark;
PImage drzwi_otwarte_photo; 
PImage drzwi_otwarte_photo_dark; 
PImage temp_otwarte;
PImage temp_zamkniete;

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
Letter[] letters;

String message= "Home Sweet Home";
int opcje = 70;
int wifi;

//wifi
String remoteIP = "192.168.0.227";      //local IP plytki ESP
int remotePort = 8888;                  //port do wysylania
int localPort = 9999;                   //lokalny port
int otwarcie_drzwi = 0;

OscP5 oscP5;
NetAddress myRemoteLocation;

// klawiatura 

//import android.app.PendingIntent;
//import android.content.Intent;
//import android.os.Bundle;
import ketai.net.nfc.*;
import ketai.ui.*;                                        // 1

KetaiNFC ketaiNFC;

// ----------------------------------------------
//  to co jest potrzebne do komunikacji:
// ----------------------------------------------
// logowanie
String Password = "";
String Username = "";
// dodanie nowego czlonka
String newUserNumber = "";
String newUserName = "";
String newUserSurname = "";
int tempText; 
int NewUserSubmitted = 0; // gdy dane gotowe do przeslania == 1
// sygnal - chcemy dodac nowa karte
int newCard;                  //przycisk został klikniety == 1, czyli uzytkownik chce dodac nowa karte
// signing up
String NewUsername ="";
String NewPasswordRepeat = "";
String NewPassword = "";


void setup() {
  orientation(PORTRAIT); 
  fullScreen();
  fill(0);
  background(xb, yb, zb);
  //wifi
  oscP5 = new OscP5(this,localPort);
  myRemoteLocation = new NetAddress(remoteIP,remotePort);
  
  drzwi_zamkniete_photo = loadImage("drzwi_zamkniete.png");
  drzwi_otwarte_photo = loadImage("drzwi_otwarte.png");
  drzwi_zamkniete_photo_dark = loadImage("drzwi_zamkniete_dark.png");
  drzwi_otwarte_photo_dark = loadImage("drzwi_otwarte_dark.png");
  temp_zamkniete = loadImage("drzwi_zamkniete.png");
  temp_otwarte = loadImage("drzwi_otwarte.png");
  
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
  
  //myFont = createFont("Bauhaus93-120", 32);
  
  textFont(myFont);
  // Create the array the same size as the String
  letters = new Letter[message.length()];
  // Initialize Letters at the correct x location
  int x = 60;
  for (int i = 0; i < message.length(); i++) {
   letters[i] = new Letter(x,1100,message.charAt(i));
   x += textWidth(message.charAt(i));
   
   if (ketaiNFC == null)
    ketaiNFC = new KetaiNFC(this);
  
  }
}
void draw() {
  /*
 ZAKOMENTOWANE DO CZASU PRACY NAD RESZTĄ KODU
 -------------------------------------
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
    */
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
     
      image(temp_otwarte, 140, 0, 1100, 1100);

    }
    else if(otwarcie_drzwi == 13)
    {
      fill(0, 149, 255);
      strokeWeight(5);
      stroke(xc, yc, zc);
      rect(380, 1100,300,300,30);
      triangle(468, 1170, 468, 1330, 609,1250);
      image(drzwi_zamkniete_photo, 140, 0, 1100, 1100);
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
  case 7:
    SiteAddingNewCard();
    break;
  case 8:
    SiteSigningUp();
    break;
  case 70:
    SiteLoggingIn();
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
image(temp_zamkniete, 140, 0, 1100, 1100);

fill(xb, yb, zb);
strokeWeight(5);
stroke(xc, yc, zc);
rect(380, 1100,300,300,30);
triangle(468, 1170, 468, 1330, 609,1250);
fill(xc, yc, zc);
textSize(70);
textAlign(CENTER, BOTTOM);
text("Click here to open the door", width/2, 1500);

  // tu dodać ifa zamykajacego obrazek drzwi gdy drzwi zostana zamkniete albo uplynie czas
  
  textSize(70);
  strokeWeight(5);
  stroke(255);

}

void mousePressed()
{
  //clicking options
  if(opcje == 1 || opcje == 2 || opcje == 3 || opcje == 4 || opcje == 5){
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
  }
    switch(opcje){
  // historia wejsc
  case 1: 
    break;
  //  kamerka
  case 2:
    if (mouseX > width/2-400 && mouseX < width/2+400 && mouseY > height/2-350 && mouseY < height/2+350 ) {
      link("http://192.168.31.190/mjpeg/1");
    }
    break;
  // strona glowna
  case 3:
    if (mouseX > 380 && mouseX < 680 && mouseY > 1100 && mouseY < 1400 ) {
      fill(9, 74, 171);
      strokeWeight(5);
      stroke(230);
      rect(380, 1100,300,300,30);
      triangle(468, 1170, 468, 1330, 609,1250);
      otwarcie_drzwi = 22;
      OscMessage myMessage = new OscMessage("/int");
      myMessage.add(otwarcie_drzwi);
      oscP5.send(myMessage, myRemoteLocation); 
    } 
    break;
  // adding a new member
  case 4:
  // click here to add a new member
    if (mouseX > width/3 && mouseX < 2*width/3 && mouseY > (height/3  - 150) && mouseY < (height/3 + height/7 - 150) ) {
      fill(150);
      rect(width/3, height/3  - 150, width/3, height/7, 15);
      opcje = 6;
    }
  // click here to add a new card
    if (mouseX > width/3 && mouseX < 2*width/3 && mouseY > (height/3 +height/7 + 150) && mouseY < (height/3 + 2*height/7 + 150) ) {
      fill(150);
      rect(width/3, height/3 +height/7 + 150, width/3, height/7, 15);
      opcje = 7;
    }
    break;
  case 5:
    break;
  // site adding new member
  case 6:{
  // powrót do poprzedniej strony
  if (mouseX > 0 && mouseX < 75 && mouseY > 0 && mouseY < 75) {
    opcje = 4;
    SiteNewMember();
  }
    // otwieranie klawiatury
  if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 400 && mouseY < 500 ){
    // klawiatura
    KetaiKeyboard.toggle(this);                             
    newUserNumber = "";
    tempText=1;
    
  }
  else if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 800 && mouseY < 900){
    // klawiatura
    KetaiKeyboard.toggle(this);                             
    newUserName = "";
    tempText=2;
  }
  else if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 1200 && mouseY < 1300 ){
    // klawiatura
    KetaiKeyboard.toggle(this);
    newUserSurname = "";
    tempText=3;
  } else if (mouseX > (width/2 - 175) && mouseX < (width/2 + 175) && mouseY > (1525) && mouseY < (1875)){
    NewUserSubmitted = 1;
  }
  else {
    KetaiKeyboard.hide(this);
  }
  break;
  }
  
  // ADDING A CARD
  case 7: 
  if (mouseX > 0 && mouseX < 75 && mouseY > 0 && mouseY < 75) {
    opcje = 4;
    SiteNewMember();
  }
  break;
    
  // Sign up
  case 8: 
    // cofnięcie się do logowania
    if (mouseX > 0 && mouseX < 75 && mouseY > 0 && mouseY < 75) {
      opcje = 70;
      SiteLoggingIn();
      // otwieranie klawiatury
    if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 400 && mouseY < 500 ){
      // klawiatura
      KetaiKeyboard.toggle(this);                             
      NewUsername = "";
      tempText=6;
    
    }
    else if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 800 && mouseY < 900){
      // klawiatura
      KetaiKeyboard.toggle(this);                             
      NewPassword = "";
      tempText=7;
    }
    else if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 1200 && mouseY < 1300 ){
      // klawiatura
      KetaiKeyboard.toggle(this);
      NewPasswordRepeat = "";
      tempText=8;
    } else {
      KetaiKeyboard.hide(this);
    }
    }
    break;
  // SITE LOGGING IN
  case 70: 
  if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 400 && mouseY < 500 ){
    // klawiatura
    KetaiKeyboard.toggle(this);                             
    Username = "";
    tempText=4; 
  }
  else if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 800 && mouseY < 900){
    // klawiatura
    KetaiKeyboard.toggle(this);                             
    Password = "";
    tempText=5;
  } 
  // ------------------------ SUBMIT ---------------------------
  // zabezpieczyc kiedy dziala - login haslo sie zgadzaja+ przycisk klikniety -> przejscie na glowna strone
  else if (mouseX > (width/2 - 175) && mouseX < (width/2 + 175) && mouseY > (1525) && mouseY < (1875)){
    opcje = 3; // przejscie na strone główną
    OpenDoorSite();
  }
  // przejscie 
  else if(mouseX > (333) && mouseX < (758) && mouseY > (1950) && mouseY < (2050)){
   opcje = 8; // tworzenie nowego konta - signing up 
   SiteSigningUp();
  } else {
    KetaiKeyboard.hide(this);
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

  
  textSize(70);
  strokeWeight(5);
  stroke(255);
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
  
  textSize(70);
  strokeWeight(5);
  stroke(255);  
}

// nowy czlonek strona 4
void SiteNewMember(){
  strokeWeight(5);
  background(xb, yb, zb);
  dolnyPasek();
  image(newMember_po_photo, 3*width/5, 2050, width/5, width/5);

  fill(255);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  textSize(75);
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
  text("to the application!", (width/2), (500));
  
  // przycisk dodania nowego użytkownika
  fill(210);
  rect(width/3, height/3  - 150, width/3, height/7, 15);
  textSize(70);
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("Add", (width/2), (height/3 - 50));
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("a new", (width/2), (height/3 + 50));
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("member", (width/2), (height/3 + 150));
  
  fill(255);
  textAlign(CENTER, BOTTOM);
  textSize(60);
  line(0, 120, width, 120);
  text("If you want to add a new card", (width/2), (height/3 + 330));
  text("Click here", (width/2), (height/3 + 400));
  
  // przycisk dodania nowej karty
  fill(210);
  rect(width/3, height/3 +height/7 + 150, width/3, height/7, 15);
  textSize(70);
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("Add", (width/2), (height/3 +height/7 + 250));
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("a new", (width/2), (height/3 +height/7 + 350));
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("card", (width/2), (height/3 +height/7 + 450));
  
  textSize(70);
  strokeWeight(5);
  stroke(255);
  
}
// ustawienia strona 5
void SiteUstawienia() {
  background(xb, yb, zb);
  
  strokeWeight(5);
  stroke(255);
  
  dolnyPasek();
  image(ustawienia_po_photo, 4*width/5, 2050, width/5, width/5);
  textSize(60);
  fill(xc, yc, zc);
  textAlign(CENTER, CENTER);
  text("Change to bright/ dark color theme", width/2,  (100));
  fill(0, 149, 255);
  rect((width/2-width/5), 200, width/5, height/6, 10);
  fill(xd, yd, zd);
  rect(width/2, 200, width/5, height/6, 10);
  // po kliknieciu zmiana koloru
  // bright
  if (mouseX > (width/2-width/5) && mouseX < (width/2) && mouseY > (200) && mouseY < (200 + height/6) ){
    xb = 0;
    yb = 149;
    zb = 255; 
    temp_otwarte = drzwi_zamkniete_photo;
    temp_zamkniete = drzwi_zamkniete_photo;
  }
  // dark
  if (mouseX > (width/2) && mouseX < (width/2+width/5) && mouseY > (200) && mouseY < (200 + height/6) ){
    xb = 13;
    yb = 32;
    zb = 140;
    temp_otwarte = drzwi_otwarte_photo_dark; 
    temp_zamkniete = drzwi_zamkniete_photo_dark;
  }
  textSize(70);
  strokeWeight(5);
  stroke(255);
}

void SiteAddingNewMember() {
  NewUserSubmitted = 0;
  newCard = 0;
  strokeWeight(5);
  background(xb, yb, zb);
  textSize(60);
  // tutaj zeby sie cofnac trzeba kliknac strzaleczke w lewym gornym rogu
  fill(xc, yc, zc);
  textAlign(CENTER, CENTER);
  text("Provide the number of the new user", (width/2), (350));
  fill(xc, yc, zc);
  rect(width/8, 400, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  text(newUserNumber, width/8 + 20, 177+250, 3*width/4, 100);
  
  fill(xc, yc, zc);
  textAlign(CENTER, CENTER);
  text("Provide the name of the new user", (width/2), (750));
  fill(xc, yc, zc);
  rect(width/8, 800, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  text(newUserName, width/8 + 20, 577 + 250, 3*width/4, 100);
  
  fill(xc, yc, zc);
  textAlign(CENTER, CENTER);  
  text("Provide the surname of the new user", (width/2), (1150));
  fill(xc, yc, zc);
  rect(width/8, 1200, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  text(newUserSurname, width/8 + 20, 977 + 250, 3*width/4, 100);
  textSize(70);
  
  rectMode(CENTER);
  fill(255);
  rect(width/2, 1700, 350, 350);
  rectMode(CORNER);
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(90);
  text("Submit", width/2, 1700);
  
  // rysowanie strzałeczki with geometric shapes
  strokeWeight(5);
  stroke(255);
  fill(xb, yb, zb);
  rect(0,0, 120, 120, 0);
  noStroke();
  fill(255);
  rect(40, 50, 60, 20, 0);
  triangle(60, 95, 60 , 25, 20, 60);
  
  textSize(70);
  strokeWeight(5);
  stroke(255);
}

void SiteAddingNewCard(){
  newCard = 0;
  background(xb, yb, zb);
  strokeWeight(5);
  stroke(255);
  
  fill(255);
  textAlign(CENTER, TOP);
  textSize(70);
  text("Press the button", width/2, (height/6 + 90));
  text("to activate pairing", width/2, (height/6 + 200));  
  fill(42, 62, 175);
  rectMode(CENTER);
  rect(width/2, height/6 + 500, 2*width/5, 2*width/5);
  rectMode(CORNER);
  
  if(mouseX > (width/2 - 2*width/5) && mouseX < (width/2 + 2*width/5) && mouseY > (height/6 + 600 - 2*width/5 - 100) && mouseY < (height/6 + 600 + 2*width/5 - 100)){
    newCard = 1;
  }
  switch (newCard){
  case 1: {
    fill(255);
    textAlign(CENTER, TOP);
    //line(0, 120, width, 120);
    textSize(100);
    text("Touch the scanner", width/2, (2* height/3));
    text("with your new card", width/2, (2 * height/3  + 100));
    break;
  }
  default:
  break;
  }
  
  // rysowanie strzałeczki with geometric shapes
  strokeWeight(5);
  stroke(255);
  fill(xb, yb, zb);
  rect(0,0, 120, 120, 0);
  noStroke();
  fill(255);
  rect(40, 50, 60, 20, 0);
  triangle(60, 95, 60 , 25, 20, 60);
  
  textSize(70);
  strokeWeight(5);
  stroke(255);
}

void SiteLoggingIn(){
  strokeWeight(5);
  background(xb, yb, zb);
  textSize(60);
  
  fill(255);
  text("Hello there", width/2, 200);
  fill(xc, yc, zc);
  textAlign(CENTER, CENTER);
  text("Username / name", (width/2), (350));
  fill(xc, yc, zc);
  rect(width/8, 400, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  text(Username, width/8 + 20, 177+250, 3*width/4, 100);
  
  fill(xc, yc, zc);
  textAlign(CENTER, CENTER);
  text("Password", (width/2), (750));
  fill(xc, yc, zc);
  rect(width/8, 800, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  text(Password, width/8 + 20, 577 + 250, 3*width/4, 100);
  
  rectMode(CENTER);
  fill(255);
  rect(width/2, 1700, 350, 350);
  rectMode(CORNER);
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(90);
  text("Submit", width/2, 1700);
  
  fill(0);
  text("Sign in", width/2, 2000);
  fill(0);
  line(width/3, 2050, 2*width/3, 2050);
  
  
}
void SiteSigningUp(){
  strokeWeight(5);
  background(xb, yb, zb);
  textSize(60);
  
  fill(0);
  textAlign(CENTER, CENTER);
  text("To log in", width/2, 100);
  text("Fill out the form below:", width/2, 175);
  fill(0);
  textAlign(CENTER, CENTER);
  text("New: Username / name", (width/2), (350));
  fill(xc, yc, zc);
  rect(width/8, 400, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  text(NewUsername, width/8 + 20, 177+250, 3*width/4, 100);
  
  fill(0);
  textAlign(CENTER, CENTER);
  text("Password:", (width/2), (750));
  fill(xc, yc, zc);
  rect(width/8, 800, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  text(NewPassword, width/8 + 20, 577 + 250, 3*width/4, 100);

  fill(0);
  textAlign(CENTER, CENTER);
  text("Repeat the Password:", (width/2), (1050));
  fill(xc, yc, zc);
  rect(width/8, 1200, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  text(NewPasswordRepeat, width/8 + 20, 977 + 250, 3*width/4, 100);
  
  rectMode(CENTER);
  fill(255);
  rect(width/2, 1700, 350, 350);
  rectMode(CORNER);
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(90);
  text("Submit", width/2, 1700);  
  
  // rysowanie strzałeczki with geometric shapes
  strokeWeight(5);
  stroke(255);
  fill(xb, yb, zb);
  rect(0,0, 120, 120, 0);
  noStroke();
  fill(255);
  rect(40, 50, 60, 20, 0);
  triangle(60, 95, 60 , 25, 20, 60);
  
  textSize(70);
  strokeWeight(5);
  stroke(255);
  
  fill(255);
  
}


void keyPressed() {
  if (key != CODED)                                       
  {
    //tagStatus = "Write URL, then press ENTER to transmit";
    switch(tempText)
    {
    case 1:
      newUserNumber += key;
      break;
    case 2:
      newUserName += key;
      break;    
    case 3:
      newUserSurname += key;
      break;
    case 4:
      Username += key;
      break;
    case 5:
      Password += key;
      break;
    case 6:
      NewUsername += key;
      break;
    case 7:
      NewPassword += key;
      break;
    case 8:
      NewPasswordRepeat += key;
      break;
    default:
      break;
    }
    
    
  }
   if (keyCode == 67)
  {
    switch(tempText)
    {
    case 1:
      newUserNumber = newUserNumber.substring(0, newUserNumber.length()-1);      
      break;
    case 2:
      newUserName = newUserName.substring(0, newUserName.length()-1);
      break;    
    case 3:
      newUserSurname = newUserSurname.substring(0, newUserSurname.length()-1);
      break;
    case 4:
      Username = Username.substring(0, Username.length()-1);
      break;
    case 5:
      Password = Password.substring(0, Password.length()-1);
      break;
    case 6:
      NewUsername = NewUsername.substring(0, NewUsername.length()-1);
      break;
    case 7:
      NewPasswordRepeat = NewPasswordRepeat.substring(0, NewPasswordRepeat.length()-1);
      break;
    case 8:
      NewPassword = NewPassword.substring(0, NewPassword.length()-1);
      break;
    default:
      break;
    }
  }
}

void oscEvent(OscMessage theOscMessage)
{
  otwarcie_drzwi = theOscMessage.get(0).intValue();
}
