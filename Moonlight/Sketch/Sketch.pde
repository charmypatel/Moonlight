//Minim is the audio library that allows us to play songs
import ddf.minim.*;


//Establishing the parameters for the audioplayer, minim, and input
AudioInput in;
Minim minim;
AudioPlayer player;

//Setting variables that will be used later for the playlist
boolean playeurInit = false;
boolean stop = true;

//Establishes the initial playlist variable and sets a filler integer for the variable current
StringList tableau;
int current=0;

//Star [250] is the amount of stars in the animation. Also declaring the variable for speed of the stars.
//Fly is implementing the variable used in the star class for the up and down movement of the stars and c is setting the color
Star[] stars = new Star[250];
float speed;
float fly;
color c;

//Float magnitude is the wave, boolean is declaring the variable for the if statement involving the wave, float stepsX up until sum are the parameters for the line movement
float magnitude;
boolean voice = false;
float stepsX, stepsY, radius, intensity, movement, last_sum, scale, factor, wave, sum;


//Set up runs everything only one time, full screen makes the screen full screen, noSmooth is for making the lines of the wave jagged
void setup() {
  fullScreen();
  noSmooth();

//Once the stars position is equal to >0 it is reset randomly back to the top of the screen, the for loop takes into account the full length of 
//the star rather than resetting it as soon as it hits the bottom of the screen
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
}  

//Bringing the minim class back in, getLinein allows us to set the bitrate(44100) and bit depth of the input volume or in this case the songs 
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048, 44100);

  minim = new Minim(this);

//Tableau is a StringList object like an expandable array, all songs used in animation are stored here
  tableau=new StringList();
  tableau.append("Am I Wrong.mp3");
  tableau.append("Coldplay - Hymn For The Weekend.mp3");
  tableau.append("Hall Of Fame.mp3");
  tableau.append("Imagine Dragons - Thunder.mp3");
  tableau.append("OneRepublic - I Lived.mp3");
  tableau.append("Shawn James- Aint No Sunshine - Bill Withers Cover.mp3");
  tableau.append("Alan Walker - Tired.mp3");
  

//A song is selected through shuffle, when the mouse is clicked the current song stops, playlist gets reshuffled, and new song is played
  shufflePlayList();
  String son = tableau.get(current++);
  println(son);
  player = minim.loadFile(son);
  player.pause();
  factor = float(width)/player.bufferSize();
}


//Draw continuously executes the lines of the code contained in its block unit the program is stopped, noCursor just makes the cursor disappear
void draw() { 
  noCursor();

//Links the value of the speed variable to the position of the mouse while linking the value of fly with the  mouses up/down positioning
  { 
    speed = map(mouseX, 0, width, 0, 20);
    fly = map(mouseY, 0, height, 0, 20);
    background(0);

//Moving the center of the screen from the top left corner to the center of the canvas
    translate(width/2, height/2);
    
//Drawing each star, running the update method to its position, stars[i].show displays it on the canvas
    for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].show();
    }
}

//Moving the center of the screen from the top left corner to the center of the canvas

  translate(-width /2, -height /2); 
  c = color(170 + wave/2, wave*5, 255, 255);
  fill(random(0, 255), random(0, 255), random(0, 255));
  stroke(random(0, 255), random(0, 255), random(0, 255));
  strokeWeight(2);
  sum = 0; 

// Creates sound waves that change in frequency and amplitude, initially makes it so the array //"i" is less than that of the songs buffer size or its bass. The "if" and "else" statements 
//lock the line on the left and right side of the screen at exactly the middle y value of the entire //screen. It brings in the factor variable just putting all of the parameters of the line 
//in one place

  for (int i = 0; i < player.bufferSize() - 1; i++)
  {
    if (voice) {
      line(i*factor, height/2 + in.left.get(i)*last_sum + 1, i*factor+1, height/2 + in.left.get(i+1)*last_sum + 2);
      sum += abs(in.left.get(i));
    } else {
      line(i*factor, height/2 + player.left.get(i)*last_sum + 1, i*factor+1, height/2 + player.left.get(i+1)*last_sum + .05);
      sum += abs(player.left.get(i));
    }
}


//Makes both wavelengths equal 
  last_sum = sum;
  {

//Randomizes the color for the moon
    fill(random(0, 255), random(0, 255), random(0, 255));

//Draws the moon shape, and noStroke gives it no outline
    ellipse(width /2, height /2, 500, 500);
    noStroke();
  }

  {
//Puts the moon the in the center, fills it the color white, and noStroke means no outline
//Next ellipse statement is for a black circle on top of the white making crescent shape
    ellipseMode(CENTER);
    fill (0);
    ellipse(width /2 -50, height /2 -50, 460, 450);
    noStroke();
  }
  {

//Makes the thickness of all lines to 2
    strokeWeight(2);
}

  if (!stop) {

    if (player.isPlaying() == false) {
      
      
//Checking if we haven't exhausted the current shuffled(random) play list
//If we have played all the songs, then re-shuffle the list
      if (current==tableau.size()-1) {
        shufflePlayList();
      }

      String son = tableau.get(current++);
      player = minim.loadFile(son);
      player.play();      
      playeurInit = true;
    }
  }
}

//If stop is true, then it changes to false. Then draw will take care of playing the next song.
//If stop is false, then it sets the stop state to true and pauses minim.
void mouseReleased() {
  if (stop == true) {
    stop = false;
  } else {
    stop = true;
    if (player.isPlaying() == true ) {
      player.pause();
    }
  }
}

//Song stops playing when mouse is pressed
void stop() {
  player.close();
  minim.stop();
  super.stop();
}

//Playlist gets reshuffled if mouse is click again
void shufflePlayList() {
  current=0;
  tableau.shuffle();
}
