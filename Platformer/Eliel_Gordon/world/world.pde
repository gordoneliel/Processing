PImage ground;
Luga character;
int direction;
int dir;
boolean jump;
int currentScreen;


//Timer for level difficulty
float timer = 0;
float levelTimer = 0;
float powerTimer = 0;
float min, max;

//Handles character direction
boolean upPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

//Cherries and power ups
ArrayList<Cherry> cherries;
ArrayList<PowerUp> powerUps;

//Default image && values
String normal = "sara_normal.png";
PImage bg;
int life = 250;
boolean powerup = false;
int score;
int highScore = 0;
int pTimer = 0;
int multiplier = 1;
// Audio imports
import ddf.minim.*;

Minim minim;
AudioPlayer player;
AudioSample eat;
AudioSample deadSound;
int deadPlay = 0;
AudioSample mainMusic;

void setup()
{
  size(960, 640);
  ground = loadImage("ground.png");
  bg = loadImage("clouds.jpg");
  cherries = new ArrayList<Cherry>();  
  powerUps = new ArrayList<PowerUp>();
  min = 1;
  max = 2;
  character = new Luga(0, 0, normal, 10, powerup);
  frameRate(60);
  smooth();
  minim = new Minim(this);
  eat = minim.loadSample("sound/munch.mp3", 512);
  deadSound = minim.loadSample("sound/main.mp3", 512);
  mainMusic = minim.loadSample("sound/themeSong.mp3", 512);
  smooth();
  currentScreen = 1;
  mainMusic.trigger();
}

/* Funtion: hoverOverRect
 * Purpose: Handles event when your move mouse
 *          over the play button 
 */
boolean hoverOverRect(float x, float y, float width, float height)  
{
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else 
  {
    return false;
  }
}

/* Creates the button to play the game again
 * Takes in the x,y position to create the button as well as
 * the with and height and the roundness of the rect
 */
