import 'package:flutter/material.dart';
import 'package:simulador/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {

    // var user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Culo'),
      ),

      body: Center(
        child: TextButton(
          child: Text('Logout'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.red
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
  }
}