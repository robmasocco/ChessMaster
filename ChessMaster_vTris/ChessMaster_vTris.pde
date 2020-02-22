/*  
    Robotica Industriale - Progetto finale
    Author:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

void setup(){
  
  // Setup of the scene.
  fullScreen(P3D);
  background(BACKGROUND);

  initSocket();
  importOBJs();
  initPawns();
  
  // Computes initial conditions of robot with inverse kinematics.
  qs[2] = q3_inv(HOME[0], HOME[1]);
  qs[1] = q2_inv(HOME[2], D1, D4);
  qs[0] = q1_inv(HOME[0], HOME[1], qs[2]);
  
}

void draw(){
  
  // Set the scene.
  background(BACKGROUND);
  lights();
  
  // Comunication with Simukink 
  if( readUDP ){
    if( nAttempts < MAX_ATTEMPTS){
      sendUDP(targetPawn[indexPawn], targetCell);
      nAttempts += 1;
    }  
    receiveUDP();
  }
  
  // Manages the movement of the pawns.
  nextStateFSM();
  outputFSM();
  
  // 
  setupScene();
  drawChessboard();
  drawPawns();
  drawRobot();
    
}
