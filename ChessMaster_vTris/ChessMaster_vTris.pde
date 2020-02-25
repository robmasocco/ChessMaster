/*
    Robotica Industriale - Progetto Finale
    Authors:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

void setup() {

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
  
  qsR[0] = qs[0];
  qsR[1] = qs[1];
  qsR[2] = qs[2];

}

void draw() {

  // Set the scene.
  background(BACKGROUND);
  lights();

  // Communication with Simulink. 
  if ( readUDP ) {
    if ( nAttempts < MAX_ATTEMPTS ) {
      sendUDP(udpPawn, udpCell);
      nAttempts += 1;
    }
  }
  receiveUDP();
  
  qs[0] = qs[0] - kp * (qs[0] - qsR[0]);
  qs[1] = qs[1] - kp * (qs[1] - qsR[1]);
  qs[2] = qs[2] - kp * (qs[2] - qsR[2]);
  
  ps[0] = -qs[2] * sin(qs[0]);
  ps[1] = qs[2] * cos(qs[0]);
  ps[2] = qs[1] - D4 + D1;
  
  // Storage of the new values
  value_q[0][index] = ps[0];
  value_q[1][index] = ps[1];
  value_q[2][index] = ps[2];
  value_qr[0][index] = psR[0];
  value_qr[1][index] = psR[1];
  value_qr[2][index] = psR[2];
  
  index = (index+1) % nPoint;

  // Manages the movement of the pawns.
  nextStateFSM();
  outputFSM();

  // Display some text and information.
  pushMatrix();
    displayText();
  popMatrix();
  // Draw plots
  pushMatrix();
    translate(width-widthOsc-5*margin, margin);
    oscilloscope(value_q[0], value_qr[0], "X Plot");
  popMatrix();
  pushMatrix();
    translate(width-widthOsc-5*margin, height-heightOsc-12*margin);
    oscilloscope(value_q[1], value_qr[1], "Y Plot");
  popMatrix();
  pushMatrix();
    translate(margin, height-heightOsc-12*margin);
    oscilloscope(value_q[2], value_qr[2], "Z Plot");
  popMatrix();

  // Draw the objects.
  setupScene();
  drawChessboard();
  drawPawns();
  drawRobot();

}
