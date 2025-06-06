class BuildStation extends Station {
  ArrayList<Sundae> sundaes;

  ArrayList<Button> cupSizeButtons;
  ArrayList<Button> flavorButtons;
  ArrayList<Button> syrupButtons;

  String selectedCupSize = "";
  String selectedFlavor = "";
  String selectedSyrup = "";

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

    if (!selectedCupSize.equals("")) {
      drawSelectedCupVisual();
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
    for (Button b : cupSizeButtons) {
      if (b.isClicked(mx, my)) {
        selectedCupSize = b.label;
        return;
      }
    }
    for (Button b : flavorButtons) {
      if (b.isClicked(mx, my)) {
        selectedFlavor = b.label;
        return;
      }
    }
    for (Button b : syrupButtons) {
      if (b.isClicked(mx, my)) {
        selectedSyrup = b.label;
        return;
      }
    }
  }

  void drawSelectedCupVisual() {
    if (selectedCupSize.equals("")) return;
  
    float cupX = width / 2 - 30;
    float cupY = height / 2 + 70;
  
    float cupWidth, cupHeight;
    switch (selectedCupSize) {
      case "S":
        cupWidth = 120;
        cupHeight = 100;
        break;
      case "M":
        cupWidth = 140;
        cupHeight = 120;
        break;
      case "L":
        cupWidth = 160;
        cupHeight = 140;
        break;
      default:
        cupWidth = 120;
        cupHeight = 100;
    }

    float topWidth = cupWidth;
    float bottomWidth = cupWidth * 0.6;
  
    float topX1 = cupX - topWidth / 2;
    float topX2 = cupX + topWidth / 2;
    float bottomX1 = cupX - bottomWidth / 2;
    float bottomX2 = cupX + bottomWidth / 2;
  
    float topY = cupY - cupHeight / 2;
    float bottomY = cupY + cupHeight / 2;
  
    if (!selectedFlavor.equals("")) {
      float scoopY = topY + 5;
      float scoopWidth = topWidth-10;
      float scoopHeight = scoopWidth * 1.4;
  
      switch (selectedFlavor) {
        case "Vanilla":
          fill(#FAF6D1);
          break;
        case "Chocolate":
          fill(#673500);
          break;
        case "Strawberry":
          fill(#FA6FA9);
          break;
      }
  
      noStroke();
      ellipse(cupX, scoopY, scoopWidth, scoopHeight);
    }
  
    fill(200);
    noStroke();
    quad(
      topX1, topY,       // top left
      topX2, topY,       // top right
      bottomX2, bottomY, // bottom right
      bottomX1, bottomY  // bottom left
    );
  
    if (!selectedFlavor.equals("") && !selectedSyrup.equals("")) {
      float drizzleX1 = cupX-30;
      float drizzleX2 = cupX+45;
      float drizzleY1 = topY-75;
      float drizzleY2 = topY-60;
  
      strokeWeight(3);
      noFill();
      switch (selectedSyrup) {
        case "Chocolate":
          stroke(#5A0F00);
          break;
        case "Caramel":
          stroke(#CB8500);
          break;
        case "Strawberry":
          stroke(#CB0285);
          break;
      }
      line(drizzleX1, drizzleY1, drizzleX2, drizzleY2); //top drizzle
      line(drizzleX1-32, drizzleY1+45, drizzleX2+10, drizzleY2+20); //middle drizzle
    }
  }
}
