import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text_project/pages/home_page.dart';
import 'package:speech_to_text_project/utils/speech_to_text_controller.dart';
import 'package:speech_to_text_project/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Main Widget
    return ChangeNotifierProvider(
      create: (_) => SpeechToTextController(),
      child: MaterialApp(
        theme: MyTheme.getTheme(context),
        title: 'Test project',
        home: HomePage(),
      ),
    );
  }
}
