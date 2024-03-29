/*  
    Robotica Industriale - Progetto Finale
    Authors:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

/* Joint and space variables. */
int nDOF = 3;
float[] qs = new float[3];
float[] qsR = new float[nDOF];
float[] ps = new float[3];
float[] psR = new float[3];

/* Known coordinates. */
float[] HOME = {720.0, 720.0, 300.0};
float xPawnGold = 0;
float[] yPawnsGold = {1020.0, 1320.0, 1620.0};
float[] xPawnsGreen = {1020.0, 1320.0, 1620.0};
float yPawnGreen = 0;
float zPawn = 50.0;
float[] xCells = {920.0, 1040.0, 1160.0};
float[] yCells = {920.0, 1040.0, 1160.0};
float zCell = 75.0;

/* Target coordinates. */
float[][] targetPawn = new float[6][3];
float[] targetCell = new float[3];
float[] udpPawn = new float[3];
float[] udpCell = new float[3];

/* Data sizes. */
int nBYTE_FLOAT = 4;
int nBYTE_SEND = 24;
int nBYTE_RECV = 24;
int MAX_ATTEMPTS = 10;
int nAttempts = MAX_ATTEMPTS;

/* Increments for direct kinematics. */ 
float stepAngle = 0.1;
float stepPosition = 20.0;
float kp = 0.2;

/* Palette colors. */
color BACKGROUND = color(57, 163, 188);
color RED = color(255, 0, 0);
color DARK_RED = color(178,34,34);
color DARK_GREY = color(100);
color BLUE = color(0, 0, 255);
color DARK_BLUE = color(0, 0, 204);
color DARK_GREEN = color(0, 150, 0);
color LIGHT_YELLOW = color(255, 255, 125);
color LIGHT_RED = color(255, 97, 97);
color LIGHT_GREEN = color(97, 255, 97);
color GOLD = color(212,190,0);
color BROWN = color(139, 93, 46);

/* Error strings. */
String ERROR_INIT = "Failed to initialize socket.";
String ERROR_SEND = "Failed to send packet.";
String ERROR_RECV = "Failed to receive packet.";
