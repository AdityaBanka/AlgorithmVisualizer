//opening to the title screen with settings. Includes:
//a play or make screen
//a settings screen
//a credits screen

import java.util.*;
TitleScreen titleScreen;
MainMenu mainMenu;
Grid grid;

String mode = "mainmenu";
boolean change = false;
void setup()
{
  fullScreen();
  //size(800, 60);
  mainMenu = new MainMenu();
  titleScreen = new TitleScreen();
}
void draw()
{
  if (mode == "mainmenu") {
    mainMenu.render();
  }
  if (mode == "titlescreen") {
    if (change) {
      //titleScreen = new TitleScreen();
      change = false;
    }
    titleScreen.render();
  }
}
