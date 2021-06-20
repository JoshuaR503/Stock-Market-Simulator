import 'package:flutter/material.dart';

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(8)),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.1),
      spreadRadius: 2,
      blurRadius: 2,
      offset: Offset(0, 3), // changes position of shadow
    ),
  ]
);
