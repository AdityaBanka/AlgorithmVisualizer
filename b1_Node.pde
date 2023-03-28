class Node
{
  int x, y;
  boolean visited;
  boolean neighbourLock;
  int distance;
  String type;          //empty, path, wall, start, goal, threat

  boolean colour = false;

  Node(boolean edge, int rows, int cols)
  {
    x = rows;
    y = cols;
    visited = false;
    neighbourLock = false;
    distance = Integer.MAX_VALUE;
    type = "empty";
    if (edge) {
      visited = true;
      type = "wall";
    }
  }
  void colour()
  {
    stroke(#000000);

    if (type == "empty")
    {
      stroke(#FFFFFF);
      noFill();
    }
    if (type == "path")
      fill(#FFFFFF);
    if (type == "wall")
      //fill(#B45A1E);
      fill(#A04000);
    if (colour == true)
      fill(#FF0000);
    if (type == "start")
      fill(#0000FF);
    if (type == "goal")
      fill(#00FF00);
    if (type == "threat")
      fill(#FF0000);

    noStroke();
  }
}
