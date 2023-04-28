import dmxP512.*;
import processing.serial.*;

DmxP512 dmx;
int universeSize = 128;
String DMXPRO_PORT="/dev/tty.usbserial-EN283370";
int DMXPRO_BAUDRATE=115200;

void updateDMX(float r, float b, float w, float scaler, int channel) {
  r = (int)(map(r, 0, scaler, 0, 255));
  b = (int)(map(b, 0, scaler, 0, 255));
  w = (int)(map(w, 0, scaler, 0, 255));
  if (r <= 0) {
    r = 0;
  }
  if (r >= 255) {
    r = 255;
  }
  if (b <= 0) {
    b = 0;
  }
  if (b >= 255) {
    b = 255;
  }
  if (w <= 0) {
    w = 0;
  }
  if (w >= 255) {
    w = 255;
  }
  dmx.set(1+channel-1, (int)r);
  dmx.set(3+channel-1, (int)b);
  dmx.set(4+channel-1, (int)w);
}

void updateSingleChannelDMX(float value, float scaler, int channel){
  int val = (int)(map(value, 0, scaler, 0, 255));
  if(val <= 0){
    val = 0;
  }
  if(val >= 255){
    val = 255;
  }
  
  dmx.set(channel,val);
}


void setup(){
  dmx=new DmxP512(this, universeSize, false);
  dmx.setupDmxPro(DMXPRO_PORT, DMXPRO_BAUDRATE);
}

void draw(){
  float red = floor(random(255));
  float blue = floor(random(255));
  float white = floor(random(255));
  updateDMX(red, blue, white, 0.4, 1); //heildarmynd a channel 1-4
}
