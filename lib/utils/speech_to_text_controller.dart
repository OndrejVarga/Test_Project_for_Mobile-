import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';

class SpeechToTextController with ChangeNotifier {
  /*
    Main class of speech to speech functions
    https://pub.dev/packages/flutter_speech
    provides speech to text initialization and conversion
*/

  late SpeechRecognition _speech;
  //is it possible to perform a successful speech recognition
  bool _speechRecognitionAvailable = false;
  //is currently listening to microphone
  bool _isListening = false;
  String _recognizedText = '';

  //Getters
  String get recognizedText => _recognizedText;
  bool get isListening => _isListening;
  bool get speechRecognitionAvailable => _speechRecognitionAvailable;

  // Initializaiton of speech recognition platform
  void activateSpeechRecognizer() {
    _speech = SpeechRecognition();

    _speech.setAvailabilityHandler((val) {
      _speechRecognitionAvailable = val;
      notifyListeners();
    });

    _speech.setRecognitionStartedHandler(() {
      _isListening = true;
      notifyListeners();
    });

    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(() => activateSpeechRecognizer());

    _speech.activate('en_US').then((res) {
      _speechRecognitionAvailable = res;
      notifyListeners();
    });
  }

  // start speech to text conversion
  void start() => _speech.activate('en_US').then((_) {
        return _speech.listen().then((result) {
          print('_MyAppState.start => result $result');

          _isListening = result;
          notifyListeners();
        });
      });

//call off current speech to text conversion
  void cancel() => _speech.cancel().then((_) {
        _isListening = false;
        notifyListeners();
      });

//stop listening microphone
  void stop() => _speech.stop().then((_) {
        _isListening = false;
        notifyListeners();
      });

//set any text recognized by platform to variable
  void onRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    _recognizedText = text;
    notifyListeners();
  }

//sel _isListening false after the whole phrase was recognized
  void onRecognitionComplete(String text) {
    print('_MyAppState.onRecognitionComplete... $text');
    _isListening = false;
    notifyListeners();
  }
}
