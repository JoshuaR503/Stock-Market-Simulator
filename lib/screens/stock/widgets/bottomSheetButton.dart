import 'package:flutter/material.dart';

class BottomSheetButton extends StatelessWidget {

  final String title;
  final Function callback;
  final Color color;

  const BottomSheetButton({
    this.title,
    this.callback,
    this.color = Colors.grey
  });

  @override
  Widget build(BuildContext context) {
    
    final ButtonStyle kButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff02da89)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    );

    return TextButton(
      onPressed: callback,
      style: kButtonStyle,
      child: Container(
        height: 34,
        child: Align(
          alignment: Alignment.center,
          child: Text(title, style: TextStyle(fontSize: 16)),
        )
      ),
    );
  }
}