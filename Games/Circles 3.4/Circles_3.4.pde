import processing.sound.*;

PFont fontMain;
PFont fontSub;

SoundFile bgm;
SoundFile BGM1;
SoundFile BGM2;
SoundFile BGM3;
FFT fft1;
FFT fft2;
int bands1 = 32;
int bands2 = 16;
// Define how many FFT bands to use
float smoothingFactor = 0.02;
float smoothingFactor2 = 0.01;
float[] sum1 = new float[bands1];
float[] sum2 = new float[bands2];
float scale = 1.2;
// scale factor
float barWidth1;
float barWidth2;
// drawing variable

int a = 0;
int b = 0;
int c = 0;
int d = 0;
int e = 0;
// general scoring system
int i = 0;
// endless scoring system

int f = 0;
// number of combo

int g = 0;
// height of health

int h = 0;
// lenth of health

int p = 0;
// page #

boolean m = false;
// no fail mode

boolean n = false;
// state of the bgm

boolean w = false;
// state of the game

boolean z = false;
// endless mode

float x = random(100, 540);
float y = random(100, 240);
// target circle location
final static String TITLE = "Circles 3.4";
// window title

int o;
// opportunities to miss the circles in Endless mode
boolean k = false;
// hard mode
int u;
// number of circles being clicked (will be clear to "0" each "80")
int number;
// # on the circle in hard mode

boolean keyState = true;
// check if key can be pressed

float duration;
// duration of circle in hard mode





void setup() {
  
   size(640, 480);
   frameRate(100);
   changeAppTitle(TITLE);
   fontMain = createFont("Georgia.ttf",40);
   fontSub = createFont("Verdana",40);
   barWidth1 = width/float(bands1);
   barWidth2 = width/float(bands2);
   BGM1 = new SoundFile(this, "BGM1.wav");
   BGM2 = new SoundFile(this, "BGM2.wav");
   BGM3 = new SoundFile(this, "BGM3.wav");
   bgm = new SoundFile(this, "CLEAR.wav");
   bgm.loop();
   fft1 = new FFT(this, bands1);
   fft2 = new FFT(this, bands2);
   
   while (h < width/2) {   
      h += width/200;
      g = height/16;
   }

}

void changeAppTitle(String title) {
  surface.setTitle(title);
}

void BgmFFT() {
      fft1.input(bgm);
      fill(255);
      stroke(2);
      fft1.analyze();
      for (int song1 = 0; song1 < bands1; song1++) {
        sum1[song1] += (fft1.spectrum[song1] - sum1[song1]) * smoothingFactor;
        rect(song1*barWidth1, height, barWidth1, -sum1[song1]*height*scale);
        scale = 1.0;
      }
}
void BgmTITLE() {
      fft2.input(bgm);
      fill(255,100);
      stroke(2);
      fft2.analyze();
      for (int song2 = 0; song2 < bands2; song2++) {
        sum2[song2] += (fft2.spectrum[song2] - sum2[song2]) * smoothingFactor2;
          rect(song2*barWidth2, height, barWidth2, -sum2[song2]*height*scale);
          scale = 0.5;
      }
      
}

