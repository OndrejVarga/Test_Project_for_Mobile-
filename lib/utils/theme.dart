import 'package:flutter/material.dart';

/*
Theme setup
*/

class MyTheme {
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: Colors.white,
      primaryColor: Color.fromARGB(255, 19, 111, 99),
      textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.black, fontFamily: 'Montserrat', fontSize: 25),
        headline2: TextStyle(
            color: Colors.black, fontFamily: 'Montserrat', fontSize: 15),
      ),
    );
  }
}
