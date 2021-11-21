import processing.net.*;

Server myServer;
String incoming;
String outgoing;
int x = 215;
int y = 215;
int remoteX = 215;
int remoteY = 215;

int MAX_AXIS_LENGHT = 3;
int MOVEMENT_VELOCITY = 3;

void setup() {
  size(480, 480);  
  myServer = new Server(this, 1234);
}

void draw() {
  background(0);
  stroke(255);
  
  ellipse(x, y, 10, 10);
  ellipse(remoteX, remoteY, 10, 10);

  Client myClient = myServer.available();
  if (myClient != null) { 
    incoming = myClient.readString();
    // X,Y ex: 222,111
    System.out.println("incomingX,Y: " + incoming);
    remoteX = int(incoming.substring(0,3));
    remoteY = int(incoming.substring(4,7));
    System.out.println(remoteX + "," + remoteY);
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT && (x-MOVEMENT_VELOCITY) > 0) {      
      x-=MOVEMENT_VELOCITY;
    } else if (keyCode == RIGHT && (x+MOVEMENT_VELOCITY) < width) {
      x+=MOVEMENT_VELOCITY;
    } else if (keyCode == UP && (y-MOVEMENT_VELOCITY) > 0) {
      y-=MOVEMENT_VELOCITY;
    } else if (keyCode == DOWN && (y+MOVEMENT_VELOCITY) < height) {
      y+=MOVEMENT_VELOCITY;
    }
    outgoing =  nf(x, MAX_AXIS_LENGHT) + "," + nf(y, MAX_AXIS_LENGHT);
    System.out.println("sentX,Y: " + outgoing);
    myServer.write(outgoing);
  }
}
