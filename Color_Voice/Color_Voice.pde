import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Box2DProcessing ball;

ArrayList<Esfera> esferas;
ArrayList<Boundary> limites;

Boundary limite;

int pantalla = 0;
PImage cielo1;
PFont letra1;

Minim minim;
FFT fft;
AudioInput in;


void setup() {
  size(1300, 650);
  
  cielo1 = loadImage("cielo.jpg");
  
  letra1 = createFont("Amethyst.ttf",200);
  
  minim = new Minim(this);
  in = minim.getLineIn();
  fft = new FFT(in.bufferSize(), in.sampleRate());

  ball = new Box2DProcessing(this);
  ball.createWorld();

  esferas = new ArrayList<Esfera>();
  limites = new ArrayList<Boundary>();

  limites.add(new Boundary(width/2, 650, width/2-100, 0)); //enmedio
  

}

void draw() {

  switch(pantalla) {
  case 0:
    menu();
    break;

  case 1:
    instrucciones();
    break;
    
  case 2:
    app();
    break;
  }
}

void menu() {
  background(0);
  
  image(cielo1,-100,-600);
  
  textFont(letra1);
  textSize(100);
  fill(255);
  fill(#ff0000);
  text("C",150,200);
  fill(#0000ff);
  text("o",250,200);
  fill(#00ff00);
  text("l",350,200);
  fill(#ffff00);
  text("o",440,200);
  fill(#00ffff);
  text("r",540,200);
  fill(255);
  text("Voice",655,200);
  fill(#ff0000);
  textSize(20);
  fill(255);
  text("Click para continuar",450,600);
  
  if (mousePressed) {
    pantalla = 1;
  }
}

void instrucciones(){
 background(0);
  
  image(cielo1,-100,-1000);
  
  textFont(letra1);
  textSize(20);
  text("Emite un sonido con tu voz a traves del microfono",160,200);
  text("mientras presionas la tecla R",350,250);
  textSize(15);
  text("Presiona ENTER para continuar",450,600);
  
  if (keyPressed) {
    pantalla = 2;
  }
}
void app() {
    background(#ff0000);
    
    image(cielo1,-400,-400);
    

  if(keyPressed){
  if(key == 'r'){
    fft.forward(in.mix);
  

    for(int i = 0; i <fft.specSize(); i++){
    println(i/10);
    color c = color(i/2, 255, 255);
    
    if (i == 50 ||i==100 || i==125 || i==150 || i==175 || i==200 ||
        i ==225 || i==250 || i==275 || i==300 || i==325|| i==350 || 
        i==375 || i==400 || i==425 || i==450 || i==500) {
      esferas.add(new Esfera(random(width), random(0,20), i/10, c));
        }
      }
    }
  }
  
  
  ball.setGravity(0, -50);
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