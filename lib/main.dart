import 'package:flutter/material.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/navbar.dart';

void main() {
  runApp(MaterialApp(
    title: 'Virtual Tour Museum',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
      fontFamily: "Cera Round Pro 2",
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: kBodyTextColor),
      ),
    ),
    home: const Navbar(),
  ));
}
