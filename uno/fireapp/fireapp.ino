// Library file
#include <DHT.h>       // Library DHT
#include <Wire.h>
#include <WiFiEsp.h>  // Interface arduino and esp
#include <LiquidCrystal_I2C.h>

//Personal config
#include "auth.h"     // contain wifi and pass data
#include "setting.h"  // Setting file (board_id, sensors etc)

// Emulate Serial1 on pins 2/3 if not present
#ifndef HAVE_HWSERIAL1
#include "SoftwareSerial.h"
SoftwareSerial Serial1(2, 3); // RX, TX
#endif

///////please enter your sensitive data in the Secret tab/auth.h
/////// Wifi Settings ///////
char ssid[] = SECRET_SSID;
char pass[] = SECRET_PASS;
char server[] = "fireapp.kahosting.my.id";
int status = WL_IDLE_STATUS;     // the Wifi radio's status

// data setting config
int    mq2Max      = MQ2MAX;
int    tempMax     = TEMP;
int    sens        = SENSOR;
int    board_id    = BOARD_ID;
String PATH_NAME   = "/api/push"; // API End point

// Pin Config
const int pinBuzzer = 13;

// Sensor MQ2 input Pin
const int pinMq2a = A3;
const int pinMq2b = A2;
const int pinMq2c = A1;
const int pinMq2d = A0;

// Sensor DHT 11 Pin
const int pinDHT1 = 5;
const int pinDHT2 = 4;
const int pinDHT3 = 6;
const int pinDHT4 = 7;

// sensor Value Variable dafault
int Vmq2 = 150; // MQ2 value
float temp = 30; // Temperature value
float humi = 70; // Humidity Value

// Initial LCD Object
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Initialize conection
WiFiEspClient client;

// init HDT object
DHT dht1(pinDHT1, DHT11);
DHT dht2(pinDHT2, DHT11);
DHT dht3(pinDHT3, DHT11);
DHT dht4(pinDHT4, DHT11);

void setup()
{
  initial();
  delay(250);
  lcd.print(F("."));
  dhtSetup();
  delay(250);
  lcd.print(F("."));
  koneksi();
  printWifiStatus();
  Serial.println();
  lcd.clear();
  lcd.setCursor(4, 0);
  lcd.print(F("Initialize"));
  lcd.setCursor(4, 1);
  lcd.print(F("Sensor...."));
  Serial.println(F("Initialize all sensor..."));
  delay(15000);
  Serial.println();
  lcd.clear();
  lcd.setCursor(1, 0);
  lcd.print(F("Connecting...."));
  lcd.setCursor(0, 1);
  lcd.print(F("To: API!"));
  Serial.println(F("Starting connection to server..."));
}

void initial()
{
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.print(F("Starting."));
  Serial.begin(115200); // initialize serial for debugging
  delay(250);
  modePin();
  lcd.print(F("."));
  delay(250);
  lcd.print(F("."));
  Serial1.begin(9600);   // initialize serial for ESP module
  delay(250);
  lcd.print(F("."));
  WiFi.init(&Serial1); // initialize ESP module
  delay(250);
  lcd.print(F("."));
}

void modePin()
{
  pinMode(pinDHT1, INPUT);
  pinMode(pinDHT2, INPUT);
  pinMode(pinDHT3, INPUT);
  pinMode(pinDHT4, INPUT);
  pinMode(pinMq2a, INPUT);
  pinMode(pinMq2b, INPUT);
  pinMode(pinMq2c, INPUT);
  pinMode(pinMq2d, INPUT);
  pinMode(pinBuzzer, OUTPUT);
}

void dhtSetup()
{
  dht1.begin();
  dht2.begin();
  dht3.begin();
  dht4.begin();
}

void loop()
{
  info();
  digitalWrite(pinBuzzer, LOW);
  for (int i = 1; i <= sens; i++)
  {
    sensor(i);
    delay(3000);
  }
  Serial.println();
}

