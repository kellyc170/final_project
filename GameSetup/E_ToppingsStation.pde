class ToppingsStation extends Station {
  ArrayList<Sundae> sundaes;
  Setup game;
  ArrayList<Button> toppingButtons;
  ArrayList<String> selectedToppings;
  HashMap<String, PImage> toppingImages;
  Button clearButton;

  ToppingsStation(ArrayList<Sundae> sundaes, Setup game) {
    super("Toppings");
    this.sundaes = sundaes;
    this.game = game;
    selectedToppings = new ArrayList<String>();
    toppingButtons = new ArrayList<Button>();
    toppingImages = new HashMap<String, PImage>();
    
    String[] toppings = {"blueberry", "cherry", "strawberry", "marshmallow", "oreo", "nut", "whippedcream", "chocolate", "sprinkles"};
    for (String topping : toppings) {
      PImage img = loadImage(topping + ".png");
      toppingImages.put(topping, img);
    }
    
    float startXLeft = 20;
    float startXRight = 120;
    float startY = 40;
    float bottomMargin = 40;
    int totalToppings = toppings.length;
    int rows = (int) ceil(totalToppings / 2.0);
    float spacing = 15;
    float totalHeight = height - startY - bottomMargin;
    float btnSize = (totalHeight - (rows - 1) * spacing) / rows;

    for (int i = 0; i < totalToppings; i++) {
      int col = i / rows;
      int row = i % rows;
      float x = (col == 0) ? startXLeft : startXRight;
      float y = (col == 0) ? (startY + row * (btnSize + spacing)) : (startY + row * (btnSize + spacing));
      Button b = new Button(x, y, btnSize, btnSize, toppings[i], "square", color(255));
      b.setImage(toppingImages.get(toppings[i]));
      toppingButtons.add(b);
    }
    float clearBtnX = startXRight;
    float clearBtnY = startY + rows * (btnSize) - 25;
    clearButton = new Button(clearBtnX, clearBtnY, btnSize, btnSize / 1.5f, "Clear \n Toppings", "rectangle", color(200, 100, 100));
  }

  void display() {
    background(255, 230, 230);
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Toppings Station", width / 2, 60);

    for (Button b : toppingButtons) {
      if (selectedToppings.contains(b.label)) {
        stroke(255, 0, 0);
        strokeWeight(3);
      } 
      else {
        noStroke();
      }
      b.display(mouseX, mouseY);
    }
    clearButton.display(mouseX, mouseY);
    displayNavButtons();
    if (game.selectedCustomer != null) {
      game.selectedCustomer.order.display(width - 220, 20);
    }
    if (game.selectedSundae != null) {
      game.selectedSundae.display(width / 2, height / 2 + 100);
    }
  }

  void handleClick(float mx, float my) {
    for (Button b : toppingButtons) {
      if (b.isClicked(mx, my)) {
        String topping = b.label;

        if (game.selectedSundae != null) {
          game.selectedSundae.addTopping(topping);
        }
        return;
      }
    }
    if (clearButton.isClicked(mx, my)) {
      if (game.selectedSundae != null) {
        game.selectedSundae.clearToppings(); 
      }
    }
  }

  void update() {}
}
