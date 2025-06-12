class OrderStation extends Station {
  ArrayList<Customer> customers;
  int currentCustomerIndex = 0;
  Customer selectedCustomer = null;
  boolean showReceipt = false;

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
  
  void drawVerticalGradient(float x, float y, float w, float h, color topColor, color bottomColor) {
    noStroke();
    for (int i = 0; i < int(h); i++) {
      float inter = map(i, 0, h, 0, 1);
      color c = lerpColor(topColor, bottomColor, inter);
      fill(c);
      rect(x, y + i, w, 1);
    }
  }

  void display() {
    noStroke();
  
    // Floor
    color darkGray = color(#5F5F5F);
    color lightGray = color(#8E8E8E);
    drawVerticalGradient(0, height-100, width, 100, darkGray, lightGray); // top
    drawVerticalGradient(0, height-320, width, 120, darkGray, lightGray); // bottom
    
    // Green counter
    strokeWeight(0.75);
    fill(#5AD154);
    rect(0, height-200, width, 100);
    fill(#17A055);
    rect(0, height-110, width, 20);
  
    // light purple wall
    fill(#ECD6FF);
    rect(0, 0, width, 280);
  
    // dark purple borders
    noStroke();
    fill(#8F3DD8);
    rect(0, 275, width, 10);
  
    strokeWeight(10);
    stroke(#8F3DD8); // door border
    fill(#B4B4B4); // grey door filling
  
    float doorWidth = 300;
    float doorHeight = 250;
    float doorX = width / 2 - doorWidth / 2;
    float doorY = 30;
    rect(doorX, doorY, doorWidth, doorHeight);
    
    //line double doors
    strokeWeight(3);
    stroke(#747373);
    fill(#B4B4B4);
    rect(doorX+5, doorY+5, doorWidth/2, doorHeight-2);
    rect(doorX+doorWidth/2, doorY+5, doorWidth/2-5, doorHeight-2);
  
    // sunset gradient in door window
    float inset = 20;
    drawVerticalGradient(doorX+ 3 + inset, doorY + inset, doorWidth/2 - 2 * inset, doorHeight - 3 * inset, color(#FC75D4), color(#FAB077));
    noFill();
    stroke(#747373);
    rect(doorX+ 3 + inset, doorY + inset, doorWidth/2 - 2 * inset, doorHeight - 3 * inset);
    drawVerticalGradient(doorX+doorWidth/2 + inset, doorY + inset, doorWidth/2 - 2 * inset, doorHeight - 3 * inset, color(#FC75D4), color(#FAB077));
    noFill();
    stroke(#747373);
    rect(doorX+doorWidth/2 + inset, doorY + inset, doorWidth/2 - 2 * inset, doorHeight - 3 * inset);
    
    stroke(#8F3DD8);
    strokeWeight(10);
  
    // Left window frame
    float windowWidth = 100;
    float windowHeight = 200;
    float windowY = doorY+5;
    float leftWindowX = doorX - 175;
    rect(leftWindowX, windowY, windowWidth, windowHeight);
  
    // sunset gradient in left window
    noStroke();
    drawVerticalGradient(leftWindowX + 5, windowY + 5, windowWidth-9, windowHeight-9, color(#FC75D4), color(#FAB077));
  
    stroke(#8F3DD8);
    strokeWeight(10);
  
    // Right window frame
    float rightWindowX = doorX + doorWidth + 70;
    rect(rightWindowX, windowY, windowWidth, windowHeight);
  
    // sunset gradient in right window
    noStroke();
    drawVerticalGradient(rightWindowX + 5, windowY + 5, windowWidth - 9, windowHeight - 9, color(#FC75D4), color(#FAB077));
    
    // add blue water in all windows from left to right
    fill(#85E3F5);
    rect(leftWindowX + 5, windowY + windowHeight-20, windowWidth-9, 16);
    rect(doorX+5+inset, doorY+doorHeight-3*inset, doorWidth/2-2*inset-3.5, 18.5);
    rect(doorX+doorWidth/2 + inset+2, doorY+doorHeight-3*inset, doorWidth/2-2*inset-3.5, 18.5);
    rect(rightWindowX + 5, windowY + windowHeight-20, windowWidth-9, 16);
  
    fill(0);
    textSize(20);
    textAlign(LEFT, TOP);
    text("Day: " + game.dayCount, 20, 20);
    text("Order Number to Next Day: " + (game.orderCount + 1) + " / 10", 20, 50);
  
    if (currentCustomerIndex < customers.size()) {
      Customer current = customers.get(currentCustomerIndex);
      current.display();
      if (selectedCustomer != null && showReceipt) {
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
        game.selectedCustomer = c;
        showReceipt = true; 
      }
    }
  }
}
