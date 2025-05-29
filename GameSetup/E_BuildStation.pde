//class BuildStation extends Station {
//  ArrayList<Sundae> sundaes;
//  String selectedCup = "";
//  String selectedSyrup = "";
//  String selectedFlavor = "";

//  BuildStation(ArrayList<Sundae> sundaes) {
//    super("Build");
//   this.sundaes = sundaes;
//  }

//  void update() {
    // Nothing automatic for now
//  }

//  void display() {
//    background(230, 255, 230); // light green
//    fill(0);
 //   textSize(24);
 //   text("Build Station", 30, 30);

 //   textSize(16);
 //   text("Choose Cup:", 30, 80);
 //   drawButton(30, 110, "Small", selectedCup);
  //  drawButton(120, 110, "Large", selectedCup);

//    text("Choose Syrup:", 30, 160);
//    drawButton(30, 190, "Vanilla", selectedSyrup);
//    drawButton(120, 190, "Chocolate", selectedSyrup);

//    text("Choose Flavor:", 30, 240);
//    drawButton(30, 270, "Strawberry", selectedFlavor);
//    drawButton(120, 270, "Banana", selectedFlavor);

//    drawSubmitButton();
//  }

//  void drawButton(float x, float y, String label, String selected) {
//    if (label.equals(selected)) {
//      fill(150, 200, 255);
//    } else {
//      fill(200);
//    }
//    rect(x, y, 80, 30);
//    fill(0);
//    textAlign(CENTER, CENTER);
//    text(label, x + 40, y + 15);
//  }

//  void drawSubmitButton() {
//    if (canSubmit()) {
//      fill(0, 200, 0);
//    } else {
//      fill(150);
//    }
//    rect(30, 340, 170, 40);
//    fill(255);
//    textAlign(CENTER, CENTER);
//    text("Build Sundae", 30 + 85, 340 + 20);
//  }

//  boolean canSubmit() {
//    return !selectedCup.equals("") && !selectedSyrup.equals("") && !selectedFlavor.equals("");
//  }

//  void handleClick(float mx, float my) {
    // Cup
//    if (over(mx, my, 30, 110)) selectedCup = "Small";
//    if (over(mx, my, 120, 110)) selectedCup = "Large";

    // Syrup
//    if (over(mx, my, 30, 190)) selectedSyrup = "Vanilla";
//    if (over(mx, my, 120, 190)) selectedSyrup = "Chocolate";

    // Flavor
//    if (over(mx, my, 30, 270)) selectedFlavor = "Strawberry";
//    if (over(mx, my, 120, 270)) selectedFlavor = "Banana";

    // Submit button
//    if (canSubmit() && over(mx, my, 30, 340)) {
//      sundaes.add(new Sundae(selectedCup, selectedSyrup, selectedFlavor, new String[]{}, 100));
//      selectedCup = selectedSyrup = selectedFlavor = ""; // reset
//    }
//  }

//  boolean over(float mx, float my, float x, float y) {
//    return mx > x && mx < x + 80 && my > y && my < y + 30;
//  }
//}
