/*  
    Robotica Industriale - Progetto Finale
    Authors:  Roberto Masocco, Alessandro Tenaglia
    Created: 22.02.2020
*/

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Arrays;

/* Converts two float arrays in a single bytes array. */
byte[] encodingPacket(float[] pawn, float[] cell) {
  byte[] temp, finalPacket = {};
  for ( int i = 0; i < 3; i++ ) {
    temp = toByteArray(pawn[i]/1000.0);
    finalPacket = concatenateByteArrays(finalPacket, temp);
  }
  for ( int i = 0; i < 3; i++ ) {
    temp = toByteArray(cell[i]/1000.0);
    finalPacket = concatenateByteArrays(finalPacket, temp);
  }
  return finalPacket;
}

/* Converts a bytes array in a float array. */
float[][] decodingPacket(byte[] sourcePacket, int len) {
  byte[][] splitPacket = divideArray(sourcePacket, len);
  float[][] decodedPacket = new float[2][splitPacket.length/2];
  for ( int i = 0; i < decodedPacket[0].length; i++ ) {
    decodedPacket[0][i] = toFloat(splitPacket[i]);
    decodedPacket[1][i] = toFloat(splitPacket[i+3]);
  } 
  return decodedPacket;
}

/* Concatenates two bytes array in one. */
byte[] concatenateByteArrays(byte[] a, byte[] b) {
  byte[] result = new byte[a.length + b.length]; 
  System.arraycopy(a, 0, result, 0, a.length); 
  System.arraycopy(b, 0, result, a.length, b.length);
  return result;
}

/* Splits a bytes array in a bytes matrix. */
byte[][] divideArray(byte[] source, int size) {    
  byte[][] ret = new byte[(int)Math.ceil(source.length / (double)size)][size];  
  int start = 0; 
  for ( int i = 0; i < ret.length; i++ ) {
      ret[i] = Arrays.copyOfRange(source, start, start + size);
      start += size ;
  }   
  return ret;
}

/* Converts a float in a bytes array. */
byte[] toByteArray(float value) {
  byte[] bytes = new byte[nBYTE_FLOAT];
  ByteBuffer.wrap(bytes).order(ByteOrder.LITTLE_ENDIAN).putFloat(value);
  return bytes;
}

/* Converts a byte array in a float. */
float toFloat(byte[] bytes) {
  return ByteBuffer.wrap(bytes).order(ByteOrder.LITTLE_ENDIAN).getFloat();
}
