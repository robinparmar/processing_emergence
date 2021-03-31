/*
	emergencePlayground

	(c) 2021 Robin Parmar. MIT License. 

	These experiments in screen division were inspired by Larry Cuba.
	Created for the music video "Emergence" by Mai.

	This sketch allows us to explore different parameter combinations.
	A second version of this sketch then facilitates playback, in order, 
	of only the desired variants. 

	You will need a sound file in the current folder.

	Use the keyboard to explore different designs:
        - =    decrease / increase cell offset
        0      reset cell offset
        [ ]    previous / next algorithm
*/

// minim is a capable sound library
import ddf.minim.*;
Minim minim;
AudioPlayer music;

// control mirroring of equations
int flipper = 1;
int flopper = 1;

// initial grid size
int boxsize = 256;

// maximum draw dimensions (larger than screen)
int xMax, yMax;

// current counter in milliseconds (ms)
int counter = 0;

// how often to render (in ms)
// chosen to (somewhat) align with the music tempo
int beat = 15; 

Designs des;

void setup() {
    // designed for high-quality screen capture
    fullScreen(1);
    frameRate(60);
    
    colorMode(HSB, 1.);
    
    // we increment past screen size to avoid black borders during oscillation
    xMax = width  + 2*boxsize;
    yMax = height + 2*boxsize;
    
    des = new Designs();
    
    // initialise music...
    minim = new Minim(this);
    music = minim.loadFile("music.mp3");
}

void draw() {
    fader(2);
    
    if (des.ready()) {
        if (millis() - counter > beat) {
            counter = millis();
            render();
        }
    }
}
    
// draw the results of our design in each grid cell
void render() {
    float[] coord;
    color k = color(0.1 * random(0, 2 ), 1., 1., .6);

	// grid of variable size
    for (int x=0; x<xMax; x+=des.offset) {
        for (int y=0; y<yMax; y+=des.offset) {
            pushMatrix();
            	// we start offscreen to avoid black borders
    		    translate(x-boxsize, y-boxsize);
    
                coord = des.getPoint(millis());
                
                bubble(coord[0] * boxsize, coord[1] * boxsize, 10, k);
            popMatrix();
            
            flipper = -1 * flipper;
        }
        flopper = -1 * flopper;
    }
}

// clean up audio when sketch is terminated
void stop() {
    music.close();
    minim.stop();
    super.stop();
}
