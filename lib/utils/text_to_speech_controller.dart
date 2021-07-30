import 'package:text_to_speech/text_to_speech.dart';

class TextToSpeechController {
  TextToSpeech tts = TextToSpeech();
  void init(){
    String language = 'en-US';  
    tts.setLanguage(language);  
    tts.setVolume(1);
  }
  void speak(String text) {
    tts.speak(text);
  }
}
