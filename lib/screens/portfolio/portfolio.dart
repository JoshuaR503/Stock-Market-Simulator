import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:simulador/models/marketIndex.dart';
import 'package:simulador/models/movers.dart';
import 'package:simulador/screens/portfolio/commodity.dart';
import 'package:simulador/screens/portfolio/indexCard.dart';

import 'package:simulador/services/portfolio.dart';

import 'package:simulador/shared/common/portfolioBalance.dart';
import 'package:simulador/shared/typography.dart';


class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>  {

  final PortfolioService _marketService = PortfolioService();

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
                    this._buildWinnersAndLosers(),
                    SizedBox(height: 24,),
                    this._buildPortfolioSubtitle(title: 'Precios de comodidades'),
                    SizedBox(height: 8),
                    this._buildCommodities()
                  ],
                ),
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

              final MarketIndexModel marketIndex = snapshot.data[idx]; 
              
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: FadeIn(
                  duration: Duration(milliseconds: 500),
                  child: MarketIndexCard(
                    ticker: marketIndex.name, 
                    change: marketIndex.change.toString(), 
                    percentChange: marketIndex.changesPercentage.toString(), 
                    price: marketIndex.price
                  ),
                )
              );
            },
          );
        } else {
          return Container(
            height: 312, 
          );
        }
      }
    );
  }

  Widget _buildWinnersAndLosers() {
    return FutureBuilder(
      future: this._marketService.fetchWinnersAndLosers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<MarketMover> mover = snapshot.data; 
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWinnerAndLoserCard(mover[0], true),
              SizedBox(width: 24),
              _buildWinnerAndLoserCard(mover[1], false)
            ],
          );
        } else {
          return Container(height: 100,);
        }
      },
    );
  }

  Widget _buildWinnerAndLoserCard(mover, isUp) {
    return Expanded(
      child: FadeIn(
        duration: Duration(milliseconds: 500), 
        child: this._buildGainersAndLosers(
          name: mover.companyName,
          ticker: mover.ticker,
          changePercentage: mover.changesPercentage,
          isUp: isUp
        ),
      )
    );
  }

  Widget _buildCommodities() {
    return FutureBuilder(
      future: this._marketService.fetchCommodities(),
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:  snapshot.data.length,
            itemBuilder: (context, idx) {

              final MarketIndexModel marketIndex = snapshot.data[idx]; 

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: CommodityCard( 
                  ticker: marketIndex.symbol, 
                  commodityName: marketIndex.name, 
                  change: marketIndex.changesPercentage, 
                  price: marketIndex.price,
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
  
  Widget _buildGainersAndLosers({String name, String ticker, String changePercentage, bool isUp}) {
    final Color lightColor =  isUp ? Color(0xffdaf4e3) : Colors.red.shade100;
    final Color deepColor = isUp ? Color(0xff51cd7b) : Colors.red;
    final IconData icon = isUp ? FontAwesomeIcons.caretUp : FontAwesomeIcons.caretDown;

    final TextStyle companyName = TextStyle(
      fontSize: 20.0,
      height: 1.5,
      letterSpacing: -1,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    final TextStyle companyPrice = TextStyle(
      fontSize: 16,
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
              Flexible(child: Text(name, style: companyName, maxLines: 1, overflow: TextOverflow.ellipsis,),),
              FaIcon(icon,
                color: deepColor,
                size: 24,
              ),
            ],
          ),

          SizedBox(height: 4),
          Text(ticker, style: companyPrice),
          SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    changePercentage,
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
          )
        ],
      ),
    );
  }

}