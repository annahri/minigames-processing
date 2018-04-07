Cell[][] cells;
StopWatchTimer timer;
//Button playButton;
final int dim = 12;
final float xStart = 10;
final float yStart = 30;
final float offset = 2;
final int bombs =30;
int startTime = 0;
int time = 0;
float s;
//boolean started = false;
//boolean menu = true;

void setup() {
  background(255);
  size(500, 520);
  
  s = (width - xStart*2) / dim;
  timer = new StopWatchTimer();
  cells = new Cell[dim][dim];

  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      float x = xStart + j * s + offset;
      float y = yStart + i * s + offset;
      float ss = s - offset;
      cells[i][j] = new Cell(x, y, ss);
    }
  }
  PopulateBombs();
  CalculateNeighbors();
  
}

void draw() {
  background(255);
  
  for (Cell[] obj : cells) {
    for (Cell self : obj) {
      self.Show();
    }
  }

  CheckGame();

  fill(0);
  textSize(12);
  textAlign(LEFT);
  text(String.format("Bombs : %d", bombs), xStart, yStart-10);
  text(String.format("Dimension : %d x %d", dim, dim), xStart + 100, yStart-10);
  textAlign(RIGHT);
  text(String.format("%d:%d", timer.minute(), timer.second()), width - 10, yStart - 10);

  //started = true;
}

void mousePressed() {
  if (!timer.running) {
    timer.start();
  }

  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      Cell self = cells[i][j];
      boolean intersected = self.Intersects(mouseX, mouseY);      
      int val = self.neighbors;

      if (intersected) {
        if (mouseButton == LEFT) {
          if (val == 0 && self.status == 0) FloodFill(i, j);
        } else if (mouseButton == RIGHT) {
          if (!self.revealed) self.ChangeStatus();
        }
      }
      
    }
  }
}