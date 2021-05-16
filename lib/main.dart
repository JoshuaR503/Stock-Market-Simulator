

import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simulador/screens/holdings/holdings.dart';
import 'package:simulador/screens/home/home.dart';
import 'package:simulador/screens/login/login.dart';
import 'package:simulador/screens/portfolio/commodities/commoditiesScreen.dart';
import 'package:simulador/screens/portfolio/indexes/indexesScreen.dart';
import 'package:simulador/screens/trading/trading.dart';

import 'package:simulador/services/auth.dart';
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
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],

        routes: {
          '/': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/holdings': (context) => HoldingsScreen(),
          '/trading': (context) => TradingScreen(),
          '/indexes': (context) => IndexesScreen(),
          '/commodities': (context) => CommoditiesScreen(),

          // '/profile': (context) => ProfileScreen(),
          // '/about': (context) => AboutScreen(),
        },

        theme: ThemeData(
          brightness: Brightness.light,
          canvasColor: Colors.transparent,

        ),
      )
    );
  }
}