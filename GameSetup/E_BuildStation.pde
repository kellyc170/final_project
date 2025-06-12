class BuildStation extends Station {
  ArrayList<Sundae> sundaes;
  Setup game;
  ArrayList<Button> cupSizeButtons;
  ArrayList<Button> flavorButtons;
  ArrayList<Button> syrupButtons;
  String selectedCupSize = "";
  String selectedFlavor = "";
  String selectedSyrup = "";

  BuildStation(ArrayList<Sundae> sundaes, Setup game) {
    super("Build");
    this.sundaes = sundaes;
    this.game = game;

    cupSizeButtons = new ArrayList<Button>();
    flavorButtons = new ArrayList<Button>();
    syrupButtons = new ArrayList<Button>();

    setupOptionButtons();
  }

  void setupOptionButtons() {
    float btnWidth = 120;
    float btnHeight = 40;
    float spacing = 10;

    float startX = 20;
    float startY = 80;

    // Cup Size buttons
    String[] cupSizes = {"S", "M", "L"};
    color cupColor = color(144, 238, 144);
    float btnSize = btnHeight;

    for (int i = 0; i < cupSizes.length; i++) {
      float x = startX + i * (btnSize + spacing);
      cupSizeButtons.add(new Button(x, startY, btnSize, btnSize, cupSizes[i], "square", cupColor));
    }

    // Flavor buttons
    startY += btnHeight + 60;
    String[] flavors = {"Vanilla", "Chocolate", "Strawberry"};
    color flavorColor = color(200, 162, 200);
    for (int i = 0; i < flavors.length; i++) {
      float y = startY + i * (btnHeight + spacing);
      flavorButtons.add(new Button(startX, y, btnWidth, btnHeight, flavors[i], "rectangle", flavorColor));
    }

    // Syrup buttons
    startY += flavors.length * (btnHeight + spacing) + 40;
    String[] syrups = {"Chocolate", "Caramel", "Strawberry"};
    color syrupColor = color(210, 180, 140);
    for (int i = 0; i < syrups.length; i++) {
      float y = startY + i * (btnHeight + spacing);
      syrupButtons.add(new Button(startX, y, btnWidth, btnHeight, syrups[i], "rectangle", syrupColor));
    }
  }

  void update() {}

  void display() {
    background(#E6FFE6);

    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Build Station", width / 2, 40);

    textAlign(LEFT, CENTER);
    textSize(20);

    text("Cup Size", 20, 60);
    text("Flavor", 20, cupSizeButtons.get(cupSizeButtons.size() - 1).y + 60);
    text("Syrup", 20, flavorButtons.get(flavorButtons.size() - 1).y + 60);

    displayOptionButtons(cupSizeButtons, selectedCupSize);
    displayOptionButtons(flavorButtons, selectedFlavor);
    displayOptionButtons(syrupButtons, selectedSyrup);

    displayNavButtons();

    if (game.selectedCustomer != null) {
      game.selectedCustomer.order.display(width - 220, 20);
    }

    if (game.selectedSundae != null) {
      game.selectedSundae.display(width / 2, height / 2 + 100);  // Adjust coords as needed
    }
  }

  void displayOptionButtons(ArrayList<Button> buttons, String selected) {
    for (Button b : buttons) {
      if (b.label.equals(selected)) {
        stroke(255, 0, 0);
        strokeWeight(4);
      } else {
        noStroke();
      }
      b.display(mouseX, mouseY);
      noStroke();
    }
  }

  void handleClick(float mx, float my) {
    boolean updated = false;
  
    for (Button b : cupSizeButtons) {
      if (b.isClicked(mx, my)) {
        selectedCupSize = b.label;
        updated = true;
        break;
      }
    }
    if (!updated) {
      for (Button b : flavorButtons) {
        if (b.isClicked(mx, my)) {
          selectedFlavor = b.label;
          updated = true;
          break;
        }
      }
    }
    if (!updated) {
      for (Button b : syrupButtons) {
        if (b.isClicked(mx, my)) {
          selectedSyrup = b.label;
          updated = true;
          break;
        }
      }
    }
    if (updated) {
      if (game.selectedSundae == null) {
        Order tempOrder = new Order(0, selectedCupSize, selectedSyrup, selectedFlavor, 0, new String[0]);
        game.selectedSundae = new Sundae(tempOrder);
        sundaes.add(game.selectedSundae);
      } else {
        game.selectedSundae.cupSize = selectedCupSize;
        game.selectedSundae.flavor = selectedFlavor;
        game.selectedSundae.syrup = selectedSyrup;
      }
    }
  }
}
