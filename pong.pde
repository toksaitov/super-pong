/*
  Игра Pong
 */

// Ball

final int BALL_SIZE = 30;
final int BALL_HALF_SIZE = BALL_SIZE / 2;

int ballX;
int ballY;
int ballDX = 5;
int ballDY = 5;

// Paddles

final int PADDLES_WIDTH = 30;
final int PADDLES_HEIGHT = 120;
final int PADDLES_HALF_WIDTH = PADDLES_WIDTH / 2;
final int PADDLES_HALF_HEIGHT = PADDLES_HEIGHT / 2;

int leftPaddleX;
int leftPaddleY;
int leftPaddleDY = 5;

int rightPaddleX;
int rightPaddleY;
int rightPaddleDY = 5;

// Score

final int SCORE_TEXT_SIZE = 150;
final int SCORE_MARGIN_TOP = 100;
final int SCORE_MARGIN_SIDE = 200;

int leftPlayerScore = 0;
int rightPlayerScore = 0;

void setup() {
  fullScreen();
  background(0);
  noStroke();
  rectMode(CENTER);
  
  // Ball
  
  ballX = width / 2;
  ballY = height / 2;
  
  // Paddle
  
  leftPaddleX = PADDLES_HALF_WIDTH;
  rightPaddleX = width - PADDLES_HALF_WIDTH;
  leftPaddleY = rightPaddleY = height / 2;
}

void draw() {
  background(0);
  
  // Ball

  fill(255);
  rect(ballX, ballY, BALL_SIZE, BALL_SIZE);

  ballX += ballDX;
  ballY += ballDY;

  if (ballX - BALL_HALF_SIZE >= width) {
    leftPlayerScore++;
    ballX = width / 2;
    ballY = height / 2;
    ballDX *= -1;
  }
  if (ballX + BALL_HALF_SIZE < 0) {
    rightPlayerScore++;
    ballX = width / 2;
    ballY = height / 2;
    ballDX *= -1;
  }
  if (ballY + BALL_HALF_SIZE >= height || ballY - BALL_HALF_SIZE < 0) {
    ballDY *= -1;
  }
  
  // Paddles
  
  rect(leftPaddleX, leftPaddleY, PADDLES_WIDTH, PADDLES_HEIGHT);
  rect(rightPaddleX, rightPaddleY, PADDLES_WIDTH, PADDLES_HEIGHT);
  
  if (keyPressed) {
    if (keyCode == UP) {
      leftPaddleY -= leftPaddleDY;
      rightPaddleY -= rightPaddleDY;
    } else if (keyCode == DOWN) {
      leftPaddleY += leftPaddleDY;
      rightPaddleY += rightPaddleDY;
    }
    leftPaddleY = constrain(leftPaddleY, PADDLES_HALF_HEIGHT, height - PADDLES_HALF_HEIGHT);
    rightPaddleY = constrain(rightPaddleY, PADDLES_HALF_HEIGHT, height - PADDLES_HALF_HEIGHT);
  }

  // Collision Detection

  if (abs(ballX - leftPaddleX) < BALL_HALF_SIZE + PADDLES_HALF_WIDTH &&
      abs(ballY - leftPaddleY) < BALL_HALF_SIZE + PADDLES_HALF_HEIGHT ||
      abs(ballX - rightPaddleX) < BALL_HALF_SIZE + PADDLES_HALF_WIDTH &&
      abs(ballY - rightPaddleY) < BALL_HALF_SIZE + PADDLES_HALF_HEIGHT) {
    ballDX *= -1;
  }

  // Score

  textSize(SCORE_TEXT_SIZE);
  textAlign(CENTER, CENTER);
  text(leftPlayerScore, SCORE_MARGIN_SIDE, SCORE_MARGIN_TOP);
  text(rightPlayerScore, width - SCORE_MARGIN_SIDE, SCORE_MARGIN_TOP);
}
