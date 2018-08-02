String move1 = "";
String move2 = "";
String[] word1 = {"slime", "explosion", "plant", "zero gravity", "hurricane", "stretchy", 
"electricity", "fog", "shake", "dream", "mountain", "statue", "slide", "bloom",
"drill", "fire", "machine", "rubberband", "string", "steam", "the internet", 
"origami", "mirror", "water droplet", "ghost", "melting", "undulate", "frozen", 
"push", "breeze", "flick", "twist", "swing"};
String[] word2 = {"low-level", "mid-level", "high-level", "with a half turn", 
"with a full turn", "while jumping: one leg to the other", "while jumping: two legs", 
"lead with: elbow", "lead with: head", "lead with: hips", "lead with: shoulder", 
"lead with: toes", "isolate: arms", "isolate: legs", "isolate: shoulders", "in slow-motion"};

int Word1;
int Word2;
int state, counter;
PFont Bold;
int startX, startY;
int freeX, freeY;     // Position of free button
int lightX, lightY;   // Position of light button
int closeX, closeY;
int startSizeX = 200;
int startSizeY = 75;
int freeSizeX = 300;  //size of button
int freeSizeY = 80;   //size of button
int lightSizeX = 330; //size of button
int lightSizeY = 75; //size of button
int closeSizeX = 50;
int closeSizeY = 68;

color baseColor;
color highlightColor;
boolean startOver = false;
boolean freeOver = false;
boolean lightOver = false;
boolean closeOver = false;
float timer;

int numFrames = 4;
int currentFrame = 0;
PImage[] startgif = new PImage[4];

