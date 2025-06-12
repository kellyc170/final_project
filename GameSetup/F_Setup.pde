import java.util.ArrayList;

class MenuScreen {
  PImage startScreen;
  Button startButton;

  MenuScreen() {
    startScreen = loadImage("start.png");
    float btnWidth = 150;
    float btnHeight = 80;
    float x = (width - btnWidth) / 2;
    float y = height - 270;
    startButton = new Button(x, y, btnWidth, btnHeight, "PLAY", "oval", color(#F2D2DF));
  }

  void display() {
    image(startScreen, 0, 0, width, height);
    startButton.display(mouseX, mouseY);
  }

  void mousePressed(float mx, float my) {
    if (startButton.isClicked(mx, my)) {
      game = new Setup();
      currentScreen = "game";
    }
  }
}

class Setup {
  Station currentStation;
  OrderStation orderStation;
  BuildStation buildStation;
  MixStation mixStation;
  ToppingsStation toppingsStation;
  Customer selectedCustomer = null;
  ArrayList<Customer> customers;
  ArrayList<Sundae> sundaes;
  Sundae selectedSundae = null;
  FinishScreen finishScreen = null;
  int orderCount = 0;
  int dayCount = 1; 
  int globalOrderNumber = 1; 

  Setup() {
    customers = new ArrayList<Customer>();
    sundaes = new ArrayList<Sundae>();
    String[] customerNames = {"lisa", "harry", "pie", "chels", "wolf", "barry", "louie"};
    String[] cupSizes = {"Small", "Medium", "Large"};
    String[] syrups = {"Strawberry", "Chocolate", "Caramel"};
    String[] flavors = {"Strawberry", "Vanilla", "Chocolate"};
    String[][] toppingsOptions = {
      {"cherry", "sprinkles", "strawberry"},
      {"nut", "whippedcream", "marshmallow"},
      {"oreo", "chocolate", "blueberry"}
    };

    for (int i = 0; i < 3; i++) {
      String cupSize = cupSizes[(int)random(cupSizes.length)];
      String syrup = syrups[(int)random(syrups.length)];
      String flavor = flavors[(int)random(flavors.length)];
      int mixLevel = (int)random(1, 4);
      String[] toppings = toppingsOptions[(int)random(toppingsOptions.length)];
      Order order = new Order(globalOrderNumber, cupSize, syrup, flavor, mixLevel, toppings);
      globalOrderNumber++; 
      String name = customerNames[(int)random(customerNames.length)];
      Customer customer = new Customer(order, -100, height / 2, name);
      customers.add(customer);
    }
    
    orderStation = new OrderStation(customers);
    buildStation = new BuildStation(sundaes, this);
    mixStation = new MixStation(sundaes, this);
    toppingsStation = new ToppingsStation(sundaes, this);
    currentStation = orderStation;
  }

  void backToOrderStationPressed() {
    String[] cupSizes = {"Small", "Medium", "Large"};
    String[] syrups = {"Strawberry", "Chocolate", "Caramel"};
    String[] flavors = {"Strawberry", "Vanilla", "Chocolate"};
    String[][] toppingsOptions = {
      {"cherry", "sprinkles", "strawberry"},
      {"nut", "whippedcream", "marshmallow"},
      {"oreo", "chocolate", "blueberry"}
    };
    String cupSize = cupSizes[(int)random(cupSizes.length)];
    String syrup = syrups[(int)random(syrups.length)];
    String flavor = flavors[(int)random(flavors.length)];
    int mixLevel = (int)random(1, 4);
    String[] toppings = toppingsOptions[(int)random(toppingsOptions.length)];
    globalOrderNumber++;
    Order order = new Order(globalOrderNumber, cupSize, syrup, flavor, mixLevel, toppings);
    Customer newCustomer = new Customer(order, -100, height / 2, "newCustomer");
    customers.add(newCustomer);
    currentStation = orderStation;
  }

  void switchStation(String stationName) {
    switch (stationName) {
      case "Order":
        currentStation = orderStation;
        break;
      case "Build":
        currentStation = buildStation;
        break;
      case "Mix":
        currentStation = mixStation;
        break;
      case "Toppings":
        currentStation = toppingsStation;
        break;
    }
  }

  void update() {
    currentStation.update();
  }

  void display() {
    currentStation.display();
  }

  void mousePressed() {
    currentStation.mousePressed();
  }
}


class FinishScreen {
  Sundae sundae;
  Order order;
  Button backButton;

  FinishScreen(Sundae sundae, Order order) {
    this.sundae = sundae;
    this.order = order;
    int btnWidth = 220;
    int btnHeight = 45;
    backButton = new Button((width - btnWidth) / 2, height - btnHeight - 30, btnWidth, btnHeight, "Back to OrderStation", "rectangle", color(#FFB6C1));
  }

  void update() {}

  void display() {
    for (int i = 0; i < height; i++) {
      float inter = map(i, 0, height, 0, 1);
      int c = lerpColor(color(#FFE9BA), color(#FFB6C1), inter);
      stroke(c);
      line(0, i, width, i);
    }
    textAlign(CENTER, TOP);
    fill(80, 40, 60);
    textSize(32);
    text("Order Complete!", width/2, 20);
    if (sundae != null) {
      sundae.display(60, 100);
    }
    displayRating(width / 2, 65);
    displayStarRating(width / 2, 40 + 5 * 28);
    backButton.display(mouseX, mouseY);
  }

  void displayRating(float x, float y) {
    fill(50, 30, 45);
    textSize(18);
    textAlign(CENTER, TOP);
    text("Rating Breakdown:", x, y);
    
    int lineHeight = 28;
    int offset = 1;
  
    String orderCup = order.getCupSize().toLowerCase();
    String sundaeCup = sundae.cupSize.toLowerCase();
    orderCup = orderCup.equals("small") ? "s" : orderCup.equals("medium") ? "m" : orderCup.equals("large") ? "l" : orderCup;
    sundaeCup = sundaeCup.equals("small") ? "s" : sundaeCup.equals("medium") ? "m" : sundaeCup.equals("large") ? "l" : sundaeCup;
  
    boolean cupMatch = sundaeCup.equals(orderCup);
    text("Cup Size: " + order.getCupSize() + " - " + (cupMatch ? "Match" : "Mismatch"), x, y + lineHeight * offset++);
  
    boolean syrupMatch = sundae.syrup.equalsIgnoreCase(order.getSyrup());
    text("Syrup: " + order.getSyrup() + " - " + (syrupMatch ? "Match" : "Mismatch"), x, y + lineHeight * offset++);
  
    boolean flavorMatch = sundae.flavor.equalsIgnoreCase(order.getFlavor());
    text("Flavor: " + order.getFlavor() + " - " + (flavorMatch ? "Match" : "Mismatch"), x, y + lineHeight * offset++);
  
    boolean mixMatch = sundae.mixLevel == order.getMixLevel();
    text("Mix Level: " + order.getMixLevel() + " - " + (mixMatch ? "Match" : "Mismatch"), x, y + lineHeight * offset++);
  
    ArrayList<String> orderToppings = new ArrayList<String>();
    for (String t : order.getToppings()) {
      orderToppings.add(t.trim().toLowerCase());
    }
  
    int correctToppings = 0;
    ArrayList<String> matched = new ArrayList<String>();
  
    for (String topping : sundae.toppings) {
      if (orderToppings.contains(topping.toLowerCase())) {
        correctToppings++;
        matched.add(topping);
      }
    }
  }

  void displayStarRating(float x, float y) {
    int matches = 0;
    if (sundae.cupSize.equalsIgnoreCase(order.getCupSize())) matches++;
    if (sundae.syrup.equalsIgnoreCase(order.getSyrup())) matches++;
    if (sundae.flavor.equalsIgnoreCase(order.getFlavor())) matches++;
    if (sundae.mixLevel == order.getMixLevel()) matches++;

    ArrayList<String> orderToppings = new ArrayList<String>();
    for (String t : order.getToppings()) orderToppings.add(t.toLowerCase());
    int correctToppings = 0;
    for (String topping : sundae.toppings) {
      if (orderToppings.contains(topping.toLowerCase())) {
        correctToppings++;
      }
    }
    
    if (correctToppings > 3) correctToppings = 3;
    float toppingsScore = (float)correctToppings / (float)orderToppings.size();
    if (toppingsScore >= 0.9) {
      matches++;
    } 
    else if (toppingsScore > 0.75) {
      matches++;
    }
    if (matches > 5) matches = 5;
  
    textSize(20);
    fill(50, 30, 45);
    float starSize = 20;
    float spacing = 40;
    float totalWidth = spacing * 4;
    float starX = x - totalWidth / 2;
  
    for (int i = 0; i < 5; i++) {
      float cx = starX + i * spacing;
      float cy = y + 40;
      if (i <= matches) {
        drawCustomStar(cx, cy, starSize, true);
      } 
      else {
        drawCustomStar(cx, cy, starSize, false);
      }
    }
  }

  void drawCustomStar(float cx, float cy, float size, boolean filled) {
    pushMatrix();
    translate(cx, cy);
    if (filled) {
      fill(#FFCC00);
    } 
    else {
      noFill();
    }
    stroke(0);
    strokeWeight(1);
    beginShape();
    for (int i = 0; i < 5; i++) {
      float angle = TWO_PI / 5 * i - PI / 2;
      float sx = cos(angle) * size;
      float sy = sin(angle) * size;
      vertex(sx, sy);

      angle += PI / 5;
      sx = cos(angle) * size * 0.5;
      sy = sin(angle) * size * 0.5;
      vertex(sx, sy);
    }
    endShape(CLOSE);
    popMatrix();
  }

  void mousePressed(float mx, float my) {
    if (backButton.isClicked(mx, my)) {
      if (!game.customers.isEmpty()) {
        game.customers.remove(0);
      }
      game.orderCount++;
      if (game.orderCount >= 10) {
        game.dayCount++;
        game.orderCount = 0;
      }
      String[] customerNames = {"lisa", "harry", "pie", "chels", "wolf", "barry", "louie"};
      String[] cupSizes = {"Small", "Medium", "Large"};
      String[] syrups = {"Strawberry", "Chocolate", "Caramel"};
      String[] flavors = {"Strawberry", "Vanilla", "Chocolate"};
      String[][] toppingsOptions = {
        {"cherry", "sprinkles", "strawberry"},
        {"nut", "whippedcream", "marshmallow"},
        {"oreo", "chocolate", "blueberry"}
      };

      String cupSize = cupSizes[(int)random(cupSizes.length)];
      String syrup = syrups[(int)random(syrups.length)];
      String flavor = flavors[(int)random(flavors.length)];
      int mixLevel = (int)random(1, 4);
      String[] toppings = toppingsOptions[(int)random(toppingsOptions.length)];
      Order order = new Order(game.globalOrderNumber, cupSize, syrup, flavor, mixLevel, toppings);
      game.globalOrderNumber++;
      String name = customerNames[(int)random(customerNames.length)];
      Customer newCustomer = new Customer(order, -100, height / 2, name);
      game.customers.add(newCustomer);
      game.selectedCustomer = null;
      game.selectedSundae = null;
      game.finishScreen = null;
      game.switchStation("Order");
      game.orderStation.selectedCustomer = null;
      game.orderStation.showReceipt = false;
      currentScreen = "game";
    }
  }
}

MenuScreen menuScreen;
String currentScreen = "menu"; 
Setup game;

void setup() {
  size(800, 600);
  menuScreen = new MenuScreen();
  game = new Setup();
}

void draw() {
  if (currentScreen.equals("menu")) {
    menuScreen.display();
  } else if (currentScreen.equals("game")) {
    background(255);
    game.update();
    game.display();
  } else if (currentScreen.equals("finish")) {
    background(255);
    if (game.finishScreen != null) {
      game.finishScreen.update();
      game.finishScreen.display();
    }
  }
}


void mousePressed() {
  if (currentScreen.equals("menu")) {
    menuScreen.mousePressed(mouseX, mouseY);
  } else if (currentScreen.equals("game")) {
    game.mousePressed();
  } else if (currentScreen.equals("finish")) {
    if (game.finishScreen != null) {
      game.finishScreen.mousePressed(mouseX, mouseY);
    }
  }
}
