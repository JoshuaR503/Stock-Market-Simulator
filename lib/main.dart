import 'package:flutter/material.dart';
import 'package:simulador/screens/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: false,
        bottom: false,
        child: LoginScreen(),
      )
    );
  }
}