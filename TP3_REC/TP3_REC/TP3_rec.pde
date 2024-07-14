//Alumno: Mateo Bruny
//Legajo: 120283/6
//Comision Nº5
// Video: https://youtu.be/CVXehc57crE

PImage img;  // Variable para almacenar la imagen
int gridSize = 10;  // Tamaño de la cuadrícula
int patternType = 1;  // Tipo de patrón
int cols, rows;
float angle = 0;
float offset = 0.05;
float spacing = 0.1;
boolean showStatic = true;  // Muestra el patrón estático
PFont font;

void setup() {
  size(800, 400);
  img = loadImage("op-art.jpg");  // Carga la imagen 
  cols = (width / 2) / gridSize;  // Calcula columnas para la mitad derecha
  rows = height / gridSize;  // Calcula filas para toda la ventana
  font = createFont("Arial", 16, true);  // Crea la fuente para el botón
}

void draw() {
  background(255);
  
  // Dibuja la imagen en la parte izquierda
  if (showStatic) {
    pushMatrix();
    translate(width / 4, height / 2);
    imageMode(CENTER);
    image(img, 0, 0, width / 2, height);  // Dibuja la imagen ajustada a la mitad izquierda de la ventana
    popMatrix();
  }
  
  // Dibuja la figura dinámica en la parte derecha
  for (int i = cols; i < 2 * cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = i * gridSize;
      float y = j * gridSize;
      if (patternType == 1) {
        drawPattern1(x, y, gridSize);
      } else {
        drawPattern2(x, y, gridSize);
      }
    }
  }
  
  // Dibuja el botón de reinicio en la parte inferior izquierda
  drawResetButton();
}

void drawPattern1(float x, float y, float size) {
  float d = dist(mouseX, mouseY, x + size / 2, y + size / 2);
  float offset = map(d, 0, max(width, height), -PI, PI);
  float s = map(sin(angle + offset), -1, 1, size * 0.5, size * 2);
  fill(0);
  ellipse(x + size / 2, y + size / 2, s, s);
}

void drawPattern2(float x, float y, float size) {
  float d = dist(mouseX, mouseY, x + size / 2, y + size / 2);
  float offset = map(d, 0, max(width, height), -PI, PI);
  float s = map(cos(angle + offset), -1, 1, size * 0.5, size * 2);
  fill(0);
  rect(x + size / 2 - s / 2, y + size / 2 - s / 2, s, s);
}

void keyPressed() {
  if (key == '1') {
    patternType = 1;
  } else if (key == '2') {
    patternType = 2;
  } else if (key == 'r') {
    resetPattern();
  }
}

void resetPattern() {
  gridSize = 10;
  patternType = 1;
  angle = 0;
  offset = 0.05;
}

void mouseMoved() {
  angle += offset;
}

void mousePressed() {
  if (mouseX < 100 && mouseY > height - 50) {
    resetPattern();
  } else {
    offset = random(0.01, 0.1);
  }
}

void drawResetButton() {
  fill(200);
  rect(10, height - 40, 80, 30);
  fill(0);
  textFont(font);
  textAlign(CENTER, CENTER);
  text("Reiniciar", 50, height - 25);
}

float calculateDistance(float x1, float y1, float x2, float y2) {
  return dist(x1, y1, x2, y2);
}
