class ToppingsStation extends Station {
  ArrayList<Sundae> sundaes;
  String[] allToppings = {"Cherry", "Oreos", "Peanuts", "Caramel", "Chocolate", "Marshmallows"};
  ArrayList<String> toppings = new ArrayList<String>();
  float boxSize = 80;
  int selectedIndex = -1;

  ToppingsStation(ArrayList<Sundae> sundaes) {
    super("Toppings");
    this.sundaes = sundaes;
    for (String t : allToppings) {
      toppings.add(t);
    }
  }

  void display() {
    background(230, 230, 255);
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Toppings Station", width / 2, 40);

    for (int i = 0; i < toppings.size(); i++) {
      float x = 20 + i * (boxSize + 10);
      float y = 80;

      if (i == selectedIndex) {
        stroke(255, 0, 0);
        strokeWeight(4);
      } else {
        noStroke();
      }

      fill(255);
      rect(x, y, boxSize, boxSize);
      fill(0);
      textSize(16);
      textAlign(CENTER, CENTER);
      text(toppings.get(i), x + boxSize / 2, y + boxSize / 2);
      noStroke();
    }

    displayNavButtons();
  }

  void update() {
    // edit later
  }

  void handleClick(float mx, float my) {
    for (int i = 0; i < toppings.size(); i++) {
      float x = 20 + i * (boxSize + 10);
      float y = 80;
      if (mx >= x && mx <= x + boxSize && my >= y && my <= y + boxSize) {
        selectedIndex = i;
        return;
      }
    }
  }
}
