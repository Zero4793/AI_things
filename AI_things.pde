
Brain[] AI = new Brain[64];


void setup(){
  size(1600,900);
  int[] layers = {2,4,6};
  for(int i=0; i<AI.length; i++){
    AI[i] = new Brain(layers,.01);
  }
}


void draw(){
  background(16,16,32);
  for(int i=0; i<AI.length; i++){
    //input
    float[] in = {mouseX-width/2,mouseY-height/2};
    //process
    float[] out = AI[i].process(in); //input
    //output
    int n=0;
    fill(out[n++]*250,out[n++]*250,out[n++]*250);
    circle(out[n++]*width,out[n++]*height,out[n++]*100+10);
    
    //kill/regenerate
    n=3;//set to position and size output, ignoring color
    if(dist(mouseX,mouseY,out[n++]*width,out[n++]*height)<out[n++]*50+5){
      //ont touch, replace this AI with a random other
      AI[i] = new Brain(AI[(int)random(AI.length)]);
    }
  }
}
