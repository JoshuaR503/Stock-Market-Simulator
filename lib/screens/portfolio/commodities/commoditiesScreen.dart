

import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:simulador/models/marketIndex.dart';
import 'package:simulador/screens/portfolio/commodity.dart';
import 'package:simulador/services/portfolio.dart';
import 'package:simulador/shared/typography.dart';

class CommoditiesScreen extends StatelessWidget {
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
                      'Comodidades',
                      style: screenTitle
                    ),

                    SizedBox(height: 12,),
                    this._buildPortfolioSubtitle(title: 'Granos'),

                    SizedBox(height: 12),
                    this._buildCommodities('CCUSD,CUSX,SBUSX,RRUSD'),

                    SizedBox(height: 12),
                    this._buildPortfolioSubtitle(title: 'Metales Preciosos'),

                    SizedBox(height: 12),
                    this._buildCommodities('GCUSD,SIUSD,HGUSD,PLUSD'),
                    
                    SizedBox(height: 12),
                    this._buildPortfolioSubtitle(title: 'Materias primas'),

                    SizedBox(height: 12),
                    this._buildCommodities('LBUSD,CTUSX'),

                    SizedBox(height: 12),
                    this._buildPortfolioSubtitle(title: 'Ganado'),

                    SizedBox(height: 12),
                    this._buildCommodities('FCUSX,LHUSX'),
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

  Widget _buildCommodities(String commodities) {
    return FutureBuilder(
      future: this._marketService.fetchCommodities(commodities: commodities),
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:  snapshot.data.length,
            itemBuilder: (context, idx) {

              final MarketIndexModel marketIndex = snapshot.data[idx]; 

              return FadeIn(
                
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CommodityCard( 
                    ticker: marketIndex.symbol, 
                    commodityName: marketIndex.name, 
                    change: marketIndex.changesPercentage, 
                    price: marketIndex.price,
                  ),
                ),
              );
            },
          );
        } else {
          return Container(
            height: 1000,
          );
        }

      }
    );
  }
}