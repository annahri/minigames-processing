Cell[][] cells;
final int dimension = 10;
final float xStart = 10;
final float yStart = 50;
final float offset = 2;
final int bombs = 10;
float s;


void setup() {
  background(255);
  size(500, 600);
  
  s = (width - xStart*2) / dimension;
  
  cells = new Cell[dimension][dimension];
  
  for (int i = 0; i < dimension; i++) {
    for (int j = 0; j < dimension; j++) {
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
  for (int i = 0; i < dimension; i++) {
    for (int j = 0; j < dimension; j++) {
      cells[i][j].Show();
      
      if (mousePressed && cells[i][j].Intersects(mouseX, mouseY)) {
        FloodFill(i,j);      
      } 
    }
  }    
  if (CheckGame()) GameOver();
  
   
  
  fill(0);
  textSize(12);
  textAlign(LEFT);
  text(String.format("x:%d | y:%d", mouseX, mouseY), xStart, yStart-10);
}

void PopulateBombs() {
  int amount = bombs;
  ArrayList<int[]> options = new ArrayList<int[]>();
  for (int i = 0; i < dimension; i++) {
    for (int j = 0; j < dimension; j++) {
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
  for (int i = 0; i < dimension; i++) {
    for (int j = 0; j < dimension; j++) {
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
      } catch (ArrayIndexOutOfBoundsException e) {
        continue;
      }
    }
  }
  return count;
}

boolean CheckGame() {
  for (int i = 0; i < dimension; i++) {
    for (int j = 0; j < dimension; j++) {
      if (cells[i][j].revealed && cells[i][j].bomb) {
        cells[i][j].Show();
        return true;
      }
    }
  }
  return false;
}

void FloodFill(int x, int y) {
  try {
    if (cells[x][y].bomb) return;
    if (cells[x][y].revealed) return;
    else {
      cells[x][y].Reveal();
      FloodFill(x+1, y);
      FloodFill(x-1, y);
      FloodFill(x, y+1);
      FloodFill(x, y-1);
    }
  } catch (ArrayIndexOutOfBoundsException e) {
    return;
  }
  return;
}

void GameOver() {
  fill(0, 200);
  rect(0, 0, width, height);
  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width / 2, height / 2);
  noLoop();
}