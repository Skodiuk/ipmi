// Variables para la presentación
int screenWidth = 640;  // Ancho de la pantalla
int screenHeight = 480;  // Altura de la pantalla
int currentScreen = -1;  // Pantalla actual (-1 indica que está en la pantalla de inicio)
int totalScreens = 3;  // Número total de pantallas de presentación
int resetScreen = totalScreens;  // Pantalla de reinicio
PImage[] images;  // Arreglo de imágenes
String[][] texts = {  // Textos de cada pantalla
  {"Bienvenidos a la presentación.", "De este libro increíble.", "Su historia es atrapante."}, // pantalla 1
  {"Con su personaje principal; Ana", "Recorreremos una historia,", "llena de emociones,"}, // pantalla 2
  {"aventuras, sorpresas y amigos.", "Espero que la disfruten", "Hasta la próxima!."} // pantalla 3
};
PFont font;  // Fuente para el texto
float textX;  // Posición x del texto
boolean textMoving = true;  // Indica si el texto está en movimiento
int switchTime = 9500;  // Tiempo entre pantallas (en milisegundos)
int lastSwitchTime = 0;  // Última vez que se cambió de pantalla

void setup() {
  size(640, 480);  // Establece el tamaño de la ventana
  images = new PImage[totalScreens];  // Inicializa el arreglo de imágenes
  for (int i = 0; i < totalScreens; i++) {
    images[i] = loadImage("Imagen_" + (i + 1) + ".jpg");  // Carga las imágenes desde la carpeta data
  }
  font = loadFont("BodoniMT-Italic-48.vlw");  // Carga la fuente personalizada desde la carpeta data
  textX = width;  // Posición inicial del texto fuera de la pantalla a la derecha
}

void draw() {
  background(255);  // Establece el fondo blanco

  if (currentScreen == -1) {
    // Pantalla de inicio
    drawStartButton();
  } else if (currentScreen < totalScreens) {
    // Dibuja la imagen de la pantalla actual
    image(images[currentScreen], 0, 0, width, height);  // Dibuja la imagen de la pantalla actual
    textFont(font);  // Establece la fuente personalizada
    fill(#5957E3);  // Establece el color del texto en blanco
    textAlign(LEFT, CENTER);  // Alinea el texto a la izquierda y centrado verticalmente

    // Dibuja cada línea de texto en la pantalla actual
    for (int i = 0; i < texts[currentScreen].length; i++) {
      text(texts[currentScreen][i], textX, height / 2 - 20 + i * 40);  // Dibuja cada línea de texto
    }

    // Mueve el texto de derecha a izquierda
    if (textMoving) {
      textX -= 2;  // Mueve el texto hacia la izquierda
      if (textX < 0) {
        textX = 0;  // Detiene el movimiento del texto cuando llega al margen izquierdo
        textMoving = false;  // Detiene el movimiento del texto
      }
    }

    // Cambia de pantalla automáticamente si no es la última pantalla de la presentación
    if (millis() - lastSwitchTime > switchTime) {
      currentScreen++;  // Cambia a la siguiente pantalla
      lastSwitchTime = millis();  // Actualiza el tiempo de cambio de pantalla
      if (currentScreen < totalScreens) {
        textX = width;  // Restablece la posición del texto para la nueva pantalla
        textMoving = true;  // Reactiva el movimiento del texto
      }
    }
  } else if (currentScreen == resetScreen) {
    // Pantalla de reinicio
    drawResetButton();
  }
}

// Dibuja el botón de inicio
void drawStartButton() {
  fill(#F2DCC4);  // Color de fondo del botón
  rect(width / 2 - 100, height / 2 - 30, 200, 60);  // Dibuja el rectángulo del botón más largo
  fill(0);  // Color del texto del botón
  textFont(font);  // Establece la fuente para el texto
  textAlign(CENTER, CENTER);  // Alinea el texto al centro
  text("Iniciar", width / 2, height / 2);  // Dibuja el texto del botón
}

// Dibuja el botón de reinicio
void drawResetButton() {
  fill(#F2DCC4);  // Color de fondo del botón
  rect(width / 2 - 100, height / 2 - 30, 200, 60);  // Dibuja el rectángulo del botón más largo
  fill(0);  // Color del texto del botón
  textFont(font);  // Establece la fuente para el texto
  textAlign(CENTER, CENTER);  // Alinea el texto al centro
  text("Reiniciar", width / 2, height / 2);  // Dibuja el texto del botón
}

// Maneja los clics del ratón
void mousePressed() {
  // Si se hace clic en el botón de inicio
  if (currentScreen == -1 && mouseX > width / 2 - 100 && mouseX < width / 2 + 100 && mouseY > height / 2 - 30 && mouseY < height / 2 + 30) {
    currentScreen = 0;  // Cambia a la primera pantalla
    lastSwitchTime = millis();  // Reinicia el tiempo de cambio de pantalla
    textX = width;  // Restablece la posición del texto
    textMoving = true;  // Reactiva el movimiento del texto
  }

  // Si se hace clic en el botón de reinicio en la pantalla de reinicio
  if (currentScreen == resetScreen && mouseX > width / 2 - 100 && mouseX < width / 2 + 100 && mouseY > height / 2 - 30 && mouseY < height / 2 + 30) {
    currentScreen = -1;  // Reinicia la presentación volviendo a la pantalla de inicio
    textX = width;  // Restablece la posición del texto
    textMoving = true;  // Reactiva el movimiento del texto
  }
}
