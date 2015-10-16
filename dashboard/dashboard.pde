import processing.serial.*;
Serial myPort;
String[] inputs;
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
  //printArray(Serial.list());
  myPort = new Serial(this, "/dev/ttyACM0", 115200);
  size(512, 512);
}

void draw() {
  // Inputs
  //inputX = mouseX;
  //inputY = mouseY;
  //inputZ = (mousePressed) ? size : 0;
  while (!(myPort.available() > 0));
  parseInput();
  //printArray(inputs);
  inputX = parseInt(inputs[0]);
  inputY = parseInt(inputs[1]);
  inputZ = parseInt(inputs[2]);
  
  // Calculate values
  x = (int) map(inputX - (4096 / 2), 0, 4096, 0, 255);
  y = (int) map(inputY - (4096 / 2), 0, 4096, 0, 255);
  z = (int) map(inputZ - (4096 / 2), 0, 4096, 0, 255);
  
  // Draw background
  fill(#afaaff);
  rect(0, 0, size, size);
  
  // Draw X and Y
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
  
  // Draw Z
  rect(padding + 255 + padding, padding, 31, 255);
  fill(#00ff00);
  rect(padding + 255 + padding, 255 / 2 + padding, 31, z * -1);
  
  // Display raw values
  offsetX = padding * 3 + 255 + 31;
  fill(#0000ff);
  text("X: " + inputX, offsetX, padding + 12);
  fill(#ff0000);
  text("Y: " + inputY, offsetX, padding * 2 + 12 * 2);
  fill(#00ff00);
  text("Z: " + inputZ, offsetX, padding * 3 + 12 * 3);
}

// Read values from the serial device
void parseInput() {
  while (myPort.read() != '|') {
    String input = myPort.readStringUntil('$');
    input = split(input, '$')[0];
    //print(input);
    inputs = split(input, ',');
  }
}