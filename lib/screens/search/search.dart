import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:simulador/screens/search/search_box.dart';
import 'package:simulador/shared/typography.dart';

class SearchScreen extends StatelessWidget {

  @override
   Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Color(0xfff2f1f6),
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 40.0),
              child: FadeIn(
                duration: Duration(milliseconds: 300, ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24,),
                    Text(
                      'Búsqueda & descubrimiento',
                      style: screenTitle
                    ),
                    SizedBox(height: 24),

                    SearchBoxWidget()
                  ],
                ),
              )
            ),
          )
        ),
      ),
    );
  }
}