int[][] world;
PImage[] tiles;
PVector pos;
int wsx;
int wsy;
int walkspeed = 2;
PVector chmove;
int screenx = 0;
int screeny = 0;
ArrayList<Entity> entities;

void settings() {
  size(512, 512);
}
void setup() {
  entities = new ArrayList<Entity>();
  wsx = width/16;
  wsy = height/16;
  world = new int[wsx][wsy];
  loadLevel("data/img/lvl/"+screenx+"-"+screeny+".png");
  pos = new PVector(width/2, height/2);
  chmove = new PVector(0, 0);
  tiles = new PImage[11];
  tiles[0] = loadImage("data/img/tile/floor.png");
  tiles[1] = loadImage("data/img/tile/wall.png");
  tiles[2] = null; //Air tile
  tiles[3] = loadImage("data/img/tile/missing.png");
  tiles[4] = loadImage("data/img/tile/chest.png");
  tiles[5] = loadImage("data/img/tile/chest.png");
  tiles[6] = loadImage("data/img/tile/chest.png");
  tiles[7] = loadImage("data/img/tile/chest.png");
  tiles[8] = loadImage("data/img/tile/chest.png");
  tiles[9] = loadImage("data/img/tile/chest.png");
  tiles[10] = loadImage("data/img/tile/chest.png");
}
void draw() {
  background(0);
  for(int i = 0; i < wsx; i++) {
    for(int j = 0; j < wsy; j++) {
      if(world[i][j] != 2 && world[i][j] < tiles.length) { 
        image(tiles[world[i][j]], i*16, j*16); 
      }
      if(world[i][j] > tiles.length) {
        image(tiles[3], i*16, j*16); 
      }
    }
  }
  for(Entity e: entities) {
    e.update();
  }
  fill(255);
  rect(pos.x, pos.y, 16, 16);
  PVector npos = new PVector(pos.x, pos.y);
  npos.x += chmove.x;
  npos.y += chmove.y;
  int rx = round(npos.x/16);
  int ry = round(npos.y/16);
  if(world[rx][ry] == 0) {
    pos.x = npos.x;
    pos.y = npos.y;
  }
  if(rx == wsx-1) {
    screenx++;
    pos.x = 1*16;
    loadLevel("data/img/lvl/"+screenx+"-"+screeny+".png");
  }
  if(rx == 0) {
    screenx--;
    pos.x = (wsx-2)*16;
    loadLevel("data/img/lvl/"+screenx+"-"+screeny+".png");
  }
  if(ry == wsy-1) {
    screeny--;
    pos.y = 1*16;
    loadLevel("data/img/lvl/"+screenx+"-"+screeny+".png");
  }
  if(ry == 0) {
    screeny++;
    pos.y = (wsy-2)*16;
    loadLevel("data/img/lvl/"+screenx+"-"+screeny+".png");
  }
}
void keyPressed() {
  if(key == 'w') {
    chmove.y = -walkspeed;
  }
  if(key == 's') {
    chmove.y = walkspeed;
  }
  if(key == 'a') {
    chmove.x = -walkspeed;
  }
  if(key == 'd') {
    chmove.x = walkspeed;
  }
}
void keyReleased() {
  if(key == 'w') {
    chmove.y = -0;
  }
  if(key == 's') {
    chmove.y = 0;
  }
  if(key == 'a') {
    chmove.x = -0;
  }
  if(key == 'd') {
    chmove.x = 0;
  }
}
void loadLevel(String path) {
  PPImage lvl = loadImage(path);
  entities = new ArrayList<Entity>();
  try {
    for(int i = 0; i < wsx; i++) {
      for(int j = 0; j < wsy; j++) {
        color c = lvl.get(i, j);
        int type = 2000;
        if(c == color(100, 100, 100)) {
          type = 1;
        }
        if(c == color(50, 50, 50)) {
          type = 0;
        }
        if(c == color(0, 0, 0)) {
          type = 2;
        }
        if(c == color(127, 82, 19)) {
          type = 4;
        }
        if(c == color(127, 82, 20)) {
          type = 5;
        }
        if(c == color(127, 82, 21)) {
          type = 6;
        }
        if(c == color(127, 82, 22)) {
          type = 7;
        }
        if(c == color(127, 82, 23)) {
          type = 8;
        }
        if(c == color(127, 82, 24)) {
          type = 9;
        }
        if(c == color(127, 82, 25)) {
          type = 10;
        }
        if(c == color(109, 16, 16)) {
          type = 0;
          entities.add(new Entity(i*16, j*16, loadImage("data/img/ent/warrior.png")).addBehavior("homing"));
        }
        world[i][j] = type;
      }
    }
  } catch(Exception e) {
    loadLevel("data/img/lvl/null.png");
    pos.x = width/2;
    pos.y = height/2;
  }
}
