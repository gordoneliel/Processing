class Luga
{
  PImage guy_normal;
  float x, y;
  int ground_padding = 147;
  int c_speed;
  String normal = "sara_normal.png";

  String image;
  int incr = 0;
  int isjumping=0;    

  float gravity = .5;

  float yspeed = 0;
  int drag = 1;
  boolean power;
  float timer = 0;

  Luga(int x, int y, String _image, int speed, boolean power) 
  {
    this.x = x;
    this.y = height - ground_padding;
    image = _image;
    this.c_speed = speed;
    guy_normal = loadImage(image);
    this.power = power;
  }


  /**
   * Moves the character based on speed and direction
   * If direction == -1, left, if == 0, still, if 1, move right
   */
  void move(int dirSpeed, int direction)
  {
    if (millis() - timer >= 7000) 
    {
      timer = millis();
      powerup = false;
    }
    // increase speed if you have a powerup
    if (powerup)
    {
      //Draws the powerup bar
      powerUpBar();
      dirSpeed *= 1.5;
    }

    if (direction !=0)
    {
      x += dirSpeed;
    }
    if (direction  == 1)
    {
      guy_normal = loadImage("rightWalking/rightW_" + drag +".png");
    }
    if (direction == -1)
    {
      guy_normal = loadImage("leftWalking/leftW_" + drag +".png");
    }
    if (direction == 0 && isjumping == 0)
    {
      guy_normal = loadImage("sara_normal.png");
    }

    //Drag controls the walking images to animate the character walking
    if (drag >= 9)
    {
      drag = 1;
    } else
    {
      drag +=1;
    }
  }

  // The jump part of the character
  void jump()
  {
    if (upPressed && isjumping == 0)
    {
      guy_normal = loadImage("sara_jump.png");
      incr = -100;
      isjumping = 1;
    }

    if (isjumping == 1)
    {
      y = y + incr;
      incr += 2 + gravity;
      if (direction  == -1)
      {
        x += incr/10;
        incr += 2 + gravity;
      }
      if (direction  == 1)
      {
        x += -incr/10;
        incr += 2 + gravity;
      }
    }

    if (incr > 0)
    {
      isjumping = 0;
    }
  }

  void draw()
  {
    // Stops the character from going off the screen
    if (x<0) x=0;
    if ((x+40)>width) x=(width-40);
    if (y>147)
    { 
      y = 147;
    }
    if (y <= height - ground_padding)
    {
      y = height - ground_padding;
    }

    jump();
    image(guy_normal, x, y);
  }

  /* 
   * Draws the powerup of the character
   */
  void powerUpBar()
  {
    int barWidth = 1;
    noStroke();
    fill(255, 122, 47);
    float mapp = map(millis() - timer,0, timer, 0, 250);
    float time = map(timer, 0, timer, 0, 250);
    rect(x, y - 12, time-mapp, 12, 2);
    textSize(17);
    text("PowerUp ", x, y - 12);
    fill(255);
  }

  boolean intersect(Cherry _cherry)
  {
    float distanceL = dist(x, y, _cherry.x, _cherry.y);

    if (distanceL <= 50)
    {
      return true;
    } else 
    {
      return false;
    }
  }
}

