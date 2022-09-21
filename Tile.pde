class Tile{
  Brain brain;
  int ID, state, res = 2;
  color[] col = new color[res*res];
  
  
  Tile(int i){
    ID = i;  state = 0;
    int[] layers = {2,6,3*res*res};
    brain = new Brain(layers,.01);
  }
  
  
  Tile(Tile b, int i){
    ID = i;  state = 0;
    brain = new Brain(b.brain); 
  }
  
  
  void process(){
    //sense
    float[] in = {mouseX,mouseY};
    
    //think
    float[] out = brain.process(in);
    
    //act
    int n=0;
    for(int i=0; i<col.length; i++){
      col[i] = color(out[n++]*250,out[n++]*250,out[n++]*250);
    }
  }
  
  
  void display(){
    int x = ID%(2*GS);
    int y = ID/(2*GS);
    int s = height/GS;

    noStroke();
    for(int i=0; i<col.length; i++){
      int px = i%res;
      int py = i/res;
      int ps = (s-4)/res;
      fill(col[i]);
      rect(x*s+2+ps*px,y*s+2+ps*py,ps,ps);
    }
    
    if(mouseX>x*s && mouseX < x*s+s && mouseY>y*s && mouseY<y*s+s){
      stroke(150-100*state,150+100*state,150);
    }
    else{
      stroke(50-40*state,50+40*state,50);
    }
    noFill();  strokeWeight(4);
    rect(x*s+2,y*s+2,s-5,s-5);
    
  }
}
