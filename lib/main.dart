// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:speech_to_text_project/pages/home_page.dart';
// import 'package:speech_to_text_project/utils/speech_to_text_controller.dart';

// void main() {
//  runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => SpeechToTextController(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Test project',
//         home: HomePage(),
//       ),
//     );
//   }
// }
// // import 'dart:collection';

// // import 'package:avatar_glow/avatar_glow.dart';
// // import 'package:flutter/material.dart';
// // import 'package:highlight_text/highlight_text.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Voice',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primarySwatch: Colors.red,
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //       ),
// //       home: SpeechScreen(),
// //     );
// //   }
// // }

// // class SpeechScreen extends StatefulWidget {
// //   @override
// //   _SpeechScreenState createState() => _SpeechScreenState();
// // }

// // class _SpeechScreenState extends State<SpeechScreen> {
// //   final Map<String, HighlightedWord> _highlights = {
// //     'flutter': HighlightedWord(
// //       onTap: () => print('flutter'),
// //       textStyle: const TextStyle(
// //         color: Colors.blue,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //     'voice': HighlightedWord(
// //       onTap: () => print('voice'),
// //       textStyle: const TextStyle(
// //         color: Colors.green,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //     'subscribe': HighlightedWord(
// //       onTap: () => print('subscribe'),
// //       textStyle: const TextStyle(
// //         color: Colors.red,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //     'like': HighlightedWord(
// //       onTap: () => print('like'),
// //       textStyle: const TextStyle(
// //         color: Colors.blueAccent,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //     'comment': HighlightedWord(
// //       onTap: () => print('comment'),
// //       textStyle: const TextStyle(
// //         color: Colors.green,
// //         fontWeight: FontWeight.bold,
// //       ),
// //     ),
// //   };

// //   stt.SpeechToText _speech = stt.SpeechToText();
// //   bool _isListening = false;
// //   String _text = 'Press the button and start speaking';
// //   double _confidence = 1.0;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _speech = stt.SpeechToText();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// //       floatingActionButton: AvatarGlow(
// //         animate: _isListening,
// //         glowColor: Theme.of(context).primaryColor,
// //         endRadius: 75.0,
// //         duration: const Duration(milliseconds: 2000),
// //         repeatPauseDuration: const Duration(milliseconds: 100),
// //         repeat: true,
// //         child: FloatingActionButton(
// //           onPressed: _listen,
// //           child: Icon(_isListening ? Icons.mic : Icons.mic_none),
// //         ),
// //       ),
// //       // body: SingleChildScrollView(
// //       //   reverse: true,
// //       //   child: Container(
// //       //     padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
// //       //     child: TextHighlight(
// //       //       text: _text,
// //       //       words: _highlights as LinkedHashMap<String, HighlightedWord>,
// //       //       textStyle: const TextStyle(
// //       //         fontSize: 32.0,
// //       //         color: Colors.black,
// //       //         fontWeight: FontWeight.w400,
// //       //       ),
// //       //     ),
// //       //   ),
// //       // ),
// //     );
// //   }

// //   void _listen() async {
// //     if (!_isListening) {
// //       bool available = await _speech.initialize(
// //         onStatus: (val) => print('onStatus: $val'),
// //         onError:(val) => print('onStatus: $val'),
// //       );
// //       if (available) {
// //         setState(() => _isListening = true);
// //         _speech.listen(
// //           onResult: (val) => setState(() {
// //             print(val.recognizedWords);
// //             _text = val.recognizedWords;
// //             if (val.hasConfidenceRating && val.confidence > 0) {
// //               _confidence = val.confidence;
// //             }
// //           }),
// //         );
// //       }
// //     } else {
// //       setState(() => _isListening = false);
// //       _speech.stop();
// //     }
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:speech_recognition/speech_recognition.dart';

// void main() {
//   runApp(new MyApp());
// }

// const languages = const [
//   const Language('Francais', 'fr_FR'),
//   const Language('English', 'en_US'),
//   const Language('Pусский', 'ru_RU'),
//   const Language('Italiano', 'it_IT'),
//   const Language('Español', 'es_ES'),
// ];

