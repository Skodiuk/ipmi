PImage img;
void setup(){
  size (800,400);
  img = loadImage("sandi.jpg");
}

void draw (){
  background (205,240,215);
  image (img,0,0,400,400);
  fill (#3FB754);
  noStroke();
  circle(506, 303,0);
  noStroke();
  circle(716, 306,0);
  noStroke();
  fill(255,255,255);
  bezier(504.0,309.0,508.0,345.0,724.0,344.0,724.0,310.0);
  
  
  
}

void mouseClicked(){
  println(mouseX, mouseY);

}
