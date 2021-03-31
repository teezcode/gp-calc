import 'dart:async';
import 'package:calc/form_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  BuildContext _context;
  startTimeout(){
    return new Timer(Duration(seconds:2), handleTimeout);
  }

  void handleTimeout(){
    Navigator.pushReplacement(
        _context,
        MaterialPageRoute(builder: (BuildContext context){
          return FormScreen();
        }));
  }
  @override
  Widget build(BuildContext context) {
    _context=context;
    startTimeout();
    return Container(
      child: Center(
        child: Image.asset('assets/image/cointena.png',
          height: 300,
          width: 300,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
