/*  
    Robotica Industriale - Progetto Finale
    Authors:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

/* Camera view parameters. */
float angleX = -radians(30.0);
float angleZ = radians(120.0);
float prevMouseX = width/2.0;
float prevMouseY = height/2.0;
float viewAngleStep = 0.05;
float mouseViewThresh = 20.0;
float distanceZ = -2000.0;
float zoomStep = 10.0;

/* Simulation variables. */
boolean readUDP = false;
int indexCell = 0;
int indexPawn = 0;
int joint = 1;

/* Processes mouse wheel input to zoom in or out. */
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e > 0) distanceZ -= zoomStep;
  if (e < 0) distanceZ += zoomStep;
}

/* Processes mouse drags to set the camera view. */
void mouseDragged() {
  float sgnX = 0.0, sgnY = 0.0;
  // Analyze mouse movement and determine the sign of the increments.
  if (abs(mouseX - prevMouseX) > mouseViewThresh) {
    if (mouseX < prevMouseX) {
      // Y angle decrement.
      sgnY = -1.0;
    } else {
      // Y angle increment.
      sgnY = 1.0;
    }
    angleZ += sgnY * viewAngleStep;
    prevMouseX = mouseX;
  }
  if (abs(mouseY - prevMouseY) > mouseViewThresh) {
    if (mouseY < prevMouseY) {
      // X angle increment.
      sgnX = 1.0;
    } else {
      // X angle decrement.
      sgnX = -1.0;
    }
    angleX += sgnX * viewAngleStep;
    prevMouseY = mouseY;
  }
}

/* Processes keyboard inputs. */
void keyPressed() {
  // Direct kinematics.
  if ( !readUDP ) {
    // Increment current joint variable.
    if ( keyCode == RIGHT ) {
      switch (joint) {
        case 1:
          qs[0] += stepAngle;
          break;
        case 2:
          qs[1] += stepPosition;
          break;
        case 3:
          qs[2] += stepPosition;
          break;
      }   
    }

    // Decrement current joint variable.
    if ( keyCode == LEFT ) {
      switch (joint) {
        case 1:
          qs[0] -= stepAngle;
          break;
        case 2:
          qs[1] -= stepPosition;
          break;
        case 3:
          qs[2] -= stepPosition;
          break;
      } 
    }

    // Select joint to modify.
    if ( key == 'q' || key == 'Q' ) {
      joint = 1;
    }
    if ( key == 'w' || key == 'W' ) {
      joint = 2;
    }
    if ( key == 'e' || key == 'E' ) {
      joint = 3;
    }
  }

  // Select target pawn and cell.
  if ( !toCell && !toCatch && !toHome ) {
    // Keys for pawns.
    if ( key == 'a' || key == 'A') {
      indexPawn = 0;
    }
    if ( key == 'b' || key == 'B') {
      indexPawn = 1;
    }
    if ( key == 'c' || key == 'C') {
      indexPawn = 2;
    }
    if ( key == 'd' || key == 'D') {
      indexPawn = 3;
    }
    if ( key == 'e' || key == 'E') {
      indexPawn = 4;
    }
    if ( key == 'f' || key == 'F') {
      indexPawn = 5;
    }

    // Keys for cells.
    if ( key == '1') {
      indexCell = 0;
    }
    if ( key == '2') {
      indexCell = 1;
    }
    if ( key == '3') {
      indexCell = 2;
    } 
    if ( key == '4') {
      indexCell = 3;
    }
    if ( key == '5') {
      indexCell = 4;
    }
    if ( key == '6') {
      indexCell = 5;
    }
    if ( key == '7') {
      indexCell = 6;
    }
    if ( key == '8') {
      indexCell = 7;
    }
    if ( key == '9') {
      indexCell = 8;
    }
    if ( key == 'h' || key == 'H') {
      indexCell = -1;
    }

    // Reset simulation.
    if ( key == 'r' || key == 'R') {
      initPawns();
    }

    // Start simulation.
    if ( keyCode == ENTER ) {
      toCatch = true;
      toCell = false;
      toHome = false;
      if ( indexCell < 0 ) {
        // Must bring a pawn back.
        if ( indexPawn < 3 ) {
          // Gold pawn.
          targetCell[0] = xPawnGold;
          targetCell[1] = yPawnsGold[indexPawn];  
          targetCell[2] = 0.0;
        }
        else {
          // Green pawn.
          targetCell[0] = xPawnsGreen[indexPawn % 3];
          targetCell[1] = yPawnGreen;  
          targetCell[2] = 0.0;
        }
      }
      else {
        // Must place a pawn.
        targetCell[0] = xCells[indexCell / 3];
        targetCell[1] = yCells[indexCell % 3];
        targetCell[2] = zCell;
      }
      // Set initial and final positions and transmit data.
      udpCell[0] = targetCell[0];
      udpCell[1] = targetCell[1];
      udpCell[2] = targetCell[2] + zPawn;
      udpPawn[0] = targetPawn[indexPawn][0];
      udpPawn[1] = targetPawn[indexPawn][1];
      udpPawn[2] = targetPawn[indexPawn][2] + zPawn/2.0;
      nAttempts = 0;
    }
  }  

  // Toggle network communication.
  if( key == 'u' || key == 'U'){
    readUDP = !readUDP;
    toCatch = false;
    toCell = false;
    toHome = false;
  }

}
