import 'package:flutter/material.dart';
import 'package:simulador/screens/stock/widgets/bottomSheetButton.dart';
import 'package:simulador/screens/stock/widgets/bottomSheetInputField.dart';
import 'package:simulador/screens/stock/widgets/bottomSheetStyles.dart';

void displayInputDialogBottomSheet({
  BuildContext context,
  Function(int) inputFieldCallback,
  Function inputFieldButtonCallback,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      return BottomSheetStyle(
        height: MediaQuery.of(context).size.height  * 0.32,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Introduzca el número de acciones que desea comprar",
              textAlign: TextAlign.center,
              style: kBottomSheetTitle
            ),
            SizedBox(height: 20),
            BottomSheetInputField(callback: inputFieldCallback),
            SizedBox(height: 10),
            BottomSheetButton(
              callback: () {
                inputFieldButtonCallback();
                Navigator.of(context).pop();
              },
              title: 'Comprar',
            ),
          ],
        ),
      );
    }
  ); 
}

void displayReciptBottomSheet({
  BuildContext context,
  Function callback,
  String message
}) {
  final double height = MediaQuery.of(context).size.height  * 0.35;

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
            Text("$message",
              textAlign: TextAlign.center,
              style: kBottomSheetTitle
            ),
            SizedBox(height: 20),
            BottomSheetButton(title: 'Ver historial de transaciones', callback: () {}),
            SizedBox(height: height * 0.05),
            BottomSheetButton(title: 'Aceptar', callback: callback),
            SizedBox(height: height * 0.04),
          ],
        ),
      );
    }
  );
}
