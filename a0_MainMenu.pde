class MainMenu
{
  int background = #000000;
  
  Button Visualize;
  Button Setting;
  Button Credits;
  
  int yButtonBuffer = (int)(height*0.05);
  
  MainMenu()
  {
    Visualize = new Button();
    Visualize.buttonWidth = (int)(width/4);
    Visualize.buttonHeight = (int)(height/8);
    Visualize.center.x = width/2;
    Visualize.center.y = (int)(height*0.3);
    Visualize.text = "Visualize";
    
    Setting = new Button();
    Setting.copyProperties(Visualize);
    Setting.center.y += Setting.buttonHeight + yButtonBuffer;
    Setting.text = "Setting";
    
    Credits = new Button();
    Credits.copyProperties(Setting);
    Credits.center.y += Credits.buttonHeight + yButtonBuffer;
    Credits.text = "Credits";
  }
  
  void render()
  {
    background(background);
    
    if (Visualize.clicked()){
      mode = "titlescreen";
      change = true;
    }
    
    Visualize.render();
    Setting.render();
    Credits.render();
  }
}
