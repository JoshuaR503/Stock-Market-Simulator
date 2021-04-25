import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simulador/screens/login/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: FutureBuilder(
              // Initialize FlutterFire:
              future: _initialization,
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return Text('culo');
                }

                // Once complete, show your application
                if (snapshot.connectionState == ConnectionState.done) {
                  return LoginScreen();
                }

                // Otherwise, show something whilst waiting for initialization to complete
                return Text('cul2o');
              },
            ),
          )
        )
      )
    );
  }
}