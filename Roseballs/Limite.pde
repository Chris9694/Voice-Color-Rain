class Boundary {

  float x;
  float y;
  float w;
  float h;
  
  Body b;
  
  Boundary(float x_,float y_, float w_, float h_){
  x = x_;
  y = y_;
  w = w_;
  h = h_;
  PolygonShape forma = new PolygonShape();
  float box2dW = ball.scalarPixelsToWorld(w/2);
  float box2dH = ball.scalarPixelsToWorld(h/2);
   
   forma.setAsBox(box2dW, box2dH);
   BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(ball.coordPixelsToWorld(x,y));
    b = ball.createBody(bd);
    
   
    b.createFixture(forma,1);
    
    b.setUserData(this);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(#ff0000);
    stroke(0);
    rectMode(CENTER);
    rect(x,y,w,h);
  }


}