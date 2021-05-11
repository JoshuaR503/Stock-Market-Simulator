import 'package:flutter/material.dart';
import 'package:simulador/shared/common/portfolioCard.dart';
import 'package:simulador/shared/common/stockCard.dart';
import 'package:simulador/shared/typography.dart';

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
                    'Posiciones',
                    style: screenTitle
                  ),
                  SizedBox(height: 16,),
                  PortfolioCard(
                    title: "Valor de la cartera:",
                    value: '\$5,439,00',
                    action: false,
                    actionCallback: () {}
                  ),
                  SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: PortfolioCard(
                        title: "Cambio en\ndólares USD:",
                        value: '125.93',
                        action: false,
                        color: Colors.green,
                        actionCallback: () {},
                      ),),
                      SizedBox(width: 14,),
                      Expanded(child: PortfolioCard(
                        title: "Cambio en\nporcentaje:",
                        value: '+5.98%',
                        action: false,
                        color: Colors.green,
                        actionCallback: () {},

                      ),),
                    ],
                  ),
                  SizedBox(height: 24,),
                  this._buildPortfolioSubtitle(title: 'Cartera', ),
                  SizedBox(height: 12),
                  StockCard( image: 'netflix', ticker: 'NFLX', companyName: 'Netflix', change: '4.29', price: '503.84'),
                  SizedBox(height: 12),
                  StockCard( image: 'facebook2', ticker: 'FB', companyName: 'Facebook', change: '0.94', price: '319.08'),
                  SizedBox(height: 12),
                  StockCard( image: 'apple', ticker: 'AAPL', companyName: 'Apple', change: '17.34', price: '130.21'),
                  SizedBox(height: 12),
                  StockCard( image: 'search', ticker: 'GOOG', companyName: 'Google', change: '17.34', price: '2,398.69'),
                  SizedBox(height: 12),
                  StockCard( image: 'sbux', ticker: 'SBUX', companyName: 'Starbucks', change: '-0.46', price: '114.28'),
                ],
              )
            ),
          )
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