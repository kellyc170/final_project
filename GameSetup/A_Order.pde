class Order {

  int orderNumber = 1;
  String cupSize;    //"Small", "Medium", "Large"
  String syrup;      // "Vanilla", "Chocolate"
  String flavor;     // e.g., "Strawberry", "Banana"
  int mixLevel;   
  String[] toppings; // e.g., {"Cherry", "Sprinkles"}

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
  
  // Place top right: x near width - padding - boxWidth
  float x = width - padding - boxWidth;
  float y = padding;

  ArrayList<String> linesList = new ArrayList<String>();
  linesList.add("Order #" + orderNumber);
  for (int i = 0; i < toppings.length; i++) {
    linesList.add("Topping: " + toppings[i]);
  }
  linesList.add("Flavor: " + flavor);
  linesList.add("Syrup: " + syrup);
  linesList.add("Mix Level: " + mixLevel);
  linesList.add("Cup Size: " + cupSize);

  String[] lines = linesList.toArray(new String[0]);

  textFont(createFont("Comic Sans MS", 16));
  textSize(16);
  textLeading(22);
  textAlign(LEFT, TOP);

  float lineHeight = 28;

  for (int i = 0; i < lines.length; i++) {
    if (i % 2 == 0) {
      fill(255, 245, 255); // very light pink
    } else {
      fill(255, 220, 240); // light pink
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

  linesList.add("Flavor: " + flavor);
  linesList.add("Syrup: " + syrup);
  linesList.add("Mix Level: " + mixLevel);
  linesList.add("Cup Size: " + cupSize);

  // Convert list to array
  String[] lines = linesList.toArray(new String[0]);

  // Set font
  textFont(createFont("Comic Sans MS", 16));
  textSize(16);
  textLeading(22);  // More line spacing
  textAlign(LEFT, TOP);

  float lineHeight = 28;  // Height of each line box
  float boxWidth = 200;   // Make wider to better fit text and look balanced


  for (int i = 0; i < lines.length; i++) {
    // Alternate pastel fill for lines
    if (i % 2 == 0) {
      fill(255, 245, 255); // very light pink
    } else {
      fill(255, 220, 240); // light pink
    }

    noStroke();
    float lineY = y + i * lineHeight;
    rect(x - 5, lineY, boxWidth - 10, lineHeight);

    fill(80, 30, 60);
    text(lines[i], x, lineY + 6);
  }
}

}
