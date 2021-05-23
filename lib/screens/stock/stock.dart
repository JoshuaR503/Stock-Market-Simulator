import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:simulador/models/stockHolding.dart';
import 'package:simulador/models/stockQuote.dart';
import 'package:simulador/models/stockStats.dart';
import 'package:simulador/screens/stock/chart.dart';
import 'package:simulador/services/database.dart';
import 'package:simulador/services/stock.dart';
import 'package:simulador/shared/typography.dart';
import 'package:intl/intl.dart';

const subtitleStyle = const TextStyle(
  color: Colors.grey,
  fontSize: 14.5,
  height: 1.5
);

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
                    Database().stockHolding(this.ticker)
                  ]),
                  builder: (ctx, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      return this.buildStockInfo(
                        snapshot.data[0], 
                        snapshot.data[1], 
                        snapshot.data[2]
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

  Widget buildStockInfo(StockQuote quote, StockStats stats, StockHolding stockHolding) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20,),
        
        Text(
          quote.symbol,
          style: TextStyle(
            fontSize: 24.0,
            height: 1.5,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.bold,
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: Text(
              quote.companyName,
              maxLines: 2,
              style: TextStyle(
                fontSize: 34.0,
                height: 1.5,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )
            ),),
            SizedBox(width: 60,),
            _buildImage()
          ],
        ),
        SizedBox(height: 16,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '\$${quote.latestPrice.toString()}',
              style: TextStyle(
                fontSize: 24.0,
                height: 1.5,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(width: 10,),
            this._buildPriceInfo(quote.changePercent * 100),
          ],
        ),
        SizedBox(height: 4,),
        Text(
          '${quote.change.toString()}',
          style: TextStyle(
            fontSize: 18.0,
            height: 1.5,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(height:28,),
        Divider(thickness: .75,),
        LineChartSample2(),
        Divider(thickness: .75,),
        SizedBox(height:14,),



        // TextButton(
        //   style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all<Color>(Color(0xffee394a)),
        //     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        //   ),
        //   onPressed: () async {},
        //   child: Container(
        //     height: 40,
        //     child: Align(
        //       alignment: Alignment.center,
        //       child: Text('Realizar orden', style: TextStyle(fontSize: 16)),
        //     )
        //   ),
        // ),
        // SizedBox(height:14,),
        // Divider(thickness: .75,),
        // SizedBox(height:14,),



        Text(
          'Tu posición',
          style: TextStyle(
            fontSize: 24.0,
            height: 1.5,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(height:14,),

        Row(
          children: <Widget>[
            Expanded(
              child: 
              Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Cantidad de acciones', style: subtitleStyle),
                    trailing: Text(stockHolding.quanity)
                  ),
                  Divider(thickness: .75,),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Coste\npromedio', style: subtitleStyle),
                    trailing: Text(NumberFormat().format(stockHolding.baseCost))
                  ),
                  Divider(thickness: .75,),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Rendimiento', style: subtitleStyle),
                    trailing: Text( 
                      "${(quote.latestPrice * int.parse(stockHolding.quanity) - stockHolding.totalCost).toStringAsFixed(2)}  "
                    )
                  ),
                ]
              )
            ),
            SizedBox(width: 40),

            Expanded(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Valor actual', style: subtitleStyle),
                    trailing: Text( NumberFormat().format(quote.latestPrice * int.parse(stockHolding.quanity)))
                  ),
                  Divider(thickness: .75,),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Precio de compra', style: subtitleStyle),
                    trailing: Text( NumberFormat().format(stockHolding.totalCost))
                  ),
                  Divider(thickness: .75,),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Rendimiento', style: subtitleStyle),
                    trailing: Text( 
                      "${(quote.latestPrice * int.parse(stockHolding.quanity) - stockHolding.totalCost).toStringAsFixed(2)}  "
                    )
                  ),
                ]
              )
            ),

            
          ],
        ),
        
        
        

        Divider(thickness: .75,),
        SizedBox(height:14,),
        Text(
          'Estadísticas',
          style: TextStyle(
            fontSize: 24.0,
            height: 1.5,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(height:14,),

        Row(
          children: <Widget>[
            Expanded(child: Column(children: _leftColumn(quote, stats))),
            SizedBox(width: 40),
            Expanded(child: Column(children: _rightColumn(quote, stats)))
          ],
        ),

        
      ]
    );
  }

  List<Widget> _leftColumn(StockQuote quote, StockStats stats) {    
    return [
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Apertura', style: subtitleStyle),
        trailing: Text(quote.open.toString())
      ),
      Divider(thickness: .75,),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Último cierre', style: subtitleStyle),
        trailing: Text(quote.previousClose.toString())
      ),
      Divider(thickness: .75,),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Máx. intradía', style: subtitleStyle),
        trailing: Text(quote.high.toString())
      ),
      Divider(thickness: .75,),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Min. intradía', style: subtitleStyle),
        trailing: Text(quote.low.toString())
      ),
      Divider(thickness: .75,),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Alta 52-sem.', style: subtitleStyle),
        trailing: Text(stats.week52high.toString())
      ),
      Divider(thickness: .75,),

      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Baja 52-sem', style: subtitleStyle),
        trailing: Text(stats.week52low.toString())
      ),
      Divider(thickness: .75,),
    ];
  }

  List<Widget> _rightColumn(StockQuote quote, StockStats stats) {
    return [
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Acciones en circulación', style: subtitleStyle),
        trailing: Text(NumberFormat.compact().format(stats.sharesOutstanding))
      ),
      Divider(thickness: .75,),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('10D Vol. promedio', style: subtitleStyle),
        trailing: Text(NumberFormat.compact().format( stats.avg10Volume))
      ),
      Divider(thickness: .75,),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('30D Vol. promedio', style: subtitleStyle),
        trailing: Text(NumberFormat.compact().format( stats.avg30Volume))
      ),
      Divider(thickness: .75,),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Cap. mercado', style: subtitleStyle),
        trailing: Text(NumberFormat.compact().format(stats.marketcap))
      ),
      Divider(thickness: .75,),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('PER', style: subtitleStyle),
        trailing: Text(stats.peRatio.toStringAsFixed(2))
      ),
      Divider(thickness: .75,),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('BPA', style: subtitleStyle),
        trailing: Text(stats.ttmEPS.toStringAsFixed(2))
      ),
      Divider(thickness: .75,),
    ];
  }

  Widget _buildImage() {
    return Container(
      height: 54.0,
      width: 54.0,
      decoration: BoxDecoration(
        border: Border.all(width: 5.0, color: Colors.grey.shade200),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        // child: Image.network('https://storage.googleapis.com/iex/api/logos/$ticker.png'),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/warning.png',
          image: 'https://storage.googleapis.com/iex/api/logos/$ticker.png'
        )
      )
    );
  }

  Widget _buildPriceInfo(double change) {

    final isUp = change  > 0;
    final deepColor = isUp ? Color(0xff51cd7b) : Color(0xffee394a);

    final TextStyle priceChangeStyle = TextStyle(
      fontSize: 16.0,
      height: 1.5,
      letterSpacing: -1,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        SizedBox(height: 4),
        Container(
          width: 90,
          height: 30,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: deepColor, 
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text( '${change.toStringAsFixed(2)} %' , textAlign: TextAlign.center, style: priceChangeStyle)
          )
        ),
      ],
    );
  }
}