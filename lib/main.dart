import 'package:calc/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
      }
class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}