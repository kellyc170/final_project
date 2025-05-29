class Sundae {
  String cupSize;
  String syrup;
  String flavor;
  String mixLevel;   // e.g., "Light", "Medium", "Heavy"
  ArrayList<String> toppings;

  // Mixing progress: 0 to 100 (or any scale)
  float mixProgress;
  float targetMixTime;  // e.g., how much mixProgress needed to finish

  Sundae(String cupSize, String syrup, String flavor, String mixLevel, String[] initialToppings) {
    this.cupSize = cupSize;
    this.syrup = syrup;
    this.flavor = flavor;
    this.mixLevel = mixLevel;
    this.toppings = new ArrayList<String>();

    if (initialToppings != null) {
      for (String t : initialToppings) {
        toppings.add(t);
      }
    }

    this.mixProgress = 0;
    this.targetMixTime = 100;  // Default target, adjust as needed
  }

  // Increase mix progress, capped at targetMixTime
  void mix(float amount) {
    mixProgress += amount;
    if (mixProgress > targetMixTime) {
      mixProgress = targetMixTime;
    }
  }

  // Check if mixing is done
  boolean isMixed() {
    return mixProgress >= targetMixTime;
  }

  // Add a topping
  void addTopping(String topping) {
    toppings.add(topping);
  }

  // Remove a topping (if exists)
  void removeTopping(String topping) {
    toppings.remove(topping);
  }

  // Display a simple representation (can expand later)
  void display(float x, float y) {
    fill(255);
    rect(x, y, 150, 120);

    fill(0);
    textAlign(LEFT, TOP);
    textSize(12);
    text("Cup: " + cupSize, x + 10, y + 10);
    text("Syrup: " + syrup, x + 10, y + 30);
    text("Flavor: " + flavor, x + 10, y + 50);
    text("Mix: " + mixLevel + " (" + int(mixProgress) + "/" + int(targetMixTime) + ")", x + 10, y + 70);
    
    String tops = "Toppings: ";
    if (toppings.isEmpty()) tops += "None";
    else tops += String.join(", ", toppings);
    text(tops, x + 10, y + 90);
  }
}
