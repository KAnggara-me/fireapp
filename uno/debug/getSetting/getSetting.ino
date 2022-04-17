#include "WiFiEsp.h"  
//#include <ArduinoJson.h>

// Emulate Serial1 on pins 6/7 if not present
#ifndef HAVE_HWSERIAL1
#include "SoftwareSerial.h"
SoftwareSerial Serial1(2, 3); // RX, TX
#endif

char ssid[] = "KAnggara75v7";            // your network SSID (name)
char pass[] = "kenamkali3";        // your network password
int status = WL_IDLE_STATUS;     // the Wifi radio's status

char server[] = "fireapp.kahosting.my.id";
// Initialize the Ethernet client object
WiFiEspClient client;

int    tempMax     = 40;
int    sens        = 150;
char c;

void setup()
{
  // initialize serial for debugging
  Serial.begin(115200);
  // initialize serial for ESP module
  Serial1.begin(9600);
  // initialize ESP module
  WiFi.init(&Serial1);

  // check for the presence of the shield
  if (WiFi.status() == WL_NO_SHIELD) {
    Serial.println("WiFi shield not present");
    // don't continue
    while (true);
  }

  // attempt to connect to WiFi network
  while ( status != WL_CONNECTED) {
    Serial.print("Attempting to connect to WPA SSID: ");
    Serial.println(ssid);
    // Connect to WPA/WPA2 network
    status = WiFi.begin(ssid, pass);
  }

  // you're connected now, so print out the data
  Serial.println("You're connected to the network");

  printWifiStatus();
}

void loop()
{
  char data[10];
  Serial.println();
  Serial.println("Starting connection to server...");
  // if you get a connection, report back via serial
  client.stop();
  if (client.connect(server, 80)) {
    Serial.println("Connected to server");
    // Make a HTTP request
    client.println("GET /public/api/setting HTTP/1.1");
    client.println("Host: " + String(server));
    client.println("Connection: close");
    client.println();
  }
  // if there are incoming bytes available
  // from the server, read them and print them
  while (client.available()) {
    c = client.read();
    Serial.write(c);
  }

  Serial.println(data);

  delay(5000);
}


void printWifiStatus()
{
  // print the SSID of the network you're attached to
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);

  // print the received signal strength
  long rssi = WiFi.RSSI();
  Serial.print("Signal strength (RSSI):");
  Serial.print(rssi);
  Serial.println(" dBm");
}