boolean createButton(float x, float y, float w, float h, float rw)
{
  boolean isOverButton = false;
  noStroke();
  fill(34, 100, 220);
  rect(x, y, w, h, rw);
  fill(255);
  textSize(28);
  text("Play Again", x + 50, y + 35);
  if (hoverOverRect(x, y, w, h))
  {
    fill(#FFF520); 
    rect(x, y, w, h, rw);
    fill(255);
    text("Play Again", x + 50, y + 35);
    isOverButton = true;
  }
  return isOverButton;
}

/*
 * Resets the game for another session of play
 * Starts the levels and sound for replay
 */
void resetGame()
{
  timer = 0;
  levelTimer = millis();
  powerTimer = 0;
  currentScreen = 1;
  cherries = new ArrayList<Cherry>();  
  powerUps = new ArrayList<PowerUp>();
  min = 1;
  max = 2;
  character = new Luga(0, 0, normal, 12, powerup);
  background(#54C0C9);
  bg = loadImage("clouds.jpg");
  bg.resize(0, 600);
  image(bg, 0, 0);
  life = 250;
  mainMusic.trigger();
  score = 0;
}

/* Draws the screen for level one
 * 
 */
void drawScreenOne()
{
  background(#54C0C9);
  bg.resize(0, 600);
  image(bg, 0, 0);
  textSize(50);
  text("Level 1", width/2 - 120, height/2);

  if (millis() - timer >= 3000) 
  {
    timer = millis();
    cherries.add(new Cherry(random(min, max)));
  }
  // second level
  if (millis()/1000>10) 
  {
    min = 1;
    max = 2;
  }
}

/* Draws the screen for level two
 * 
 */
void drawScreenTwo()
{
  background(#54C0C9);
  bg.resize(0, 600);
  image(bg, 0, 0);
  textSize(50);
  text("Level 2", width/2 - 120, height/2);
  if (millis() - timer >= 1500) 
  {
    timer = millis();
    cherries.add(new Cherry(random(min, max)));
  }
  // second level
  if (millis()/1000>20) 
  {
    min = 1;
    max = 4;
  }
}

/* Draws the screen for level three
 * 
 */
void drawScreenThree() 
{
  background(#54C0C9);
  bg.resize(0, 600);
  image(bg, 0, 0);
  textSize(50);
  text("Level 3", width/2 - 120, height/2);
  if (millis() - timer >= 2200) 
  {
    timer = millis();
    cherries.add(new Cherry(random(min, max)));
  }
  // third level
  if (millis()/1000>35) 
  {
    min = 4;
    max = 5;
  }
}

/* 
 * Draws the screen for level three
 */
void drawScreenFour()
{
  background(#54C0C9);
  bg.resize(0, 600);
  image(bg, 0, 0);
  textSize(50);
  text("Level 4", width/2 - 120, height/2);
  if (millis() - timer >= 1100) 
  {
    timer = millis();
    cherries.add(new Cherry(random(min, max)));
  }
  // fourth level
  if (millis()/1000>35) 
  {
    min = 1;
    max = 6;
  }
}
/* Draws the Game Over Screen
 * if life <= 0 , game over, play gameover sound and display blank screen
 * Resets the game
 */
void drawGameOverScreen()
{
  background(255);
  fill(#FF072C);
  textSize(50);
  text("Game Over", width/2 - 130, height/2 - 70);

  // Check for high Score
  fill(#0E80B2);
  textSize(22);
  if (score > highScore)
  {
    text("High Score! " + score, width/2 - 130, height/2);
    text("You ate: " + score/5 + " Cherries!", width/2 - 130, height/2 + 20);
    highScore = score;
  } else
  {
    text("Score: " + score, width/2 - 130, height/2);
    text("You ate: " + score/5 + " Cherries!", width/2 - 130, height/2 + 20);
  }


  int rectW = 250;
  int rectH = 50;
  boolean overCreate = createButton(width/2 - 130, height/2 + rectH, rectW, rectH, 5);

  //Stop main theme music
  mainMusic.close();
  if (overCreate && mousePressed)
  {
    resetGame();
  }

  if (deadPlay == 0)
  {
    eat.close();
    deadSound.trigger();
    deadPlay = 1;
  }
  cherries = new ArrayList<Cherry>();  
  powerUps = new ArrayList<PowerUp>();
}

/*
 * Draw the curret screen based on which level we are on
 * Level is based on how long the player survives
 */
void draw()
{
  switch(currentScreen)
  {
  case 0: 
    drawGameOverScreen();
    break;
  case 1: 
    drawScreenOne(); 

    break;
  case 2: 
    drawScreenTwo(); 

    break;
  case 3:
    drawScreenThree(); 
    break;
  case 4:
    drawScreenFour();
  default: 
    break;
  }

  // Draw the ground and move the character
  drawGround();
  character.move(direction * multiplier, dir);
  character.draw();

  //Display the player's current score
  textSize(22);
  text("Score: " + score, 20, 100);

  // Level 2
  if (millis() - levelTimer >= 25000) 
  {
    currentScreen = 2;
  }

  // Level 3
  if (millis() - levelTimer >= 37000) 
  {
    currentScreen = 3;
  }

  // Level 4
  if (millis() - levelTimer >= 49000) 
  {
    currentScreen = 4;
  }

  // Game Over
  if (life <= 0)
  {
    currentScreen = 0;
  }

  // Player's interaction with the cherries
  for (int i = cherries.size () - 1; i>=0; i--) 
  {
    Cherry e = cherries.get(i);
    e.display();
    e.move();

    if (character.intersect(e) || e.y > height - 147) 
    {
      cherries.remove(i);
      if (e.y > height - 147)
      {
        life -= 25;
      }
      if (character.intersect(e))
      {
        eat.trigger();
        score += 5;
      }
    }
  }

  /** Throw in some powerups
   *  Creates powerups for accelerated gameplay
   *  If user has powerup, increase speed
   */
  // Have a powerup every 10 seconds
  if (millis() - powerTimer >= 12000) 
  {
    powerTimer = millis();
    powerUps.add(new PowerUp(random(min, max)));
  }

  for (int i = powerUps.size ()-1; i>=0; i--) 
  {
    PowerUp e = powerUps.get(i);
    e.display();
    e.move();
    if ( e.intersect(character) )
    {
      powerup = true;
//      multiplier = 2;
      powerUps.remove(e);
    }
  }


  // Draws a life bar
  lifeBar(life);
  //  // Draws the power up
  //  powerUpBar();
}

void drawGround()
{
  image(ground, 0, height - 100);
  image(ground, 696, height - 100);
}

void keyPressed()
{
  if (keyCode == RIGHT)
  {
    direction = 6;
    rightPressed = true;
    dir = 1;
  } else if (keyCode == LEFT)
  {
    direction = -6;
    leftPressed = true;
    dir = -1;
  } else 
  {
    dir = 0;
  }

  if (keyCode == UP)
  {
    upPressed = true;
  }
}

/* Draws the life of the character
 * The player has 10 life points, each cherry that falls on
 * the floor takes away one life point
 */
void lifeBar(int life)
{
  for (int i = 20; i  <= life; i+=25)
  {
    fill(255, 2 * i, (3*i) /3);
    rect(i, 20, 20, 35, 3);
    noStroke();
  }
  fill(255);
  textSize(22);
  text("Life " + life/25, 20, 80);
}

/* 
 * Draws the powerup of the character
 */
void powerUpBar()
{
  noStroke();
  fill(255, 12, 23);
  rect(20, 100, 200, 15, 3);
  textSize(17);
  text("PowerUp " + life, 20, 80);
}

void keyReleased()
{
  direction = 0;
  dir = 0;
  if (keyCode == UP)
  {
    upPressed = false;
  }
}