PImage startscreen;
PImage menu;
PImage play;
PImage thanks;
PImage logo;
void setup () {
  fullScreen();
  frameRate(24);
  colorMode(RGB);
  background(200, 255, 255);
  Bold = createFont("Museo500-Italic.otf", 72);  
  counter = 0;
  state = 0;
  baseColor = color(13, 255, 218);
  highlightColor = color(187, 23, 255);  
  startX = width/2-80;
  startY = 750-startSizeY;
  lightX = 400+lightSizeX/2;
  lightY = 730;
  freeX = width/2-freeSizeX+150;
  freeY = height/2-freeSizeY+145;
  closeX = width-100;
  closeY = 70;  
  ellipseMode(CENTER);  
  startgif[0] = loadImage("img/dancible_slow_1.gif");
  startgif[1] = loadImage("img/dancible_slow_2.gif");
  startgif[2] = loadImage("img/dancible_slow_3.gif");
  startgif[3] = loadImage("img/dancible_slow_4.gif");  
  startscreen = loadImage("img/splash_screen.png");
  menu = loadImage("img/mode_select.png");
  play = loadImage("img/divider.png");
  thanks = loadImage("img/thankyou.png");
  logo = loadImage("img/logo.png");
}
void draw(){  
  if(state == 2) {
  timer = map(counter, 0, 1000, 0, 350);
  fill(baseColor);
  noStroke();
  rect(0, 129, timer, 31);
  }else if(state == 3) {
  timer = map(counter, 0, 300, 0, 350);
  fill(baseColor);
  noStroke();
  rect(0, 129, timer, 31);
  }
  update(mouseX, mouseY);  
  //State 0
  if (state == 0){
    startscreen();
  }
  if (state > 1){
   counter ++;   
  }  
  //State 1
  if (state == 1){
    menu();
  }  
  //State 2
  if ((counter == 1) && (state == 2)){
   freestyle();    
  }
  //increase counter to speed up/slowdown
  if ((state == 2) && (counter == 1000)){
  counter = 0;
  }   
  //State 3
  if ((counter == 1) && (state == 3)){
   lightning(); 
  }
  //increase counter to speed up/slowdown
  if ((state == 3) && (counter == 300)){
  counter = 0;
  }   
  if (state == 4) {
    thanks();
  }  
  if ((state == 4) && (counter == 100)){
  state = 0;
  counter = 0;
  }  
  /////////////
  //quit button
  /////////////
  if (closeOver) {
    fill(highlightColor);
  } else {
    fill(baseColor);
  }
  if ((state > 0) && (state < 4)){
  text("X", closeX, closeY, closeSizeX, closeSizeY); 
  }  
  if ((closeOver) && (mousePressed)) {
   state = 4; 
   counter = 0;
  } 
}
////////////
//game menus
////////////
void startscreen() {  
  frameRate(8);
  startscreen.resize(0, height);
  startgif[0].resize(0, height);
  startgif[1].resize(0, height);
  startgif[2].resize(0, height);
  startgif[3].resize(0, height);  
  currentFrame = (currentFrame+1) % numFrames;  // Use % to cycle through frames
  int offset = 0;  
  image(startscreen, -50, 0);
  if (startOver) {
    for (int x = -100; x < width; x += startgif[0].width) { 
    image(startgif[(currentFrame+offset) % numFrames], -50, 0);
    offset+=2;    
  }
  }
  if ((startOver) && (mousePressed)) {
   state = 1; 
  }
}
void menu() {
  frameRate(60);
  background(200, 255, 255);
  image(menu, -250, -100);
  textFont(Bold);
  textSize(34);
  fill(highlightColor);
  textAlign(LEFT);
  text("Dance it out!", freeX, freeY+80, freeSizeX, freeSizeY);
  text("Think on your feet!", lightX, lightY+80, lightSizeX, lightSizeY);  
  textSize(25);
  fill(baseColor);
  text("How to Play", 50, 590, 200, 100);
  fill(highlightColor);
  textLeading(32);
  text("These words are dancible.\nDance like the word on the top.\nModify with the word(s) on the bottom.\nWatch for when the prompts change!\nThere's no wrong or right way to move.", 50, 625, 600, 800);  
////////////
//menu buttons
////////////
  if (freeOver) {
    fill(highlightColor);
  } else {
    fill(baseColor);
  }  
  if ((freeOver) && (mousePressed)) {
   state = 2; 
  }
  textSize(72);
  //freestyle menu button
  text("Freestyle", freeX, freeY, freeSizeX, freeSizeY); 
  if (lightOver) {
    fill(highlightColor);
  } else {
    fill(baseColor);
  }
  if ((lightOver) && (mousePressed)) {
   state = 3; 
  } 
  //lightning round menu button
  text("Lightning", lightX, lightY, lightSizeX, lightSizeY); 
}
/////////////
//quit screen
/////////////
void thanks() {
  background(0);
  thanks.resize(0, height);
  image(thanks, -50, 0);
}
////////////
//game modes
////////////
void freestyle() {
  play.resize(0, height);
  image(play, -50, 0);  
  image(logo, 0, 0);
  Word1 = int(random(word1.length));
  Word2 = int(random(word2.length));
  move1 = word1[Word1];  
  move2 = word2[Word2];   
  fill(13, 255, 218);  
  textAlign(CENTER);
  text(move1, width/2, height/3.2);
  text(move2, width/2, height/1.5 + 100);
}
void lightning() {
  play.resize(0, height);
  image(play, -50, 0);
  image(logo, 0, 0);
  Word1 = int(random(word1.length));
  Word2 = int(random(word2.length));
  move1 = word1[Word1];  
  move2 = word2[Word2]; 
  fill(13, 255, 218);
  textAlign(CENTER);
  text(move1, width/2, height/3.2);
  text(move2, width/2, height/1.5 + 100);  
}
////////////////////////
//button hover detection
////////////////////////
void update(int x, int y) {
  if (overstart(startX, startY, startSizeX, startSizeY) ) {
    startOver = true;
    closeOver = false;
    lightOver = false;
    freeOver = false;
  } else if ( overlight(lightX, lightY, lightSizeX, lightSizeY) ) {
    lightOver = true;
    freeOver = false;
    closeOver = false;
    startOver = false;
  } else if ( overfree(freeX, freeY, freeSizeX, freeSizeY) ) {
    freeOver = true;
    lightOver = false;
    closeOver = false;
    startOver = false;
  } else if ( overclose(closeX, closeY, closeSizeX, closeSizeY) ) {
    closeOver = true;
    startOver = false;
    freeOver = false;
    lightOver = false;
  } else {
    closeOver = startOver = lightOver = freeOver = false;
  }
}
boolean overstart(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
boolean overfree(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
boolean overlight(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
boolean overclose(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}