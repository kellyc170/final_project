class Customer {
  Order order;
  float x, y;      // current position on screen
  float targetX;   // where the customer is walking to
  PImage img;     
  boolean hasReachedTarget;

  Customer(Order order, float startX, float startY, float targetX) {
    this.order = order;
    this.x = startX;
    this.y = startY;
    this.targetX = targetX;
    this.hasReachedTarget = false;
    this.img = loadImage("chuck.png");
  }

  void moveToTarget() {
    if (x < targetX) {
      x += 2; // move right
    } else {
      hasReachedTarget = true;
    }
  }

  void display() {
    if (img != null) image(img, x - img.width/4, y - img.height/6, 100, 180);
  }
}

//Order myOrder;
//Customer myCustomer;

//void setup() {
//  size(600, 300);
//  background(240);

  // Sample order
//  String[] toppings = {"Sprinkles", "Cherry"};
//  myOrder = new Order("Large", "Vanilla", "Banana", 2, toppings);
//  myOrder.orderNumber = 1;

  // Create customer at left edge, walking to x = 300
//  myCustomer = new Customer(myOrder, 50, 200, 300);
//}

//void draw() {
//  background(240);

  // Move and display the customer
//  myCustomer.moveToTarget();
//  myCustomer.display();

  // Once the customer arrives, show their order
//  if (myCustomer.hasReachedTarget) {
//    myCustomer.order.display();
//  }
//}
