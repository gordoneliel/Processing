class Cherry
{
  float x, y;
  float boxSpeed;
  PImage boxImage;
  boolean dropped;

  Cherry(float _boxSpeed)
  {
    boxImage = loadImage("cherry.png");
    x = random(width - 47);
    y = 0;
    boxSpeed = _boxSpeed;
    dropped = false;
  }

  void display()
  {
    image(boxImage, x, y);
  }

  void move()
  {
    // Subtract the ground and the height of the boxes
    if (y <= height - 100 - 47)
    {
      y = y + boxSpeed;
    } 
    
    if(y > height - 100 - 47)
    {
      dropped = true;
    }
  }
  //Checks if the cherry has touched the ground
  boolean touchedGround()
  {
    if ( y >= height - 100 - 47) 
    {
      return true;
    } else 
    {
      return false;
    }
  }
}

