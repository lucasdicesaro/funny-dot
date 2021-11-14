import processing.net.*;

Server myServer;
String incoming;
String outgoing;
int x = 215;
int y = 215;
int remoteX = 215;
int remoteY = 215;

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
    // row,col ex: 2,1
    System.out.println("incomingX,Y: " + incoming);
    remoteX = int(incoming.substring(0,3));
    remoteY = int(incoming.substring(4,7));
    System.out.println(remoteX + "," + remoteY);
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      x-=3;
    } else if (keyCode == RIGHT) {
      x+=3;
    } else if (keyCode == UP) {
      y-=3;
    } else if (keyCode == DOWN) {
      y+=3;
    }  
    outgoing = x + "," + y;
    System.out.println("sentX,Y: " + outgoing);
    myServer.write(outgoing);
    draw();
  }
  
}
