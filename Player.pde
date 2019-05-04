class Player {
  char[] keys = {'a', 'd', 'w', 's', ' '};
  int legend;
  PVector pos = new PVector(800, 400);//random(900, 900), 500);
  PVector vel = new PVector(0, 0);
  boolean stunned = false;
  boolean grounded = false;
  int jumps = 3;
  int move = -1;
  int frame = 0;
  int frameTimer = 0;
  Player(int legend_) {
    legend = legend_;
  }
  void move(int move_) {
    if (move == -1) {
      move = move_;
      frame = 0;
    }
  }

  void update() {
    updatePosition();
    if (move != -1) {
      frameTimer += 1;
      if (legends[legend].moves[move].frames[frame].time <= frameTimer) {
        frame += 1;
        if (frame >= legends[legend].moves[move].frames.length) {
          move = -1;
          frame = 0;
          frameTimer = 0;
        }
      }
    }
  }
  void render() {
    imageMode(CENTER);
    image(getFrame(), pos.x, pos.y);
  }

  private PImage getFrame() {
    if (move != -1) {
      return legends[legend].moves[move].frames[frame].frameImage;
    }
    if (!stunned) {
      return legends[legend].idleFrames[frame].frameImage;
    }
    return legends[legend].idleFrames[frame].frameImage;
  }

  boolean leftPressed = false;
  boolean rightPressed = false;
  boolean jumpPressed = false;
  int direction = 0;



  void handleCollision(float x1, float y1, float x2, float y2) {//top left and bottom right corners
    float px1 = pos.x-32;
    float px2 = pos.x+32;
    float py1 = pos.y-32;
    float py2 = pos.y+32;
    float pvx1 = pos.x-32+vel.x;
    float pvx2 = pos.x+32+vel.x;
    float pvy1 = pos.y-32+vel.y;
    float pvy2 = pos.y+32+vel.y;
    
    if (px2>=x1 && px1<=x2) {
      if (py2<=y1 && pvy2>=y1) {
        pos.y=y1-32;
        vel.y=0;
        grounded = true;
      }
    }
    if (py2>=y1 && py1<=y2) {
      if (px2<=x1 && pvx2>=x1) {
        pos.x=x1-32;
        vel.x=0;
      }
    }
    
    if (px2>=x1 && px1<=x2) {
      if (py2<=y1 && pvy2>=y1) {
        pos.y=y1-32;
        vel.y=0;
        grounded = true;
      }
    }
    if (py2>=y1 && py1<=y2) {
      if (px2<=x1 && pvx2>=x1) {
        pos.x=x1-32;
        vel.x=0;
      }
    }
    //right
    //left
    //up
    //down
  }


  void updatePosition() {



    if (Input.keyDown(keys[0])) {
      if (!leftPressed || direction == 0 || !rightPressed) {

        direction = -1;
      }
      leftPressed = true;
    } else {
      leftPressed = false;
    }
    if (Input.keyDown(keys[1])) {
      if (!rightPressed || direction == 0 || !leftPressed) {

        direction = 1;
      }
      rightPressed = true;
    } else {
      rightPressed = false;
    }

    if (!Input.keyDown(keys[0]) && !Input.keyDown(keys[1])) {
      direction =0;
    }

    if (jumps > 0 && Input.keyPressed(keys[2])) {
      jumps -=1;
      vel.y = -5;
    }
    vel.x=direction * 4;

    vel.y += 0.1;
    grounded = false;
    handleCollision(stage.platformPosition.x - stage.platformSize.x/2, stage.platformPosition.y - stage.platformSize.y/2, 
      stage.platformPosition.x + stage.platformSize.x/2, stage.platformPosition.y + stage.platformSize.y/2
      );
    //if (
    //  pos.x>=stage.platformPosition.x - stage.platformSize.x/2 - 32 &&
    //  pos.x<=stage.platformPosition.x + stage.platformSize.x/2 + 32 //within the stages width
    //  ) {
    //  if (pos.y>=stage.platformPosition.y - stage.platformSize.y/2-32-vel.y && pos.y <= stage.platformPosition.y - stage.platformSize.y/2-32+vel.y) 
    //  {
    //    grounded = true;
    //    jumps = 3;
    //    vel.y = 0;
    //    pos.y = stage.platformPosition.y - stage.platformSize.y/2-32;
    //  }
    //}

    //if (pos.y>stage.platformPosition.y - stage.platformSize.y/2-32 && pos.y<stage.platformPosition.y + stage.platformSize.y/2+32) {
    //  if (vel.x > 0 && pos.x>=stage.platformPosition.x - stage.platformSize.x/2-32 && pos.x <= stage.platformPosition.x - stage.platformSize.x/2-30) {
    //    vel.x = 0;
    //  }

    //  if (vel.x < 0 && pos.x<=stage.platformPosition.x + stage.platformSize.x/2+32 && pos.x >= stage.platformPosition.x + stage.platformSize.x/2+30) {
    //    vel.x = 0;
    //  }
    //}
    pos.x += vel.x;
    pos.y += vel.y;
  }
}
