float position = 200; float velocity = 0;
float radius = 40; float floor = 600;
float position2=0; float velocity2 = 0;
void setup() {
  size(600,600,P3D);
}

void computePhysics(float dt) {
  float acceleration = 9.8;
  velocity = velocity + acceleration * dt;
  position = position + velocity * dt;
  
  float acceleration2 = 0.5;
  velocity2 = velocity2 + acceleration2 * dt;
  position2 = position2 + velocity2 * dt;
  
  if (position2 + radius > 400) {
    position2 = 400 - radius;
    velocity2 *=-0.5;
  }
  if (position + radius > floor) {
    position = floor - radius;
    velocity *=-0.95;
  }
}

void draw() {
  background(255,255,255);
  computePhysics(0.15);
  fill(0,200,10);
  noStroke();
  lights();
  //translate(300,position);
  translate(200+position2,position);
  sphere(radius);
}
