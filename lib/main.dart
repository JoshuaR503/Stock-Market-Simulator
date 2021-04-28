

import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:simulador/services/auth.dart';

import 'screens/screens.dart';
import 'package:provider/provider.dart';
import 'dart:async';

 Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user, 
          initialData: null
        )
      ],
      child: MaterialApp(

        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],

        routes: {
          // '/': (context) => LoginScreen(),
          // '/topics': (context) => TopicsScreen(),
          // '/profile': (context) => ProfileScreen(),
          '/': (context) => AboutScreen(),
        },

        theme: ThemeData(
          brightness: Brightness.dark,
        ),
      )
    );
  }
}