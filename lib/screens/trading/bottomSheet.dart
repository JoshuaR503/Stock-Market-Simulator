import 'package:flutter/material.dart';

void displayBottomSheet(BuildContext context, String message) {

  Widget buttonBuilder ({
    String title,
    Function callback
  }) {
    final TextStyle optionStyle = TextStyle(fontSize: 16);
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
          child: Text(title, style: optionStyle),
        )
      ),
    );
  }

  final BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: new BorderRadius.only(
      topLeft: const Radius.circular(20.0),
      topRight: const Radius.circular(20.0)
    )
  );

  final TextStyle orderStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.5
  );

  final double height = MediaQuery.of(context).size.height  * 0.32;

  showModalBottomSheet(
    isDismissible: false,
    context: context,
    builder: (ctx) {
      return Container(
        height: height,
        color: Colors.transparent,
        child: Container(
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: boxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.05),
                // Image(image: AssetImage('assets/checked.png',), height: 80, width: 80, ),
                Text("$message",
                  textAlign: TextAlign.center,
                  style: orderStyle
                ),
                SizedBox(height: 20),
                buttonBuilder( title: 'Ver historial de transaciones', callback: ( ) {
                  

                }),
                SizedBox(height: height * 0.05),
                buttonBuilder( title: 'Aceptar', callback: ( ) {
                  Navigator.pop(context);
                  Navigator.pop(context);

                }),
                SizedBox(height: height * 0.04),

              ],
            )
          ),
        ),
      );
    }
  );
}