import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simulador/screens/stock/stockInfoStyles.dart';


class TextHelpers {
  static String compactOrFormat(dynamic num) {
    if (num > 9999) {
      return NumberFormat.compact().format(num);
    } else {
      return NumberFormat().format(num);
    }
  }

  static String compact(dynamic num) {
    return NumberFormat.compact().format(num);
  }
}

Widget buildTile({String title, String trailing}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(title, style: subtitleStyle),
    trailing: Text(trailing)
  );
}