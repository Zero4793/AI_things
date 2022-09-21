
int GS = 4;  //gridsize
Tile[] AI = new Tile[GS*GS*2];

void setup(){
  size(1600,800);
  for(int i=0; i<AI.length; i++){
    AI[i] = new Tile(i);
  }
}


void draw(){
  background(16,16,32);
  for(int i=0; i<AI.length; i++){
    AI[i].process();
    AI[i].display();
  }
}


void mousePressed(){
  int s = height/GS;
  int x = mouseX/s;
  int y = mouseY/s;
  int i = x+y*2*GS;
  if(mouseButton==LEFT){AI[i].state += AI[i].state==1? 0 : 1;}  //increment if not already max
  if(mouseButton==RIGHT){AI[i].state -= AI[i].state==-1? 0 : 1;}  //dec if not min
}


void keyPressed(){
  //space = clear (all states = 0)
  if(key==' '){
    for(int i=0; i<AI.length; i++){
      AI[i].state=0;
    }
  }
  //backspace = mass kill (all states==0 = -1)
  else if(key==BACKSPACE){
    for(int i=0; i<AI.length; i++){
      if(AI[i].state==0){AI[i].state=-1;}
    }
  }
  //enter = rebirth (replace reds with green copies)
  else if(key==ENTER){
    int r = 0;
    int g = 0;
    //move g to each green until array end
    //at each g, move r to next red, end if array end
    //on each g that gets an r, make r child of g, set g state to 0
    //excess g&r maintain their state, can altered next gen
    while(g<AI.length && r<AI.length){
      if(AI[g].state==1){
        while(r<AI.length){
          if(AI[r].state==-1){
            AI[r] = new Tile(AI[g],r);
            AI[g].state = 0;
            break;
          }
          r++;
        }
      }
      g++;
    }
  }
}
