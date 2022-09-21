class Boid{
  Brain brain;
  PVector pos,vel,dim;
  float R,G,B;
  
  
  Boid(){
    int[] layers = {5,4,3};
    brain = new Brain(layers,.1);
    pos = new PVector(width/2,height/2);
    vel = new PVector(0,0);
    dim = new PVector(0,-16);
    R = 150+random(-10,10);  G = 150+random(-10,10);  B = 150+random(-10,10);
  }
  
  
  Boid(Boid b){
    brain = new Brain(b.brain);
    pos = new PVector(b.pos.x,b.pos.y);
    vel = new PVector(b.vel.x,b.vel.y);
    dim = new PVector(b.dim.x,b.dim.y);
    R = b.R+random(-10,10);  G = b.G+random(-10,10);  B = b.R+random(-10,10);
  }
  
  
  void process(){
    //sense
    float[] in = {pos.x,pos.y,vel.x,vel.y,dim.heading()};
    
    //think
    float[] out = brain.process(in);
    
    //act
    int n=0;
    PVector f = new PVector(dim.x,dim.y);
    dim.rotate((out[n++]-.5)*.01);
    vel.add(f.setMag((out[n++]-.5)*.1));
    vel.mult(.9);  //friction
    
    //motion
    if(pos.x<0){vel.x=abs(vel.x);}
    if(pos.x>width){vel.x=-abs(vel.x);}
    if(pos.y<0){vel.y=abs(vel.y);}
    if(pos.y>height){vel.y=-abs(vel.y);}
    pos.add(vel);
  }
  
  
  void display(){
    fill(R,G,B);  stroke(0);
    //circle(pos.x,pos.y,dim.mag());
    triangle(pos.x+dim.x,pos.y+dim.y,pos.x+dim.rotate(2*PI/3).mult(.5).x,pos.y+dim.y,pos.x+dim.rotate(2*PI/3).x,pos.y+dim.y);
    dim.mult(2).rotate(2*PI/3);
  }
  
  
  boolean dead(){
    //return false;
    return dist(mouseX,mouseY,pos.x,pos.y)<30 && mousePressed;
    //return pos.x<0 || pos.x>width || pos.y<0 || pos.y>height;
  }
}
