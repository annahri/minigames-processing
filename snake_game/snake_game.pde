Snake snake;
Food food;
float res;
float cols = 20, rows = 15;
int offset = 1;
int score = 0;

void setup() {
  size(500,500);
  frameRate(15);
  res = width / cols;
  float fx = floor(random(cols)) * res;
  float fy = floor(random(rows)) * res;
  translate(0, (cols-rows) * res * 0.5);
  snake = new Snake(100, 100, res);
  food = new Food(fx, fy, res);
}

void draw() {
  background(255);
  translate(0, (cols-rows) * res * 0.5);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float x = j * res;
      float y = i * res;
      noFill();
      stroke(1);
      rect(x,y, res, res);
    }
  }
  
  snake.Draw();
  snake.DrawTail();  
  snake.Move();
  snake.Update(cols*res, rows*res);
  food.Draw();
  
  if (snake.Intersects(food)) {
    score += 10;
    float fx = floor(random(cols)) * res;
    float fy = floor(random(rows)) * res;
    food.Relocate(fx, fy);
  }
}

void keyPressed() {
  if (key == 'z') {
    if (snake.dir != 4) snake.ChangeDir(3);    
  } else if (key == 's') {
    if (snake.dir != 3) snake.ChangeDir(4);
  } else if (key == 'q') {
    if (snake.dir != 2) snake.ChangeDir(1);
  } else if (key == 'd') {
    if (snake.dir != 1) snake.ChangeDir(2);
  }
}