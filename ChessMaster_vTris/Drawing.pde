/*  
    Robotica Industriale - Progetto Finale
    Authors:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

/* Robot geometric parameters. */
float D1 = 525.0;
float hPivot = 450.0;
float hPivotAtt = 175.0;
float L2o = 175.0;
float hLink2 = 125.0;
float hLink2Att = 125.0;
float endEffectorDist = 840.5;
float hEndEffectorAtt = 400.0;
float D4 = 650.0;

/* Pawns and chessboard geometric parameters. */
float xChessboard = 840.0;
float yChessboard = 840.0;
float radiusPawn = 50.0;

/* Floor dimensions. */
float[] dimFloor = {5e3, 5e3, 0};

/* Sets the scene angulation. */
void setupScene() {
  translate(width/2, height/2, distanceZ);
  rotateX(-angoloX);
  rotateY(angoloY);
  rotateX(PI/2);
  // Draws the floor of the scene.
  fill(50);
  box(dimFloor[0], dimFloor[1], dimFloor[2]);
}

/* Draws chessboard and cells. */
void drawChessboard() {

  pushMatrix();
    translate(xChessboard, -yChessboard, 0);
    shape(chessboard);
  popMatrix();

  int nCell = 1;
  for ( int i = 0; i<3; i++ ) {
    for ( int j = 0; j<3; j++ ) {
      pushMatrix();
        translate(xCells[i], -yCells[j], zCell);
        if( (i+j) % 2 == 0 )
          // White cell.
          fill(255);
        else
          // Black cell.
          fill(0);
        box(120, 120, 0.5);
        if( (i+j) % 2 == 0 )
          // White cell (black on white).
          fill(0);
        else
          // Black cell (white on black).
          fill(255);
        textSize(80);
        translate(textWidth(str(nCell))/2, -textWidth(str(nCell))/2, 1);
        rotateZ(PI);
        text(nCell, 0, 0);
        nCell += 1;
      popMatrix();
    }
  }

}

/* Draws the pawns. */
void drawPawns() {

  for ( int i = 0; i < 3; i++ ) {
    pushMatrix();
      translate(xPawnGold, -yPawnsGold[i], 0.5);
      fill(GOLD);
      ellipse(0, 0, radiusPawn*2, radiusPawn*2);
    popMatrix();
    pushMatrix();
      translate(xPawnsGreen[i], -yPawnGreen, 0.5);
      fill(DARK_GREEN);
      ellipse(0, 0, radiusPawn*2, radiusPawn*2);
    popMatrix();
  }

  char pawnChar;
  for ( int i = 0; i < 3; i++ ) {
    pushMatrix();
      translate(targetPawn[i][0], -targetPawn[i][1], targetPawn[i][2]);
      shape(pawnsGold[i]);
      fill(0);
      pawnChar = (char) (65 + i);
      textSize(80);
      translate(textWidth(str(pawnChar))/2, -textWidth(str(pawnChar))/2, zPawn/2+0.5);
      rotateZ(PI);
      text(pawnChar, 0, 0);
    popMatrix();
    pushMatrix();
      translate(targetPawn[i+3][0], -targetPawn[i+3][1], targetPawn[i+3][2]);
      shape(pawnsGreen[i]);
      fill(0);
      pawnChar = (char) (65 + i + 3);
      textSize(80);
      translate(textWidth(str(pawnChar))/2, -textWidth(str(pawnChar))/2, zPawn/2+0.5);
      rotateZ(PI);
      text(pawnChar, 0, 0);
    popMatrix();
  }

}

/* Draws the robot. */
void drawRobot() {

  pushMatrix();
    // Base of robot, fixed.
    translate(0, 0, D1/2.0);  
    shape(base); 
    // Pivot and Link2, 2 DOF.
    rotateZ(-qs[0]);
    translate(0, 0, qs[1] + (D1 - hPivot)/2.0 - hLink2);
    shape(pivot);
    translate(0, 0, hPivotAtt);
    shape(link2);  
    // Link3 and End Effector, 1 DOF.
    translate(0, - qs[2] + endEffectorDist, hLink2Att);
    shape(link3);
    translate(0, -endEffectorDist, hEndEffectorAtt);
    shape(endEffector);
  popMatrix();

}
