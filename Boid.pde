class Boid{
  int ID;
  boolean exist;
  float mutate;
  Brain brain;
  PVector pos;
  float size;
  float R,G,B;
  
  
  Boid(int id){
    exist = true;
    mutate = 0.01;
    ID = id;
    brain = new Brain(2, 2, 4, 6, 8, mutate); //In, Px, Py, Out, Mem, Mut
    pos = new PVector();
  }
  
  
  Boid(Boid parent, int id){
    exist = true;
    ID = id;
    mutate = parent.mutate * random(.8,1.25);
    brain = new Brain(parent.brain, mutate);
    pos = new PVector();
  }
  
  
  void process(){
    //inputs
    float[] in = {2*mouseX/(float)width-1,2*mouseY/(float)height-1};
    
    //process/think
    float[] out = brain.process(in);
    
    //outputs
    int n=0;
    R = out[n++]*250;
    G = out[n++]*250;
    B = out[n++]*250;
    pos.set(out[n++]*width,out[n++]*height);
    size = out[n++]*100+20;
    
    //die
    if(dist(mouseX,mouseY,pos.x,pos.y)<size/2){
      exist = false;
    }
  }
  
  
  void display(){
    strokeWeight(4);
    fill(R,G,B);
    circle(pos.x,pos.y,size);
  }
}
