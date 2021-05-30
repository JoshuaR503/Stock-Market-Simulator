import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:simulador/screens/stock/stockInfo.dart';
import 'package:simulador/services/database.dart';
import 'package:simulador/services/stock.dart';

class StockScreen extends StatelessWidget {

  final String ticker;

  const StockScreen({
    @required this.ticker
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 40.0),
              child: FadeIn(
                duration: Duration(milliseconds: 300, ),
                child: FutureBuilder(
                  future: Future.wait([
                    StockService().fetchStockQuote(this.ticker), 
                    StockService().fetchStockStats(this.ticker),
                    Database().stockHolding(this.ticker),
                    StockService().fetchStockChart(this.ticker),
                  ]),
                  builder: (ctx, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      return StockInfo(
                        quote: snapshot.data[0], 
                        stats: snapshot.data[1], 
                        stockHolding: snapshot.data[2],
                        chart: snapshot.data[3]
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              )
            ),
          )
        ),
      ),
    );
  }

  
}