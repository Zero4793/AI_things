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
    
    for(int i=0; i<5; i+=1){
      dir.setMag(P.size/2);
      boolean see = true;
      while(see && dir.mag()<range){
        dir.setMag(dir.mag()+16);
        //stroke(250); point(pos.x+dir.x,pos.y+dir.y);
        for(Boid B : boid){
          if(B!=P && dist(pos.x+dir.x,pos.y+dir.y,B.pos.x,B.pos.y)<B.size){
            see = false;
            vision[i] = -range+dir.mag();
            //pupil += pupil<1.0/5 ? 1/dir.mag() : 0 ;
          }
        }
        for(PVector F : food){
          if(dist(pos.x+dir.x,pos.y+dir.y,F.x,F.y)<16){
            see = false;
            vision[i] = range-dir.mag();
          }
        }
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
