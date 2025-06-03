class Customer {
  Order order;
  float x, y;           // current position on screen
  float targetX, targetY; // target position customer is walking to
  PImage img;     
  boolean hasReachedTarget;

  Customer(Order order, float startX, float startY) {
    this.order = order;
    this.x = startX;
    this.y = startY;
    this.targetX = width / 2;  // Center horizontally
    this.targetY = startY;     
    this.hasReachedTarget = false;
    this.img = loadImage("chuck.png");
  }

  void moveToTarget() {
    // Move horizontally toward targetX
    if (abs(x - targetX) > 1) {
      if (x < targetX) {
        x += 2; // move right
      } else if (x > targetX) {
        x -= 2; // move left if at center
      }
    } else {
      hasReachedTarget = true;
      x = targetX; // snap to exact position
    }
  }

  void display() {
    if (img != null) image(img, x - img.width/4, y - img.height/6, 100, 180);
  }
}
