

import 'package:flutter/material.dart';
import 'package:simulador/screens/login/styles.dart';

class LoginInput extends StatelessWidget {

  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool showLabel;

  LoginInput({
    @required this.hintText,
    @required this.icon,
    @required this.keyboardType,
    @required this.controller,
    this.showLabel = false
  });

  @override
  Widget build(BuildContext context) {

    final kHintTextStyle = TextStyle( 
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w500, 
      color: Colors.black
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
        if (showLabel) Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            'Introducir credenciales:',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.5,
            ),
          ),
        ),

        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: kHintTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                icon,
                color: Colors.black,  
              ),
              hintText: hintText,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}