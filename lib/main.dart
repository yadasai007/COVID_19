import 'dart:ui';
import 'package:covid_19/info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
        fontFamily: "Poppins",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: TextTheme(
          // ignore: deprecated_member_use
          body1: TextStyle(color: kBodyTextColor),
        ),
      ),
      initialRoute: 'homeScreen',
      routes: {
        'homeScreen': (context) => HomeScreen(),
        'infoScreen': (context) => InfoScreen()
      },
      home: HomeScreen(),
    );
  }
}
