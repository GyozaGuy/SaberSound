#include <Audio.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>

#define humFreq 100 //93.57
#define multiplier 10

// GUItool: begin automatically generated code
AudioSynthWaveformSine   sine2;          //xy=154,221
AudioSynthWaveformSine   sine1;          //xy=156,174
AudioSynthWaveformSine   sine3;
AudioSynthWaveform       waveform1;      //xy=330,310
AudioSynthWaveform       waveform2;
AudioEffectMultiply      multiply1;      //xy=333,257
AudioMixer4              mixer1;         //xy=516,279
AudioFilterStateVariable filter1;        //xy=677,249
//AudioSynthNoiseWhite     noise1;         //xy=692,374
AudioMixer4              mixer2;         //xy=863,323
AudioOutputAnalog        dac1;           //xy=1009,327
AudioConnection          patchCord1(sine2, 0, multiply1, 1);
AudioConnection          patchCord2(sine1, 0, multiply1, 0);
AudioConnection          patchCord3(waveform1, 0, mixer1, 1);
AudioConnection          patchCord4(multiply1, 0, mixer1, 0);
AudioConnection          patchCord5(mixer1, 0, filter1, 0);
AudioConnection          patchCord10(sine3, 0, filter1, 1);
AudioConnection          patchCord6(filter1, 0, mixer2, 0);
//AudioConnection          patchCord7(noise1, 0, mixer2, 1);
AudioConnection          patchCord8(mixer2, dac1);
AudioConnection          patchCord9(waveform2, 0, mixer1, 2);
// GUItool: end automatically generated code

int16_t x;
int16_t y;
int16_t z;
int32_t average;
float change;

void setup() {
//  Serial.begin(115200);
//  while (!Serial);
//  delay(200);

//  Serial.print("Commence noise making");

  AudioMemory(18);
  sine1.amplitude(1.0);
  sine1.frequency(7.37);
  // sine1.phase(0);

  sine2.amplitude(1.0);
  sine2.frequency(83.36);
  // sine2.phase(0);

  sine3.amplitude(0.75);
  sine3.frequency(0.23);

  waveform1.amplitude(1.0);
  waveform1.frequency(44.67);
  // waveform1.phase(0);
  waveform1.pulseWidth(0.5);  // 50%

  waveform2.amplitude(1.0);
  waveform2.frequency(humFreq);
  waveform2.pulseWidth(0.33);

//  noise1.amplitude(0.02);

  mixer1.gain(0, 0.25);		// 25% gain
  mixer1.gain(1, 0.15);		// 50% gain
//  mixer1.gain(2, 0.5);		// Passthrough
  mixer1.gain(2, 0.6);
  
  mixer2.gain(0, 0.95);
  mixer2.gain(1, 0.0);

  filter1.frequency(500.0);		// Cutoff frequency
  filter1.resonance(0.9);		// Not sure about this one.
  // filter1.octaveControl(2);	// maybe use this one with a sine LFO to act as flanger
  filter1.octaveControl(1);

  //  sine1.begin();
  //  sine2.begin();
  waveform1.begin(WAVEFORM_PULSE);
  waveform2.begin(WAVEFORM_SAWTOOTH);

  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
}

void loop() {
  x = abs(analogRead(A0) - 4095);
  y = abs(analogRead(A1) - 4095);
  z = abs(analogRead(A2) - 4095);
  average = (x + y + z) / 3;
  waveform2.frequency(average + 4000);
//  change = ((float) average / 4095.0) * multiplier;
//  waveform2.frequency(humFreq + change);
}
