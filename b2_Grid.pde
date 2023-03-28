class Grid
{
  String mode = "building";
  
  int size;
  int xOffset, yOffset;
  int rows, cols;
  
  Node nodes[][];
  
  Grid(int size, int xOffset, int yOffset)
  {
    this.size = size;
    this.xOffset = xOffset;
    this.yOffset = yOffset;
    
    rows = (height-2*yOffset)/size;
    cols = (width-2*xOffset)/size;
    
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
  }
}
