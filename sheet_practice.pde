int  notes = 21;
int  dist  = 4;
char noteName[] = {'f', 'e', 'd', 'c', 'b', 'a', 'g',
                   'f', 'e', 'd', 'c', 'b', 'a', 'g',
                   'f', 'e', 'd', 'c', 'b', 'a', 'g'};
int  noteID;
int  status;  // 0:nohint 1:goodhint -1:wronghint 2:delay
int  counterAll;
int  counterGood;

void setup() {
  size(150, 150, P2D);
  background(0, 0, 0);
  textSize(16);
  status = 0;
  counterAll  = 0;
  counterGood = 0;
  newNote();
}

void draw() {
  if (status == 2) {
    delay(1000);
    status = 0;
    newNote();
  }
  
  background(0);
  stroke(255);
  text(counterGood+"/"+(counterAll-1)+"   "+
      round((float)(counterGood+1.0)/(float)counterAll*100)+"%",
      20, height - 2);
  
  // draw lines
  for (int i=0; i<notes; i++) {
    int y = getYByNoteID(i);
    if (i % 2 == 1 || i == 10 ) continue;
    line(20, y, 100, y);
  }
  
  // draw note
  noStroke();
  fill(255);
  if (status > 0) {
    fill(0, 255, 0);
    counterGood++;
    status = 2;
  }
  if (status < 0) {
    fill(255, 0, 0);
    status = 2;
  }
  circle(70, getYByNoteID(noteID), dist+3);
}

void keyPressed() {
  status = (key == noteName[noteID]) ? 1 : -1;
}

int getYByNoteID(int n) {
  return (height - notes * dist) / 2 + n * dist;
}

void newNote() {
  counterAll++;
  noteID = (int) random(notes);
}
