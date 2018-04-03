class Cell {
  float x, y, cx, cy, s;
  int neighbors = 0, defcolor = 100, alpha = 100;
  color col = color(defcolor, alpha);
  boolean bomb = false, revealed = false;
  
  public Cell(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.cx = this.x + this.s / 2;
    this.cy = this.y + this.s / 2;
  }
  
  boolean Intersects(int x, int y) {
    return (x < this.x + this.s && x > this.x) && (y < this.y + this.s && y > this.y); 
  }
  
  void ChangeAlpha(int num) {
    this.alpha = num;
  }
  
  void Reveal() {
    this.revealed = true;
  }
    
  void Show() {
    if (this.revealed) col = color(180, alpha);
    else {
      if (this.Intersects(mouseX, mouseY)) col = color(defcolor, 200);
      else col = color(defcolor, alpha);
    }
    
    noStroke();
    fill(col);
    rect(this.x, this.y, this.s, this.s);
    
    if (this.revealed) {
      if (this.neighbors == -1 || this.bomb) {
        fill(0);
        ellipse(this.cx, this.cy, this.s / 3, this.s / 3);
      } else {
        if (this.neighbors != 0) {
          fill(0);
          textSize(this.s / 3);
          textAlign(CENTER, CENTER);
          text(this.neighbors, this.cx, this.cy);
        }
      }
    }
    
    if (mousePressed && this.Intersects(mouseX, mouseY)) {
      if (mouseButton == LEFT) {
        this.Reveal();
      }
    }    
  }
}