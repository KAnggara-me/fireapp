// Sensor MQ2 input Pin
const int pinMq2a = A3;
const int pinMq2b = A2;
const int pinMq2c = A1;
const int pinMq2d = A0;

void setup() {
  Serial.begin(115200); // initialize serial for debugging
  pinMode(pinMq2a, INPUT);
  pinMode(pinMq2b, INPUT);
  pinMode(pinMq2c, INPUT);
  pinMode(pinMq2d, INPUT);
  pinMode(13, OUTPUT);
  delay(15000);
  Serial.println(); Serial.println();
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
  int Vmq2 = 150;
  int mq2Max = 150;
  if (id == 1)
  {
    Vmq2 = analogRead(pinMq2a) - 350;
  } else if (id == 2) {
    Vmq2 = analogRead(pinMq2b) - 300;
  } else if (id == 3) {
    Vmq2 = analogRead(pinMq2c) - 350;
  } else if (id == 4) {
    Vmq2 = analogRead(pinMq2d) - 350;
  }
  Serial.println();

  //=============================================
  //                MQ2 Section             // ==
  if (Vmq2 > mq2Max) {                      // ==
    Serial.print(id);                       // ==
    Serial.print(F(". MQ2 Value: "));       // ==
    Serial.print(Vmq2);                     // ==
    Serial.print(F(" | "));                 // ==
    Serial.print(F("Asap/Gas Terdeteksi")); // ==
    warning(5);                             // ==
  } else if (Vmq2 < -1) {                   // ==
    Serial.print(id);                       // ==
    Serial.print(F(". MQ2 Off"));           // ==
  } else {                                  // ==
    Serial.print(id);                       // ==
    Serial.print(F(". MQ2 Value: "));       // ==
    Serial.println(Vmq2);                   // ==
  }                                         // ==
  //=============================================
}

void warning(int j)
{
  for (int i = 1; i < (j * 5); i++)
  {
    digitalWrite(13, HIGH);
    delay(100);                       // wait for a second
    digitalWrite(13, LOW);
    delay(100);                       // wait for a second
  }
}
