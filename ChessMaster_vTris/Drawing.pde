/*  
    Robotica Industriale - Progetto finale
    Author:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

float D1 = 525.0;
float hPivot = 450.0;
float hPivotAtt = 175.0;
float L2o = 175.0;
float hLink2 = 125.0;
float hLink2Att = 125.0;
float endEffectorDist = 840.5;
float hEndEffectorAtt = 400.0;
float D4 = 650.0;
float xChessboard = 840.0;
float yChessboard = 840.0;
float radiusPawn = 50.0;
// Floor
float[] dimFloor = {1e5, 1e5, 1};

/* Sets the scene angulation. */
void setupScene(){

  translate(width/2, height/2, distanceZ);
  rotateX(-angoloX);
  rotateY(angoloY);
  rotateX(PI/2);
  // Draws the floor of the scene.
  fill(50);
  box(dimFloor[0], dimFloor[1], dimFloor[2]);
}

/* Draws chessboard and cells. */
void drawChessboard(){
  
  pushMatrix();
    translate(xChessboard, -yChessboard, 0);
    shape(chessboard);
  popMatrix();
  
  for(int i = 0; i<3; i++){
    for(int j = 0; j<3; j++){
      pushMatrix();
        translate(xCells[i], -yCells[j], zCell);
        if( (i+j) % 2 == 0)
          fill(255);
        else
          fill(0);
        box(120, 120, 0.5);
      popMatrix();
    }
  }
  
}

/* Draws the pawns. */
void drawPawns(){
  
  for(int i = 0; i<3; i++){
    pushMatrix();
      translate(targetPawn[i][0], -targetPawn[i][1], 0.5);
      fill(GOLD);
      ellipse(0, 0, radiusPawn*2, radiusPawn*2);
      translate(0, 0, targetPawn[i][2]-0.5);
      shape(pawnsGold[i]);
    popMatrix();
    pushMatrix();
      translate(targetPawn[i+3][0], -targetPawn[i+3][1], 0.5);
      fill(DARK_GREEN);
      ellipse(0, 0, radiusPawn*2, radiusPawn*2);
      translate(0, 0, targetPawn[i+3][2]-0.5);
      shape(pawnsGreen[i]);
    popMatrix();
  }
  
}

/* Draws the robot. */
void drawRobot() {
 
  pushMatrix();
    // Base of robot, fixed
    translate(0, 0, D1/2.0);  
    shape(base); 
    // Pivot and Link2, 2 DOF
    rotateZ(-qs[0]);
    translate(0, 0, qs[1] + (D1 - hPivot)/2.0 - hLink2);
    shape(pivot);
    translate(0, 0, hPivotAtt);
    shape(link2);  
    // Link3 and Pinza, 1 DOF
    translate(0, - qs[2] + endEffectorDist, hLink2Att);
    shape(link3);
    translate(0, -endEffectorDist, hEndEffectorAtt);
    shape(endEffector);
  popMatrix();
  
}
 
