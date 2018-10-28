class Entity {
  ArrayList<String> behaviors;
  PVector epos;
  PImage img; 
  boolean flip;
  
  Entity(int x, int y, PImage i) {
    epos = new PVector(x, y);
    img = i;
    flip = false;
    behaviors = new ArrayList<String>();
  }
  void update() {
    if(flip) {
      image(img, epos.x, epos.y);
    } else {
      pushMatrix();
      translate(img.width, 0);
      scale(-1, 1);
      //translate(epos.x, epos.y);
      image(img, -epos.x, epos.y);
      popMatrix();
    }
    PVector npos = new PVector(epos.x, epos.y);
    for(String b: behaviors) {
      if(b.equals("homing")) {
        PVector tele = new PVector(epos.x-pos.x, epos.y-pos.y);
        tele.normalize();
        tele.mult(-2);
        if(tele.x < 0) {
          flip = true;
        } else {
          flip = false;
        }
        npos.x += tele.x;
        npos.y += tele.y;
      }
    }
    if(world[round(npos.x/16)][round(npos.y/16)] == 0) {
      epos.x = npos.x;
      epos.y = npos.y;
    }
  }
  Entity addBehavior(String b) {
    behaviors.add(b);
    return this;
  }
}
