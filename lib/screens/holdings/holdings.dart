import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HoldingsScreen extends StatefulWidget {
  @override
  _HoldingsScreenState createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfff2f1f6),
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
                    padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 24,),
                        Text(
                          'Posiciones',
                          style: TextStyle(
                            fontSize: 34.0,
                            height: 1.5,
                            letterSpacing: -1,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                        

                        
                        SizedBox(height: 16,),
                        this._buildPortfolioCard(
                          title: "Valor de la cartera:",
                          value: '\$5,439,00',
                          action: 'Ver posiciones'
                        ),
                        SizedBox(height: 14,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            

                            Expanded(child: this._buildPortfolioCard(
                              title: "Cambio en\ndólares USD:",
                              value: '125.93',
                              action: '',
                              color: Colors.green
                            ),),
    
                            SizedBox(width: 14,),

                            Expanded(child: this._buildPortfolioCard(
                              title: "Cambio en\nporcentaje:",
                              value: '+5.98%',
                              action: '',
                              color: Colors.green
                            ),),
                          ],
                        ),

                        SizedBox(height: 24,),
                        this._buildPortfolioSubtitle(title: 'Cartera', ),

                        SizedBox(height: 12),
                        _buildWatchlistItem( image: 'netflix', ticker: 'NFLX', companyName: 'Netflix', change: '4.29', price: '503.84'),

                        SizedBox(height: 12),
                        _buildWatchlistItem( image: 'facebook2', ticker: 'FB', companyName: 'Facebook', change: '0.94', price: '319.08'),

                        SizedBox(height: 12),
                        _buildWatchlistItem( image: 'apple', ticker: 'AAPL', companyName: 'Apple', change: '17.34', price: '130.21'),

                        SizedBox(height: 12),
                        _buildWatchlistItem( image: 'search', ticker: 'GOOG', companyName: 'Google', change: '17.34', price: '2,398.69'),
                        
                        SizedBox(height: 12),
                        _buildWatchlistItem( image: 'sbux', ticker: 'SBUX', companyName: 'Starbucks', change: '-0.46', price: '114.28'),
                      
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

  Widget _buildPortfolioCard({
    String title,
    String value,
    String action,
    Color color = Colors.black,
  }) {
    return Container(
      padding: EdgeInsets.all(14),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.5,
                  height: 1.5,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),),


            ],
          ),
          
          Text(
            value,
            style: TextStyle(
              fontSize: 28.0,
              height: 1.5,
              letterSpacing: -1,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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

        Text(
          'Trading Center',
          style: TextStyle(
            fontSize: 18.0,
            height: 1.5,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildWatchlistItem({
    String image, 
    String ticker,
    String companyName,
    String change, 
    String price
  }) {

    final isUp = double.parse(change)  > 0;
    final deepColor = isUp ? Color(0xff51cd7b) : Colors.red;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(
          Radius.circular(8)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [            
              Row(
                children: [
                  Container(
                    height: 54.0,
                    width: 54.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3.0,
                        color: Colors.grey.shade200
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
        
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(image: AssetImage('assets/$image.png')),
                    )
                  ),

                  SizedBox(width: 14),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 2,),
    
                      Text(
                        ticker,
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.5,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$$price',
                    style: TextStyle(
                      fontSize: 18.0,
                      height: 1.5,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Container(
                    width: 70,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: deepColor,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        change,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.5,
                          letterSpacing: -1,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    )
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}