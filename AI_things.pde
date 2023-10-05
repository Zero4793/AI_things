// TODO:
// brain saving, probs json format
// strokeweight = fat = energy
// boids choose when to breed, evolved vars to track how much of their energy/mass goes into child, how much is child mass/starting energy
// eyes:
//   eyes return 4 vals, r,g,b, 1/dist (0 in case of no target)
//   this makes vals small/normalized, larger for closer, and return 0 rather than infinite for no target


int t = 0; int rate=60;
int time; int delta;

float ANGLE = 2*PI/3;

boolean pause, text, showSight;

ArrayList<Boid> boid = new ArrayList<Boid>();
ArrayList<PVector> food = new ArrayList<PVector>();

//Boid player;
//boolean FW,BW,LT,RT;


void setup(){
  size(1600,900);
  //noCursor();
  //frameRate(16);
  pause = false; text = true; showSight = false;
  
  for(int i=0; i<128; i++){
    food.add(new PVector(random(width),random(height)));
  }
  for(int i=0; i<16; i++){
    boid.add(new Boid());
  }
}


void draw(){
  background(50);
  strokeWeight(1);
  
  delta = millis() - time;
  time = millis();
  
  //add food
  t++;
  if(t>=rate && !pause){
    t=0;
    food.add(new PVector(random(width),random(height)));
  }
  
  //process/display food
  for(PVector F : food){
    fill(100,200,100);
    circle(F.x,F.y,12);
    if(!pause){
      //food moves to center
      //F.x += (width/2-F.x)/1000;
      //F.y += (height/2-F.y)/1000;
    }
  }
  
  //boids
  int i=0; 
  while(i<boid.size()){
    if(!pause){boid.get(i).process();}
    boid.get(i).display();
        
    if(boid.get(i).dead){
      food.add(new PVector(boid.get(i).pos.x,boid.get(i).pos.y));
      boid.remove(i);
      i-=1;
    }
    i++;
  }
  
  //UI
  textSize(50); fill(200);
  text(rate,30,20);
  textSize(20); fill(200);
  text(delta,15,50);

  if(text){
    fill(0,100);
    rect(5,70,140,90,5);
    fill(200);
    textSize(20); textAlign(LEFT);
    text("Space = Pause", 10, 90); // Added instruction for pausing
    text("T = Toggle Text", 10, 120); // Added instruction for toggling text  
    text("I = Display Sight", 10, 150); // Added instruction for toggling vision display
  }
}


void birth(){
  boid.add(new Boid(boid.get((int)random(boid.size()))));
}
void birth(Boid B){
  boid.add(new Boid(B));
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  rate= rate>1 ? rate+(int)e : rate+1 ;
}


void keyPressed(){
  switch(key){
    case ' ':
      pause = !pause;
      break;
    case 't':
      text = !text;
      break;
    case 'i':
      showSight = !showSight;
      break;
  }
  //ESC = save boids
}


/**
void keyPressed(){
  if (key == CODED){
    if (keyCode==LEFT){
      LT = true;
    }
    if (keyCode==RIGHT){
      RT = true;
    }
    if (keyCode==UP){
      FW = true;
    }
    if (keyCode==DOWN){
      BW = true;
    }
  }
  else{
    if (key=='a'){
      LT = true;
    }
    if (key=='d'){
      RT = true;
    }
    if (key=='w'){
      FW = true;
    }
    if (key=='s'){
      BW = true;
    }
  }
}
void keyReleased(){
  if (key == CODED){
    if (keyCode==LEFT){
      LT = false;
    }
    if (keyCode==RIGHT){
      RT = false;
    }
    if (keyCode==UP){
      FW = false;
    }
    if (keyCode==DOWN){
      BW = false;
    }
  }
  else{
    if (key=='a'){
      LT = false;
    }
    if (key=='d'){
      RT = false;
    }
    if (key=='w'){
      FW = false;
    }
    if (key=='s'){
      BW = false;
    }
  }
}
**/
