class Boid{
  int ID;
  boolean exist;
  float mutate;
  Brain brain;
  PVector pos, vel;
  float size;
  float R,G,B;
  
  
  Boid(int id){
    exist = true;
    mutate = .1;
    ID = id;
    brain = new Brain(4, 2, 4, 6, 2, mutate); //In, Px, Py, Out, Mem, Mut
    pos = new PVector(width/2,height/2);
    vel = new PVector(1,0);
  }
  
  
  Boid(Boid parent, int id){
    exist = true;
    ID = id;
    mutate = parent.mutate * random(.9,1.1);
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
    pos.add(vel);
    
    //die
    //mouse
    //if(dist(mouseX,mouseY,pos.x,pos.y)<size/2){exist = false;}
    //wall
    int m = (int)size/2; //margin
    if(pos.x<m || pos.y<m || pos.x>width-m || pos.y>height-m){exist=false;}
    //slow
    if(vel.mag()<.2){exist=false;}
  }
  
  
  void display(){
    strokeWeight(4);
    fill(R,G,B);
    circle(pos.x,pos.y,size);
  }
}
