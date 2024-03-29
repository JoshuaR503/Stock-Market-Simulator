import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

import 'package:simulador/models/marketPrices.dart';
import 'package:simulador/screens/holdings/empty.dart';
import 'package:simulador/screens/stock/stock.dart';

import 'package:simulador/services/database.dart';
import 'package:simulador/services/holdings.dart';
import 'package:simulador/shared/common/portfolioBalance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:simulador/shared/common/stockCard.dart';
import 'package:simulador/shared/typography.dart';

class HoldingsScreen extends StatefulWidget {
  @override
  _HoldingsScreenState createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen>  {

  final HoldingsService _holdingsService = HoldingsService();

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
                duration: Duration(milliseconds: 800, ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24,),
                    Text('Posiciones',
                      style: screenTitle,
                    ),
                    SizedBox(height: 24),
                    PortfolioBalance(actionEnabled: false),
                    
                    SizedBox(height: 4),
                    this._buildStreambuilder()
                  ],
                )
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

  Widget _buildStreambuilder() {
    return StreamBuilder(
      stream: Database().database,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {

          final dbtickers = snapshot.data['holdings'];
          final List<String> list = [];

          dbtickers.forEach((hodl) =>  list.add(hodl['ticker']));

          if (list.isNotEmpty) {
            return Column(
              children: [
                SizedBox(height: 24,),
                this._buildPortfolioSubtitle(title: 'Cartera', ),
                this._buildFuturebuilder(list.join(',')),
              ],
            );
          } else {
            return HoldingsEmpty();
          }
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      }
    );
  }

  Widget _buildFuturebuilder(String tickers) {

    final defaultWidget = Padding(
      padding: EdgeInsets.symmetric(vertical: 100),
      child: Center(child: CircularProgressIndicator())
    );

    return FutureBuilder(
      future: _holdingsService.fetchHoldings(tickers),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final itemCount = snapshot.data.length;
          
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: (context, idx) {
            
              final MarketPricesModel quote = snapshot.data[idx]; 
              
              return FadeIn(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StockScreen(ticker: quote.symbol)));
                    },
                    child: StockCard( marketQuote: quote,),
                  )
                ),
              );
            },
          );
        } else {
          return defaultWidget;
        }
      }
    );
  }
 
}