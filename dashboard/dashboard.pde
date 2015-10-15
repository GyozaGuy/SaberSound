int inputX;
int inputY;
int inputZ;
int x;
int y;
int z;
int size = 512;
int padding = 10;
int offsetX;

void setup() {
  size(512, 512);
}

void draw() {
  // Inputs
  inputX = mouseX;
  inputY = mouseY;
  inputZ = (mousePressed) ? size : 0;
  
  // 
  x = (int) map(inputX - (size / 2), 0, size, 0, 255);
  y = (int) map(inputY - (size / 2), 0, size, 0, 255);
  z = (int) map(inputZ - (size / 2), 0, size, 0, 255);
  
  // 
  fill(#aaaaaa);
  rect(0, 0, size, size);
  
  // 
  fill(#ffffff);
  rect(padding, padding, 255, 255);
  line(padding, 127 + padding, 255 + padding, 127 + padding);
  line(127 + padding, padding, 127 + padding, 255 + padding);
  fill(#0000ff);
  text("X", padding + 2, 127 + padding + 12);
  fill(#ff0000);
  text("Y", 127 + padding - 8, 255 + padding - 2);
  fill(#ffffff);
  ellipse(x + padding + 128, y + padding + 128, padding, padding);
  
  // Bar for Z
  rect(padding + 255 + padding, padding, 31, 255);
  fill(#00ff00);
  rect(padding + 255 + padding, 255 / 2 + padding, 31, z * -1);
  
  // Raw values
  offsetX = padding * 3 + 255 + 31;
  fill(#0000ff);
  text("X: " + inputX, offsetX, padding + 12);
  fill(#ff0000);
  text("Y: " + inputY, offsetX, padding * 2 + 12 * 2);
  fill(#00ff00);
  text("Z: " + inputZ, offsetX, padding * 3 + 12 * 3);
}