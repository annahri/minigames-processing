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

void CheckGame() {
  int count = 0, exact = 0;  
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      Cell self = cells[i][j];
      if (self.revealed && self.bomb) {
        self.Show();
        GameOver("Game Over");
        return;
      }
      if (self.revealed && !self.bomb) {
        count++;
      } else if (!self.revealed && self.bomb && self.status == 1) {
        exact++;
      }
    }
  }
  if (count == (dim*dim) - bombs || exact == bombs) {
    GameOver("You Win");
    return;
  }

  return;
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