import 'package:flutter/material.dart';

class BottomSheetInputField extends StatelessWidget {

  final Function(int) callback;

  BottomSheetInputField({
    this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15))]
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        smartDashesType: SmartDashesType.enabled,
        autofocus: true,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.isNotEmpty && value != null) {
            if (int.parse(value) > 0) {
              this.callback(int.parse(value));
            }
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.redAccent,
          hoverColor: Colors.redAccent,
          errorStyle: TextStyle(height: 1.5, fontSize: 13)
        ),
      )
    );
  }
}