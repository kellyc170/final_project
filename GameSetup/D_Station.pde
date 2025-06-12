class Button {
  float x, y, w, h;
  String label;
  String shapeType;
  color bgColor;
  PFont verdanaFont;
  PFont impactFont;
  private PImage img;

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
    verdanaFont = createFont("Verdana", 50);
    impactFont = createFont("Impact", 25);
  }
  
  Button(float x, float y, float w, float h, String label, String shapeType, color bgColor, PImage img) {
    this(x, y, w, h, label, shapeType, bgColor);
    this.img = img;
  }
  
  void setImage(PImage img) {
    this.img = img;
  }

  void display(float mx, float my) {
    color fillColor = bgColor;
    if (isHovered(mx, my)) {
      fillColor = color(max(red(bgColor) - 40, 0), max(green(bgColor) - 40, 0), max(blue(bgColor) - 40, 0));
    }

    noStroke();

    if (shapeType.equals("oval")) {
      fill(0, 0, 0, 80);
      ellipseMode(CENTER);
      ellipse(x + w / 2 + 5, y + h / 2 + 5, w, h);
    }

    fill(fillColor);
    switch (shapeType) {
      case "circle":
        ellipseMode(CENTER);
        ellipse(x, y, w, h);
        break;
      case "square":
        stroke(0);
        strokeWeight(1);
        rectMode(CORNER);
        rect(x, y, w, h);
        break;
      case "oval":
        ellipseMode(CENTER);
        ellipse(x + w / 2, y + h / 2, w, h);
        break;
      case "rectangle":
      default:
        stroke(0);
        strokeWeight(1);
        rectMode(CORNER);
        rect(x, y, w, h);
        break;
    }

    if (img != null) {
      imageMode(CORNER);
      float padding = w * 0.1;
      image(img, x + padding, y + padding, w - 2 * padding, h - 2 * padding);
    } else {
      float textSizeValue = min(w, h) * 0.7;
      textSize(textSizeValue);
      if (shapeType.equals("oval") && label.equalsIgnoreCase("play")) {
        textFont(verdanaFont);
        fill(#FF69B4);
      } else {
        textFont(impactFont);
        fill(0);
      }

      noStroke();
      textAlign(CENTER, CENTER);

      switch (shapeType) {
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
  Button finishButton;

  Station(String name) {
    this.name = name;
    navButtons = new ArrayList<Button>();
    setupNavButtons();
    setupMenuButton();
    setupFinishButton();
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

  void setupFinishButton() {
    float btnWidth = 140;
    float btnHeight = 40;
    float x = width - btnWidth - 20;
    float y = height - btnHeight - 20;
    finishButton = new Button(x, y, btnWidth, btnHeight, "Finish Order", "rectangle", color(100, 200, 100));
  }

  void displayNavButtons() {
    for (Button b : navButtons) {
      b.display(mouseX, mouseY);
    }
    menuButton.display(mouseX, mouseY);
    finishButton.display(mouseX, mouseY);
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
      return;
    }

    if (finishButton.isClicked(mx, my)) {
      handleFinishClick();
      return;
    }
  }

  void handleNavigation(String target) {
    println("Switching to station: " + target);
    game.switchStation(target);
  }

  void handleMenuClick() {
    println("Switching to menu");
    currentScreen = "menu";
  }

  void handleFinishClick() {
  if (game.selectedSundae != null && game.selectedCustomer != null) {
    println("finished");
    game.finishScreen = new FinishScreen(game.selectedSundae, game.selectedCustomer.order);
    currentScreen = "finish";
  } 
  else {
    println("No sundae or order selected");
  }
}

  abstract void display();
  abstract void update();
  abstract void handleClick(float mx, float my);

  void mousePressed() {
    checkNavButtonClicks(mouseX, mouseY);
    handleClick(mouseX, mouseY);
  }
}
