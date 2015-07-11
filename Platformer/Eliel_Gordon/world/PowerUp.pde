class PowerUp
{
  float x, y;
  float boxSpeed;
  color c;
  PImage boxImage;
  boolean dropped;
  int heightOfImage = 49;
  PowerUp(float _boxSpeed)
  {
    dropped = false;
    boxImage = loadImage("good_potion.png");
    x = random(width - 47);
    y = 0;
    boxSpeed = _boxSpeed;
    c = color(0);
  }

  void display()
  {
    fill(c);
    //rect(x, y, 40, 40);
    image(boxImage, x, y);
  }

  void move()
  {  
    // Subtract the ground and the height of the boxes
    if (y <= height - 100 - heightOfImage)
    {
      y = y + boxSpeed;
    }

    //the box has been dropped so mark it 
    dropped = true;
  }

  //Checks if the cherry has touched the ground
  boolean touchedGround()
  {
    if ( y > height - 100 - 47) 
    {
      return true;
    } else 
    {
      return false;
    }
  }

  // if user eats a powerup
  boolean intersect(Luga _c)
  {
    float distanceL = dist(x, y, _c.x, _c.y);

    if (distanceL <= 30)
    {
      return true;
    } else 
    {
      return false;
    }
  }
}

