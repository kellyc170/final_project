import java.util.ArrayList;

class Sundae {
  String cupSize;
  String syrup;
  String flavor;
  int mixLevel; 
  ArrayList<String> toppings;
  String[] initialToppings;

  float mixProgress;
  float targetMixTime;

  Sundae(Order order) {
    cupSize = order.getCupSize();
    syrup = order.getSyrup();
    flavor = order.getFlavor();
    mixLevel = order.getMixLevel();
    initialToppings = order.getToppings();

    toppings = new ArrayList<String>();
    if (initialToppings != null) {
      for (String t : initialToppings) {
        toppings.add(t);
      }
    }

    this.mixProgress = 0;
    this.targetMixTime = 100;
  }

  void mix(float amount) {
    mixProgress += amount;
    if (mixProgress > targetMixTime) {
      mixProgress = targetMixTime;
    }
  }

  boolean isMixed() {
    return mixProgress >= targetMixTime;
  }

  void addTopping(String topping) {
    toppings.add(topping);
  }

  void removeTopping(String topping) {
    toppings.remove(topping);
  }

  void display(float x, float y) {
    // Determine cup size
    float cupHeight = 100;
    float cupWidth = 60;

    if (cupSize.equals("Small")) {
      cupHeight = 100;
    } else if (cupSize.equals("Medium")) {
      cupHeight = 120;
    } else if (cupSize.equals("Large")) {
      cupHeight = 140;
    }

    // Draw cup
    fill(255);
    stroke(0);
    rect(x, y, cupWidth, cupHeight);

    // Draw syrup layer
    if (syrup.equals("Vanilla")) fill(255, 255, 200);
    else if (syrup.equals("Chocolate")) fill(120, 60, 20);
    else if (syrup.equals("Strawberry")) fill(255, 100, 150);
    else fill(180); // fallback
    rect(x + 5, y + 10, cupWidth - 10, 10);

    // Draw scoop
    if (flavor.equals("Banana")) fill(255, 255, 150);
    else if (flavor.equals("Chocolate")) fill(120, 60, 20);
    else if (flavor.equals("Strawberry")) fill(255, 200, 200);
    else fill(230); // fallback
    ellipse(x + cupWidth / 2, y + cupHeight - 30, 40, 40);

    // Mix progress bar
    float barY = y + cupHeight + 10;
    float barWidth = map(mixProgress, 0, targetMixTime, 0, cupWidth - 10);
    fill(0, 200, 255);
    rect(x + 5, barY, barWidth, 10);
    noFill();
    stroke(0);
    rect(x + 5, barY, cupWidth - 10, 10);

    // Draw toppings
    float toppingY = y + cupHeight - 50;
    for (int i = 0; i < toppings.size(); i++) {
      String topping = toppings.get(i);
      float ty = toppingY - i * 12;
      if (topping.equals("Cherry")) {
        fill(255, 0, 0);
        ellipse(x + cupWidth / 2, ty, 10, 10);
      } else if (topping.equals("Sprinkles")) {
        fill(255, 150, 0);
        for (int j = 0; j < 5; j++) {
          float sx = x + cupWidth / 2 - 10 + j * 4;
          rect(sx, ty, 2, 5);
        }
      } else {
        fill(100);
        ellipse(x + cupWidth / 2, ty, 8, 8); // generic topping
      }
    }
  }
}
