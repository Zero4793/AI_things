class Boid{
  int ID;
  boolean exist;
  float mutate;
  Brain brain;
  PVector pos, vel;
  float size;
  float R,G,B;
  float metaMutate = 0.01;
  float friction = 0.02;
  
  
  Boid(int id){
    exist = true;
    mutate = .1;
    ID = id;
    brain = new Brain(4, 2, 6, 6, 4, mutate); //In, Px, Py, Out, Mem, Mut
    pos = new PVector(width/2,height/2);
    vel = new PVector(0,0);
  }
  
  
  Boid(Boid parent, int id){
    exist = true;
    ID = id;
    mutate = parent.mutate + random(-metaMutate,metaMutate);
    mutate = mutate < 0 ? 0 : mutate;
    brain = new Brain(parent.brain, mutate);
    pos = new PVector(parent.pos.x,parent.pos.y);
    vel = new PVector(parent.vel.x,parent.vel.y);
  }
  
  
  void process(){
    //inputs
    float[] in = {2*pos.x/(float)width-1,2*pos.y/(float)height-1,vel.x,vel.y};
    
    //process/think
    float[] out = brain.process(in);
    
    //outputs
    int n=0;
    R = out[n++]*250;
    G = out[n++]*250;
    B = out[n++]*250;
    vel.add((out[n++]-.5),(out[n++]-.5));
    size = out[n++]*100+20;
    
    //move
    vel.mult(1-friction);
    pos.add(vel);
    
    //die
    //mouse
    //if(dist(mouseX,mouseY,pos.x,pos.y)<size/2){exist = false;}
    //wall
    int m = (int)size/2; //margin
    if(pos.x<m || pos.y<m || pos.x>width-m || pos.y>height-m){exist=false;}
    //slow - threshold increase over time
    if(vel.mag()<t/20000){exist=false;}
  }
  
  
  void display(){
    strokeWeight(mutate*10);
    fill(R,G,B);
    circle(pos.x,pos.y,size);
  }
}
