Brain[] AI = new Brain[64];

void setup(){
  size(1600,900);
  for(int i=0; i<AI.length; i++){
    AI[i] = new Brain(2, 2, 4, 6, 8, 0.01); //In, Px, Py, Out, Mem, Mut
  }
}

void draw(){
  background(16,16,32);
  for(int i=0; i<AI.length; i++){
    //input
    float[] in = {2*mouseX/(float)width-1,2*mouseY/(float)height-1};
    //process
    float[] out = AI[i].process(in);
    //output
    int n=0;
    strokeWeight(4);
    fill(out[n++]*250,out[n++]*250,out[n++]*250);
    circle(out[n++]*width,out[n++]*height,out[n++]*100+10);
    
    //kill and repopulate
    n=3;//set to position and size output, ignoring aesthetics
    if(dist(mouseX,mouseY,out[n++]*width,out[n++]*height)<out[n++]*50+5){
      //on touch, kill this AI and replace it with a mutated child of a random other
      AI[i] = new Brain(AI[(int)random(AI.length)]);
    }
  }
}
