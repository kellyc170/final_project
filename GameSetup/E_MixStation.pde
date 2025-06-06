class MixStation extends Station {
  ArrayList<Sundae> sundaes;

  String[] mixTypes = {"Light", "Medium", "Heavy"};
  ArrayList<Button> mixButtons;

  int selectedMixIndex = -1; 
  float mixProgress = 0;

  float[] mixSpeeds = {0.002f, 0.005f, 0.01f};

  MixStation(ArrayList<Sundae> sundaes) {
    super("Mix");
    this.sundaes = sundaes;

    mixButtons = new ArrayList<Button>();
    float btnWidth = 100;
    float btnHeight = 40;
    float spacing = 20;
    float totalWidth = mixTypes.length * btnWidth + (mixTypes.length - 1) * spacing;
    float startX = (width - totalWidth) / 2;
    float y = 120;

    for (int i = 0; i < mixTypes.length; i++) {
      float x = startX + i * (btnWidth + spacing);
      Button b = new Button(x, y, btnWidth, btnHeight, mixTypes[i]);
      mixButtons.add(b);
    }
  }

  void update() {
    if (selectedMixIndex != -1 && mixProgress < 1.0) {
      mixProgress += mixSpeeds[selectedMixIndex];
      if (mixProgress > 1.0) {
        mixProgress = 1.0;
      }
    }
  }

  void display() {
    background(230, 230, 255);
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Mix Station", width/2, 80);

    displayMixProgressBar();

    for (int i = 0; i < mixButtons.size(); i++) {
      Button b = mixButtons.get(i);
      if (i == selectedMixIndex) {
        stroke(255, 0, 0);
        strokeWeight(4);
      } else {
        noStroke();
      }
      b.display(mouseX, mouseY);
    }

    displayNavButtons();
    if (game.selectedCustomer != null) {
    game.selectedCustomer.order.display(width - 220, 20);
    }
  }

  void displayMixProgressBar() {
    float barX = width * 0.1f;
    float barY = 200;
    float barWidth = width * 0.8f;
    float barHeight = 25;

    stroke(0);
    strokeWeight(2);
    fill(200);
    rect(barX, barY, barWidth, barHeight, 10);

    fill(50, 100, 255);
    noStroke();
    rect(barX, barY, barWidth * mixProgress, barHeight, 10);

    fill(0);
    textSize(14);
    textAlign(CENTER, CENTER);
    text(int(mixProgress * 100) + "% Mixed", barX + barWidth / 2, barY + barHeight / 2);
  }

  void handleClick(float mx, float my) {
    for (int i = 0; i < mixButtons.size(); i++) {
      Button b = mixButtons.get(i);
      if (b.isClicked(mx, my)) {
        selectedMixIndex = i;
        mixProgress = 0;
        return;
      }
    }
    // add more mix graphics later
  }
}
