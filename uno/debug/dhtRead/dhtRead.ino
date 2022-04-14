// Library file
#include <DHT.h>       // Library DHT

// Sensor DHT 11 Pin
const int pinDHT1 = 5;
const int pinDHT2 = 4;
const int pinDHT3 = 6;
const int pinDHT4 = 7;

// init HDT object
DHT dht1(pinDHT1, DHT11);
DHT dht2(pinDHT2, DHT11);
DHT dht3(pinDHT3, DHT11);
DHT dht4(pinDHT4, DHT11);

void setup() {
  Serial.begin(115200); // initialize serial for debugging
  pinMode(pinDHT1, INPUT);
  pinMode(pinDHT2, INPUT);
  pinMode(pinDHT3, INPUT);
  pinMode(pinDHT4, INPUT);

  Serial.println("Initializing....");

  dht1.begin();
  dht2.begin();
  dht3.begin();
  dht4.begin();
}

void loop() {
  for (int i = 1; i <= 4; i++)
  {
    sensor(i);
    delay(1000);
  }
  Serial.println();
}

void sensor(int id)
{
  float t, h;

  if (id == 1)
  {
    h = dht1.readHumidity();
    t = dht1.readTemperature();
  } else if (id == 2) {
    h = dht2.readHumidity();
    t = dht2.readTemperature();
  } else if (id == 3) {
    h = dht3.readHumidity();
    t = dht3.readTemperature();
  } else if (id == 4) {
    h = dht4.readHumidity();
    t = dht4.readTemperature();
  } else {
    t = 30;
    h = 150;
  }
  //=============================================
  //          Temperature Section           // ==
  if (isnan(t)) {                           // ==
    Serial.print(id);                       // ==
    Serial.println(F(". Temp Error!"));     // ==
  } else {                                  // ==
    Serial.print(id);                       // ==
    Serial.print(F(". Temperature : "));    // ==
    Serial.print(t);                        // ==
    Serial.println(F("°C"));                // ==
  }                                         // ==
  //=============================================
  //             Humidity Section           // ==
  if (isnan(h)) {                           // ==
    Serial.print(id);                       // ==
    Serial.println(F(". Humidity Error!")); // ==
  } else {                                  // ==
    Serial.print(id);                       // ==
    Serial.print(F(". Humidity    : "));    // ==
    Serial.print(h);                        // ==
    Serial.println(F("%"));                 // ==
  }                                         // ==
  //=============================================
  Serial.println();
}
