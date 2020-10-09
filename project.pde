Ball bll;
Paddle Paddle;
ArrayList brickslist;
void setup() {
  size(1024, 768);
  background(0);
  noCursor();
  smooth();
  //creates a ball that will bounce around the screen
  bll = new Ball (175, 420, 1, 2, color(random(255), random(255), random(255)));
  rectMode(CENTER);
  //creates the paddle that will hit the ball into the bricks 
  Paddle = new Paddle (height, 120, 30);
  //create an empty array list for the Bricks
  brickslist = new ArrayList();
  // fill the array list
  for (int x = 1; x<=9; x++) {
    for (int y = 1; y<=4; y++) {
      brickslist.add(new Bricks (x*100+15, y*40+20, 90, 30));
    } // for
  } // for
} // func
//
void draw() {
  background(0);
  //
  //lets the ball move
  bll.move();
  // check collisions with Bricks
  for (int i = brickslist.size()-1; i>=0; i--) {
    // get the brick #i
    Bricks oneSingleBrick = (Bricks) brickslist.get(i);
    // check it
    if (oneSingleBrick.collide( bll.xposition, bll.yposition, bll.radiusBall ) ) {
      // this needs more attention: when he hits from below, yspeed needs to
      // be changed; when from the sides, xspeed
      bll.yspeed = bll.yspeed * -1;
      brickslist.remove(i);
    } // if
  } // for  
  bll.bounce();//allows ball to bounce off the edges
  bll.display();//displays the ball
  // display Bricks
  for (int i = brickslist.size()-1; i>=0; i--) {
    Bricks oneSingleBrick = (Bricks) brickslist.get(i);
    oneSingleBrick.display();
  } // for
  // now Paddle stuff
  Paddle.move();//paddle is allowed to move
  Paddle.display();//displays the paddle
} // func
// ==============================================================
// Ball Code (in new tab):
class Ball {
  float xposition;
  float yposition;
  float xspeed;
  float yspeed;
  color c;
  // two times the radius:
  int diameterBall=32; // wrong name
  // the single radius
  int radiusBall=diameterBall / 2;  // wrong name
  //
  //all the code for the class goes here
  Ball(float xpos, float ypos, float xsp, float ysp, color c1) {
    xposition = xpos;
    yposition = ypos;
    xspeed = xsp;
    yspeed = ysp;
    c = c1;
    ysp = 2;
    xsp = 2;
  }
  // move ball
  void move() {
    xposition = xposition + xspeed;// Change the x location by speed
    yposition = yposition + yspeed;
  }
  //A function to void bounce the ball
  void bounce() {
    // If we've reached an edge, reverse speed: X
    if ((xposition > width-radiusBall) || (xposition < radiusBall)) {
      xspeed = xspeed *  -1;
    }
    // ... and y
    if ((yposition > height-radiusBall) || (yposition < radiusBall)) {
      yspeed = yspeed * -1;
    }
    // paddle
    if ((yposition >  670) && (xposition < mouseX+50)) {
      yspeed = yspeed * -1;
    }
  }
  //A function to display the ball
  void display() {
    stroke(0);
    fill(c);
    ellipse(xposition, yposition, diameterBall, diameterBall);
  } // func
} // class
// ==============================================================
// Paddle(also in new tab)
//Paddle
class Paddle {
  float xpos;
  float hgt;
  float wdth;
  Paddle(float tempXpos, float tempWdth, float tempHgt) {
    xpos = tempXpos;
    hgt = tempHgt;
    wdth = tempWdth;
  }
  void display() {
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(mouseX, 700, 120, 30);
  }
  //mouse moves the paddle horizonally
  void move() {
    constrain(xpos, 0+(hgt/2), 400-(hgt/2));
    xpos = mouseX;
  } // func
} // class
// ==============================================================
// Bricks(again a new tab):
//Bricks
class Bricks {
  float hgt;
  float wdth;
  float x;
  float y;
  Bricks(float tempx, float tempy, float tempwdth, float temphgt) {
    hgt = temphgt;
    wdth = tempwdth;
    x = tempx;
    y = tempy;
  }
  void display() {
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(x, y, wdth, hgt);
  }
  boolean collide (float xBall, float yBall, int radusBallHalf) {
    // all wrong because of rectMode(CENTER);
    if ((xBall+radusBallHalf > x) &&
      (yBall+radusBallHalf > y) &&
      (xBall-radusBallHalf < x+wdth) &&
      (yBall-radusBallHalf < y+hgt))
    {
      return (true);
    }
    else {
      return (false);
    }
  } // func
} // class
