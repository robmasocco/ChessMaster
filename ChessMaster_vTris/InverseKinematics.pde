/*  
    Robotica Industriale - Progetto Finale
    Authors:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

/* Functions to compute inverse kinematics of the robot. */

/* Computes the rotation angle q1. */
float q1_inv(float x, float y, float q_3) {
  return atan2(-x/q_3, y/q_3);
}

/* Computes the vertical extension q2. */
float q2_inv(float z, float D1, float D4) {
  return z - D1 + D4;
}

/* Computes the horizontal extension q3. */
float q3_inv(float x, float y) {
  return sqrt( pow(x, 2) + pow(y, 2) );
}
