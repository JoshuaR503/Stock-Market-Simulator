import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffedf3f7),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Simulador de Bolsa: Cartera',
                          style: TextStyle(
                            fontSize: 34.0,
                            height: 1.5,
                            letterSpacing: -1,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16,),
                        this._buildPortfolioValue(),
                        SizedBox(height: 16,),
                        this._buildPortfolioValueChange(),
                      ],
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioValue() {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(
          Radius.circular(8)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Valor de la cartera:',
            style: TextStyle(
              fontSize: 18.0,
              height: 1.5,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            '\$5,439,00',
            style: TextStyle(
              fontSize: 28.0,
              height: 1.5,
              letterSpacing: -1,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioValueChange() {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(
          Radius.circular(8)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Cambio en la cartera:',
            style: TextStyle(
              fontSize: 18.0,
              height: 1.5,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 4,),

          Text(
            'USD +583 (+5.98%)',
            style: TextStyle(
              fontSize: 24.0,
              height: 1.5,
              letterSpacing: -1,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


        //   Row(
        //   children: [
            
          
        //     Text(
        //       '',
        //       style: TextStyle(
        //         fontSize: 24.0,
        //         height: 1.5,
        //         letterSpacing: -1,
        //         color: Colors.green,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ],
        // )
}