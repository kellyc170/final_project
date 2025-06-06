class Order {

  int orderNumber = 1;
  String cupSize;    // small, medium, large
  String syrup;      // chocolate, caramel, strawberry
  String flavor;     // vanilla, chocolate, strawberry
  int mixLevel;      // light, medium, heavy
  String[] toppings; // cherry, sprinkles, whipped cream, oreo, add others later

  Order(String cupSize, String syrup, String flavor, int mixLevel, String[] toppings) {
    this.cupSize = cupSize;
    this.syrup = syrup;
    this.flavor = flavor;
    this.mixLevel = mixLevel;
    this.toppings = toppings;
  }
  
  int getOrderNumber() {
    return orderNumber;
  }
  
  String getCupSize() {
    return cupSize;
  }
  
  String getSyrup() {
    return syrup;
  }
  
  String getFlavor() {
    return flavor;
  }
  
  int getMixLevel() {
    return mixLevel;
  }
  
  String[] getToppings() {
    return toppings;
  }

  void display() {
    float padding = 20;
    float boxWidth = 200;
    
    // top right
    float x = width - padding - boxWidth;
    float y = padding;
  
    ArrayList<String> linesList = new ArrayList<String>();
    linesList.add("Order #" + orderNumber);
    for (int i = 0; i < toppings.length; i++) {
      linesList.add("Topping: " + toppings[i]);
    }
    linesList.add("Mix Level: " + mixLevel);
    linesList.add("Flavor: " + flavor);
    linesList.add("Syrup: " + syrup);
    linesList.add("Cup Size: " + cupSize);
  
    String[] lines = linesList.toArray(new String[0]);
  
    textFont(createFont("Comic Sans MS", 16));
    textSize(16);
    textLeading(22);
    textAlign(LEFT, TOP);
  
    float lineHeight = 28;
  
    for (int i = 0; i < lines.length; i++) {
      if (i % 2 == 0) {
        fill(#FFF5FF); // lighter pink
      } else {
        fill(#FFDCF0); // light pink
      }
      noStroke();
      float lineY = y + i * lineHeight;
      rect(x + 5, lineY, boxWidth - 10, lineHeight);
      fill(80, 30, 60);
      text(lines[i], x + 10, lineY + 6);
    }
  }

  void display(float x, float y) {
    ArrayList<String> linesList = new ArrayList<String>();
    linesList.add("Order #" + orderNumber);

    for (int i = 0; i < toppings.length; i++) {
      linesList.add("Topping: " + toppings[i]);
    }

    linesList.add("Mix Level: " + mixLevel);
    linesList.add("Flavor: " + flavor);
    linesList.add("Syrup: " + syrup);
    linesList.add("Cup Size: " + cupSize);

    String[] lines = linesList.toArray(new String[0]);

    textFont(createFont("Comic Sans MS", 16));
    textSize(16);
    textLeading(22);
    textAlign(LEFT, TOP);

    float lineHeight = 28;
    float boxWidth = 200;


    for (int i = 0; i < lines.length; i++) {
      // Alternate fill per line
      if (i % 2 == 0) {
        fill(#FFF5FF); // lighter pink
      } else {
        fill(#FFDCF0); // light pink
      }

      noStroke();
      float lineY = y + i * lineHeight;
      rect(x - 5, lineY, boxWidth - 10, lineHeight);
      fill(80, 30, 60);
      text(lines[i], x, lineY + 6);
    }
  
    textFont(createFont("Impact", 100));
  }
}