void sensor(int id)
{
  // Delay between measurements.
  // Wait a few seconds between measurements.
  delay(3000);
  String notif = "Aman";
  float t, h;

  if (id == 1)
  {
    //    Kalibrasi sensor mq-2 no. 1
    Vmq2 = analogRead(pinMq2a) - 250;
    h = dht1.readHumidity();
    t = dht1.readTemperature();
  } else if (id == 2) {
    //    Kalibrasi sensor mq-2 no. 2
    Vmq2 = analogRead(pinMq2b) - 200;
    h = dht2.readHumidity();
    t = dht2.readTemperature();
  } else if (id == 3) {
    //    Kalibrasi sensor mq-2 no. 3
    Vmq2 = analogRead(pinMq2c) - 200;
    h = dht3.readHumidity();
    t = dht3.readTemperature();
  } else if (id == 4) {
    //    Kalibrasi sensor mq-2 no. 4
    Vmq2 = analogRead(pinMq2d) - 300;
    h = dht4.readHumidity();
    t = dht4.readTemperature();
  } else {
    t = 30;
    h = 150;
  }

  //=============================================
  //          Temperature Section           // ==
  lcd.clear();                              // ==
  lcd.setCursor(0, 0);                      // ==
  if (isnan(t)) {                           // ==
    Serial.println(F("Temperature Error!"));// ==
    lcd.print(F("Temp "));                  // ==
    lcd.print(id);                          // ==
    lcd.print(F(" Error"));                 // ==
    return;                                 // ==
  } else {                                  // ==
    Serial.print(F("Temperature: "));       // ==
    Serial.print(t);                        // ==
    temp = t;                               // ==
    lcd.print(F("Temp "));                  // ==
    lcd.print(id);                          // ==
    lcd.print(F(" : "));                    // ==
    lcd.print(round(temp));                 // ==
    lcd.print((char)223);                   // ==
    lcd.print(F("C"));                      // ==
    Serial.println(F("°C"));                // ==
  }                                         // ==
  //=============================================
  //                MQ2 Section             // ==
  Serial.print(F("MQ2 Value: "));           // ==
  Serial.print(Vmq2);                       // ==
  if (Vmq2 > mq2Max) {                      // ==
    Serial.print(F(" | "));                 // ==
    notif = "Asap/Gas%20Terdeteksi";        // ==
    Serial.print(F("Asap/Gas Terdeteksi")); // ==
  } else if (Vmq2 < -1) {                   // ==
    Serial.print(F("MQ2 Value: "));         // ==
    Serial.print(Vmq2);                     // ==
    Serial.print(F(" | "));                 // ==
    notif = "MQ2%20Off";                    // ==
    Serial.print(F("MQ2 Off"));             // ==
    Vmq2 = 0;                               // ==
  }                                         // ==
  lcd.setCursor(0, 1);                      // ==
  lcd.print(F("MQ-2 "));                    // ==
  lcd.print(id);                            // ==
  lcd.print(F(" : "));                      // ==
  lcd.print(round(Vmq2));                   // ==
  lcd.print(" ppm");                        // ==
  Serial.println();                         // ==
  //=============================================


  sendData(id, Vmq2, temp, notif); // Call Send data
  if ((Vmq2 > mq2Max) || (temp >= tempMax))
  {
    warning(5);
  }
}

void sendData(int kid, int kmq2, float ktemp, String knotif)
{
  // close any connection before send a new request
  // this will free the socket on the WiFi shield
  client.stop();

  // split data to 3 segment because string zise limitation
  String data1 = String("?id=") + String(kid) +
                 String("&board_id=") + String(board_id);
  String data2 = String("&mq2=") + String(kmq2) +
                 String("&temp=") + String(ktemp);
  String data3 = String("&notif=") + String(knotif);

  //Don't Edit from this
  Serial.println();
  Serial.print(F("Send sensor "));
  Serial.print(kid);
  Serial.println(F(" Data"));
  if (client.connect(server, 80)) {
    client.println("GET " + PATH_NAME + data1 + data2 + data3 + " HTTP/1.1");
    delay(100); 
    client.println("Host: " + String(server));
    delay(100); 
    client.println("Connection: close");
    delay(100); 
    client.println(); // end HTTP header
    delay(500);
    client.stop();
  }
  else {
    // if you couldn't make a connection
    Serial.println(F("Connection failed"));
  }
  Serial.print(server);
  Serial.print(PATH_NAME);
  Serial.println(data1 + data2 + data3);
  // end of send data
}

void koneksi()
{
  // check for the presence of the shield
  if (WiFi.status() == WL_NO_SHIELD) {
    Serial.println(F("WiFi shield not present"));
    lcd.clear();
    lcd.setCursor(1, 0);
    lcd.print(F("No Wifi Module"));
    // don't continue
    while (true);
  }

  // attempt to connect to WiFi network
  while ( status != WL_CONNECTED) {
    Serial.print(F("Attempting to connect to WPA SSID: "));
    Serial.println(ssid);
    lcd.clear();
    lcd.setCursor(1, 0);
    lcd.print(F("Connecting...."));
    lcd.setCursor(0, 1);
    lcd.print(F("To: "));
    lcd.print(ssid);
    // Connect to WPA/WPA2 network
    status = WiFi.begin(ssid, pass);
  }

  // you're connected now, so print out the data
  Serial.println(F("You're connected to the network"));
}

void printWifiStatus()
{
  // print the SSID of the network you're attached to
  Serial.print(F("SSID: "));
  Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address
  IPAddress ip = WiFi.localIP();
  Serial.print(F("IP Address: "));
  Serial.println(ip);

  // print the received signal strength
  long rssi = WiFi.RSSI();
  Serial.print(F("Signal strength (RSSI):"));
  Serial.print(rssi);
  Serial.println(F(" dBm"));
}

void warning(int j)
{
  for (int i = 1; i < (j * 10); i++)
  {
    digitalWrite(pinBuzzer, HIGH);
    delay(100);                       // wait for a second
    digitalWrite(pinBuzzer, LOW);
    delay(100);                       // wait for a second
  }
}

void info()
{
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(WiFi.SSID());
  lcd.setCursor(0, 1);
  lcd.print(WiFi.localIP());
}
