import 'package:flutter/material.dart';

/// BD stands for Box Decoration.
final BoxDecoration kBottomSheetBD = BoxDecoration(
  color: Colors.white,
  borderRadius: new BorderRadius.only(
    topLeft: const Radius.circular(20.0),
    topRight: const Radius.circular(20.0)
  )
);

/// Title text style.
final TextStyle kBottomSheetTitle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  height: 1.5
);

class BottomSheetStyle extends StatelessWidget {

  final Widget content;
  final double height;

  const BottomSheetStyle({
    this.content,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: kBottomSheetBD,
        child: content,
      ),
    );
  }
}