/*  
    Robotica Industriale - Progetto Finale
    Authors:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

/* Movement state variables. */
boolean toCatch = false;
boolean toCell = false;
boolean toHome = false;

/* Sets the initial positions of pawns. */
void initPawns() {

  for( int i = 0; i < 3; i++ ){
    // Initialize gold pawns.
    targetPawn[i][0] = xPawnGold;
    targetPawn[i][1] = yPawnsGold[i];
    targetPawn[i][2] = zPawn/2.0;
    // Initialize green pawns.
    targetPawn[i+3][0] = xPawnsGreen[i];
    targetPawn[i+3][1] = yPawnGreen;
    targetPawn[i+3][2] = zPawn/2.0;
  }
  
}

/* Cycles through movement stages analyzing distances. */
void nextStateFSM() {

  if ( toCatch ) {
    float norm = sqrt(abs( pow( (targetPawn[indexPawn][0] - ps[0]) , 2) + pow( (targetPawn[indexPawn][1] - ps[1]) , 2) +  pow( (targetPawn[indexPawn][2] - ps[2]) , 2) ));
    if ( norm <= 27.0 ) {
      toCatch = false;
      toCell = true;
    }
  }

  if ( toCell ) {
    float norm = sqrt(abs( pow( (targetCell[0] - targetPawn[indexPawn][0]) , 2) + pow( (targetCell[1] - targetPawn[indexPawn][1]) , 2) +  pow( (targetCell[2] - targetPawn[indexPawn][2]) , 2) ));
    if ( norm <= 27.0 ) {
      toCell = false;
      toHome = true;
    }
  }

  if ( toHome ) {
    float norm = sqrt(abs( pow( (HOME[0] - ps[0]) , 2) + pow( (HOME[1] - ps[1]) , 2) +  pow( (HOME[2] - ps[2]) , 2) ));
    if ( norm <= 1.0 ) {
      toHome = false;
    }
  }

}

/* Sets the position of the target pawn. */
void outputFSM() {

  if ( toCell ) {
    // The pawn is being moved.
    targetPawn[indexPawn][0] = ps[0];
    targetPawn[indexPawn][1] = ps[1];
    targetPawn[indexPawn][2] = ps[2] - zPawn/2.0;
  }
  else if ( toHome ) {
    // The pawn has been placed.
    targetPawn[indexPawn][0] = targetCell[0];
    targetPawn[indexPawn][1] = targetCell[1];
    targetPawn[indexPawn][2] = targetCell[2] + zPawn/2.0;
  }

}
