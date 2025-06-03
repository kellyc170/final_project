class BuildStation extends Station {
  ArrayList<Sundae> sundaes;

  ArrayList<Button> cupSizeButtons;
  ArrayList<Button> flavorButtons;
  ArrayList<Button> syrupButtons;

  String selectedCupSize = "Medium";    // Default selected
  String selectedFlavor = "Vanilla";
  String selectedSyrup = "Chocolate";

  BuildStation(ArrayList<Sundae> sundaes) {
    super("Build");
    this.sundaes = sundaes;

    cupSizeButtons = new ArrayList<Button>();
    flavorButtons = new ArrayList<Button>();
    syrupButtons = new ArrayList<Button>();

    setupOptionButtons();
  }

  void setupOptionButtons() {
    float btnWidth = 120;
    float btnHeight = 40;
    float spacing = 15;

    float startX = 20;
    float startY = 60;

    // Cup Size buttons
    String[] cupSizes = {"Small", "Medium", "Large"};
    for (int i = 0; i < cupSizes.length; i++) {
      float y = startY + i * (btnHeight + spacing);
      cupSizeButtons.add(new Button(startX, y, btnWidth, btnHeight, cupSizes[i]));
    }

    // Flavor buttons
    startY += cupSizes.length * (btnHeight + spacing) + 40;
    String[] flavors = {"Vanilla", "Chocolate", "Strawberry"};
    for (int i = 0; i < flavors.length; i++) {
      float y = startY + i * (btnHeight + spacing);
      flavorButtons.add(new Button(startX, y, btnWidth, btnHeight, flavors[i]));
    }

    // Syrup buttons
    startY += flavors.length * (btnHeight + spacing) + 40;
    String[] syrups = {"Chocolate", "Caramel", "Strawberry"};
    for (int i = 0; i < syrups.length; i++) {
      float y = startY + i * (btnHeight + spacing);
      syrupButtons.add(new Button(startX, y, btnWidth, btnHeight, syrups[i]));
    }
  }

  void update() {
    // edit later
  }

  void display() {
    background(230, 255, 230);
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Build Station", width / 2, 40);

    // Display option buttons
    displayOptionButtons(cupSizeButtons, selectedCupSize);
    displayOptionButtons(flavorButtons, selectedFlavor);
    displayOptionButtons(syrupButtons, selectedSyrup);

    displayNavButtons();
  }

  void displayOptionButtons(ArrayList<Button> buttons, String selected) {
    for (Button b : buttons) {
      if (b.label.equals(selected)) {
        stroke(255, 0, 0);  // Red border if selected
        strokeWeight(4);
      } else {
        noStroke();
      }
      b.display();
      noStroke();
    }
  }

  void handleClick(float mx, float my) {
    // Check cup size buttons
    for (Button b : cupSizeButtons) {
      if (b.isClicked(mx, my)) {
        selectedCupSize = b.label;
        return;
      }
    }

    // Check flavor buttons
    for (Button b : flavorButtons) {
      if (b.isClicked(mx, my)) {
        selectedFlavor = b.label;
        return;
      }
    }

    // Check syrup buttons
    for (Button b : syrupButtons) {
      if (b.isClicked(mx, my)) {
        selectedSyrup = b.label;
        return;
      }
    }
  }
}
