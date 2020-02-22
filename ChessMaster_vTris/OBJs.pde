/*  
    Robotica Industriale - Progetto finale
    Author:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

// Paths of the objs to be imported
String pathBase = "Robot/Base.obj";
String pathPivot = "Robot/Pivot.obj";
String pathLink2 = "Robot/Link2.obj";
String pathLink3 = "Robot/Link3.obj";
String pathEndEffector = "Robot/EndEffector.obj";
String pathPawn = "Robot/Pawn.obj";
String pathChessboard = "Robot/Chessboard.obj";
// Shapes
PShape base, pivot, link2, link3, endEffector;
PShape[] pawnsGold = new PShape[3];
PShape[] pawnsGreen = new PShape[3];
PShape chessboard;

/* Imports objs. */
void importOBJs(){
  
  base = loadShape(pathBase);
  base.setFill(DARK_GREY);
  
  pivot = loadShape(pathPivot);
  pivot.setFill(DARK_RED);
  
  link2 = loadShape(pathLink2);
  link2.setFill(DARK_RED);
  
  link3 = loadShape(pathLink3);
  link3.setFill(RED);
  
  endEffector = loadShape(pathEndEffector);
  endEffector.setFill(RED);
  
  for(int i = 0; i<3; i++){
    pawnsGold[i] = loadShape(pathPawn);
    pawnsGold[i].setFill(GOLD);
  }
  for(int j = 0; j<3; j++){
    pawnsGreen[j] = loadShape(pathPawn);
    pawnsGreen[j].setFill(DARK_GREEN);
  }
  
  chessboard = loadShape(pathChessboard);
  chessboard.setFill(BROWN);
  
}
