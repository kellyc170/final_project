import java.util.ArrayList;

class Sundae {
  String cupSize;
  String syrup;
  String flavor;
  int mixLevel; 
  ArrayList<String> toppings;
  String[] initialToppings;

  // Mixing progress: 0 to 100 (or any scale)
  float mixProgress;
  float targetMixTime;  // e.g., how much mixProgress needed to finish

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
    //display the cone
    //add the toppings and syrup
  }
}
