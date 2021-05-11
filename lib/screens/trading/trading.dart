import 'package:flutter/material.dart';
import 'package:simulador/screens/login/loginInput.dart';
import 'package:simulador/shared/common/portfolioCard.dart';
import 'package:simulador/shared/common/stockCard.dart';
import 'package:simulador/shared/typography.dart';

class TradingScreen extends StatefulWidget {
  @override
  _TradingScreenState createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24,),
                  Text(
                    'Trading',
                    style: screenTitle
                  ),
                  SizedBox(height: 24,),

                  
                  this._buildPortfolioSubtitle(title: 'Hacer orden', ),
                  SizedBox(height: 16,),


                  cost(),
                  SizedBox(height: 16),

                  c(),
                  SizedBox(height: 16),

                  c(),
                  SizedBox(height: 16),

                  o(),
                  SizedBox(height: 16),

                  o(),
                  SizedBox(height: 16),

                  metaDa(),
                  SizedBox(height: 16),
                ],
              )
            ),
          )
        ),
      ),
    );
  }

  Widget metaDa( ) {
    final TextStyle kTitleStyle = TextStyle(
      fontSize: 16.5,
      height: 1.5,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w500,
    );

    final TextStyle kValueStyle = TextStyle(
      fontSize: 16.5,
      height: 1.5,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );

    return GestureDetector(
      onTap: () {},
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Costo estimado\nde la orden', style: kTitleStyle),
                Text('\$180.27', style: kValueStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cost( ) {
    final TextStyle kTitleStyle = TextStyle(
      fontSize: 16.5,
      height: 1.5,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w500,
    );

    final TextStyle kValueStyle = TextStyle(
      fontSize: 16.5,
      height: 1.5,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );

    return GestureDetector(
      onTap: () {},
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dinero\ndisponible', style: kTitleStyle),
                Text('\$180.27', style: kValueStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget c( ) {
    final TextStyle kTitleStyle = TextStyle(
      fontSize: 16.5,
      height: 1.5,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w500,
    );

    return GestureDetector(
      onTap: () {},
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tipo de Orden', style: kTitleStyle),
                

                Row(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade50),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { },
                      child: Text('Comprar'),
                    ),

                    SizedBox(width: 14,),

                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade50),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { },
                      child: Text('Vender'),
                    )
                  ],
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget o( ) {
    final TextStyle kTitleStyle = TextStyle(
      fontSize: 16.5,
      height: 1.5,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w500,
    );

    return GestureDetector(
      onTap: () {},
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('Cantidad de\nacciones', 
                    style: kTitleStyle
                  )
                ),
                SizedBox(width: 44),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextField(
                      
                      style: TextStyle(
                        color: Colors.blue
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.blue,
                        focusColor: Colors.blueAccent,
                        
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Acciones",
                        hintStyle: TextStyle(
                          color: Colors.blueAccent
                        )
                      )
                    ),
                  )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioSubtitle({
    String title
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: Text(
          title,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 20.0,
            height: 1.5,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        )),

        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/trading'),
          child: Text(
            'Trading Center',
            style: TextStyle(
              fontSize: 18.0,
              height: 1.5,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}