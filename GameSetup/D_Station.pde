class Button {
  float x, y, w, h;
  String label;
  color baseColor;
  color hoverColor;
  float cornerRadius = 20;

  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;

    // Set base and hover colors based on label
    switch(label) {
      case "Order":
        baseColor = color(0, 200, 0);       // green
        hoverColor = color(0, 150, 0);
        break;
      case "Build":
        baseColor = color(128, 0, 128);     // purple
        hoverColor = color(90, 0, 90);
        break;
      case "Mix":
        baseColor = color(255, 215, 0);     // yellow (gold)
        hoverColor = color(200, 170, 0);
        break;
      case "Toppings":
        baseColor = color(0, 0, 255);       // blue
        hoverColor = color(0, 0, 180);
        break;
      default:
        baseColor = color(200);
        hoverColor = color(150);
        break;
    }
  }

  void display() {
    if (isHovered()) {
      fill(hoverColor);
    } else {
      fill(baseColor);
    }
    stroke(0);
    rect(x, y, w, h, cornerRadius);
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }

  boolean isHovered() {
    return mouseX >= x && mouseX <= x + w &&
           mouseY >= y && mouseY <= y + h;
  }

  boolean isClicked(float mx, float my) {
    return mx >= x && mx <= x + w &&
           my >= y && my <= y + h;
  }
}

abstract class Station {
  String name;
  ArrayList<Button> navButtons;

  Station(String name) {
    this.name = name;
    navButtons = new ArrayList<Button>();
    setupNavButtons();
  }

  void setupNavButtons() {
    String[] labels = {"Order", "Build", "Mix", "Toppings"};
    float btnWidth = 100;
    float btnHeight = 40;
    float spacing = 20;
    float totalWidth = labels.length * btnWidth + (labels.length - 1) * spacing;
    float startX = (width - totalWidth) / 2;
    float y = height - btnHeight - 20;  // 20px margin from bottom

    navButtons.clear();
    for (int i = 0; i < labels.length; i++) {
      float x = startX + i * (btnWidth + spacing);
      Button b = new Button(x, y, btnWidth, btnHeight, labels[i]);
      navButtons.add(b);
    }
  }

  void displayNavButtons() {
    for (Button b : navButtons) {
      b.display();
    }
  }

  void checkNavButtonClicks(float mx, float my) {
    for (Button b : navButtons) {
      if (b.isClicked(mx, my)) {
        handleNavigation(b.label);
        break;
      }
    }
  }

  void handleNavigation(String target) {
    println("Switching to station: " + target);
    game.switchStation(target);
  }

  abstract void display();
  abstract void update();
  abstract void handleClick(float mx, float my);

  void mousePressed() {
    checkNavButtonClicks(mouseX, mouseY);
    handleClick(mouseX, mouseY);
  }
}
