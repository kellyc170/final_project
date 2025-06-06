class Button {
  float x, y, w, h;
  String label;
  String shapeType;  // rectangle, square, circle, oval
  color bgColor;

  Button(float x, float y, float w, float h, String label) {
    this(x, y, w, h, label, "rectangle", color(200));
  }

  Button(float x, float y, float w, float h, String label, String shapeType, color bgColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.shapeType = shapeType.toLowerCase();
    this.bgColor = bgColor;
  }

  void display(float mx, float my) {
    color fillColor = bgColor;
    if (isHovered(mx, my)) {
      fillColor = color(max(red(bgColor) - 40, 0), max(green(bgColor) - 40, 0), max(blue(bgColor) - 40, 0));
    }

    fill(fillColor);
    stroke(0);
    strokeWeight(2);
    textFont(createFont("Impact", 100));

    switch(shapeType) {
      case "circle":
        ellipseMode(CENTER);
        ellipse(x, y, w, h);
        break;
      case "square":
        rectMode(CORNER);
        rect(x, y, w, h);
        break;
      case "oval":
        ellipseMode(CENTER);
        ellipse(x + w / 2, y + h / 2, w, h);
        break;
      case "rectangle":
      default:
        rectMode(CORNER);
        rect(x, y, w, h);
        break;
    }

    fill(255);
    noStroke();
    textAlign(CENTER, CENTER);
    textSize(20);

    switch(shapeType) {
      case "circle":
        text(label, x, y);
        break;
      case "oval":
        text(label, x + w / 2, y + h / 2);
        break;
      case "square":
      case "rectangle":
      default:
        text(label, x + w / 2, y + h / 2);
        break;
    }
  }

  boolean isClicked(float mx, float my) {
    switch(shapeType) {
      case "circle":
        float radiusX = w / 2;
        float radiusY = h / 2;
        float dx = mx - x;
        float dy = my - y;
        return (dx*dx)/(radiusX*radiusX) + (dy*dy)/(radiusY*radiusY) <= 1;
      case "oval":
        float centerX = x + w / 2;
        float centerY = y + h / 2;
        float rx = w / 2;
        float ry = h / 2;
        float dxo = mx - centerX;
        float dyo = my - centerY;
        return (dxo*dxo)/(rx*rx) + (dyo*dyo)/(ry*ry) <= 1;
      case "square":
      case "rectangle":
      default:
        return (mx >= x && mx <= x + w && my >= y && my <= y + h);
    }
  }

  boolean isHovered(float mx, float my) {
    return isClicked(mx, my);
  }
}

abstract class Station {
  String name;
  ArrayList<Button> navButtons;
  Button menuButton;

  Station(String name) {
    this.name = name;
    navButtons = new ArrayList<Button>();
    setupNavButtons();
    setupMenuButton();
  }

  void setupNavButtons() {
    String[] labels = {"Order", "Build", "Mix", "Toppings"};
    float btnWidth = 100;
    float btnHeight = 40;
    float spacing = 20;
    float totalWidth = labels.length * btnWidth + (labels.length - 1) * spacing;
    float startX = (width - totalWidth) / 2;
    float y = height - btnHeight - 20;

    navButtons.clear();
    color[] colors = {
      color(#1DA02D),   // Order - Green
      color(#8707B7),   // Build - Purple
      color(#EDE724),   // Mix - Yellow
      color(#3B96F5)    // Toppings - Blue
     };

    for (int i = 0; i < labels.length; i++) {
      float x = startX + i * (btnWidth + spacing);
      Button b = new Button(x, y, btnWidth, btnHeight, labels[i], "rectangle", colors[i]);
      navButtons.add(b);
    }
  }

  void setupMenuButton() {
    float btnWidth = 100;
    float btnHeight = 40;
    float x = 20;
    float y = height - btnHeight - 20;
    menuButton = new Button(x, y, btnWidth, btnHeight, "Menu");
  }

  void displayNavButtons() {
    for (Button b : navButtons) {
      b.display(mouseX, mouseY);
    }
    menuButton.display(mouseX, mouseY);
  }

  void checkNavButtonClicks(float mx, float my) {
    for (Button b : navButtons) {
      if (b.isClicked(mx, my)) {
        handleNavigation(b.label);
        return;
      }
    }
    
    if (menuButton.isClicked(mx, my)) {
      handleMenuClick();
    }
  }

  void handleNavigation(String target) {
    println("Switching to station: " + target);
    game.switchStation(target);
  }

  void handleMenuClick() {
    println("Switching to menu screen");
    currentScreen = "menu";
  }

  abstract void display();
  abstract void update();
  abstract void handleClick(float mx, float my);

  void mousePressed() {
    checkNavButtonClicks(mouseX, mouseY);
    handleClick(mouseX, mouseY);
  }
}
