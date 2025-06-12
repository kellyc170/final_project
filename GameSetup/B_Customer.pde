class Customer {
  Order order;
  String name;
  float x, y;
  float targetX, targetY;
  PImage img;
  boolean hasReachedTarget;

  Customer(Order order, float startX, float startY, String name) {
    this.order = order;
    this.name = name;
    this.x = startX;
    this.y = startY;
    this.targetX = width / 2;
    this.targetY = startY;
    this.hasReachedTarget = false;
    this.img = loadImage(name + ".png");
  }

  void moveToTarget() {
    if (abs(x - targetX) > 1) {
      if (x < targetX) {
        x += 2;
      } else if (x > targetX) {
        x -= 2;
      }
    } else {
      hasReachedTarget = true;
      x = targetX;
    }
  }

  void display() {
    if (img != null) image(img, x - img.width / 4, y - img.height / 6, 100, 180);
  }
}
