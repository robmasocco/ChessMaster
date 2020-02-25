// Oscilloscope
int index = 0;              // Array index
int FPS = 60;               // FPS processing
int nSeconds = 3;           // Seconds to store
int nPoint = nSeconds*FPS;  // num indici max; 3 secondi
int widthOsc = 2 * nPoint;  // Display width for oscilloscope
int heightOsc = 360;        // Display height for oscilloscope
int nRow = 10;              // Number of grid rows  
int nCol = 10;              // Number of grid columns  
float[][] value_q = new float[3][nPoint];
float[][] value_qr = new float[3][nPoint];

void oscilloscope(float[] value, float[] value_r, String title){
  int i, j, k;
  int p=index;
  int q=index;
  float[] points = new float[nPoint];
  float[] points_r = new float[nPoint];

  // Convert values from radians to degree
  for (k = 0; k < nPoint; k++){
    points[k] = value[k]/10.0;
    points_r[k] = value_r[k]/10.0;
  }
  
  // Grafic display
  //translate(width-widthOsc-5*margin, margin);
  fill(LIGHT_YELLOW);
  rect(0, 0, widthOsc+4*margin, 7*margin);
  textSize(20);
  fill(0);
  text(title, (widthOsc-textWidth(title))/2, 5*margin);
  translate(0, 7*margin);
  fill(175);
  rect(0, 0, widthOsc+4*margin, heightOsc + 4*margin);
  translate(2*margin, 2*margin);
  fill(150, 225, 225);
  rect(0, 0, widthOsc, heightOsc);
  stroke(125);
  for (i = 0; i < nRow+1; i++){
    line(0, i*heightOsc/nRow, 360, i*heightOsc/nRow);
  }
  for (i = 0; i < nCol+1; i++){
    line(i*heightOsc/nCol, 0, i*heightOsc/nCol, 360);
  }
  stroke(0);
  translate(0, heightOsc/2);
  line(0, 0, widthOsc, 0);
  
  // Plot values
  noFill();
  strokeWeight(2.5);
 
  stroke(238, 118, 0);
  beginShape();
  for(j = 0; j < nPoint; j++){
    vertex(2*j, points_r[p]);
    p = (p+1) % nPoint;
  }
  endShape();

  stroke(BLUE);
  beginShape();
  for(j = 0; j < nPoint; j++){
    vertex(2*j, points[q]);
    q = (q+1) % nPoint;
  }
  endShape();
  strokeWeight(1.5);
  stroke(0);
}
