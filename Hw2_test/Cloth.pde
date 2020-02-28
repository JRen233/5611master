class Cloth {
  Ball[][] cloth;
  PVector[][] vel;
  int rows = 30;
  int cols = 30;
  float between = 10;
  PVector start = new PVector(100,100,0);
  //PVector top = new PVector(100,50,0);
  float ks = 100;
  float kd = 100;
  float restLen =10;
  float dtF = 1.5;
  //float dt = (float)dtF/1000;
  float dt = 0.007;
  PVector gravity = new PVector(0,1,0);
  float gravitys = 100;
  PVector zeros = new PVector(0,0,0);
  float mass = 20;
  
  float radius = 1; 
  
  Cloth() {
    cloth = new Ball[cols][rows];
    vel = new PVector[cols][rows];
    for (int i = 0; i < cols; i++) {
      //cloth[i][0] = new Ball(new PVector(start.x+i*between,start.y,start.z), new PVector(0,0,0), new PVector(0,0,0));
      //println(cloth[i][0].location.x);
      for (int j = 0; j < rows; j++) {
        //cloth[i][j] = new Ball(new PVector(start.x+i*between,start.y+(j*between),start.z), new PVector(0,0,0), new PVector(0,0,0));
        cloth[i][j] = new Ball(new PVector(start.x+i*between,start.y,start.z+(j*between)), new PVector(0,0,0), new PVector(0,0,0));
        //print(cloth[i][j].location.y+" "); 
        vel[i][j] = zeros.copy();
      } 
      //println();
    }
  }
  
  void update() {
    for(int i = 0; i< cols; i++) {
      for(int j = 0; j<rows; j++) {
        cloth[i][j].acceleration = zeros.copy();
      }
    }   
    
    for (int i = 0; i < cols-1; i++) {
      for (int j = 0; j< rows; j++) {
        Ball temp = cloth[i][j];
        Ball tempN = cloth[i+1][j];
        
        PVector e = PVector.sub(tempN.location,temp.location);
        float sLength = e.mag();
        //e = e.div(sLength);  // now e become direction vector
        e.normalize();
        float v1 = e.dot(temp.velocity);
        float v2 = e.dot(tempN.velocity);
        float f = -ks*(restLen-sLength)-kd*(v1-v2);
        
        PVector springForce = PVector.mult(e, f);
        PVector new_Acce = springForce.div(mass);        
        temp.acceleration.x = new_Acce.x/2;
        temp.acceleration.y = new_Acce.y/2 + gravitys/mass;    
        temp.acceleration.z = new_Acce.z/2;
        tempN.acceleration.x = -new_Acce.x/2;
        tempN.acceleration.y = -new_Acce.y/2 + gravitys/mass;
        tempN.acceleration.z = -new_Acce.z/2;
        
        //temp.update(dt);
        //tempN.update(dt);   
        
        //temp.velocity.add(PVector.mult(temp.acceleration,dt));
        //tempN.velocity.add(PVector.mult(tempN.acceleration,dt));
        //temp.velocity.add(e.mult(f));  // damping force + spring force
        //tempN.velocity.sub(e.mult(f)); // other one
      }
    }
    
     for (int i = 0; i < cols; i++) {
      for (int j = 0; j< rows-1; j++) {
        Ball temp = cloth[i][j];
        Ball tempN = cloth[i][j+1];
        
        PVector e = PVector.sub(tempN.location,temp.location);
        float sLength = e.mag();
        e = e.div(sLength);
        float v1 = e.dot(temp.velocity);
        float v2 = e.dot(tempN.velocity);
        float f = -ks*(sLength-restLen)-kd*(v1-v2);
        
        PVector springForce = PVector.mult(e, f);
        PVector new_Acce = springForce.div(mass);        
        temp.acceleration.x = new_Acce.x/2;
        temp.acceleration.y = new_Acce.y/2 + gravitys/mass;    
        temp.acceleration.z = new_Acce.z/2;
        tempN.acceleration.x = -new_Acce.x/2;
        tempN.acceleration.y = -new_Acce.y/2 + gravitys/mass;
        tempN.acceleration.z = -new_Acce.z/2;
        
        //temp.update(dt);
        //tempN.update(dt);   
        
        //temp.velocity.add(PVector.mult(temp.acceleration,dt));
        //tempN.velocity.add(PVector.mult(tempN.acceleration,dt));
        //temp.velocity.add(e.mult(f));  // 
        //tempN.velocity.sub(e.mult(f)); // other one
      }
    }
    //for(int i = 0; i< cols; i++) {  // add gravity
    //  for(int j = 0; j<rows; j++) {
    //    cloth[i][j].velocity.add(gravity);
    //  }
    //}\
    //wind();
    for(int i = 0; i< cols; i++) {  // set top row to 0
      cloth[i][0].acceleration = zeros.copy();
    }
    for(int i = 0; i< cols; i++) {  
      for(int j = 0; j<rows; j++) {
        cloth[i][j].update(dt);
      }
    }  

  }
  
  void wind() {
    for(int i = 0; i< cols; i++) {  
      for(int j = 0; j<rows; j++) {
        cloth[i][rows-1].acceleration.add(new PVector(0,0,10));
      }
    }
  }
  
  void keyPressed() {
    wind();
  }
  
  void display() {
    fill(0,0,0);
    
    //for(int i = 0; i< cols; i++) {
    //  for(int j = 0; j < rows; j++) {
    //    cloth[i][j].display(radius);
    //    // line(cloth[i][j].location.x,cloth[i][j].location.y,cloth[i][j].location.z,cloth[i+1][j].location.x,cloth[i+1][j].location.y,cloth[i+1][j].location.z);
    //  }
    //}
    for(int i = 0; i< cols-1; i++) {
      for(int j = 0; j < rows-1; j++) {
        // cloth[i][j].display(radius);
        line(cloth[i][j].location.x,cloth[i][j].location.y,cloth[i][j].location.z,cloth[i+1][j].location.x,cloth[i+1][j].location.y,cloth[i+1][j].location.z);
        line(cloth[i][j].location.x,cloth[i][j].location.y,cloth[i][j].location.z,cloth[i][j+1].location.x,cloth[i][j+1].location.y,cloth[i][j+1].location.z);
      }
    }
  

  }
  
  
}
