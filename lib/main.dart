import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memekar/View/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MemeKar',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: LogoScreen(),
    );
  }
}

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => HomeScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/MemeKarLogo.png'),
        Text(
          "MemeKar",
          style: TextStyle(fontSize: 50),
        ),
      ])),
    );
  }
}