void draw() {
   noStroke();
   if (h <= 0) {
      h = 1;
   }

   if (h > width/2) {
      h = width/2;
   }

   if (h <= 1 && h != 4 ){
     
      if (m == false) { 
         p = 2;
         h = width/2;
      }

   }

   //Placement of crosshair

   smooth();
   background(20);

   textAlign(CENTER);

   if (p == 0){
      textFont(fontMain);
      if (k == false){
         fill(255);
      }
      if (k == true){
         fill(#c42400);
         text("HARD MODE",width/4.5,50);
      }
      fill(255);
      textSize(width/8);
      text("CIRCLES",width/2,height/3);
      textSize(width/30);
      text("Tip: Press [X] or [Z] or mouse buttons to click.",width/2,height/1.2);
      text("Press [G] to get advance infromation and tutorial.",width/2,height/1.1);
      f = 0;
      a = 0;
      b = 0;
      c = 0;
      d = 0;
      e = 0;
      if (k == false){
        o = 5;
      }
      if (k == true){
        o = 3;
      }
      i = 0;
      
      if (z == true){
           textSize(width/18);
           fill(112,230,69);
           text("ENDLESS",width/2,height/2.4);
      }
      
      if (z == false){
        if (m == true){
           textSize(width/18);
           fill(112,230,69);
           text("NO FAIL",width/2,height/2.4);
        }
      }
      noStroke();
      noCursor();
      fill(255,125,218);
      ellipse(mouseX, mouseY, 30, 30);
      fill(255);
      ellipse(mouseX, mouseY, 24, 24);

      BgmTITLE();
   }

   

   if (p == 2){
      if (z == false){
        textFont(fontMain);
        textSize(width/12);
        text("YOU FAILED!",width/2,height/3);
        textAlign(LEFT);
        textFont(fontSub);
        textSize(40);
        text(a, 550, 45);
        text(0, 575, 45);
        text(0, 600, 45);
        text(b, 525, 45);
        text(c, 500, 45);
        text(d, 475, 45);
        text(e, 450, 45);
        textSize(45);
        text(f + "x", 20, 460);

        
      }
      else{
      p = 1;
      }
      noCursor();
      fill(255,125,218);
      ellipse(mouseX, mouseY, 30, 30);
      fill(255);
      ellipse(mouseX, mouseY, 24, 24);
   }

   if (p == 3){
      if (z == false){
        textFont(fontMain);
        textSize(width/12);
        fill(255);
        text("Million Master!",width/2,height/3);
        textSize(width/30);
        if (k == false){
           text("Try to press [C] for hard mode",width/2,height/1.1);
        }
        
      
      
        if (m == true){
           textSize(width/18);
           fill(112,230,69);
           text("NO FAIL",width/2,height/2.4);
        }
      
      
        if (f == 264){
           textSize(width/18);
           fill(112,230,69);
           text("FULL COMBO!",width/2,height/1.8);
        }
        
        textAlign(LEFT);
        fill(255);
        textFont(fontSub);
        textSize(40);
        text(a, 550, 45);
        text(0, 575, 45);
        text(0, 600, 45);
        text(b, 525, 45);
        text(c, 500, 45);
        text(d, 475, 45);
        text(e, 450, 45);
        textSize(45);
        text(f + "x", 20, 460);
      }
      else{
      p = 1;
      }
      noCursor();
      fill(255,125,218);
      ellipse(mouseX, mouseY, 30, 30);
      fill(255);
      ellipse(mouseX, mouseY, 24, 24);
   }

   if (p == 4){
      textFont(fontMain);
      fill(20);
      rect(width/2.5,height/2.2,110,50);
      fill(255);
      textSize(width/25);
      text("TITLE",width/2,height/2);
      textSize(width/8);

      

      text("PAUSED",width/2,height/3);
      textSize(width/30);
      text("You can press 4 to reset.",width/2,height/1.1);
      text("Tip: To setup a audio, Press the number keys 1, 2 or 3,",width/2,height/1.2);
      
      if (z == true){
           textSize(width/18);
           fill(112,230,69);
           text("ENDLESS",width/2,height/2.4);
      }
      
      if (z == false){
        if (m == true){
           textSize(width/18);
           fill(112,230,69);
           text("NO FAIL",width/2,height/2.4);
        }
      }
      
      noCursor();
      fill(255,125,218);
      ellipse(mouseX, mouseY, 30, 30);
      fill(255);
      ellipse(mouseX, mouseY, 24, 24);
   }

   if (p == 5){
      textFont(fontMain);
      fill(255);
      textSize(width/8);
      noStroke();
      
      text("CIRCLES",width/2,height/5);
      textSize(width/30);
      text("Copyright © Tianyu Li @GamingFrankie",width/2,height/3.8);
      text("Welcome to Circles, press [H] to start the game.",width/2,height/3);
      text("While playing, press [H] or [Esc] to pause and resume.",width/2,height/3 + 30);
      text("Press [X] for 1, press [Z] for 2 in the hard mode.",width/2,height/3 + 60);
      text("While on the title page, press [M] to turn on [no fail] mode,",width/2,height/3 + 90);
      text("Same to above, [Z] for [Endless] mode.",width/2,height/3 + 120);
      text("Press [G] on the title page if you have concerns.",width/2,height/3 + 150);
      text("[BGM1/2/3.wav] is the name the wav audio.",width/2,height/3 + 180);
      text("To open the music player, press [S].",width/2,height/3 + 210);
      text("A million points is the goal. Good luck and have fun!",width/2,height/3 + 240);
      
      text("Version 3.4, Standard.",width/2,height/3 + 280);
   }

   if (p == 6){
      textFont(fontMain);
      fill(20);
      rect(width/2.5,height/2.2,110,50);
      fill(255);
      textSize(width/25);
      text("TITLE",width/2,height/2);
      textSize(width/8);

      

      text("GAME OVER",width/2,height/3);
      textSize(width/30);
      
      if (z == true){
           textSize(width/18);
           fill(112,230,69);
           text("ENDLESS",width/2,height/2.4);
      }
      
      noStroke();
      noCursor();
      fill(255,125,218);
      ellipse(mouseX, mouseY, 30, 30);
      fill(255);
      ellipse(mouseX, mouseY, 24, 24);
   }

   
   if (p == 7){
      background(20);
      textSize(width/16);
      text("PLAYER",width/1.2,height/5);

      BgmFFT();
      noStroke();
      noCursor();
      fill(255,125,218);
      ellipse(mouseX, mouseY, 30, 30);
      fill(255);
      ellipse(mouseX, mouseY, 24, 24);
   }
   
   
   
   if (h <= 1){
     
      if (m == true) { 
         h = 2; 
      }

   }

   if (p == 1){
     
     if (i >= 1000000000){
     i = 1000000000;
     textFont(fontMain);
     textSize(45);
     fill(112,230,69);
     text("Maximum!", width/2, 50);
     }
     
     if (z == false){

        if (m == false) {
           h -= 10/10.99999888888;
        }

        if (m == true) {
        
           if (h >= 2){
              h -= 10/10.99999888888;
           }

        }

        //targets

        noStroke();

        ellipse(x, y, 68, 68);
        fill(71,77,255);
        ellipse(x, y, 60, 60);
        fill(255);

        if(e != 1) {

           if(a >= 10) {
              a -= 10;
              b += 1;
           }

           if(b >= 10) {
              b -= 10;
              c += 1;
           }

           if(c >= 10) {
              c -= 10;
              d += 1;
           }

           if(d >= 10) {
              a = 0;
              b = 0;
              c = 0;
              d = 0;
              e += 1;
           }

        }

        else {
           p = 3;
        }
        
      }

      

      //targets

      noStroke();
      noCursor();
      fill(255);
      ellipse(x, y, 68, 68);
      fill(71,77,255);
      ellipse(x, y, 60, 60);
      if (k == true){
        if (p == 1){
          duration -= 1.6;
        }
        fill(255);
        if (z != true){
            rect(480,430,duration / 5, 20);
        }
        if (duration <= 0){
            x = random(100, 540);
            y = random(100, 240);

            ellipse(x, y, 68, 68);
            fill(71,77,255);
            ellipse(x, y, 60, 60);
            fill(255);
            f = 0;
            h += 100;
            duration = width / 2;
            }
        if ((u / 2 == (double)u / 2 || u / 3 == (double)u / 3) && (u / 4 == (double)u / 4 || u / 5 == (double)u / 5) || f == 0){
          number = 1;
          textFont(fontMain);
          fill(255);
          text(number,x,y + 10);
        }
        else{
          number = 2;
          textFont(fontMain);
          fill(255);
          text(number,x,y + 10);
        }
        
        if (u == 80){
          u = 0;
        }
      }


      
      if (z == false){
        textAlign(LEFT);
        fill(255);
        textFont(fontSub);
        textSize(40);
        text(a, 550, 45);
        text(0, 575, 45);
        text(0, 600, 45);
        text(b, 525, 45);
        text(c, 500, 45);
        text(d, 475, 45);
        text(e, 450, 45);
      
        textSize(45);
        text(f + "x", 20, 460);
        //each number is 25 lenth
        g = 18;
        stroke(2);
        fill(#a8a6a5);
        rect(0,23,width/1.8,g);
        g = 10;
        noStroke();
        fill(20);
        rect(20,27,width/2,g);
      
        if (h > width/3.8){
           fill(255);
        }
      
        if (h <= width/3.8){
           fill(#c42400);
        }
      
        if (h <= width/7.4){
           fill(#474747);
        }

        rect(20,27,h,g);
      }
      if (z == true){
        textAlign(LEFT);
        fill(255);
        textFont(fontSub);
        textSize(45);
        text(f + "x", 20, 460);
        textSize(40);
        text(i,20,50);
        if (o >= 6 && o != 7){
          textAlign(RIGHT);
          textFont(fontMain);
          textSize(45);
          fill(255);
          text(o, 400, 460);
          
          textSize(30);
          textFont(fontMain);
          text(" CIRCLES", 600, 460);
        }
        if (o == 7){
          textAlign(RIGHT);
          textFont(fontMain);
          textSize(45);
          fill(255);
          text(o, 400, 455);
          
          textSize(30);
          textFont(fontMain);
          text(" CIRCLES", 600, 460);
        }
        if (o >= 4 && o < 6){
          textAlign(RIGHT);
          textFont(fontMain);
          textSize(45);
          fill(255);
          text(o, 400, 455);
          
          textSize(30);
          textFont(fontMain);
          text(" CIRCLES", 600, 460);
        }
        if (o == 3){
          textAlign(RIGHT);
          textFont(fontMain);
          textSize(45);
          fill(#c42400);
          text(o, 400, 455);
          
          textSize(30);
          textFont(fontMain);
          text(" CIRCLES", 600, 460);
        } 
        if (o == 2){
          textAlign(RIGHT);
          textFont(fontMain);
          textSize(45);
          fill(#c42400);
          text(o, 400, 458);
          
          textSize(30);
          textFont(fontMain);
          text(" CIECLES", 600, 460);
        } 
        if (o == 1){
          textAlign(RIGHT);
          textFont(fontMain);
          textSize(45);
          fill(#474747);
          text(o, 400, 458);
          
          textSize(30);
          textFont(fontMain);
          text(" CIRCLE", 600, 460);
        }
        if (o == 0){
          p = 6;
        }
        
      }
      fill(255,125,218);
      ellipse(mouseX, mouseY, 30, 30);
      fill(255);
      ellipse(mouseX, mouseY, 24, 24);
   }

}

void mousePressed(){

   if (p == 4 || p == 6){
     
      if (mouseX <= width/2.5 + 120 && mouseX >= width/2.5 && mouseY <= height/2.2 + 50 && mouseY >= height/2.2){
         p = 0;
         a = 0;
         b = 0;
         c = 0;
         d = 0;
         e = 0;
         h = width/2;
      }

   }

   if (p == 1){
     
    if(k == false){
       
      if (mouseButton == LEFT || mouseButton == RIGHT) {

         if (mouseX >= x - 28 && mouseX <= x + 28 && mouseY >= y - 28 && mouseY <= y + 28) {
            if (o < 8){
              if (f == 80){
                  o += 1;
              } 
              if (f == 120){
                  o += 2;
              }  
            }
            x = random(100, 540);
            y = random(100, 240);
            
            ellipse(x, y, 68, 68);
            fill(71,77,255);
            ellipse(x, y, 60, 60);
            fill(255);
            
            u += 1;
            
            if (f <= 20){
               a += 5;
               i += 500;
            }

            if (f > 20 && f <= 80){
               b += 1;
               a += 5;
               i += 1500;
            }

            if (f > 80 && f <= 120){
               b += 2; 
               a += 5;
               i += 2500;
            }

            if (f > 120 && f <= 150){
               b += 4;
               i += 4000;
            }
            
            if (f > 150){
               b += 6;
               i += 6000;
            }

            f += 1;
            h += 120;
            

         }

         else {
            h -= 50;
            if (m == false){
               f = 0;
            }
            if (z == true){
               o -= 1;
            }
        
         }

      }
      
     }
     
   }

}



void keyPressed(){
      if (key == 27 && p == 0) {
          key = 0;
      
      }
      if (key == 27 && p != 0) {
          key = 0;
          p = 4;
      
      }
      if (keyCode == 'H' && p == 4){
        p = 0;
      }

   
      if (keyState == true && (key == 'C' || key == 'c')){
        if (p == 0){
          keyState = false;
           if (k == false){
              k = true;
           }
           else{
              k = false;
           }
        }
      }
      if (keyState == true && (key == 'S' || key == 's')){
        if (p == 0){
          keyState = false;
          p = 7;
           
        }
        else{
          p = 0;
        }
      }

      if (keyState == true && (key == 'G' || key == 'g')) {
         keyState = false;

         if (p == 0){
            p = 5;
         }

         else if (p == 5){
            p = 0;
         }

      }

      if (p != 1){

         if (key == '1' && n == false){
            n = true;
            bgm = BGM1;
            println(bgm.channels());
            bgm.loop();
         }

         if (key == '2' && n == false){
            n = true;
            bgm = BGM2;
            println(bgm.channels());
            bgm.loop();
         }
         
         if (key == '3' && n == false){
            n = true;
            bgm = BGM3;
            println(bgm.channels());
            bgm.loop();
         }

         if (key == '4' && n == true){
            n = false;
            bgm.stop();
            bgm = new SoundFile(this, "CLEAR.wav");
            bgm.loop();
            println(bgm.channels());
         }
      }
  

      if (keyState == true && (key == 'h' || key == 'H')){
        keyState = false;

         if (p == 0){
            w = false;
            p = 1;
         }

         else if (p == 1){
            w = true;
         }

         if (p == 3 || p == 2){
            p = 0;
            w = false;
         }

         if (w == true) {

            if (p == 4){
               p = 1;
            }

            else if (p ==1){
               p = 4;
            }

         }

      }

      if (p == 0) {

         if(keyState == true && (key == 'M' || key == 'm')){
           keyState = false;

            if (m == false){
               m = true;
            }

            else{
               m = false;
            }

         }
         
         if (keyState == true && (key == 'z' || key == 'Z')){
           keyState = false;
            if (z == false){
               z = true;
            }
            else{
               z = false;
            }
         }

      }

      if (p == 1) {

         if (keyState == true && (key == 'z' || key == 'Z' || key == 'x' || key == 'X')) {
            keyState = false;

            if (mouseX >= x - 28 && mouseX <= x + 28 && mouseY >= y - 28 && mouseY <= y + 28) {
               if (k == true){
                 if ((key == 'X' || key == 'x') && number == 1){
                   x = random(100, 540);
                   y = random(100, 240);

                   ellipse(x, y, 68, 68);
                   fill(71,77,255);
                   ellipse(x, y, 60, 60);
                   fill(255);
                   f += 1;
                   h += 120;
               
                   u += 1;
                   duration = width / 2;
                   
                  if (f <= 20){
                     a += 5;
                     i += 500;
                  }

                  if (f > 20 && f <= 80){
                     b += 1;
                     a += 5;
                     i += 1500;
                  }

                  if (f > 80 && f <= 120){
                     b += 2; 
                     a += 5;
                     i += 2500;
                  }

                  if (f > 120 && f <= 150){
                     b += 4;
                     i += 4000;
                  }
            
                  if (f > 150){
                     b += 6;
                     i += 6000;
                  }
                 }
                 if ((key == 'Z' || key == 'z') && number == 2){
                   x = random(100, 540);
                   y = random(100, 240);

                   ellipse(x, y, 68, 68);
                   fill(71,77,255);
                   ellipse(x, y, 60, 60);
                   fill(255);
                   f += 1;
                   h += 120;
               
                   u += 1;
                   duration = width / 2;
                   
                  if (f <= 20){
                     a += 5;
                     i += 500;
                  }

                  if (f > 20 && f <= 80){
                     b += 1;
                     a += 5;
                     i += 1500;
                  }

                  if (f > 80 && f <= 120){
                     b += 2; 
                     a += 5;
                     i += 2500;
                  }

                  if (f > 120 && f <= 150){
                     b += 4;
                     i += 4000;
                  }
            
                  if (f > 150){
                     b += 6;
                     i += 6000;
                  }
                 }
                 else{
                   h -= 50;
                 }
                 
               }
               if (k == false){
                  x = random(100, 540);
                  y = random(100, 240);

                  ellipse(x, y, 68, 68);
                  fill(71,77,255);
                  ellipse(x, y, 60, 60);
                  fill(255);
                  f += 1;
                  h += 120;
               
                  u += 1;
                 
                  if (f <= 20){
                     a += 5;
                     i += 500;
                  }

                  if (f > 20 && f <= 80){
                     b += 1;
                     a += 5;
                     i += 1500;
                  }

                  if (f > 80 && f <= 120){
                     b += 2; 
                     a += 5;
                     i += 2500;
                  }

                  if (f > 120 && f <= 150){
                     b += 4;
                     i += 4000;
                  }
            
                  if (f > 150){
                     b += 6;
                     i += 6000;
                  }
               }
               if (o < 8){
                  if (f == 80){
                      o += 1;
                  } 
                  if (f == 120){
                      o += 2;
                  }  
               }  
                        
            }

            else {
               h -= 50;
               
               if (m == false){
                  f = 0;
               }
               if (z == true){
               o -= 1;
               }
               
            }

         }    

      }  

}

void keyReleased(){
  keyState = true;
}
