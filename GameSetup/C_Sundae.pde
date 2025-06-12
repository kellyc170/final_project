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
  HashMap<String, ArrayList<PVector>> toppingPositions = new HashMap<String, ArrayList<PVector>>();

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
    if (!toppingPositions.containsKey(topping)) {
      toppingPositions.put(topping, new ArrayList<PVector>());
    }
    float swirlX = width / 2;
    float swirlY = height - 300;
    float swirlRadius = 40;
    float angle = random(TWO_PI);
    float r = random(swirlRadius * 0.3f, swirlRadius);
    float tx = swirlX + cos(angle) * r;
    float ty = swirlY + sin(angle) * r;
    if (topping.equalsIgnoreCase("sprinkles")) {
      toppingPositions.get(topping).add(new PVector(tx, ty));
      for (int i = 0; i < 5; i++) {
        float a = random(TWO_PI);
        float rr = random(4, 8);
        toppingPositions.get(topping).add(new PVector(cos(a) * rr, sin(a) * rr));
      }
    } 
    else {
      toppingPositions.get(topping).add(new PVector(tx, ty));
    }
    toppings.add(topping);
  }
  
  void removeTopping(String topping) {
    toppings.remove(topping);
  }
  
  void clearToppings() {
    toppings.clear();
    toppingPositions.clear();
  }

 void display(float cupX, float cupY) {
   cupX = width / 2;
   cupY = height-180;
   float cupWidth, cupHeight;
   switch (cupSize) {
     case "S":
       cupWidth = 120;
       cupHeight = 100;
       break;
     case "M":
       cupWidth = 140;
       cupHeight = 120;
       break;
     case "L":
       cupWidth = 160;
       cupHeight = 140;
       break;
     default:
       cupWidth = 120;
       cupHeight = 100;
   }

  float topWidth = cupWidth;
  float bottomWidth = cupWidth * 0.6;
  float topX1 = cupX - topWidth / 2;
  float topX2 = cupX + topWidth / 2;
  float bottomX1 = cupX - bottomWidth / 2;
  float bottomX2 = cupX + bottomWidth / 2;
  float topY = cupY - cupHeight / 2;
  float bottomY = cupY + cupHeight / 2;
  float scoopY = topY + 5;
  float scoopWidth = topWidth - 10;
  float scoopHeight = scoopWidth * 1.4;

  // Draw scoop
  if (!isMixed()) {
    if (flavor != null && !flavor.equals("")) {
      switch (flavor) {
        case "Vanilla":
          fill(#FAF6D1);
          break;
        case "Chocolate":
          fill(#673500);
          break;
        case "Strawberry":
          fill(#FA6FA9);
          break;
        default:
          fill(230);
      }
      noStroke();
      ellipse(cupX, scoopY, scoopWidth, scoopHeight);
    }

    // Draw syrup
    if (flavor != null && syrup != null && !syrup.equals("")) {
      switch (syrup) {
        case "Chocolate":
          fill(#5A0F00);
          break;
        case "Caramel":
          fill(#CB8500);
          break;
        case "Strawberry":
          fill(#CB0285);
          break;
        default:
          fill(0);
      }
      float syrupX = cupX;
      float syrupY = scoopY - scoopHeight * 0.2f;
      float syrupW = scoopWidth * 0.9f;
      float syrupH = scoopHeight * 0.6f;
      drawSyrupWithSquigglyBottom(syrupX, syrupY, syrupW, syrupH);
    }
  } 
  else {
    drawSoftServeDollop(cupX, scoopY, scoopWidth, mixLevel, cupSize);
  }

  // Draw cup
  fill(200);
  noStroke();
  quad(topX1, topY, topX2, topY, bottomX2, bottomY, bottomX1, bottomY);

  // Draw syrup
  if (!isMixed() && flavor != null && syrup != null && !syrup.equals("")) {
    switch (syrup) {
      case "Chocolate":
        fill(#5A0F00);
        break;
      case "Caramel":
        fill(#CB8500);
        break;
      case "Strawberry":
        fill(#CB0285);
        break;
      default:
        fill(0);
    }
      float syrupX = cupX;
      float syrupY = scoopY - scoopHeight * 0.2f;
      float syrupW = scoopWidth * 0.9f;
      float syrupH = scoopHeight * 0.6f;
      drawSyrupWithSquigglyBottom(syrupX, syrupY, syrupW, syrupH);
   }

  for (String topping : toppingPositions.keySet()) {
    ArrayList<PVector> positions = toppingPositions.get(topping);
    float scale = getToppingScale();
  
    if (topping.equalsIgnoreCase("sprinkles")) {
      color[] sprinkleColors = {
        color(255, 0, 0),    // red
        color(0, 255, 0),    // green
        color(0, 0, 255),    // blue
        color(255, 255, 0),  // yellow
        color(255, 0, 255)   // magenta
      };
  
      noStroke();
      for (int i = 0; i < positions.size(); i += 6) {
        PVector mainPos = positions.get(i);
        float mainX = cupX + (mainPos.x - cupX) * scale;
        float mainY = cupY + (mainPos.y - cupY) * scale;
        for (int j = 1; j <= 5; j++) {
          PVector offset = positions.get(i + j);
          fill(sprinkleColors[j - 1]);
          float x = mainX + offset.x * 1.5f * scale;
          float y = mainY + offset.y * 1.5f * scale;
          rect(x, y, 3 * scale, 7 * scale);
        }
      }
    } 
    else {
      for (PVector pos : positions) {
        noStroke();
        float adjustedX = cupX + (pos.x - cupX) * scale;
        float adjustedY = cupY + (pos.y - cupY) * scale;
  
        switch (topping.toLowerCase()) {
          case "cherry":
            fill(255, 0, 0);
            ellipse(adjustedX, adjustedY, 18 * scale, 18 * scale);
            stroke(100);
            strokeWeight(1.5f * scale);
            line(adjustedX, adjustedY - 9 * scale, adjustedX, adjustedY - 21 * scale);
            break;
  
          case "blueberry":
            fill(50, 50, 200);
            ellipse(adjustedX, adjustedY, 12 * scale, 12 * scale);
            fill(30);
            ellipse(adjustedX, adjustedY - 1.5f * scale, 3 * scale, 3 * scale);
            break;
  
          case "strawberry":
            fill(255, 60, 100);
            ellipse(adjustedX, adjustedY, 15 * scale, 18 * scale);
            fill(0, 200, 0);
            triangle(adjustedX - 4.5f * scale, adjustedY - 9 * scale, adjustedX + 4.5f * scale, adjustedY - 9 * scale, adjustedX, adjustedY - 15 * scale);
            break;
  
          case "marshmallow":
            fill(255);
            rect(adjustedX - 7.5f * scale, adjustedY - 9 * scale, 15 * scale, 18 * scale, 6 * scale);
            break;
  
          case "oreo":
            fill(40);
            ellipse(adjustedX, adjustedY, 15 * scale, 15 * scale);
            fill(255);
            ellipse(adjustedX, adjustedY, 6 * scale, 6 * scale);
            break;
  
          case "nut":
            fill(194, 155, 96);
            ellipse(adjustedX, adjustedY, 12 * scale, 9 * scale);
            break;
  
          case "whippedcream":
            fill(255);
            ellipse(adjustedX, adjustedY, 18 * scale, 9 * scale);
            ellipse(adjustedX, adjustedY - 4.5f * scale, 15 * scale, 9 * scale);
            ellipse(adjustedX, adjustedY - 9 * scale, 12 * scale, 9 * scale);
            break;
  
          case "chocolate":
            fill(90, 45, 0);
            rect(adjustedX - 6 * scale, adjustedY - 6 * scale, 12 * scale, 12 * scale, 3 * scale);
            break;
  
          default:
            fill(0);
            ellipse(adjustedX, adjustedY, 15 * scale, 15 * scale);
        }
      }
    }
  }
}

  void drawSyrupWithSquigglyBottom(float x, float y, float w, float h) {
    int waves = 30;
    float waveWidth = w / waves;
    float amplitude = h * 0.15f;
    beginShape();
    for (float angle = PI; angle <= TWO_PI + 0.01; angle += 0.05) {
      float px = x + cos(angle) * (w / 2);
      float py = y + sin(angle) * (h / 2);
      vertex(px, py);
    }
    for (int i = waves; i >= 0; i--) {
      float px = x - w / 2 + i * waveWidth;
      float py = y + amplitude * sin(i * 0.5f);
      vertex(px, py);
    }
    endShape(CLOSE);
  }
  
  void drawSoftServeDollop(float x, float y, float w, int mixLevel, String cupSize) {
    color swirlColor = getFlavorColor();
    color syrupColor = getSyrupColor();
    int layers = 3;
    float layerHeight;
    float baseWidth;
    float overlap;
  
    switch (cupSize) {
      case "S":
        overlap = 15;
        layerHeight = 38;
        baseWidth = w * 0.95f;
        break;
      case "M":
        overlap = 12;
        layerHeight = 43;
        baseWidth = w * 0.97f;
        break;
      case "L":
        overlap = 10;
        layerHeight = 50;
        baseWidth = w * 1f;
        break;
      default:
        overlap = 15;
        layers = 3;
        layerHeight = 38;
        baseWidth = w;
    }
    
   float mixFactor = constrain(1 - (mixLevel / 10.0), 0, 1);
   for (int i = 0; i < layers; i++) {
     float swirlWidth = baseWidth - i * (baseWidth * 0.3f);
     float swirlY = y - (i * (layerHeight - overlap));
     float blendFactor = map(i, 0, layers - 1, mixFactor, 0); 
     color layerColor = lerpColor(syrupColor, swirlColor, blendFactor);
  
     fill(layerColor);
     noStroke();
     rect(x - swirlWidth / 2, swirlY - 30, swirlWidth, layerHeight, 30);
   }
  }

  color getFlavorColor() {
    switch (flavor) {
      case "Vanilla":
        return color(#FAF6D1);
      case "Chocolate":
        return color(#673500);
      case "Strawberry":
        return color(#FA6FA9);
      default:
        return color(0);
    }
  }

  color getSyrupColor() {
    switch (syrup) {
      case "Chocolate":
        return color(#5A0F00);
      case "Caramel":
        return color(#CB8500);    
      case "Strawberry":
        return color(#CB0285);
      default:
        return color(0); 
    }
  }

  float getToppingScale() {
    switch (cupSize) {
      case "S":
        return 0.8f; 
      case "M":
        return 1.0f; 
      case "L":
        return 1.2f; 
      default:
        return 1.0f;
    }
  }
}
