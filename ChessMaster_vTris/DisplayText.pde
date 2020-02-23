/*  
    Robotica Industriale - Progetto Finale
    Authors:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

/* Text settings. */
int widthDisplay = 300;     // Display width for prints.
int heightEE = 200;         // Height.
int margin = 5;             // Margin value.

/* Strings. */
String strTitleRobotState = "Robot state";
String strTitlePawn = "Pawn";
String strTitleCell = "Cell";
String strTarget = "Target";
String strJointVars = "Joint variables";

/* Displays some text whithin the simulation. */
void displayText() {
  String strCurrentState;
  String strPawn, strCell;

  textSize(20); 

  // Title bar.
  fill(LIGHT_YELLOW);
  translate(margin, margin);
  rect(0, 0, widthDisplay, 7*margin);
  fill(0);
  text(strTitleRobotState, (widthDisplay-textWidth(strTitleRobotState))/2, 5*margin);
  // Table.
  translate(0, 7*margin);
  if ( !toCatch && !toCell && !toHome ) {
    strCurrentState = "Ready!";
    fill(LIGHT_GREEN);
  }
  else {
    strCurrentState = "Work in progess...";
    fill(LIGHT_RED);
  }
  rect(0, 0, widthDisplay, 9*margin);
  line(0, 9*margin, widthDisplay/2, 9*margin);
  fill(0);
  text(strCurrentState, (widthDisplay-textWidth(strCurrentState))/2, 6*margin);

  // Robot and simulation parameters.
  translate(0, 15*margin);
  fill(LIGHT_YELLOW);
  rect(0, 0, widthDisplay, 7*margin);
  line(widthDisplay/2, 0, widthDisplay/2, 9*margin);
  fill(0);
  text(strTitlePawn, (widthDisplay/2-textWidth(strTitlePawn))/2, 5*margin);
  text(strTitleCell, (widthDisplay + widthDisplay/2-textWidth(strTitleCell))/2, 5*margin);
  line(0, 7*margin, widthDisplay, 7*margin);
  translate(0, 7*margin);
  fill(255);
  rect(0, 0, widthDisplay, 9*margin);
  line(widthDisplay/2, 0, widthDisplay/2, 9*margin);
  fill(0);
  strPawn = str((char) (65 + indexPawn));
  text(strPawn, (widthDisplay/2-textWidth(strPawn))/2, 6*margin);
  if ( indexCell < 0 )
    strCell = "Home";
  else
    strCell = str(indexCell+1);
  text(strCell, widthDisplay/2+(widthDisplay/2-textWidth(strCell))/2, 6*margin);

}
