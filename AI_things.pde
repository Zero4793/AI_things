
Brain[] AI = new Brain[64];


void setup(){
  size(1600,900);
  int[] layers = {2,4,6}; //2 In, 4 Pro, 6 Out
  for(int i=0; i<AI.length; i++){
    AI[i] = new Brain(layers,8,.01); //layers, memory nodes, mutation
  }
}


void draw(){
  background(16,16,32);
  for(int i=0; i<AI.length; i++){
    //input
    float[] in = {0,0};//temp disable input to test memory alone {mouseX-width/2,mouseY-height/2};
    //process
    float[] out = AI[i].process(in);
    //output
    int n=0;
    fill(out[n++]*250,out[n++]*250,out[n++]*250);
    circle(out[n++]*width,out[n++]*height,out[n++]*100+10);
    
    //kill and repopulate
    n=3;//set to position and size output, ignoring color
    if(dist(mouseX,mouseY,out[n++]*width,out[n++]*height)<out[n++]*50+5){
      //on touch, kill this AI and replace it with a mutated child of a random other
      AI[i] = new Brain(AI[(int)random(AI.length)]);
    }
  }
}
