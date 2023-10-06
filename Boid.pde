int count;
float metaMutate = 0.01;

class Boid{
  boolean dead = false;
  String ID;
  float age;
  
  Brain brain;
  float mutate;
  float viewRange;

  PVector pos,vel,dir;
  float size, maxSize, babySize; //add: max, growth, etc
  float R,G,B;

  //add eyes/other senses
  SenseEye[] eyes = new SenseEye[2];

  //intial AI
  Boid(){
    ID = str(count); count++; age=0;
    mutate=0.1;
    brain = new Brain(11, 3, 8, 2, 2, mutate);  //input, process-x, process-y, output, memory, mutate
    //pos = new PVector(width/2,height/2);
    pos = new PVector(random(width),random(height));
    vel = new PVector(0,0.1);
    dir = new PVector(0,-1);
    size = 32; maxSize = 64; babySize=32;
    R = 150+random(-50,50); G = 150+random(-50,50); B = 150+random(-50,50);
    
    viewRange = width/2+random(-mutate,mutate)*5000;
    eyes[0] = new SenseEye(-.5,viewRange);
    eyes[1] = new SenseEye(.5,viewRange);
  }
  
  //child AI
  Boid(Boid P){
    ID = P.ID+":"+str(count); count++; age=0;
    mutate = P.mutate + random(-metaMutate,metaMutate);
    brain = new Brain(P.brain, mutate);
    pos = new PVector(P.pos.x-P.dir.x*P.size/2,P.pos.y-P.dir.y*P.size/2);
    vel = new PVector(P.vel.x,P.vel.y);
    dir = new PVector(P.dir.x,P.dir.y);
    size = P.babySize; maxSize = P.maxSize *(1+random(-mutate,mutate)); babySize = P.babySize * (1+random(-mutate,mutate));
    R = P.R+random(-mutate*100,mutate*100); G = P.G+random(-mutate*100,mutate*100); B = P.B+random(-mutate*100,mutate*100);
    
    viewRange = P.viewRange+random(-mutate,mutate)*100;
    if(viewRange<1){viewRange=1;}if(viewRange>width){viewRange=width;}
    eyes[0] = new SenseEye(P.eyes[0].angle,P.viewRange);
    eyes[1] = new SenseEye(P.eyes[1].angle,P.viewRange);
  }
  
  
  void process(){
    think();
    
    age+=.000001;
    
    size-=vel.mag()/100;
    size-=age;
    //size-=0.0001;
    
    if(size<8){dead=true;starve++;}
    for(int i=0; i<food.size(); i++){
      if(dist(pos.x,pos.y,food.get(i).x,food.get(i).y)<size/2){
        size+=8;
        food.remove(i);
      }
      /**
      else{
        PVector disp = new PVector(food.get(i).x-pos.x,food.get(i).y-pos.y);
        disp.setMag(10/pow(disp.mag(),2));
        vel.add(disp);
      }
      **/
    }
    for(int i=0; i<boid.size(); i++){
      if(boid.get(i)!=this && boid.get(i).size*1.5 < size && dist(pos.x,pos.y,boid.get(i).pos.x,boid.get(i).pos.y)<size/2 && diff(boid.get(i))>48){
        size+=boid.get(i).size/2;
        boid.get(i).dead=true;
        eaten++;
      }
    }
    if(size>maxSize){
      birth(this);
      size-=babySize;
    }

    //wall bounce
    if (pos.x <= 0 || pos.x >= width){
      vel.x = -vel.x * (abs(vel.x)/vel.x) * abs(pos.x-width/2)/(pos.x-width/2);
      //dead=true;
    }
    if (pos.y <= 0 || pos.y >= height){
      vel.y = -vel.y * (abs(vel.y)/vel.y) * abs(pos.y-height/2)/(pos.y-height/2);
      //dead=true;
    }
    //friction,motion
    vel.mult(.9);
    pos.add(vel);
  }


  void think(){
    //sense
    int n=0;
    float[] in = new float[brain.input.length];
    in[n++] = vel.mag();
    
    //eyes
    for(int i=0; i<eyes.length; i++){
      float[] vals = eyes[i].process(pos,dir,this);
      in[n++] = vals[0];
      in[n++] = vals[1];
      in[n++] = vals[2];
      in[n++] = vals[3];
      in[n++] = vals[4];
    }
    
    float[] out = brain.process(in);

    //act
    n=0;
    dir.rotate((out[n++]-.5)/2);
    vel.add(new PVector(dir.x,dir.y).mult((out[n++]-.4)/1));
    // turn and move
  }


  void display(){
    stroke(0);
    strokeWeight(1);
    fill(R,G,B);
    circle(pos.x,pos.y,size);
    fill(200);
    textAlign(CENTER,CENTER);
    textSize(size/4);
    if(text){text(ID,pos.x,pos.y-size);}
    
    for(int i=0; i<eyes.length; i++){
      eyes[i].display(pos,dir,size);
    }
  }
  
  
  int diff(Boid O){
    int diff = 0;
    diff += abs(R-O.R);
    diff += abs(G-O.G);
    diff += abs(B-O.B);
    return diff;
  }
}
