//class Setup {
//  ArrayList<Customer> customers;
//  ArrayList<Sundae> sundaes;

//  Station orderStation;
//  Station buildStation;
//  Station mixStation;
//  Station toppingsStation;

//  Station currentStation;

//  Setup() {
//    // Initialize lists
//    customers = new ArrayList<Customer>();
 /*   sundaes = new ArrayList<Sundae>();

    // Example customers with orders
    customers.add(new Customer(new Order("Small", "Vanilla", "Strawberry", "Light", new String[]{"Cherry"}), -60, 400, 100));
    customers.add(new Customer(new Order("Large", "Chocolate", "Banana", "Medium", new String[]{"Sprinkles"}), -120, 420, 100));

    // Create stations
    orderStation = new OrderStation(customers);
    buildStation = new BuildStation(sundaes);
    mixStation = new MixStation(sundaes);
    toppingsStation = new ToppingsStation(sundaes);

    // Start at order station
    currentStation = orderStation;
  }

  void update() {
    currentStation.update();
  }

  void display() {
    currentStation.display();
  }

  // Method to switch stations, e.g. called by button handlers
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
}*\
