class Tile{
  Brain brain;
  int ID, state;
  color col;
  
  
  Tile(int i){
    ID = i;  state = 0;
    int[] layers = {2,2,3};
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
    col = color(out[n++]*250,out[n++]*250,out[n++]*250);
  }
  
  
  void display(){
    fill(col);  strokeWeight(4);
    int x = ID%(2*TS);
    int y = ID/(2*TS);
    int s = height/TS;
    if(mouseX>x*s && mouseX < x*s+s && mouseY>y*s && mouseY<y*s+s){
      stroke(150-100*state,150+100*state,150);
    }
    else{
      stroke(50-40*state,50+40*state,50);
    }
    rect(x*s+2,y*s+2,s-5,s-5);
  }
}
