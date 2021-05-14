import 'package:flutter/material.dart';
import 'package:simulador/models/marketPrices.dart';
import 'package:simulador/screens/trading/trading.dart';
import 'package:simulador/services/database.dart';
import 'package:simulador/services/holdings.dart';
import 'package:simulador/shared/common/portfolioBalance.dart';

import 'package:simulador/shared/common/stockCard.dart';
import 'package:simulador/shared/typography.dart';

class HoldingsScreen extends StatefulWidget {
  @override
  _HoldingsScreenState createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {

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
                    future: _holdingsService.fetchHoldings(),
                    builder: (context, snapshot) {

                      print(snapshot);

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
                                ticker: price.symbol, 
                                companyName: price.name, 
                                change: price.change,
                                 price: price.price
                                ),
                            );
                          },
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                                                      SizedBox(height: 20,),

                            Divider(),
                            SizedBox(height: 80,),
                            Text('Aún no tienes ninguna posición en la bolsa', style: TextStyle(
                              fontSize: 30.0,
                              height: 1.75,
                              letterSpacing: -.5,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ), textAlign: TextAlign.center,),

                            SizedBox(height: 24,),

                            
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 34),
                              child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              onPressed: () async { },
                              child: Container(
                                height: 40,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Abrir una nueva posición', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                )
                              ),
                            ),
                            ),

                          ],
                        );
                      }
                    }
                  )
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