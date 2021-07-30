import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text_project/utils/speech_to_text_controller.dart';
import 'package:speech_to_text_project/utils/text_to_speech_controller.dart';

class HomePage extends StatefulWidget {
  /*
    Home page
    Master page, where the widgets for basic functionalities
    (listen to speech, display text, play text,) are located
*/

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    //initializing speech to text
    Provider.of<SpeechToTextController>(context, listen: false)
        .activateSpeechRecognizer();
  }

  //in order to change text of textfield
  TextEditingController txt = TextEditingController();

  TextToSpeechController textToSpeechController = TextToSpeechController();

  @override
  Widget build(BuildContext context) {
    // updating text of textfield
    setState(() {
      txt.text = Provider.of<SpeechToTextController>(context).recognizedText;
    });

    return Scaffold(
      //outer space
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(15),
          //Main Layout
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                //Title of page
                child: Center(
                  child: Text(
                    'Text-To-Speech-To-Text',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              //Buttons, Microphone icon and TextArea
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Speak button
                    TaskButton(
                      child: Text(
                        Provider.of<SpeechToTextController>(context).isListening
                            ? 'Listening...'
                            : 'Listen ',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      onPressed: () {
                        if (Provider.of<SpeechToTextController>(context,
                                    listen: false)
                                .speechRecognitionAvailable &&
                            !Provider.of<SpeechToTextController>(context,
                                    listen: false)
                                .isListening) {
                          Provider.of<SpeechToTextController>(context,
                                  listen: false)
                              .start();
                        }
                      },
                      hasIcon: true,
                    ),

                    //Listen button
                    TaskButton(
                      child: Text(
                        'Speak',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      onPressed: () {
                        textToSpeechController.speak(txt.text);
                      },
                      hasIcon: false,
                    ),
                  ],
                ),
              ),

              //TextArea
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3)),
                    ]),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  style: Theme.of(context).textTheme.headline2,
                  controller: txt,
                  minLines: 20,
                  maxLines: 50,
                  keyboardType: TextInputType.multiline,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final bool hasIcon;
  TaskButton(
      {required this.child, required this.onPressed, this.hasIcon = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          //Button
          TextButton(onPressed: () => onPressed(), child: child),
          //Icon of microphone
          if (hasIcon)
            Icon(
              Icons.mic,
              size: 20,
            ),
        ],
      ),
    );
  }
}
