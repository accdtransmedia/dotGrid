
int blockSize = 10;
int blockPadding = 10;
int blockTotal;
int blockXAmount, blockYAmount;
int blockDistance = blockSize+blockPadding*2;

ArrayList blocks;

void setup() {

  size(960, 540, P3D);
  blocks = new ArrayList();

  blockXAmount = int(width/(blockSize+blockPadding));
  blockYAmount = int(height/(blockSize+blockPadding));
  blockTotal = blockXAmount*blockYAmount;
  int count = 0;

  for (int y = 0; y < blockYAmount; y++) {
    for (int x = 0; x < blockXAmount; x++) {

      int blockX = x*blockDistance;
      int blockY = y*blockDistance;

      blocks.add(new Block(count, blockX, blockY, blockSize));
      count++;
    }
  }

  for (int i = 0; i < blocks.size(); i++) {
    Block tempBlock = (Block) blocks.get(i); 
    //if (tempBlock.id != i) {
    tempBlock.calculateGrid();
  }
}

void draw() {

  background(0);

  for (int i = 0; i < blocks.size(); i++) {
    Block tempBlock = (Block) blocks.get(i); 
    tempBlock.detect(mouseX, mouseY);
    tempBlock.calculateGrid();
    tempBlock.draw();
  }
}
