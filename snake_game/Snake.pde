class Snake {
  float x, y, cx, cy;
  float s;
  int dir = 0;
  ArrayList<Snake> tail = new ArrayList<Snake>();

  Snake(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.cx = x + s/2;
    this.cy = y + s/2;
  }

  void Draw() {
    int scale = 3;
    fill(255, 0, 0);
    noStroke();
    rect(this.x + scale, this.y + scale, this.s - scale*2, this.s - scale*2);
  }

  void DrawTail() {    
    for (Snake i : tail) {
      i.Draw();
    }
  }

  void Move() {
    switch (dir) {
    case 0:
      break;
    case 1:
      this.x -= this.s;
      break;
    case 2:
      this.x += this.s;
      break;
    case 3:
      this.y -= this.s;
      break;
    case 4:
      this.y += this.s;
      break;
    }
  }

  void Update(float w, float h) {    
    this.x = (this.x + w) % w;
    this.y = (this.y + h) % h;    

    this.cx = this.x + s/2;
    this.cy = this.y + s/2;
  }

  void AddTail(Food food) {
    Snake newTail = new Snake(food.x, food.y, this.s);
    tail.add(newTail);
    pr this.dir = val;
  }

  boolean Intersects(Food food) {    
    return (this.cx == food.cx && this.cy == food.cy);
  }
}