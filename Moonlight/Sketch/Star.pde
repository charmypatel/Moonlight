//Create a "Star" class
class Star {
  
// Variables specify the x and y of each star,z variable will be used in a formula to modify the stars position
  float x;
  float y;
  float z;

// pz variable stores the previous value of the z variable 
// py stores previous frame of the z variable
  float pz;
  float py;

  Star() {
//x&y places values in the variables
//(Note: height and width are the same: the canvas is a square)
//The z value can't exceed the width/2 & height/2 value because "z" is used as divisor of the "x" and "y", whose values are also between "0" and "width/2"
//pz=z : sets the previous position of "z" in the same position of "z", stars are not moving during the first frame.
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    z = random(width/2);
    pz = z;
    py = y;
  }

  void update() {
    
//Here you take the variable z and divide it to get the new x,y coordinates of the star, the speed value is bigger = z decreases, when the "z" and “y” value equals  1
//The stars have passed the screen frame, you can place it on more time in the canvas, with new x, y and z values.
//This way we also avoid a potential division by 0.
   
    z = z - speed;
    y = y - fly;
    
  if (z < 1) {
      z = width/2;
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      pz = z;
      
      if (y < 1) {
      z = width/2;
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      py = y;
    }
  }
}

  void show() {
    
  float temp= random(0, 100);
   
//If the speed of the stars is less than 50 then we display random colors for the stars with no outline which is the noStroke
   if (temp > 50 )
       
    fill(random(0,255), random(0,255), random(0,255));
   else 
     
      fill(random(0,255), random(0,255), random(0,255));
      noStroke();

//Map will give new star positions by x/z
//This makes sure the new coordinates "sx" and "sy" move faster at each frame
// and which they finish their travel outside of the canvas (they finish when "z" is less than a).

    float sx = map(x / z, 0, 1, 0, width/2);
    float sy = map(y / z, 0, 1, 0, height/2);

//Map increases the stars size between a range from 0 to 16 and divides width of the star by 2 
    float r = map(z, 0, width/2, 16, 0);
    ellipse(sx, sy, r, r);

//Use the "pz" valute to get the previous position of the stars,to draw a line from the previous position to the new (current) one.
    float px = map(x / pz, 0, 1, 0, width/2);
    float py = map(y / pz, 0, 1, 0, height/2);

    pz = z;

    stroke(255);
    line(px, py, sx, sy);

  }
}
