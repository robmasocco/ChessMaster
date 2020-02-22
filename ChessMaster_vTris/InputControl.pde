/*  
    Robotica Industriale - Progetto finale
    Author:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

// View params
float angoloX = 0.0;
float angoloY = 0.0;
float angoloXpartenza = 0.0;
float angoloYpartenza = 0.0;
float distanceZ = -2000;
float zoomStep = 10;
//
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

void mousePressed(){
  angoloYpartenza = angoloY + (PI*mouseX)/float(500);
  angoloXpartenza = angoloX + (PI*mouseY)/float(500);
}

void mouseDragged(){
  angoloX = angoloYpartenza - (PI*mouseX)/float(500);
  angoloY = angoloX - (PI*mouseY)/float(500);
}

void keyPressed(){
  
  // Direct kinematics
  if( !readUDP ){
    if( keyCode == RIGHT){
      switch (joint){
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
    
    if( keyCode == LEFT){
      switch (joint){
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
    
    if( key == 'q' || key == 'Q' ){
      joint = 1;
    }
    if( key == 'w' || key == 'W' ){
      joint = 2;
    }
    if( key == 'e' || key == 'E' ){
      joint = 3;
    }
  }
  
  // Select pawn and cell
  if( !toCatch && !toCatch && !toHome){
    // Keys for pawns
    if( key == 'a' || key == 'A'){
      indexPawn = 0;
    }
    if( key == 'b' || key == 'B'){
      indexPawn = 1;
    }
    if( key == 'c' || key == 'C'){
      indexPawn = 2;
    }
    if( key == 'd' || key == 'D'){
      indexPawn = 3;
    }
    if( key == 'e' || key == 'E'){
      indexPawn = 4;
    }
    if( key == 'f' || key == 'F'){
      indexPawn = 5;
    }
    
    // Keys for cells
    if( key == '1'){
      indexCell = 0;
    }
    if( key == '2'){
      indexCell = 1;
    }
    if( key == '3'){
      indexCell = 2;
    } 
    if( key == '4'){
      indexCell = 3;
    }
    if( key == '5'){
      indexCell = 4;
    }
    if( key == '6'){
      indexCell = 5;
    }
    if( key == '7'){
      indexCell = 6;
    }
    if( key == '8'){
      indexCell = 7;
    }
    if( key == '9'){
      indexCell = 8;
    }
    if( key == '0'){
      indexCell = -1;
    }
    
    if( key == 'h' || key == 'H'){
      initPawns();
    }
  
    if( key == 'r' || key == 'R'){
      toCatch = true;
      toCell = false;
      toHome = false;
      if( indexCell < 0){
        if( indexPawn < 3){
          targetCell[0] = xPawnGold;
          targetCell[1] = yPawnsGold[indexPawn];  
        }
        else{
          targetCell[0] = xPawnsGreen[indexPawn];
          targetCell[1] = yPawnGreen;  
        }
      }
      else{
        targetCell[0] = xCells[indexCell/3];
        targetCell[1] = yCells[indexCell%3];
      }
      nAttempts = 0;
    }
  }  
  
  if( key == 'u' || key == 'U'){
    readUDP = !readUDP;
    toCatch = false;
    toCell = false;
    toHome = false;
  }
  
}
