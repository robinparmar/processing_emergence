/*
	utility functions
*/

// interface
void keyPressed() {
    switch (key) {
    case ' ':
    case ']':
        des.nextDesign();
        break;
    case '[':
        des.prevDesign();
        break;
    case '-':
        des.decOffset();
        break;
    case '=':
        des.incOffset();
        break;
    case '0':
        des.resetOffset();
        break;
    case 'q':
        exit();
        break;
    } 
}

// create a circle with diffuse border
void bubble(float x, float y, int d, color colour) {
    color k;
    int thick = 10;

    pushStyle();

    // basic circle
    fill(colour);
    noStroke();        
    strokeWeight(0.);
    circle(x, y, d);

	// extract components to make border
    float h = hue(colour);
    float s = saturation(colour);
    float b = brightness(colour);
    float a = alpha(colour); 

    noFill();
    strokeWeight(1.8);

	// decrease opacity each time through the loop
    for (float i=0; i<thick; i++) {
        k = color(h, s, b, map(i, 0, thick, a, 0.));
        stroke(k);
        circle(x, y, d + i);
    }

    popStyle();
}

// provides a motion trail by fading image
void fader(float amount) {
    pushStyle();   
        if (amount==0) {
            background(0);
        } else {
            fill(0, .1 * amount);
            noStroke();
            rect(0, 0, width, height);
        }
    popStyle();
}
