import 'package:flutter/material.dart';
import 'package:simulador/models/stockChart.dart';
import 'package:simulador/models/stockHolding.dart';
import 'package:simulador/models/stockQuote.dart';
import 'package:simulador/models/stockStats.dart';
import 'package:intl/intl.dart';
import 'package:simulador/screens/stock/chart.dart';

class StockInfo extends StatelessWidget {

  final StockQuote quote;
  final StockStats stats;
  final StockHolding stockHolding;
  final List<StockChart> chart;

  StockInfo({
    this.quote,
    this.stats,
    this.stockHolding,
    this.chart
  });

  final TextStyle quoteSymbol = TextStyle(
    fontSize: 24.0,
    height: 1.5,
    color: Colors.grey.shade500,
    fontWeight: FontWeight.bold,
  );

  final TextStyle quoteCompanyName = TextStyle(
    fontSize: 34.0,
    height: 1.5,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  final TextStyle quotePrice = TextStyle(
    fontSize: 24.0,
    height: 1.5,
    color: Colors.black54,
    fontWeight: FontWeight.bold,
  );

  final subtitleStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 14.5,
    height: 1.5
  );


  @override
  Widget build(BuildContext context) {
    return buildStockInfo();
  }

  Widget buildStockInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16,),
        Text(quote.symbol, style: quoteSymbol),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(quote.companyName, maxLines: 3, style: quoteCompanyName),
            ),
            SizedBox(width: 100,),
            _buildImage()
          ],
        ),
        SizedBox(height: 8),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('\$${quote.latestPrice.toString()}', style: quotePrice),
            SizedBox(width: 16),
            this._buildPriceInfo(quote.changePercent * 100, quote.change.toString()),
          ],
        ),
        
        SizedBox(height: 16,),
        SizedBox(height:28,),
        
        LineChartSample2(
          stats: stats,
          quote: quote,
          chart: chart,
        ),
        SizedBox(height: 28),
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
                    title: Text('Costo\npromedio', style: subtitleStyle),
                    trailing: Text(NumberFormat().format(stockHolding.baseCost))
                  ),
                  Divider(thickness: .75,),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Rendimiento\nporcentaje', style: subtitleStyle),
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
            Expanded(child: Column(children: _leftColumn())),
            SizedBox(width: 40),
            Expanded(child: Column(children: _rightColumn()))
          ],
        ),

        
      ]
    );
  }

  List<Widget> _leftColumn() {    
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

  List<Widget> _rightColumn() {
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
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.grey.shade200),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: EdgeInsets.all(2),
        child: stats.peRatio != 0.0 
        ? FadeInImage.assetNetwork(
          placeholder: 'assets/empty.png',
          image: quote.symbol == 'JPM' 
            ? 'https://play-lh.googleusercontent.com/nSkpJQa6V2cjC0JEgerrwner4IelIQzg06DZY8dtGwRsq6iXcrxCX2Iop_VI9pohvnI' 
            : 'https://storage.googleapis.com/iex/api/logos/${quote.symbol}.png'
        )

        : Container(
          height: 54.0,
          width: 54.0,
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.grey.shade100),
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.grey
          ),
          child: Center(
            child: Text(quote.symbol, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
        )
      )
    );
  }

  Widget _buildPriceInfo(double changePercent, String change) {

    final colors = changePercent > 0 
    ? [const Color(0xff02da89), const Color(0xff02c67d)] 
    : [const Color(0xffff332e), const Color(0xffFF4B2B)];
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        this.gradientBox(change, colors),
        SizedBox(width: 8),
        this.gradientBox('(${changePercent.toStringAsFixed(2)}%)', colors)
      ],
    );
  }

  Widget gradientBox(String text, List<Color> colors) {
    final TextStyle priceChangeStyle = TextStyle(
      fontSize: 16.0,
      height: 1.5,
      letterSpacing: -1,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Container(
      height: 30,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: colors
        )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(text, textAlign: TextAlign.center, style: priceChangeStyle)
      )
    );
  }
}