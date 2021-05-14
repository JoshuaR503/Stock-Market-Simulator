import 'package:flutter/material.dart';

class HoldingsEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 120),
        Text('Aún no tienes ninguna\nposición en la bolsa', 
          style: TextStyle(
            fontSize: 26.0,
            height: 1.75,
            letterSpacing: -.5,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.bold,
          ), textAlign: TextAlign.center
        ),
        SizedBox(height: 24),
        
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () => Navigator.pushNamed(context, '/trading'),
          child: Container(
            height: 32,
            child: Align(
              alignment: Alignment.center,
              child: Text('Abrir una nueva posición', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )
          ),
        ),
        ),
      ],
    );
  }
}