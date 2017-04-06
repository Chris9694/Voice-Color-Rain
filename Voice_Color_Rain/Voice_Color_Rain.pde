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
PImage city1;
PImage cielo1;
PFont letra1;

Minim minim;
FFT fft;
AudioInput in;


void setup() {
  size(1300, 650);
  
  city1 = loadImage("skyline.png");
  cielo1 = loadImage("cielo.jpg");
  
  letra1 = createFont("Amethyst.ttf",200);
  
  minim = new Minim(this);
  in = minim.getLineIn();
  fft = new FFT(in.bufferSize(), in.sampleRate());

  ball = new Box2DProcessing(this);
  ball.createWorld();

  esferas = new ArrayList<Esfera>();
  limites = new ArrayList<Boundary>();

  limites.add(new Boundary(width/2, 325, width/2-400, 0)); //enmedio
  limites.add(new Boundary(0, 150, width/2-300, 0)); //superior izq
  limites.add(new Boundary(1300, 200, width/2-300, 0)); //superior der
  limites.add(new Boundary(350, 650, 350, 0)); //inferior izq
  limites.add(new Boundary(950, 650, 350, 0)); //inferior der

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
  text("Voice Color",100,200);
  fill(#ff0000);
  text("R",450,380);
  fill(#0000ff);
  text("a",550,380);
  fill(#00ff00);
  text("i",620,380);
  fill(#ffff00);
  text("n",690,380);
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
  text("Mira tu voz llover sobre la ciudad",300,400);
  textSize(15);
  text("Presiona ENTER para continuar",450,600);
  
  if (keyPressed) {
    pantalla = 2;
  }
}
void app() {
    background(0);
    
    image(cielo1,-400,-400);
    image(city1,-700,200);
    
    
    fill(5);
    rect(0,400,width/2-300,500);
    rect(width/2,525,width/2-400,400);
    rect(1300,450,width/2-300,500);
    
    noStroke();
    fill(#ffff00);
    rect(0,220,80,80);
    rect(0,320,80,80);
    rect(0,420,80,80);
    rect(0,520,80,80);
    rect(95,220,80,80);
    rect(95,320,80,80);
    rect(95,420,80,80);
    rect(95,520,80,80);
    
    rect(650,390,200,20);
    rect(650,430,200,20);
    rect(650,470,200,20);
    rect(650,510,200,20);
    rect(650,550,200,20);
    rect(650,625,40,50);
    
    rect(1210,290,80,100);
    rect(1210,400,80,100);
    rect(1210,510,80,100);
    rect(1300,290,80,100);
    rect(1300,400,80,100);
    rect(1300,510,80,100);
    

if(keyPressed){
  if(key == 'r'){
    fft.forward(in.mix);
    for(int i = 0; i <fft.specSize(); i++){
    println(i);
    color c = color(random(255), 255, 255);

    if (i==100 || i==150 || i==200 || i==250 || i==300 || i==350 || i==400 || i==450 || i==500) {
      esferas.add(new Esfera(random(width), random(-500,0), i/50, c));
        }
      }
    }
  }
  
  ball.setGravity(0, -10);
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