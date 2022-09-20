
Brain[] AI = new Brain[16];


void setup(){
  size(1600,900);
  int[] layers = {2,4,36};
  for(int i=0; i<AI.length; i++){
    AI[i] = new Brain(layers,.01);
  }
}


void draw(){
  background(32);
  stroke(50,150,50);  strokeWeight(4);
  for(int i=0; i<AI.length; i++){
    //input
    float[] in = {mouseX-width/2,mouseY-height/2};
    
    //process
    float[] out = AI[i].process(in); //input
    
    //output
    PVector p = new PVector(width*(i+1)/(AI.length+1),height);
    for(int n=0; n<out.length; n+=2){
      line(p.x,p.y,p.x+=out[n]*100-50,p.y-=out[n+1]*100);
    }
    
    //kill/regenerate
    if(p.y<0 || mousePressed && dist(p.x,p.y,mouseX,mouseY)<20){
      AI[i] = new Brain(AI[(int)random(AI.length)]);
    }
  }
}
