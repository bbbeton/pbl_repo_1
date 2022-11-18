PImage img;

void setup() {
  fullScreen();
  fill(0);
  background(50,50,50);
  img = loadImage("house.png");
}

void draw() {
  fill(240);
  textSize(110);
text("Home Sweet Home", 60, 200);
fill(0);
strokeWeight(10);
stroke(240);
rect(10, 1000, 500, 500,40);
fill(0);
rect(570, 1000, 500, 500,40);
fill(0);
rect(10, 1560, 1060, 600,40);

image(img, 255, 1250, 150, 150);
}
