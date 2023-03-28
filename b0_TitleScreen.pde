class TitleScreen
{
  int background = #000000;
  int size = 10;
  int xBorderBuffer = (int)(width*0.1);
  int yBorderBuffer = (int)(height*0.2);
  int xButtonBuffer = (int)(width*0.01);

  Button generateMaze;
  Button newGoal;
  Button back;

  Board board;
  int flag = 0;

  TitleScreen()
  {
    generateMaze = new Button();
    generateMaze.buttonWidth = (int)(width/4);
    generateMaze.buttonHeight = (int)(height/8);
    generateMaze.center.x = width/2;
    generateMaze.center.y = height-100;
    generateMaze.text = "Build Maze";

    newGoal = new Button();
    newGoal.copyProperties(generateMaze);
    newGoal.center.x += newGoal.buttonWidth/2 + xButtonBuffer;
    newGoal.text = "New Start/Goal";

    back = new Button();
    back.copyProperties(newGoal);
    back.buttonWidth = (int)(height*0.1);
    back.buttonHeight = (int)(height*0.05);
    back.center.x = (int)(height*0.01) + back.buttonWidth;
    back.center.y = (int)(height*0.01) + back.buttonHeight;
    back.text = "Esc";

    board = new Board(size, xBorderBuffer, yBorderBuffer);
  }

  void render()
  {
    background(background);

    if (generateMaze.clicked())
      board = new Board(size, xBorderBuffer, yBorderBuffer);

    if (back.clicked())
    {
      mode = "mainmenu";
    }

    if (board.mode != "building")
    {
      if (flag == 0) {
        generateMaze.center.x -= generateMaze.buttonWidth/2 + xButtonBuffer;
        flag = 1;
      }

      if (newGoal.clicked())
        board.claerGoals();
      newGoal.render();
    } else
    {
      if (flag == 1) {
        generateMaze.center.x += generateMaze.buttonWidth/2 + xButtonBuffer;
        flag = 0;
      }
    }

    generateMaze.render();
    back.render();

    board.render();
  }
}
