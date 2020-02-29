/*  
    Robotica Industriale - Progetto finale
    Authors:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

import java.net.*;

/* UDP data. */
String myAddr = "10.220.67.244";
String yourAddr = "10.220.174.204";
int myPort = 8080;  // Processing UDP port.
int slPort = 8081;  // Simulink UDP port.
int TIMEOUT_SOCKET = 1;
InetAddress myIP, yourIP;
DatagramSocket sock;
DatagramPacket packetOut;
DatagramPacket packetIn;

/* Initializes socket. */
void initSocket() {

  try {
    myIP = InetAddress.getByName(myAddr);
    yourIP = InetAddress.getByName(yourAddr);
    sock = new DatagramSocket(myPort, myIP);
    sock.setSoTimeout(TIMEOUT_SOCKET);
  }
  catch(Exception e) {
    println(ERROR_INIT);
    exit();
  }

}

/* Sends a packet with pawn and cell coordinates. */
void sendUDP(float[] pawn, float[] cell) {

  byte[] packetToSend = encodingPacket(pawn, cell); 
  packetOut = new DatagramPacket(packetToSend, nBYTE_SEND, yourIP, slPort);
  try {
    sock.send(packetOut);
  }
  catch(Exception e) {
    println(ERROR_SEND);
    exit();
  }

}

/* Receives a packet with joint variables and space coordinates. */
void receiveUDP() {
  float[][] temp;
  byte[] packArrayIn = new byte[nBYTE_RECV];
  packetIn = new DatagramPacket(packArrayIn, nBYTE_RECV);
  try {
    sock.receive(packetIn);
    if ( readUDP ) {
      temp = decodingPacket(packArrayIn, nBYTE_FLOAT);
      // Convert lengths from meters to millimeters.
      qsR[0] = temp[0][0];
      qsR[1] = temp[0][1] * 1000.0;
      qsR[2] = temp[0][2] * 1000.0;
      
      psR[0] = temp[1][0] * 1000.0;
      psR[1] = temp[1][1] * 1000.0;
      psR[2] = temp[1][2] * 1000.0;
    }
  }
  catch (Exception e){
    println(ERROR_RECV);
  }
}
