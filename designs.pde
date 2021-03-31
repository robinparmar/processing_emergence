/*
    Class to manage design equations.
    
    The first design is intended as a placeholder; we don't display it.

    Each change in design and offset is printed to the console.
    Particularly good settings can be noted. 
*/

class Designs {
    // coordinates
    float x, y;

    // initial grid offsets for each design
    int[] offsets = {0, 480, 96, 544, 128, 800, 256, 128, 224, 128, 128, 128};

    // index of current design
    int design = 0;

    // current grid offset
    int offset = offsets[design];
   
    // increment to next design
    void nextDesign() {
        design++;
        design = min(design, offsets.length-1);
        _resetOffset();      
        print("\n", design, ": ", offset, " ");
    }
    
    // decrement to previous design
    void prevDesign() {
        design--;
        design = max(design, 0);
        _resetOffset();      
        print("\n", design, ": ", offset, " ");
    }

    // decrease offset, minimum 64
    void decOffset() {
        offset -= 32;
        offset = max(64, offset);
        print(offset, " ");
    }

    // increase offset - no maximum?
    void incOffset() {
        offset += 32;
        print(offset, " ");
    }

    // reset offset to original
    void resetOffset() {
        _resetOffset();      
        print(offset, " ");
    }

    // internal reset function
    private void _resetOffset() {
        offset = offsets[design];
    }

    // checks whether we are on a design other than first
    boolean ready() {
        return design>0;
    }

    // equations for each design
    // each returns a coordinate based on the time variable
    float[] getPoint(float t) {
        t /= 1000.;
        
        switch(design) {
        case 1:
            music.play();
            x = flopper * (sin(PI * sin(PI * t)) % .5);
            y = flipper * (cos(PI * sin(t))) % .3;
            break;
        case 2:
            x = abs(sin(PI * sin(PI * t)));
            y = sin(PI * sin(PI * t));
            break;
        case 3:
            x = flopper * sin(PI * sin(PI/2 + t));
            y = flipper * cos(PI * sin(PI + t));
            break;
        case 4:
            x = flopper * (sin(PI * sin(PI * t)) % .5);
            y = flipper * cos(PI * sin(t));
            break;
        case 5:
            x = flopper * (t % 10) <.5 ? sin(PI * t) : cos(PI * t);
            y = flipper * (cos(PI * sin(t)));
            break;
        case 6: // slowly wind up/down
            x = flopper * sq(sin(PI * t));
            y = flipper * cos(t*.5) + sin(t);
            break;   
        case 7: // horizontal then oscillations
            x = flopper * sin(PI * sin(PI * t));
            y = flipper * cos(PI * sin(t));
            break;
        case 8: // diagonals
            x = flopper * sin(PI * sin(PI * t));
            y = flipper * sin(PI * sin(PI*t));
            break;
        case 9:
            x = sin(PI * sin(PI * t));
            y = flipper * sin(PI * sin(PI*t));
            break;
        case 10:
            x = sin(PI * sin(PI * t));
            y = flipper * sq(sin(PI/2 * t));
            break;
        case 11:
            x = flopper * 0.5 * tan(PI * sin(PI * t));
            y = flipper * 0.5 * tan(PI * t);
            break;
        }
        return new float[] {x, y};
    }
}
   
