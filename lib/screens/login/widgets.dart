

import 'package:flutter/material.dart';
import 'package:simulador/screens/login/styles.dart';

class AltLoginButton extends StatelessWidget {

  final String imageUrl;
  final String text;

  AltLoginButton({
    @required this.imageUrl,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxDecorationStyle,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: Colors.white,
          padding: EdgeInsets.all(16),
        ),
        onPressed: () => print('Login Button Pressed'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 22.0,
                width: 22.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl)
                  ),
                ),
              ),
            ),

            SizedBox(width: 15.0),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  wordSpacing: -2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}