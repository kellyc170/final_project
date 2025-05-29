class Order {

  int orderNumber;
  String cupSize;    // e.g., "Small", "Medium", "Large"
  String syrup;      // e.g., "Vanilla", "Chocolate"
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

  void display() {
  float x = 50;
  float y = 50;
  
  ArrayList<String> linesList = new ArrayList<String>();
  linesList.add("Order #" + orderNumber);
  
  for (int i = 0; i < toppings.length; i++) {
    linesList.add("Topping: " + toppings[i]);
  }
  
  linesList.add("Flavor: " + flavor);
  linesList.add("Syrup: " + syrup);
  linesList.add("Mix Level: " + mixLevel);
  linesList.add("Cup Size: " + cupSize); // last line

  // Convert list to array
  String[] lines = linesList.toArray(new String[0]);

  textAlign(LEFT, TOP);
  textSize(12);
  
  float newY = 0;

  for (int i = 0; i < lines.length; i++) {
    // Alternate background color
    if (i % 2 == 0) {
      fill(255); // white
    } else {
      fill(255, 200, 230); //pink
    }

    float lineY = y + 10 + i * 20;
    noStroke();
    rect(x, lineY, 135, 20); // background for each line

    fill(0);
    text(lines[i], x + 5, lineY+5);
    
    newY=lineY-40;
  }
    stroke(0);
    noFill();
    rect(x, y+10, 135, newY);
}

}

//Order myOrder;

//void setup() {
//  size(300, 250);
//  background(240);

  // Create an example order
//  String[] toppings = {"Cherry", "Sprinkles", "Whipped Cream"};
//  myOrder = new Order("Medium", "Vanilla", "Strawberry", 2, toppings);
//  myOrder.orderNumber = 1;
//}

//void draw() {
 // background(240);
 // myOrder.display();
//}
