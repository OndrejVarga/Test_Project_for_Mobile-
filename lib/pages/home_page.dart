import 'package:flutter/material.dart';
// import 'package:flutter_speech/flutter_speech.dart';
// import 'package:provider/provider.dart';
// import 'package:speech_recognition/speech_recognition.dart';
// import 'package:speech_to_text_project/utils/speech_to_text_controller.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text_project/utils/text_to_speech_controller.dart';
import 'package:flutter_speech/flutter_speech.dart';
/*
  Home page
  Master page, where the widgets for basic functionalities(listen, play) are located

*/

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  TextEditingController txt = TextEditingController();
  TextToSpeechController textToSpeechController = TextToSpeechController();
  // stt.SpeechToText _speech = stt.SpeechToText();
  // bool _isListening = false;
  String _text = 'Press the button and start speaking';
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   txt.text = Provider.of<SpeechToTextController>(context).text;
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech To Text To Speech'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Speak button
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed:
                              _speechRecognitionAvailable && !_isListening
                                  ? () => start()
                                  : null,
                          // onPressed: () {
                          // if (!isListening || ) _listen();
                          // if (!speechToTextController.isListening)
                          // Provider.of<SpeechToTextController>(context,
                          //         listen: false)
                          //     .startListening();
                          //},
                          child:
                              Text(_isListening ? 'Listening...' : 'Listen ')),
                      SizedBox(width: 10),
                      Icon(Icons.mic),
                    ],
                  )),

                  //Listen button
                  ElevatedButton(
                      onPressed: () {
                        textToSpeechController.speak(txt.text);
                      },
                      child: Text('Listen'))
                ],
              ),
              //TextArea
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2)),
                child: TextField(
                  controller: txt,
                  minLines: 6,
                  maxLines: 50,
                  keyboardType: TextInputType.multiline,
                ),
                // child: Text(_text),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void _listen({to_initiate = true}) async {
  //   // if (!_isListening) {
  //   bool available = true;
  //   if (to_initiate) {
  //     available = await _speech.initialize(
  //       onStatus: (val) {
  //         if (!_speech.isListening) {
  //           _listen(to_initiate: false);
  //         }
  //       },
  //       onError: (val) => print('onStatus: $val'),
  //     );
  //   }
  //   if (available) {
  //     setState(() => _isListening = true);
  //     _speech.listen(
  //       pauseFor: Duration(seconds: 5),
  //       onResult: (val) => setState(() {
  //         print(val.recognizedWords);
  //         _text = val.recognizedWords;
  //         txt.text = _text;
  //       }),
  //     );
  //   }
  //   // } else {
  //   //   setState(() => _isListening = false);
  //   //   _speech.stop();
  //   // }
  // }

  // @override
  // void initState() {
  //   textToSpeechController.init();
  //   super.initState();
  // }
  String transcription = '';

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate('en_US').then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  void start() => _speech.activate('en_US').then((_) {
        return _speech.listen().then((result) {
          print('_MyAppState.start => result $result');
          setState(() {
            _isListening = result;
          });
        });
      });

  void cancel() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));

  void stop() => _speech.stop().then((_) {
        setState(() => _isListening = false);
      });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    setState(() => txt.text = text);
  }

  void onRecognitionComplete(String text) {
    print('_MyAppState.onRecognitionComplete... $text');
    setState(() => _isListening = false);
  }

  void errorHandler() => activateSpeechRecognizer();
}
