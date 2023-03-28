 class Board
{
  String mode = "building"; //building, adding, organizing, finding

  int size;
  int xBuffer;
  int yBuffer;
  int rows;
  int cols;

  Node nodes[][];
  Node goal, start;

  int walls = 1;

  PVector head;
  LinkedList visited = new LinkedList();

  Board(int size, int xBuffer, int yBuffer)
  {
    this.size = size;
    this.xBuffer = xBuffer;
    this.yBuffer = yBuffer;
    cols = (width-2*xBuffer)/size;
    rows = (height-2*yBuffer)/size;
    nodes = new Node[rows][cols];
    for (int i = 0; i<rows; i++)
    {
      for (int j = 0; j<cols; j++)
      {
        boolean edge = false;
        if (i==0 || j == 0 || i == rows-1 || j == cols-1)
          edge = true;
        nodes[i][j] = new Node(edge, i, j);
      }
    }
    head = new PVector();
    do {
      head.x = (int)random(0, rows);
      head.y = (int)random(0, cols);
    } while (nodes[(int)head.x][(int)head.y].type != "empty");
    visited.push(nodes[(int)head.x][(int)head.y]);
    nodes[(int)head.x][(int)head.y].type = "path";
  }

  boolean neighbourLock(int x, int y)
  {
    if (nodes[x][y].neighbourLock == true) {
      return(true);
    } else {
      int s1 = nodes[x + 1][y].type != "empty" ? 1 : 0;
      int s2 = nodes[x - 1][y].type != "empty" ? 1 : 0;
      int s3 = nodes[x][y + 1].type != "empty" ? 1 : 0;
      int s4 = nodes[x][y - 1].type != "empty" ? 1 : 0;
      int total = s1+s2+s3+s4;
      if (total == 4) {
        nodes[(int)head.x][(int)head.y].neighbourLock = true;
        return(true);
      } else
        return(false);
    }
  }

  void newMaze()
  {
    if (neighbourLock((int)head.x, (int)head.y) == false) {
      int count = (int)random(3, 10), temp = 0;
      int horizontal,  vertical;
      String wallDirection;
      do{
        horizontal = vertical = 0;
        int direction = (int)random(0, 2);
        int magnitude = (int)random(0, 2);
        if(direction == 0) //left Right
        {
          wallDirection = "vertical";
          if(magnitude == 0) //left
          horizontal = -1;
          else               //right
          horizontal = 1;
        }else                //top bottom
        {
          wallDirection = "horizontal";
          if(magnitude == 0) //bottom
          vertical = -1;
          else               //top
          vertical = 1;
        }
      }while(nodes[(int)head.x + horizontal][(int)head.y + vertical].type != "empty");
      while(temp < count && nodes[(int)head.x + horizontal][(int)head.y + vertical].type == "empty")
      {
        addWall(wallDirection);
        head.x += horizontal;
        head.y += vertical;
        nodes[(int)head.x][(int)head.y].type = "path";
        temp++;
      }
      visited.push(nodes[(int)head.x][(int)head.y]);
    } else
      backtrack();
  }
  void addWall(String axis)
  {
    int horizontal = 0;
    int vertical = 0;
    if (axis == "vertical")
    {
      horizontal = 0;
      vertical = 1;
    } else if (axis == "horizontal") {
      horizontal = 1;
      vertical = 0;
    }
    if (nodes[(int)head.x + horizontal][(int)head.y + vertical].type == "empty")
      nodes[(int)head.x + horizontal][(int)head.y + vertical].type = "wall";
    if (nodes[(int)head.x - horizontal][(int)head.y - vertical].type == "empty")
      nodes[(int)head.x - horizontal][(int)head.y - vertical].type = "wall";
  }
  boolean isSignificant(int x, int y)
  {
    boolean right, left, top, bottom;
    right  = nodes[x+1][y  ].type == "path" ? true : false;
    left   = nodes[x-1][y  ].type == "path" ? true : false;
    top    = nodes[x  ][y+1].type == "path" ? true : false;
    bottom = nodes[x  ][y-1].type == "path" ? true : false;
    if ((right && left) || (top && bottom))
      return(false);
    return(true);
  }
  void backtrack()
  {
    if (visited.isEmpty() == false) {
      Node temp;
      do {
        temp = (Node)visited.pop();
      } while (neighbourLock(temp.x, temp.y) == true && visited.isEmpty() == false);
      head.x = temp.x;
      head.y = temp.y;
    } else
      mode = "adding";
  }
  void claerGoals()
  {
    goal.type = "path";
    start.type = "path";
    mode = "adding";
    pathFindingSetup();
  }


  Node findCorner()
  {
    int ranX, ranY;
    int neighbour;
    while (true) {
      ranX = (int)random(1, rows-2);
      ranY = (int)random(1, cols-2);

      if (nodes[ranX][ranY].type != "path")
        continue;

      neighbour = 0;
      if (nodes[ranX+1][ranY].type == "wall")
        neighbour += 1;
      if (nodes[ranX-1][ranY].type == "wall")
        neighbour += 1;
      if (nodes[ranX][ranY+1].type == "wall")
        neighbour += 1;
      if (nodes[ranX][ranY-1].type == "wall")
        neighbour += 1;

      if (neighbour == 3)
        break;
    }
    return(nodes[ranX][ranY]);
  }
  void pathFindingSetup()
  {
    if (mode == "adding") {

      start = findCorner();
      start.type = "start";

      goal = findCorner();
      goal.type = "goal";
      mode = "organizing";
    }
  }
  void render()
  {
    int count = 0, steps = 50;    //increacse steps to speed up building
      while (mode == "building" && count < steps){
        newMaze();
        count++;
      }
    if (mode == "adding")
      pathFindingSetup();

    strokeWeight(size/10);
    rectMode(CORNER);
    for (int i = 0; i<rows; i++)
    {
      for (int j = 0; j<cols; j++)
      {
        nodes[i][j].colour();
        rect((j*size)+xBuffer, (i*size)+yBuffer, size, size);
      }
    }
    if (mode == "building") {
      fill(30, 150, 255);
      rect((head.y*size)+xBuffer, (head.x*size)+yBuffer, size, size);
    }
  }
}
