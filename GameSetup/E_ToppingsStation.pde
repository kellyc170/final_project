//class ToppingsStation extends Station {
//  ArrayList<Sundae> sundaes;
//  String[] allToppings = {"Cherry", "Whipped Cream", "Sprinkles", "Nuts"};
//  int selectedSundaeIndex = 0;

//  ToppingsStation(ArrayList<Sundae> sundaes) {
//    super("Toppings");
//    this.sundaes = sundaes;
//  }

 // void update() {
    // Nothing automatic for now
  //}

 // void display() {
 //   background(255, 245, 230); // light beige
 //   fill(0);
  //  textSize(24);
  //  text("Toppings Station", 30, 30);

    // Display sundae slots
//    for (int i = 0; i < sundaes.size(); i++) {
//      float x = 100 + i * 150;
 //     float y = 150;

      // Highlight selected sundae
 //     if (i == selectedSundaeIndex) {
 //       stroke(0, 200, 0);
 //       strokeWeight(3);
 //     } else {
  //      stroke(0);
  //      strokeWeight(1);
  //    }
  //    fill(255);
 //     rect(x, y, 60, 100);

      // Show current toppings
 //     fill(0);
 //     textSize(12);
  //    textAlign(CENTER);
 //     String[] toppings = sundaes.get(i).toppings;
 //     for (int t = 0; t < toppings.length; t++) {
 //       text(toppings[t], x + 30, y + 120 + t * 15);
  //    }

 //     noStroke();
 //   }

    // Draw topping buttons
 //   textAlign(LEFT, CENTER);
//    textSize(16);
//    text("Add Topping:", 30, 320);
 //   for (int i = 0; i < allToppings.length; i++) {
 //     drawToppingButton(30 + i * 130, 350, allToppings[i]);
//    }
//  }

//  void drawToppingButton(float x, float y, String topping) {
 //   fill(200);
  //  rect(x, y, 120, 30);
 //   fill(0);
 //   textAlign(CENTER, CENTER);
//    text(topping, x + 60, y + 15);
 // }

//  void handleClick(float mx, float my) {
    // Select sundae
 //   for (int i = 0; i < sundaes.size(); i++) {
 //     float x = 100 + i * 150;
//      float y = 150;
 //     if (mx > x && mx < x + 60 && my > y && my < y + 100) {
//        selectedSundaeIndex = i;
//        return;
//      }
//    }

    // Add topping if a sundae is selected
//    for (int i = 0; i < allToppings.length; i++) {
//      float x = 30 + i * 130;
//      float y = 350;
//      if (mx > x && mx < x + 120 && my > y && my < y + 30) {
  //      Sundae s = sundaes.get(selectedSundaeIndex);
//        s.addTopping(allToppings[i]);
//        return;
//      }
//    }
//  }
//}
