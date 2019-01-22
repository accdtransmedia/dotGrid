class Block {
  float ox, oy; // original xy
  float tx, ty; // tweened (animation) xy
  color c;
  float size;
  int time;
  int id;
  int rn;
  int rox, boy;
  float rtx, rty, btx, bty;

  Block(int count, int x, int y, float blockSize) {
    ox = x;
    oy = y;
    tx = x;
    ty = y;
    rn = int(random(5));
    size = blockSize;
    c = color(255);
    id = count;

    rox = id+1;
    if(id%blockXAmount == blockXAmount-1){
      rox = id;
    }

    if (id >= blockTotal) {
      rox = id;
    }

    boy = id+blockXAmount;
    if (boy > blockTotal) {
      boy = id;
      println(id);
    }
  }

  void calculateGrid() {
    try {
      Block tempBlock = (Block) blocks.get(rox); 
      rtx = tempBlock.tx;
      rty = tempBlock.ty;
    } 
    catch (Exception e) {
    }

    try {
      Block tempBlock2 = (Block) blocks.get(boy); 
      btx = tempBlock2.tx;
      bty = tempBlock2.ty;
    } 
    catch (Exception e) {
    }
  }


  void draw() {
    fill(c);
    stroke(255);
    strokeWeight(5);
    point(tx, ty);
    strokeWeight(1);
    line(tx, ty, rtx, rty);
    line(tx, ty, btx, bty);
  }

  boolean findCross(float x, float y) {
    if (dist(x, y, tx, ty) < blockSize) {
      return true;
    } else {
      return false;
    }
  }

  void detect(float px, float py) {
    if (dist(ox, oy, px, py) < 10+random(50)) {
      //c = color(255, 0, 0);
      time = id;
    }
    time--;

    if (time <= 0) time = 0;
    if (time > 0) {
      noiseSeed(id+1);
      noiseDetail(rn);

      float nx = noise(millis()*.001);
      noiseSeed(id+2);

      float ny = noise(millis()*.001);
      nx = map(nx, 0, 1, ox-50, ox+50); 
      ny = map(ny, 0, 1, oy-50, oy+50); 

      tx = lerp(tx, nx, .05);
      ty = lerp(ty, ny, .05);
    } else {
      tx = lerp(tx, ox, .05);
      ty = lerp(ty, oy, .05);
    }
  }
}
