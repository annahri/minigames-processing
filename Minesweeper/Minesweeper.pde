Cell[][] cells;
StopWatchTimer timer;
//Button playButton;
final int dim = 10;
final float xStart = 10;
final float yStart = 30;
final float offset = 2;
final int bombs =10;
int startTime = 0;
int time = 0;
float s;
//boolean started = false;
//boolean menu = true;

void init() {    
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

void setup() {
  background(255);
  size(500, 520);
  init();
}

void draw() {
  Start();
}

void mousePressed() {
  if (!timer.running) {
    timer.start();
  }
  
  if (mouseButton == LEFT) {
    for (int i = 0; i < dim; i++) {
      for (int j = 0; j < dim; j++) {
        boolean intersected = cells[i][j].Intersects(mouseX, mouseY);
        int val = cells[i][j].neighbors;
  
        if (intersected) {
          if (val == 0) FloodFill(i, j);
        }
      }
    }
  }
}


void Start() {
  background(255);  
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      cells[i][j].Show();
    }
  }    

  switch (CheckGame()) {
  case 1:  
    GameOver("GAME OVER");
    break;
  case 2:
    GameOver("YOU WIN");
    break;
  }

  fill(0);
  textSize(12);
  textAlign(LEFT);
  text(String.format("Bombs : %d", bombs), xStart, yStart-10);
  text(String.format("Dimension : %d x %d", dim, dim), xStart + 100, yStart-10);
  textAlign(RIGHT);
  text(String.format("%d:%d", timer.minute(), timer.second()), width - 10, yStart - 10);

  //started = true;
}

void PopulateBombs() {
  int amount = bombs;
  ArrayList<int[]> options = new ArrayList<int[]>();
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      options.add(new int[] { i, j });
    }
  }

  while (amount > 0) {
    int index = floor(random(options.size()));
    int[] choice = options.get(index); 
    int i = choice[0];
    int j = choice[1];
    options.remove(index);

    cells[i][j].bomb = true;
    amount--;
  }
}

void CalculateNeighbors() {
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      cells[i][j].neighbors = CountNeighbors(i, j);
    }
  }
}

int CountNeighbors(int x, int y) {
  int count = 0;
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      try {
        if (cells[x + i][j + y].bomb) count++;
      } 
      catch (ArrayIndexOutOfBoundsException e) {
        continue;
      }
    }
  }
  return count;
}

int CheckGame() {
  int count = 0;
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      if (cells[i][j].revealed && cells[i][j].bomb) {
        cells[i][j].Show();
        return 1;
      }
      if (cells[i][j].revealed && !cells[i][j].bomb) {
        count++;
      }
    }
  }
  if (count == (dim*dim) - bombs) return 2;
  return 0;
}

void FloodFill(int x, int y) {
  try {
    if (cells[x][y].bomb || cells[x][y].revealed) return; 
    else if (cells[x][y].neighbors != 0) {
      cells[x][y].Reveal();
      return;
    } else {
      cells[x][y].Reveal();
      FloodFill(x+1, y);
      FloodFill(x-1, y);
      FloodFill(x, y+1);
      FloodFill(x, y-1);
      FloodFill(x+1, y+1);
      FloodFill(x-1, y-1);
    }
  } 
  catch (ArrayIndexOutOfBoundsException e) {
    return;
  }
  return;
}

void GameOver(String text) {  
  float x = width/2, y = height / 2;
  
  timer.stop();
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      if (!cells[i][j].bomb) continue;
      cells[i][j].Reveal();
      cells[i][j].Show();
    }
  }
  fill(0, 200);
  rect(0, 0, width, height);
  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text(text, x, y - 20);
  textSize(15);
  text(String.format("Time : %d minute %d seconds", timer.minute(), timer.second()), x, y + 20);
  noLoop();
}

//void Restart() {
//  init();
//  loop();
//}

//void Menu() {
//  float x = width / 2, y = height / 2;  
//  float w = 100, h = 30;
//  playButton = new Button(x - w/2, y, w, h);
//  playButton.backColor = color(255);
//  playButton.textColor = color(0);
//  playButton.textSize = 14;
//  playButton.text = "Play";

//  fill(0);
//  rect(0, 0, width, height);
//  fill(255);
//  textSize(40);
//  textAlign(CENTER);
//  text("Minesweeper!", x, y - 20);
//  playButton.Show();
//  playButton.Update();
//  if (playButton.command) {
//    menu = false;
//  }
//}