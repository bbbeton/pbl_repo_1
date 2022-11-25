PFont myFont;
int time;
void setup() {
  fullScreen();
  fill(0);
  background(0, 149, 255);
  firstSite();
  time=0;
}
void draw() {
while(time<3000){
time=millis();
  }
 
  OpenDoorSite();
  
}

void firstSite()
{
myFont = loadFont("Bauhaus93-120.vlw");
fill(230);
textFont(myFont);
text("Home Sweet Home", 60, 1100);
}

void OpenDoorSite()
{
background(0, 149, 255);
noStroke();
fill(230,230,230);
rect(0,2000,1100,400);

fill(0, 149, 255);
strokeWeight(5);
stroke(230);
rect(380, 1100,300,300,30);
triangle(468, 1170, 468, 1330, 609,1250);

  fill(230);
  textSize(70);
text("Click here to open a door", 150, 1500);
//clikn here to open a door
if (mousePressed) {
    if (mouseX > 380 && mouseX < 680 && mouseY > 1100 && mouseY < 1400 ) {
      fill(9, 74, 171);
      strokeWeight(5);
      stroke(230);
      rect(380, 1100,300,300,30);
      triangle(468, 1170, 468, 1330, 609,1250);
    } 
  }
}
