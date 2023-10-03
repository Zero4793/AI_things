ArrayList<Boid> boids = new ArrayList<Boid>();
int ID;
float t = 0;

// TODO:
// brain saving, probs json format
// food, strokeweight = fat = energy
// kill no longer breed, boids choose when to breed, evolved vars to track how much of their energy/mass goes into child, how much is child mass/starting energy
// eyes, marching rays, each step, look at distance to all objs, if less then radius, return, else track min distance, next step is that far (-radius)
// eyes return 4 vals, r,g,b, 1/dist (0 in case of no target)
// this makes vals small/normalized, larger for closer, and return 0 rather than infinite for no target


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
      boids.add(new Boid(boids.get((int)random(boids.size()/2)),ID));  //size/2 so only from top half of list, these are older boids and so likely better
      boids.remove(i);
      ID++;
      i--;
    }
  }
  t++;
}
