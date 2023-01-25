
/*********
  Rui Santos
  Complete project details at https://randomnerdtutorials.com  
*********/

// Load Wi-Fi library
#include <WiFi.h>
#include <WiFiUdp.h>
#include <OSCMessage.h>
#include <OSCBundle.h>
#include <OSCData.h>

// Replace with your network credentials
const char* ssid = "UPC0626776";
const char* password = "f6sxWnaxctnt";

WiFiUDP Udp;

// Set web server port number to 80
WiFiServer server(80);
IPAddress remoteLocation;
const unsigned int localPort = 4444;
const unsigned int remotePort = 9999;
OSCErrorCode error;

// Variable to store the HTTP request
String header;
String uzytkownik1 = "Franek";
String uzytkownik2 = "Weronika";
String haslo1 = "123";
String haslo2 = "4444";
String uzytkownik = "";
// Current time
unsigned long currentTime = millis();
// Previous time
unsigned long previousTime = 0; 
// Define timeout time in milliseconds (example: 2000ms = 2s)
const long timeoutTime = 2000;

void setup() {
  Serial.begin(115200);
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  // Print local IP address and start web server
  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.println("Starting UDP");
  Udp.begin(localPort);
  Serial.print("Local port: ");
 Serial.println(localPort);
  server.begin();
}

 void OSCMsgReceive() {
  char str [10]; // big enough array of char to hold 8 characters and a terminating zero
  for (int i = 0; i < 10; i++) {
    str [i] = 0; // make sure to clear the array of char with zeros to have a terminating zero
  }
  int size;
  if ( (size = Udp.parsePacket() ) > 0) {
    Udp.read(str,size); // read in "size" number of bytes into array of char "str"
    Serial.println(str);
  }
}

void loop(){
  OSCMsgReceive();
  WiFiClient client = server.available();   // Listen for incoming clients

  if (client) {                             // If a new client connects,
    currentTime = millis();
    previousTime = currentTime;
    Serial.println("New Client.");          // print a message out in the serial port
    String currentLine = "";                // make a String to hold incoming data from the client
    while (client.connected() && currentTime - previousTime <= timeoutTime) {  // loop while the client's connected
      currentTime = millis();
      if (client.available()) {             // if there's bytes to read from the client,
        char c = client.read();             // read a byte, then
        Serial.write(c);                    // print it out the serial monitor
        header += c;
        if (c == '\n') {                    // if the byte is a newline character
          // if the current line is blank, you got two newline characters in a row.
          // that's the end of the client HTTP request, so send a response:
          if (currentLine.length() == 0) {
            // HTTP headers always start with a response code (e.g. HTTP/1.1 200 OK)
            // and a content-type so the client knows what's coming, then a blank line:
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println("Connection: close");
            client.println();
            
            
            // Display the HTML web page
            client.println("<!DOCTYPE html>");
             client.println("<html>");
           // client.println("<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
           // client.println("<link rel=\"icon\" href=\"data:,\">");
            // CSS to style the on/off buttons 
            // Feel free to change the background-color and font-size attributes to fit your preferences
            //client.println("<style>html { font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;}");
            //client.println(".button { background-color: #4CAF50; border: none; color: white; padding: 16px 40px;");
            //client.println("text-decoration: none; font-size: 30px; margin: 2px; cursor: pointer;}");
            //client.println(".button2 {background-color: #555555;}</style></head>");
            
            // Web Page Heading
            client.println("<body>");
            client.println("<p>" + uzytkownik1 + "</p>");
            client.println("<p>" + haslo1 + "</p>");
            client.println("<p>" + uzytkownik2 + "</p>");
            client.println("<p>" + haslo2 + "</p>");
            
            client.println("</body></html>");
            
            // The HTTP response ends with another blank line
            client.println();
            // Break out of the while loop
            break;
          } else { // if you got a newline, then clear currentLine
            currentLine = "";
          }
        } else if (c != '\r') {  // if you got anything else but a carriage return character,
          currentLine += c;      // add it to the end of the currentLine
        }
      }
    }
    // Clear the header variable
    header = "";
    // Close the connection
    client.stop();
    Serial.println("Client disconnected.");
    Serial.println("");
  }
}
