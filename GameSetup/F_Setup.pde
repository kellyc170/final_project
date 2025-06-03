class Setup {
  Station currentStation;
  OrderStation orderStation;
  BuildStation buildStation;
  MixStation mixStation;
  ToppingsStation toppingsStation;

  ArrayList<Customer> customers;
  ArrayList<Sundae> sundaes;

  Setup() {
  customers = new ArrayList<Customer>();
  sundaes = new ArrayList<Sundae>();

  // Create some sample orders with random or fixed data
  String[] cupSizes = {"Small", "Medium", "Large"};
  String[] syrups = {"Vanilla", "Chocolate"};
  String[] flavors = {"Strawberry", "Banana", "Mango"};
  String[][] toppingsOptions = {
    {"Cherry", "Sprinkles"},
    {"Nuts", "Whipped Cream"},
    {"Oreo", "Chocolate Chips"}
  };

  // Create 3 customers with random orders, starting offscreen left
  for (int i = 0; i < 3; i++) {
    String cupSize = cupSizes[(int)random(cupSizes.length)];
    String syrup = syrups[(int)random(syrups.length)];
    String flavor = flavors[(int)random(flavors.length)];
    int mixLevel = (int)random(1, 5);
    String[] toppings = toppingsOptions[(int)random(toppingsOptions.length)];

    Order order = new Order(cupSize, syrup, flavor, mixLevel, toppings);
    Customer customer = new Customer(order, -100, height - 150);

    customers.add(customer);
  }

  orderStation = new OrderStation(customers);
  buildStation = new BuildStation(sundaes);
  mixStation = new MixStation(sundaes);
  toppingsStation = new ToppingsStation(sundaes);

  currentStation = orderStation;  // start at Order
}

void setup() {
  size(800, 600);
  game = new Setup();
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

Setup game;

void setup() {
  size(800, 600);
  game = new Setup();
}

void draw() {
  background(255);
  game.update();
  game.display();
}

void mousePressed() {
  game.mousePressed();
}
