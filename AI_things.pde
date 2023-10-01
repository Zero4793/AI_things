ArrayList<Boid> boids = new ArrayList<Boid>();
int ID;

// TODO:
// implement structure evolution and pruning
// brain saving, probs json format


// BUGS:
// mysterious vanishing boids, population gradually decreases, array/list doesnt actually shrink though, they just invisible?
// boids converging in single spot. not copy ant mutate properly? incorrect pointers?


void setup(){
  size(1600,900);
  for(int i=0; i<64; i++){
    boids.add(new Boid(i));
  }
  ID = boids.size();
}


void draw(){
  background(16,16,32);
  for(int i=0; i<boids.size(); i++){
    boids.get(i).process();
    boids.get(i).display();
    if(!boids.get(i).exist){
      boids.add(new Boid(boids.get((int)random(boids.size())),ID));
      boids.remove(i);
      ID++;
    }
  }
}
