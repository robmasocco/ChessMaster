/*  
    Robotica Industriale - Progetto finale
    Authors:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

import java.net.*;

/* UDP data. */
String myAddr = "192.168.2.100";
String yourAddr = "192.168.2.100";
int myPort = 8080;
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
  }
  catch(Exception e) {
    println(ERROR_INIT);
    exit();
  }

}

/* Sends a packet with pawn and cell coordinates. */
void sendUDP(float[] pawn, float[] cell){

  byte[] packetToSend = encodingPacket(pawn, cell); 
  packetOut = new DatagramPacket(packetToSend, nBYTE_SEND, yourIP, myPort);
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
      qs = temp[0];
      // Convert lengths from meters to millimeters.
      qs[1] = qs[1] * 1000.0;
      qs[2] = qs[2] * 1000.0;
      ps[0] = temp[1][0] * 1000.0;
      ps[1] = temp[1][1] * 1000.0;
      ps[2] = temp[1][2] * 1000.0;
    }
  }
  catch(Exception e) {
    println(ERROR_RECV);
    exit();
  }
}
