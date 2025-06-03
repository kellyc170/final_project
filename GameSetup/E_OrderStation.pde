class OrderStation extends Station {
  ArrayList<Customer> customers;
  int currentCustomerIndex = 0;
  Customer selectedCustomer = null;

  OrderStation(ArrayList<Customer> customers) {
    super("Order");
    this.customers = customers;
  }

  void update() {
    if (currentCustomerIndex < customers.size()) {
      Customer c = customers.get(currentCustomerIndex);
      if (!c.hasReachedTarget) {
        c.moveToTarget();
      }
    }
  }

  void display() {
    noStroke();
    background(#727074); //background
    strokeWeight(0.75);
    fill(#5AD154); //counter color green
    rect(0, height - 200, width, 100);
    fill(#ECD6FF);
    rect(0, 0, width, 280);
    noStroke();
    fill(#8F3DD8);
    rect(0, 275, width, 10);
    
    
    strokeWeight(10);
    stroke(#8F3DD8); // door border color purple
    fill(#C8C7C9);
    float doorWidth = 300;
    float doorHeight = 250;
    float doorX = width / 2 - doorWidth / 2;
    float doorY = 30;
    rect(doorX, doorY, doorWidth, doorHeight, 10);
    
    //window in door code here

    //fill(gradient);
    float windowWidth = 100;
    float windowHeight = 200;
    float windowY = doorY + 20;
    float leftWindowX = doorX - 175;
    rect(leftWindowX, windowY, windowWidth, windowHeight, 15);
    stroke(#8F3DD8);
    strokeWeight(10);

    //fill(gradient);
    float rightWindowX = doorX + doorWidth + 70;
    rect(rightWindowX, windowY, windowWidth, windowHeight, 15);
    stroke(#8F3DD8);
    strokeWeight(10);
    
    // Show current customer only
    if (currentCustomerIndex < customers.size()) {
      Customer current = customers.get(currentCustomerIndex);
      current.display();

      if (selectedCustomer != null) {
        selectedCustomer.order.display(width - 220, 20);
      }
    }

    displayNavButtons();
  }

  void handleClick(float mx, float my) {
    if (currentCustomerIndex < customers.size()) {
      Customer c = customers.get(currentCustomerIndex);
      float left = c.x - c.img.width / 4;
      float right = left + 100;
      float top = c.y - c.img.height / 6;
      float bottom = top + 180;

      if (mx >= left && mx <= right && my >= top && my <= bottom) {
        selectedCustomer = c;
        return;
      }
    }
  }
}
