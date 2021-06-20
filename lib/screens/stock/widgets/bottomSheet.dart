import 'package:flutter/material.dart';
import 'package:simulador/screens/stock/widgets/bottomSheetButton.dart';
import 'package:simulador/screens/stock/widgets/bottomSheetStyles.dart';

void displayBottomSheet(BuildContext context, String message) {
  final double height = MediaQuery.of(context).size.height  * 0.32;

  showModalBottomSheet(
    isDismissible: false,
    context: context,
    builder: (ctx) {
      return BottomSheetStyle(
        height: height,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.05),
            // Image(image: AssetImage('assets/checked.png',), height:80, width: 80, ),
            Text("$message",
              textAlign: TextAlign.center,
              style: kBottomSheetTitle
            ),
            SizedBox(height: 20),
            BottomSheetButton( title: 'Ver historial de transaciones',callback: ( ) {}),
            SizedBox(height: height * 0.05),
            BottomSheetButton( title: 'Aceptar', callback: ( ) {
              Navigator.pop(context);
              Navigator.pop(context);
            }),
            SizedBox(height: height * 0.04),
          ],
        ),
      );
    }
  );
}