import 'package:flutter/material.dart';
import 'package:simulador/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    if (user != null) {

      print(user);

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(user.displayName ?? 'Guest'),
        ),

        body: Center(
          child: TextButton(
            child: Text('Logout', style: TextStyle(
              color: Colors.white
            ),),
            style: TextButton.styleFrom(
              backgroundColor: Colors.deepOrange
            ),
            onPressed: () async {
              await auth.signOut();

              Navigator
              .of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
            },
          ),
        ),
      );
    } else {
      return Text('not logged in...');
    }
  }
}