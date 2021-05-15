
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:simulador/models/marketIndex.dart';
import 'package:simulador/screens/portfolio/indexCard.dart';
import 'package:simulador/services/portfolio.dart';
import 'package:simulador/shared/typography.dart';

class IndexesScreen extends StatelessWidget {
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
                      'Índices\nBursátiles',
                      style: screenTitle
                    ),

                    SizedBox(height: 24,),
                    this._buildPortfolioSubtitle(title: 'Americas'),
                    SizedBox(height: 12),
                    this._buildIndexes(indexes: '^DJI,^GSPC,^IXIC,^RUT,TX60.TS'),
                    SizedBox(height: 12),
                    this._buildPortfolioSubtitle(title: 'Europa'),
                    this._buildIndexes(indexes: '^FTSE,^IBEX,^GDAXI,^GSPTSE'),
                    SizedBox(height: 12),
                    this._buildPortfolioSubtitle(title: 'Asia'),
                    this._buildIndexes(indexes: '^N225,^JKSE')
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
            fontSize: 18.0,
            height: 1.5,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w700,
          ),
        )),
      ],
    );
  }

  Widget _buildIndexes({String indexes}) {
    return FutureBuilder(
      future: this._marketService.fetchIndexes(indexes: indexes),
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
            height: 522, 
          );
        }
      }
    );
  }

}