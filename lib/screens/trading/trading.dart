import 'package:flutter/material.dart';
import 'package:simulador/shared/typography.dart';

class TradingScreen extends StatefulWidget {
  @override
  _TradingScreenState createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {

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
                    'Trading\nCenter',
                    style: screenTitle
                  ),
                  SizedBox(height: 24),
                  
                  _buildAviabaleBalance(),
                  SizedBox(height: 16),

                  _buildOrderType(),
                  SizedBox(height: 16),

                  _buildInputBox(inputLabel: "Cantidad de Acciones", inputHintText: "Acciones"),
                  SizedBox(height: 16),

                  _buildInputBox(inputLabel: "Símbolo de la Bolsa", inputHintText: "Símbolo"),
                  SizedBox(height: 16),

                  _buildCostEstimate(),
                  SizedBox(height: 24),

                  _buildOrderButton()
                ],
              )
            ),
          )
        ),
      ),
    );
  }

  Widget _buildAviabaleBalance( ) {
    return GestureDetector(
      onTap: () {},
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dinero\ndisponible', style: kTitleStyle),
                Text('\$4,892.27', style: kValueStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrderType( ) {

    final ButtonStyle style = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade50),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    );

    return GestureDetector(
      onTap: () {},
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tipo de\nOrden', style: kTitleStyle),
                Row(
                  children: [
                    TextButton(style: style, child: Text('Comprar'), onPressed: () { }),
                    SizedBox(width: 14),
                    TextButton(style: style, child: Text('Vender'), onPressed: () { })
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox({String inputLabel, String inputHintText}) {
    return GestureDetector(
      onTap: () {},
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(inputLabel, style: kTitleStyle)),
                SizedBox(width: 44),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        fillColor: Colors.blue,
                        focusColor: Colors.blueAccent,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: inputHintText,
                        hintStyle: TextStyle(color: Colors.blueAccent)
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

  Widget _buildCostEstimate( ) {
    return GestureDetector(
      onTap: () {},
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(4))
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

  Widget _buildOrderButton() {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: () { },
      child: Container(
        height: 40,
        child: Align(
          alignment: Alignment.center,
          child: Text('Realizar orden', style: TextStyle(
            fontSize: 16
          ),),
        )
      ),
    );
  }
}