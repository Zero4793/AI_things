class Boid{
  Brain brain;
  PVector pos,vel,dim;
  
  
  Boid(){
    int[] layers = {2,2,2};
    brain = new Brain(layers,.1);
    pos = new PVector(width/2,height/2);
    vel = new PVector(0,0);
    dim = new PVector(16,16);
  }
  
  
  Boid(Boid b){
    brain = new Brain(b.brain);
    pos = b.pos;
    vel = b.vel;
    dim = b.dim;    
  }
  
  
  void process(){
    //sense
    float[] in = {mouseX-pos.x,mouseY-pos.y};
    
    //think
    float[] out = brain.process(in);
    
    //act
    int n=0;
    vel.x += (out[n++]-.5)*.1;
    vel.y += (out[n++]-.5)*.1;
    vel.mult(.99);  //friction
    
    //motion
    if(pos.x<0){vel.x=abs(vel.x);}
    if(pos.x>width){vel.x=-abs(vel.x);}
    if(pos.y<0){vel.y=abs(vel.y);}
    if(pos.y>height){vel.y=-abs(vel.y);}
    pos.add(vel);
  }
  
  
  void display(){
    circle(pos.x,pos.y,dim.mag());
  }
  
  
  boolean dead(){
    return false;
    //return dist(mouseX,mouseY,pos.x,pos.y)>120;
    //return pos.x<0 || pos.x>width || pos.y<0 || pos.y>height;
  }
}
