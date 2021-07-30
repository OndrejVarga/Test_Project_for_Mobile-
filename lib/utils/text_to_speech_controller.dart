import 'package:text_to_speech/text_to_speech.dart';

class TextToSpeechController {
  /*
    Main class of text to speech functions
    https://pub.dev/packages/text_to_speech
    provides text to speech initialization and conversion
  */

  TextToSpeech tts = TextToSpeech();
  //initializing and setup of text to speech
  void init() {
    tts.setLanguage('en-US');
    tts.setVolume(1);
  }

  //Playing text as an audio(text to speech conversion)
  void speak(String text) {
    tts.speak(text);
  }
}
