class MenuScreen {
  PImage startScreen;
  Button startButton;
  PFont font;

  MenuScreen() {
    startScreen = loadImage("start.png");

    font = createFont("Impact", 100);

    float btnWidth = 150;
    float btnHeight = 80;
    float x = (width - btnWidth) / 2;
    float y = height - 270;

    startButton = new Button(x, y, btnWidth, btnHeight, "PLAY", "oval", color(#944AB2));
  }

  void display() {
    image(startScreen, 0, 0, width, height);
    textFont(font);
    textAlign(CENTER, CENTER);
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

  Setup() {
    customers = new ArrayList<Customer>();
    sundaes = new ArrayList<Sundae>();

    // Sample data for orders
    String[] cupSizes = {"Small", "Medium", "Large"};
    String[] syrups = {"Vanilla", "Chocolate"};
    String[] flavors = {"Strawberry", "Banana", "Mango"};
    String[][] toppingsOptions = {
      {"Cherry", "Sprinkles"},
      {"Nuts", "Whipped Cream"},
      {"Oreo", "Chocolate Chips"}
    };

    for (int i = 0; i < 3; i++) {
      String cupSize = cupSizes[(int)random(cupSizes.length)];
      String syrup = syrups[(int)random(syrups.length)];
      String flavor = flavors[(int)random(flavors.length)];
      int mixLevel = (int)random(1, 5);
      String[] toppings = toppingsOptions[(int)random(toppingsOptions.length)];

      Order order = new Order(cupSize, syrup, flavor, mixLevel, toppings);
      Customer customer = new Customer(order, -100, height /2);

      customers.add(customer);
    }

    orderStation = new OrderStation(customers);
    buildStation = new BuildStation(sundaes);
    mixStation = new MixStation(sundaes);
    toppingsStation = new ToppingsStation(sundaes);

    currentStation = orderStation;  // start at Order
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
  }
}

void mousePressed() {
  if (currentScreen.equals("menu")) {
    menuScreen.mousePressed(mouseX, mouseY);
  } else if (currentScreen.equals("game")) {
    game.mousePressed();
  }
}