// class Language {
//   final String name;
//   final String code;

//   const Language(this.name, this.code);
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   SpeechRecognition _speech = SpeechRecognition();

//   bool _speechRecognitionAvailable = false;
//   bool _isListening = false;

//   String transcription = '';

//   //String _currentLocale = 'en_US';
//   Language selectedLang = languages.first;

//   @override
//   initState() {
//     super.initState();
//     activateSpeechRecognizer();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   void activateSpeechRecognizer() {
//     print('_MyAppState.activateSpeechRecognizer... ');
//     _speech = new SpeechRecognition();
//     _speech.setAvailabilityHandler(onSpeechAvailability);
//     _speech.setCurrentLocaleHandler(onCurrentLocale);
//     _speech.setRecognitionStartedHandler(onRecognitionStarted);
//     _speech.setRecognitionResultHandler(onRecognitionResult);
//     _speech.setRecognitionCompleteHandler(onRecognitionComplete);
//     _speech
//         .activate()
//         .then((res) => setState(() => _speechRecognitionAvailable = res));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           title: new Text('SpeechRecognition'),
//           actions: [
//             new PopupMenuButton<Language>(
//               onSelected: _selectLangHandler,
//               itemBuilder: (BuildContext context) => _buildLanguagesWidgets,
//             )
//           ],
//         ),
//         body: new Padding(
//             padding: new EdgeInsets.all(8.0),
//             child: new Center(
//               child: new Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   new Expanded(
//                       child: new Container(
//                           padding: const EdgeInsets.all(8.0),
//                           color: Colors.grey.shade200,
//                           child: new Text(transcription))),
//                   _buildButton(
//                     onPressed: () {
//                       if (_speechRecognitionAvailable && !_isListening) {
//                         start();
//                       }
//                     },
//                     label: _isListening
//                         ? 'Listening...'
//                         : 'Listen (${selectedLang.code})',
//                   ),
//                   _buildButton(
//                     onPressed: () {
//                       if (_isListening) {
//                         cancel();
//                       }
//                     },
//                     label: 'Cancel',
//                   ),
//                   _buildButton(
//                     onPressed: () {
//                       if (_isListening) {
//                         stop();
//                       }
//                     },
//                     label: 'Stop',
//                   ),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }

//   List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
//       .map((l) => new CheckedPopupMenuItem<Language>(
//             value: l,
//             checked: selectedLang == l,
//             child: new Text(l.name),
//           ))
//       .toList();

//   void _selectLangHandler(Language lang) {
//     setState(() => selectedLang = lang);
//   }

//   Widget _buildButton({String label, VoidCallback onPressed}) => new Padding(
//       padding: new EdgeInsets.all(12.0),
//       child: new RaisedButton(
//         color: Colors.cyan.shade600,
//         onPressed: onPressed,
//         child: new Text(
//           label,
//           style: const TextStyle(color: Colors.white),
//         ),
//       ));

//   void start() => _speech
//       .listen(locale: selectedLang.code)
//       .then((result) => print('_MyAppState.start => result ${result}'));

//   void cancel() =>
//       _speech.cancel().then((result) => setState(() => _isListening = result));

//   void stop() =>
//       _speech.stop().then((result) => setState(() => _isListening = result));

//   void onSpeechAvailability(bool result) =>
//       setState(() => _speechRecognitionAvailable = result);

//   void onCurrentLocale(String locale) {
//     print('_MyAppState.onCurrentLocale... $locale');
//     setState(
//         () => selectedLang = languages.firstWhere((l) => l.code == locale));
//   }

//   void onRecognitionStarted() => setState(() => _isListening = true);

//   void onRecognitionResult(String text) => setState(() => transcription = text);

//   void onRecognitionComplete() => setState(() => _isListening = false);
// }

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_speech/flutter_speech.dart';

// void main() {
//   runApp(MyApp());
// }

