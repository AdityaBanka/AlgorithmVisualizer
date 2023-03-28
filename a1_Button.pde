class Button
{
  int buttonWidth;                                          //widht of the button
  int buttonHeight;                                          //height of the button
  PVector center = new PVector();                   //coordinates for the center of the button

  int stroke = #FFFFFF;                             //stroke colour of the boarder
  int strokeWeight = 5;                             //stroke thickness of the border
  int fill = #00FF00;                               //button filler colour

  String text = "Button";
  int fontSize = 30;
  int textFill = #FFFFFF;

  void copyProperties(Button temp)
  {
    this.buttonWidth = temp.buttonWidth;
    this.buttonHeight = temp.buttonHeight;
    this.center.x = temp.center.x;
    this.center.y = temp.center.y;

    this.stroke = temp.stroke;
    this.strokeWeight = temp.strokeWeight;
    this.fill = temp.fill;

    this.text = temp.text;
    this.fontSize = temp.fontSize;
    this.textFill = temp.fill;
  }
  boolean hover()
  {
    if (center.x-(buttonWidth/2) < mouseX && mouseX < center.x+(buttonWidth/2))
      if (center.y-(buttonHeight/2) < mouseY && mouseY < center.y+(buttonHeight/2))
        return(true);
    return(false);
  }
  boolean clicked()
  {
    if (hover() == true && mousePressed == true) {
      delay(100);
      return(true);
    }
    return(false);
  }
  void render()
  {
    rectMode(CORNER);

    strokeWeight(strokeWeight);
    stroke(stroke);
    if (hover())
      fill(fill);
    else
      noFill();

    rect(center.x-(buttonWidth/2), center.y-(buttonHeight/2), buttonWidth, buttonHeight);

    fill(stroke);
    textAlign(CENTER, CENTER);
    textSize(fontSize);
    text(text, center.x, center.y);
  }
}
