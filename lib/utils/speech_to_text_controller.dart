import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextController with ChangeNotifier {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _lastStatus = '';
  String _text = '';

  //returning singleton of speech to text
  stt.SpeechToText get speechToText => _speechToText;
  bool get isListening => _isListening;
  String get text => _text;

  Future<bool> init() async {
    bool available = await _speechToText.initialize(
        onStatus: statusListener, onError: errorListener, debugLogging: true);

    if (available) {
      _speechToText.listen(onResult: resultListener);
      return true;
    } else {
      print("The user has denied the use of speech recognition.");
      return false;
    }
  }

  void startListening({bool hasInitialized = false}) async {
    print('Start listenning');
    bool available = false;
    if (!hasInitialized) {
      available = await _speechToText.initialize(
          onStatus: (val) {
            statusListener(val);
          },
          onError: (val) => print('onStatus: $val'),
          debugLogging: true);
    } else {
      available = true;
    }
    if (available) {
      _speechToText.listen(
          onResult: (val) => resultListener(val),
          listenFor: Duration(seconds: 10),
          pauseFor: Duration(seconds: 3));
    }
  }

  void stopListening() {
    _isListening = false;
    _speechToText.stop();
  }

  void statusListener(String status) {
    print(
        'Received listener status: $status, listening: ${_speechToText.isListening}');
    _lastStatus = '$status';
    if (!_speechToText.isListening) {
      stopListening();
      startListening(hasInitialized: true);
    }
  }

  void errorListener(SpeechRecognitionError error) {
    print(
        "Received error status: $error, listening: ${_speechToText.isListening}");
  }

  void resultListener(SpeechRecognitionResult result) {
    _text += result.recognizedWords;
    print('Result listener ${result.recognizedWords}');
    notifyListeners();
  }

}
