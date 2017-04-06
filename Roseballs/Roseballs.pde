import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import processing.sound.*;

Box2DProcessing ball;

ArrayList<Esfera> esferas;
ArrayList<Boundary> limites;

Boundary limite;

int pantalla = 0;

FFT fft;
SoundFile song;
int bands = 2;
float[] spectrum = new float[bands];

PFont letra;
PImage titanic1;
PImage titanic2;


void setup() {
  size(1300, 650);
  
  titanic1 = loadImage("titanic1.jpg");
  titanic2 = loadImage("titanic2.jpg");
  
  ball = new Box2DProcessing(this);
  ball.createWorld();

  letra = createFont("Catherine de Beaumont.ttf", 200);

  esferas = new ArrayList<Esfera>();
  limites = new ArrayList<Boundary>();

  limites.add(new Boundary(width/2, 650, width/2-500, 0));
  limites.add(new Boundary(0, 650, width/2-500, 0));
  limites.add(new Boundary(1300, 650, width/2-500, 0));

  fft = new FFT(this,bands);
  song = new SoundFile(this, "Flute.mp3");
  song.play();
  fft.input(song);

}

void draw() {

  switch(pantalla) {
  case 0:
    inicio();
    break;

  case 1:
    app();
    break;
   
  }
}

void inicio() {
  background(0);
  
  image(titanic1,-700,0);
  
  textFont(letra);
  textSize(300);
  text("Roseballs", 400, 400);
  textSize(70);
  text("Click para continuar", 550, 620);
  
  if (mousePressed) {
    pantalla = 1;
  }
}


void app() {
  background(0);
  
  image(titanic2,0,-90);
  
  ball.setGravity(0, -20);
  
  fft.analyze(spectrum);
  float r = max(spectrum);
  println(r*100);
  color c = color(r*1000, 255, 255);
  
  esferas.add(new Esfera(random(width), 40, r*200, c));
    
  ball.step();

  for (int i = esferas.size()-1; i >= 0; i--) {
    Esfera e = esferas.get(i);
    e.display();

    if (e.done()) {
      esferas.remove(i);
    }
  }

  for (Boundary pared : limites) {
    pared.display();
  }
}