class Food {
  float x, y, cx, cy;
  float s;
  
  Food(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.cx = x + s/2;
    this.cy = y + s/2;
  }
  
  void Draw() {
    fill(0,255,0);
    ellipse(this.cx, this.cy, this.s * 0.8, this.s * 0.8);
  }
  
  void Relocate(float x, float y) {
    this.x = x;
    this.y = y;
    this.cx = x + s/2;
    this.cy = y + s/2;
  }
}