import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simulador/models/marketPrices.dart';
import 'package:simulador/services/database.dart';
import 'package:simulador/services/holdings.dart';
import 'package:simulador/services/indexes.dart';
import 'package:simulador/shared/common/portfolioBalance.dart';

import 'package:simulador/shared/common/stockCard.dart';
import 'package:simulador/shared/typography.dart';

class HoldingsScreen extends StatefulWidget {
  @override
  _HoldingsScreenState createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {

  final HoldingsService _holdingsService = HoldingsService();
  final Database _database = Database();

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
                  
                  PortfolioBalance(actionEnabled: false),
                  SizedBox(height: 24,),
                  this._buildPortfolioSubtitle(title: 'Cartera', ),
                  SizedBox(height: 4),

                  FutureBuilder(
                    future: _holdingsService.fetchHoldings(tickers: 'AAPL,MSFT,FB,O,STOR,LMT'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final itemCount = snapshot.data.length;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: itemCount,
                          itemBuilder: (context, idx) {

                            final MarketPricesModel price = snapshot.data[idx]; 
                            
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: StockCard( 
                                image: 'netflix', 
                                ticker: price.symbol, 
                                companyName: price.name, 
                                change: price.change,
                                 price: price.price
                                ),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    }

                  )
                  

                  // StreamBuilder(

                  //   stream: Database().holdings,
                  //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                  //     if (snapshot.hasData) {

                  //       final List holdings = snapshot.data['holdings'];
                        
                  //       return ListView.builder(
                  //         physics: NeverScrollableScrollPhysics(),
                  //         shrinkWrap: true,
                  //         itemBuilder: (context, idx) {
                  //           return Padding(
                  //             padding: EdgeInsets.symmetric(vertical: 8),
                  //             child: StockCard( image: 'netflix', ticker: 'NFLX', companyName: 'Netflix', change: '4.29', price: '503.84'),
                  //           );
                  //         }, 
                  //         itemCount: holdings.length
                  //       );
                        
                  //     } else {
                  //       return Container();
                  //     }

                  //   }

                  // ),

                  // SizedBox(height: 12),
                  // StockCard( image: 'netflix', ticker: 'NFLX', companyName: 'Netflix', change: '4.29', price: '503.84'),
                  // SizedBox(height: 12),
                  // StockCard( image: 'facebook2', ticker: 'FB', companyName: 'Facebook', change: '0.94', price: '319.08'),
                  // SizedBox(height: 12),
                  // StockCard( image: 'apple', ticker: 'AAPL', companyName: 'Apple', change: '17.34', price: '130.21'),
                  // SizedBox(height: 12),
                  // StockCard( image: 'search', ticker: 'GOOG', companyName: 'Google', change: '17.34', price: '2,398.69'),
                  // SizedBox(height: 12),
                  // StockCard( image: 'sbux', ticker: 'SBUX', companyName: 'Starbucks', change: '-0.46', price: '114.28'),
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