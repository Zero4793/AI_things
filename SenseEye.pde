class SenseEye{
  float angle;
  float pupil;
  float range;
  // 1/16 - 1/4 pupil size represent distance
  
  
  SenseEye(float ang,float viewRange){
    angle = ang;
    range = viewRange;
    pupil = map(range,0,width,.0625,.25);
  }
  
  
  float[] process(PVector pos, PVector dir, Boid P){
    float[] vision = new float[10];
    dir.rotate(angle-.4);
    stroke(250); strokeWeight(2);
    
    for(int i=0; i<5; i+=1){
      dir.setMag(P.size/2);
      boolean see = true;
      while(see && dir.mag()<range){
        float minDist = 0;
        if(showSight){point(pos.x+dir.x,pos.y+dir.y);}
        for(Boid B : boid){
          float dist = dist(pos.x+dir.x,pos.y+dir.y,B.pos.x,B.pos.y);
          if(1/dist>minDist){minDist=1/dist;}
          if(B!=P && dist<B.size){
            see = false;
            vision[i] = -range+dir.mag();
          }
        }
        for(PVector F : food){
          float dist = dist(pos.x+dir.x,pos.y+dir.y,F.x,F.y);
          if(1/dist>minDist){minDist=1/dist;}
          if(dist<16){
            see = false;
            vision[i] = range-dir.mag();
          }
        }
        dir.setMag(dir.mag()+1/minDist);
      }
      dir.rotate(.2);
    }
    

    dir.rotate(-angle-.6);
    dir.setMag(1);
    return vision;
  }
  
  
  void display(PVector pos, PVector dir,float size){
    dir.rotate(angle);
    dir.setMag(.75*size/2);
    fill(250);
    circle(pos.x+dir.x,pos.y+dir.y,size/3);
    fill(0);
    circle(pos.x+dir.x*(1.3-pupil),pos.y+dir.y*(1.3-pupil),size*pupil);    
    dir.rotate(-angle);
    dir.setMag(1);
  }
}
