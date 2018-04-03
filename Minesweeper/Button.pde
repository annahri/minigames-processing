class Button {
  String text = "";
  float x, y, bx, by, w, h;
  color textColor = 0, backColor = 0;
  float textSize = 12;  
  boolean command = false;
  
  Button(float x, float y, float w, float h) {
    this.bx = x;
    this.by = y;     
    this.w = w;
    this.h = h;
    this.x = this.bx + this.w / 2;
    this.y = this.by + this.h / 2;
  }
  
  void Show() {
    fill(backColor);
    rect(this.bx, this.by, this.w, this.h);
    fill(textColor);
    textSize(this.textSize);
    textAlign(CENTER, CENTER);
    text(this.text, this.x, this.y);
  }
  
  void Update() {
    if (mousePressed && this.Intersects(mouseX, mouseY)) {
      this.command = true;
    }
  }
  
  boolean Intersects(int x, int y) {
    return (x < this.bx + this.w && x > this.bx) && (y < this.by + this.h && y > this.by); 
  }
}