import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:simulador/models/marketIndex.dart';
import 'package:simulador/screens/home/commodity.dart';

import 'package:simulador/services/indexes.dart';

import 'package:simulador/shared/common/portfolioBalance.dart';
import 'package:simulador/shared/typography.dart';

import 'package:intl/intl.dart';
import 'package:flutter_fadein/flutter_fadein.dart';


class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>  {

  final MarketService _marketService = MarketService();

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
                  PortfolioBalance(actionEnabled: false),                  
                  SizedBox(height: 24,),
                  this._buildPortfolioSubtitle(title: 'Índices bursátiles'),
                  SizedBox(height: 12),
                  this._buildIndexes(),
                  SizedBox(height: 12),
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

                  SizedBox(height: 24,),
                  this._buildPortfolioSubtitle(title: 'Precios de comodidades'),
                  SizedBox(height: 8),
                  this._buildCommodities()
                ],
              )
            ),
          )
        ),
      ),
    );
  }

  Widget _buildPortfolioSubtitle({ String title }) {
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

  Widget _buildIndexes() {
    return FutureBuilder(
      future: this._marketService.fetchIndexes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {  

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, idx) {

              final MarketIndexModel index = snapshot.data[idx]; 
              
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: FadeIn(
                  duration: Duration(milliseconds: 750),
                  child: _buildMarketIndexItem(
                    ticker: index.name, 
                    change: index.change.toString(), 
                    percentChange: index.changesPercentage.toString(), 
                    price: index.price
                  ),
                )
              );
            },
          );
        } else {
          return Container(
            height: 312, 
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 65 ), 
              child: CircularProgressIndicator(), 
            ) 
          );
        }
      }
    );
  }

  Widget _buildCommodities() {
    return FutureBuilder(
      future: this._marketService.fetchCommodities(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final itemCount = snapshot.data.length;
          
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: (context, idx) {
              final MarketIndexModel index = snapshot.data[idx]; 
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: CommodityCard( 
                  ticker: index.symbol, 
                  commodityName: index.name, 
                  change: index.changesPercentage, 
                  price: index.price,
                ),
              );
            },
            
          );
        } else {
          return Container();
        }
      }
    );
  }
  
  Widget _buildGainersAndLosers({
    String image,
    String name,
    double change,
    String price
  }) {

    final isUp = change > 0;

    final Color lightColor =  isUp ? Color(0xffdaf4e3) : Colors.red.shade100;
    final Color deepColor = isUp ? Color(0xff51cd7b) : Colors.red;
    final IconData icon = isUp ? FontAwesomeIcons.caretUp : FontAwesomeIcons.caretDown;

    final String positivePirce = '+ ' + change.toString();
    final String negativePrice = '- ${change.toString().replaceFirst(RegExp('-'), '')}';

    final TextStyle companyName = TextStyle(
      fontSize: 20.0,
      height: 1.5,
      letterSpacing: -1,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    final TextStyle companyPrice = TextStyle(
      fontSize: 17.5,
      height: 1.5,
      letterSpacing: .5,
      color: Colors.grey.shade800,
      fontWeight: FontWeight.bold,
    );

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
              Text(name, style: companyName),
              FaIcon(icon,
                color: deepColor,
                size: 24,
              ),
            ],
          ),

          SizedBox(height: 4),
          Text(price, style: companyPrice),
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
                change > 0 ? positivePirce : negativePrice,
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
    double price
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
        borderRadius: BorderRadius.all(Radius.circular(8))
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
                  Text(NumberFormat().format(price), style: kCardsSubtitle),
                ],
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(change, style: kCardTitle),
                  SizedBox(height: 4),
                  Container(
                    width: 84,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: deepColor,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        '$percentChange %',
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