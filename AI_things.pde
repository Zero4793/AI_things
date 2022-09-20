
Boid[] boids = new Boid[64];

void setup(){
  size(1600,900);
  for(int i=0; i<boids.length; i++){
    boids[i] = new Boid();
  }
}


void draw(){
  background(16,16,32);
  for(int i=0; i<boids.length; i++){
    boids[i].process();
    boids[i].display();
    if(boids[i].dead()){
      boids[i] = new Boid(boids[(int)random(boids.length)]);
    }
  }
}
