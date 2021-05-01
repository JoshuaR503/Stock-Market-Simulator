import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.only(bottom: 10),
      child: TextButton.icon(
        icon: Icon(icon, color: Colors.white),
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(30),
          backgroundColor: color
        ),
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/topics');
          }
        },
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center, style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5
          ),),
        ),
      ),
    );
  }
}