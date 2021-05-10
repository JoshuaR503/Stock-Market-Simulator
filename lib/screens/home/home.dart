import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simulador/shared/common/portfolioCard.dart';
import 'package:simulador/shared/common/stockCard.dart';
import 'package:simulador/shared/typography.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
                    'Portafolio',
                    style: screenTitle
                  ),
                  
                  SizedBox(height: 24),
                  PortfolioCard(
                    title: "Valor de la cartera:",
                    value: '\$5,439,00',
                    action: true,
                    actionCallback: () {
                      Navigator.pushNamed(context, '/holdings');
                    }
                  ),
                  SizedBox(height: 24,),
                  this._buildPortfolioSubtitle(title: 'Índices bursátiles'),
                  SizedBox(height: 12),
                  _buildMarketIndexItem( ticker: 'Dow Jones', change: '229.23', percentChange: '0.66%', price: '34,777.76'),
                  SizedBox(height: 12),
                  _buildMarketIndexItem( ticker: 'S&P 500', change: '30.98', percentChange: '0.74%', price: '4,232.60'),
                  SizedBox(height: 12),
                  _buildMarketIndexItem( ticker: 'Nasdaq', change: '119.39', percentChange: '0.88%', price: '13,752.24'),
                  
                  SizedBox(height: 24,),
                  this._buildPortfolioSubtitle(title: 'Lista de seguimiento'),
                  SizedBox(height: 12),
                  StockCard( image: 'microsoft', ticker: 'MSFT', companyName: 'Microsoft', change: '2.73', price: '252.46'),
                  SizedBox(height: 12),
                  StockCard( image: 'mcdonalds', ticker: 'MCD', companyName: "McDonald's", change: '-0.02', price: '234.84'),
                  SizedBox(height: 24),
                  this._buildPortfolioSubtitle(title: 'Ganadores y Perdedores'),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: this._buildGainersAndLosers(
                        name: 'Apple',
                        image: 'apple',
                        change: 6.32,
                        price: '\$324.34'
                      ),),
                      SizedBox(width: 24),
                      Expanded(child: this._buildGainersAndLosers(
                        name: 'Starbucks',
                        image: 'sbux',
                        change: -0.46,
                        price: '\$114.28'
                      )),
                    ],
                  ),
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
          style: TextStyle(
            fontSize: 20.0,
            height: 1.5,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        )),
        Text(
          'Ver todos',
          style: TextStyle(
            fontSize: 16.0,
            height: 1.5,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildGainersAndLosers({
    String image,
    String name,
    double change,
    String price
  }) {

    final isUp = change > 0;

    final lightColor =  isUp ? Color(0xffdaf4e3) : Colors.red.shade100;
    final deepColor = isUp ? Color(0xff51cd7b) : Colors.red;
    final icon = isUp ? FontAwesomeIcons.caretUp : FontAwesomeIcons.caretDown;

    return Container(
      padding: EdgeInsets.all(16),
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
              Text(
                name,
                style: TextStyle(
                  fontSize: 20.0,
                  height: 1.5,
                  letterSpacing: -1,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              FaIcon(
                icon,
                color: deepColor,
                size: 24,
              ),
            ],
          ),
          
          Text(
            price,
            style: TextStyle(
              fontSize: 17.5,
              height: 1.5,
              letterSpacing: .5,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 14),

          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                change > 0 ? '+ ' + change.toString() : '- ${change.toString().replaceFirst(RegExp('-'), '')}',
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.5,
                  letterSpacing: -1,
                  color: deepColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            )
          ),
        ],
      ),
    );
  }

  Widget _buildMarketIndexItem({ 
    String ticker, 
    String change, 
    String percentChange, 
    String price
  }) {

    final isUp = double.parse(change)  > 0;
    final deepColor = isUp ? Color(0xff51cd7b) : Colors.red;

    final TextStyle changePercentStyle = TextStyle(
      fontSize: 16.0,
      height: 1.5,
      letterSpacing: -1,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ticker, style: kCardTitle),
                  Text(price, style: kCardsSubtitle),
                ],
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(change, style: kCardTitle),

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
                        percentChange,
                        textAlign: TextAlign.end,
                        style: changePercentStyle
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