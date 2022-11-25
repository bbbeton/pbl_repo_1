PFont myFont;
int time;
void setup() {
  fullScreen();
  fill(0);
  background(0, 149, 255);
 myFont = loadFont("Bauhaus93-120.vlw");
fill(230);
textFont(myFont);
text("Home Sweet Home", 60, 1100);
  time=0;
}
void draw() {
while(time<5000){
time=millis();
  }
  
background(0, 149, 255);
noStroke();
fill(230,230,230);
rect(0,2000,1100,400);

fill(0, 149, 255);
strokeWeight(5);
stroke(230);
rect(380, 1100,300,300,30);
triangle(461, 1170, 461, 1330, 600,1250);

  fill(230);
  textSize(50);
text("Click here to open a door", 265, 1500);
}
