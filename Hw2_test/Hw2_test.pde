Cloth cloth;
void setup() {
  size(600,600,P3D);
  cloth = new Cloth();
}

void draw() {
  background(255,255,255);
  cloth.update();
  cloth.display();
}
