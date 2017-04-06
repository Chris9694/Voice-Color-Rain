class Esfera {

  Body body;
  float rad;
  color c;
  
  Esfera(float x, float y, float rad_,color c_){
  rad = rad_;
  c = c_;
  makeBody(x,y,rad);
  body.setUserData(this);
  colorMode(HSB);
  }
  
  void killBody(){
  ball.destroyBody(body);
  }
  
  boolean done() {
    Vec2 pos = ball.getBodyPixelCoord(body);
    if (pos.y > height+rad*2) {
      killBody();
      return true;
    }
    return false;
  }
  
  void display(){
  
  Vec2 pos = ball.getBodyPixelCoord(body);
  float a = body.getAngle();
   pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(c);
    noStroke();
    strokeWeight(1);
    ellipse(0, 0, rad*2, rad*2);
    popMatrix();
  
  }
  
   void makeBody(float x, float y, float r) {
    
    BodyDef circulo = new BodyDef();
    
    circulo.position = ball.coordPixelsToWorld(x, y);
    circulo.type = BodyType.DYNAMIC;
    body = ball.createBody(circulo);

    CircleShape forma = new CircleShape();
    forma.m_radius = ball.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = forma;
    
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.5;

    body.createFixture(fd);

    body.setAngularVelocity(random(-10, 10));
  }
}