// const languages = const [
//   const Language('Francais', 'fr_FR'),
//   const Language('English', 'en_US'),
//   const Language('Pусский', 'ru_RU'),
//   const Language('Italiano', 'it_IT'),
//   const Language('Español', 'es_ES'),
// ];

// class Language {
//   final String name;
//   final String code;

//   const Language(this.name, this.code);
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late SpeechRecognition _speech;

//   bool _speechRecognitionAvailable = false;
//   bool _isListening = false;

//   String transcription = '';

//   //String _currentLocale = 'en_US';
//   Language selectedLang = languages.first;

//   @override
//   initState() {
//     super.initState();
//     activateSpeechRecognizer();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   void activateSpeechRecognizer() {
//     print('_MyAppState.activateSpeechRecognizer... ');
//     _speech = SpeechRecognition();
//     _speech.setAvailabilityHandler(onSpeechAvailability);
//     _speech.setRecognitionStartedHandler(onRecognitionStarted);
//     _speech.setRecognitionResultHandler(onRecognitionResult);
//     _speech.setRecognitionCompleteHandler(onRecognitionComplete);
//     _speech.setErrorHandler(errorHandler);
//     _speech.activate('fr_FR').then((res) {
//       setState(() => _speechRecognitionAvailable = res);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('SpeechRecognition'),
//           actions: [
//             PopupMenuButton<Language>(
//               onSelected: _selectLangHandler,
//               itemBuilder: (BuildContext context) => _buildLanguagesWidgets,
//             )
//           ],
//         ),
//         body: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Expanded(
//                       child: Container(
//                           padding: const EdgeInsets.all(8.0),
//                           color: Colors.grey.shade200,
//                           child: Text(transcription))),
//                   _buildButton(
//                     onPressed: _speechRecognitionAvailable && !_isListening
//                         ? () => start()
//                         : null,
//                     label: _isListening
//                         ? 'Listening...'
//                         : 'Listen (${selectedLang.code})',
//                   ),
//                   _buildButton(
//                     onPressed: _isListening ? () => cancel() : null,
//                     label: 'Cancel',
//                   ),
//                   _buildButton(
//                     onPressed: _isListening ? () => stop() : null,
//                     label: 'Stop',
//                   ),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }

//   List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
//       .map((l) => CheckedPopupMenuItem<Language>(
//             value: l,
//             checked: selectedLang == l,
//             child: Text(l.name),
//           ))
//       .toList();

//   void _selectLangHandler(Language lang) {
//     setState(() => selectedLang = lang);
//   }

//   Widget _buildButton({required String label, VoidCallback? onPressed}) =>
//       Padding(
//           padding: EdgeInsets.all(12.0),
//           child: ElevatedButton(
//             onPressed: onPressed,
//             child: Text(
//               label,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ));

//   void start() => _speech.activate(selectedLang.code).then((_) {
//         return _speech.listen().then((result) {
//           print('_MyAppState.start => result $result');
//           setState(() {
//             _isListening = result;
//           });
//         });
//       });

//   void cancel() =>
//       _speech.cancel().then((_) => setState(() => _isListening = false));

//   void stop() => _speech.stop().then((_) {
//         setState(() => _isListening = false);
//       });

//   void onSpeechAvailability(bool result) =>
//       setState(() => _speechRecognitionAvailable = result);

//   void onCurrentLocale(String locale) {
//     print('_MyAppState.onCurrentLocale... $locale');
//     setState(
//         () => selectedLang = languages.firstWhere((l) => l.code == locale));
//   }

//   void onRecognitionStarted() {
//     setState(() => _isListening = true);
//   }

//   void onRecognitionResult(String text) {
//     print('_MyAppState.onRecognitionResult... $text');
//     setState(() => transcription = text);
//   }

//   void onRecognitionComplete(String text) {
//     print('_MyAppState.onRecognitionComplete... $text');
//     setState(() => _isListening = false);
//   }

//   void errorHandler() => activateSpeechRecognizer();
// }
