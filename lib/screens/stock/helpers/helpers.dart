import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simulador/screens/stock/stockInfoStyles.dart';

String compactOrFormat(dynamic num) {
    if (num > 9999) {
      return NumberFormat.compact().format(num);
    } else {
      return NumberFormat().format(num);
    }
  }

Widget buildTile({String title, String trailing}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(title, style: subtitleStyle),
    trailing: Text(trailing)
  );
}