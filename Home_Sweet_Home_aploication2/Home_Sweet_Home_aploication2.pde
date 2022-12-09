PFont myFont;
int time;
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
void setup() {
  orientation(PORTRAIT); 
  fullScreen();
  fill(0);
  background(0, 149, 255);
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
  time=0;
}
void draw() {
 if(millis()<3000)
 {
 firstSite();
 }
 else
 {
  OpenDoorSite();
 }
  
}

void firstSite()
{
myFont = loadFont("Bauhaus93-120.vlw");
fill(230);
textFont(myFont);
text(logo, 60, 1100);
}

void OpenDoorSite()
{
background(0, 149, 255);
noStroke();
fill(230,230,230);
//rect(0,2000,1100,400);
image(drzwi_zamkniete_photo, 140, 0, 1100, 1100);
image(ustawienia_przed_photo, 3*width/4, 2050, width/4, width/4);
image(kamera_przed_photo, width/4, 2050, width/4, width/4);
image(newMember_przed_photo, 2*width/4, 2050, width/4, width/4);
image(historia_przed_photo, 0, 2050, width/4, width/4);

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
  switch(opcje){
    case '1': 
      pageHistoriaWejsc();
      break;
//    case '2': 
//      break;
//    case '3': 
//      break;
//    case '4': 
//      break;
    default:
      break;
  }
}
}
int clickingOptions()
{
  //clicking options
    // historia wejść
    if ( mouseX < width/4 && mouseY > 2050) {
      
      noStroke();
      fill(150);
      //rect(0, 2000,width/4,400);
      image(historia_po_photo, 0, 2050, width/4, width/4);
      return 1;
    } 
    // kamera
    if ( mouseX > width/4 && mouseX < width/2 && mouseY > 2050) {
      noStroke();
      fill(150);
      //rect(width/4, 2000, width/4, 400);
      image(kamera_po_photo, width/4, 2050, width/4, width/4);
      return 2;
    } 
    // adding a new member
    if ( mouseX > width/2 && mouseX < 3*width/4 && mouseY > 2050) {
      noStroke();
      fill(150);
      //rect(width/2, 2000, width/4, 400);
      image(newMember_po_photo, 2*width/4, 2050, width/4, width/4);
      return 3;
    } 
    // ustawienia
    if ( mouseX > 3*width/4 && mouseY > 2050) {
      noStroke();
      fill(150);
      //rect(3*width/4, 2000,width/4,400);
      image(ustawienia_po_photo, 3*width/4, 2050, width/4, width/4 );
      return 4;
    } 
    else
    return 0;
}

void pageHistoriaWejsc(){
  
}
