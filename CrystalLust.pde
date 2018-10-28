int[][] world;
PImage[] tiles;
PVector pos;
int wsx;
int wsy;
int walkspeed = 2;
PVector chmove;
int screenx = 0;
int screeny = 0;

void settings() {
  size(800, 800);
}
void setup() {
  wsx = width/16;
  wsy = height/16;
  world = new int[wsx][wsy];
  loadLevel("data/img/lvl/"+screenx+"+"+screeny+".png");
  pos = new PVector(width/2, height/2);
  chmove = new PVector(0, 0);
  tiles = new PImage[3];
  tiles[0] = loadImage("data/img/tile/floor.png");
  tiles[1] = loadImage("data/img/tile/wall.png");
  tiles[2] = null; //Air tile
}
void draw() {
  background(0);
  for(int i = 0; i < wsx; i++) {
    for(int j = 0; j < wsy; j++) {
      if(world[i][j] != 2 && world[i][j] < tiles.length) { image(tiles[world[i][j]], i*16, j*16); };
    }
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
  PImage lvl = loadImage(path);
  for(int i = 0; i < wsx; i++) {
    for(int j = 0; j < wsy; j++) {
      color c = lvl.get(i, j);
      int type = 2000;
      if(c == color(255, 128, 0)) {
        type = 0;
      }
      if(c == color(128, 64, 0)) {
        type = 1;
      }
      if(c == color(0, 0, 0)) {
        type = 2;
      }
      world[i][j] = type;
    }
  }
}
