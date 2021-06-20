import 'package:flutter/material.dart';

class BottomSheetInputField extends StatelessWidget {

  final Function(String) callback;

  BottomSheetInputField({
    this.callback
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2))]
      ),
      child: TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        onChanged: (value) {
          callback(value);
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.redAccent,
          hoverColor: Colors.redAccent
        ),
      ),
    );
  }

}