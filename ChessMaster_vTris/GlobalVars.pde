/*  
    Robotica Industriale - Progetto finale
    Author:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

int nDOF = 3;
float[] qs = new float[nDOF];
float[] ps = new float[3];
// Coordiantes
float[] HOME = {720.0, 720.0, 300.0};
float xPawnGold = 0;
float[] yPawnsGold = {920.0, 1040.0, 1160.0};
float[] xPawnsGreen = {920.0, 1040.0, 1160.0};
float yPawnGreen = 0;
float zPawn = 50.0;
float[] xCells = {920.0, 1040.0, 1160.0};
float[] yCells = {920.0, 1040.0, 1160.0};
float zCell = 75.0;
float[][] targetPawn = new float[6][3];
float[] targetCell = {0.0, 0.0, zCell};
// Data size
int nBYTE_FLOAT = 4;
int nBYTE_SEND = 24;
int nBYTE_RECV = 24;
int MAX_ATTEMPTS = 10;
int nAttempts = MAX_ATTEMPTS;
// Increments for direct kinematics 
float stepAngle = 0.1;
float stepPosition = 20.0;
// Palette colors
color BACKGROUND = color(57, 163, 188);
color RED = color(255, 0, 0);
color DARK_RED = color(178,34,34);
color DARK_GREY = color(100);
color DARK_BLUE = color(0, 0, 204);
color DARK_GREEN = color(0, 150, 0);
color GOLD = color(212,190,0);
color BROWN = color(139, 93, 46);
// Errors
String ERROR_INIT = "Error to init socket.";
String ERROR_SEND = "Error to send packet.";
String ERROR_RECV = "Error to receive packet.";
