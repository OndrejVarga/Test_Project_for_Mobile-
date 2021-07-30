import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({this.radius = 8, required this.mdFileName, Key? key})
      : super(key: key);

  final double radius;
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: Future.delayed(Duration(microseconds: 200)).then((value) {
              return rootBundle.loadString('assets/privacy_policy.md');
            }),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return Markdown(data: snapshot.data as String);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
                ),
                child: Text('OK'),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
              )),
        ),
      ]),
    );
  }
}
