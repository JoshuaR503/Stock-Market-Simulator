import 'package:flutter/material.dart';
import 'package:simulador/models/stockChart.dart';
import 'package:simulador/models/stockHolding.dart';
import 'package:simulador/models/stockQuote.dart';
import 'package:simulador/models/stockStats.dart';
import 'package:intl/intl.dart';
import 'package:simulador/screens/stock/chart.dart';
import 'package:simulador/screens/stock/stockInfoStyles.dart';
import 'package:simulador/services/database.dart';

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

  final green = [Color(0xff02da89), Color(0xff35e1a1)];
  final red = [Color(0xffff5e58), Color(0xffff6f55)];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Text(quote.symbol, style: quoteSymbol),
        this._buildHeading(),
        SizedBox(height: 8),
        this._buildPrices(),
              
        SizedBox(height:28),
        LineChartSample2(stats: stats, quote: quote, chart: chart),
        SizedBox(height:14),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTradeButtons("Comprar", () => Database().handleBuyOrder()),
            SizedBox(width: 14),
            _buildTradeButtons("Vender", () => Database().handleBuyOrder()),   
          ],
        ),

        SizedBox(height: 28),
        Text('Tu posición', style: sectionTitle),
        SizedBox(height:14),
        this._buildStockPosition(),
        Divider(thickness: .75,),

        SizedBox(height:28,),
        Text('Estadísticas', style: sectionTitle),
        SizedBox(height:14,),
        this._buildStockStats(),
      ]
    );
  }

  Widget _buildHeading() {

    final Widget leftRow = Flexible(
      child: Text(
        quote.companyName, 
        maxLines: 3, 
        style: quoteCompanyName
      ),
    );

    final Widget rightRow = Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.grey.shade200),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: EdgeInsets.all(2),
        child: stats.peRatio != 0.0 
          ? _buildImageWidget()
          : _buildContainer()
        )
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [leftRow, SizedBox(width: 100), rightRow],
    );
  }

  Widget _buildPrices() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('\$${quote.latestPrice.toString()}', style: quotePrice),
        SizedBox(width: 16),
        this._buildPriceInfo(quote.changePercent * 100, quote.change.toString()),
      ],
    );
  }

  Widget _buildTradeButtons(String title, Function callback) {

    final double chartStart = chart[0].close;
    final double chartEnd = chart[chart.length-1].close;
    final List<Color> colors = chartStart > chartEnd ? red : green;

    final textStyle = TextStyle(
      fontSize: 16,
      letterSpacing: 1,
      color: Colors.white,
      fontWeight: FontWeight.bold
    );

    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: callback,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            gradient: LinearGradient(begin: Alignment.topLeft, colors:colors)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(title, textAlign: TextAlign.center, style: textStyle)
          )
        ),
      )
    );
  }

  Widget _buildStockPosition() {
    final Widget leftColumn = Column(
      children: [
        _buildTile(title: "Cantidad de acciones", trailing: stockHolding.quanity),
        Divider(thickness: .75,),
        _buildTile(title: "Costo\npromedio", trailing: NumberFormat().format(stockHolding.baseCost)),
        Divider(thickness: .75),
        _buildTile(
          title: "Rendimiento\nporcentaje", 
          trailing: "${(quote.latestPrice * int.parse(stockHolding.quanity) - stockHolding.totalCost).toStringAsFixed(2)}"
        )
      ]
    );

    final Widget rightColumn = Column(
      children: [
        _buildTile(title: "Valor actual", trailing: NumberFormat().format(quote.latestPrice * int.parse(stockHolding.quanity))),
        Divider(thickness: .75,),
        _buildTile(title: "Precio de compra", trailing: NumberFormat().format(stockHolding.totalCost)),
        Divider(thickness: .75,),
        
        _buildTile(
          title: "Rendimiento",
          trailing: "${(quote.latestPrice * int.parse(stockHolding.quanity) - stockHolding.totalCost).toStringAsFixed(2)}"
        ),
      ]
    );

    return Row(
      children: <Widget>[
        Expanded(child: leftColumn),
        SizedBox(width: 40),
        Expanded(child: rightColumn),
      ],
    );
  }

  Widget _buildStockStats() {

    final leftColumn =  Column(
      children: [
        _buildTile(title: 'Apertura', trailing: quote.open.toString()),
        Divider(thickness: .75,),
        _buildTile(title: 'Último cierre', trailing: quote.previousClose.toString()),
        Divider(thickness: .75,),
        _buildTile(title: 'Máx. intradía', trailing: quote.high.toString()),
        Divider(thickness: .75,),
        _buildTile(title: 'Min. intradía', trailing: quote.low.toString()),
        Divider(thickness: .75,),
        _buildTile(title: 'Alta 52-sem.', trailing: stats.week52high.toString()),
        Divider(thickness: .75,),
        _buildTile(title: 'Baja 52-sem', trailing: stats.week52low.toString()),
        Divider(thickness: .75,),
      ]
    );

    final rightColumn = Column(
      children: [
        _buildTile(title: 'Acciones en circulación', trailing: NumberFormat.compact().format(stats.sharesOutstanding)),
        Divider(thickness: .75,),
        _buildTile(title: '10D Vol. promedio', trailing: NumberFormat.compact().format( stats.avg10Volume)),
        Divider(thickness: .75,),
        _buildTile(title: '30D Vol. promedio', trailing: NumberFormat.compact().format( stats.avg30Volume)),
        Divider(thickness: .75,),
        _buildTile(title: 'Cap. mercado', trailing: NumberFormat.compact().format(stats.marketcap)),
        Divider(thickness: .75,),
        _buildTile(title: 'PER', trailing: stats.peRatio.toStringAsFixed(2)),
        Divider(thickness: .75,),
        _buildTile(title: 'BPA', trailing: stats.ttmEPS.toStringAsFixed(2)),
        Divider(thickness: .75,),
      ],
    );

    return Row(
      children: <Widget>[
        Expanded(child: leftColumn),
        SizedBox(width: 40),
        Expanded(child: rightColumn)
      ],
    );
  }

  /// Utilities widgets.
  /// Utilities widgets.
  /// Utilities widgets.
  
  List<Color> _getColors(double changePercent) {
    return  changePercent == 0 /// If change is zero, then color is grey.
    ? [Colors.grey, Colors.grey] 
    : changePercent > 0 /// Determine color based on change.  
      ? green
      : red;
  }

  Widget _buildTile({String title, String trailing}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: subtitleStyle),
      trailing: Text(trailing)
    );
  }
  
  Widget _buildImageWidget() {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/empty.png',
      image: quote.symbol == 'JPM' 
        ? 'https://play-lh.googleusercontent.com/nSkpJQa6V2cjC0JEgerrwner4IelIQzg06DZY8dtGwRsq6iXcrxCX2Iop_VI9pohvnI' 
        : 'https://storage.googleapis.com/iex/api/logos/${quote.symbol}.png'
    );
  }

  Widget _buildContainer() {
    return Container(
      height: 54.0,
      width: 54.0,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.grey.shade100),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.grey
      ),
      child: Center(
        child: Text(quote.symbol, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPriceInfo(double changePercent, String change) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        this.gradientBox(change, _getColors(changePercent)),
        SizedBox(width: 8),
        this.gradientBox('(${changePercent.toStringAsFixed(2)}%)', _getColors(changePercent))
      ],
    );
  }

  Widget gradientBox(String text, List<Color> colors) {
    return Container(
      height: 30,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        gradient: LinearGradient(begin: Alignment.topLeft, colors: colors)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(text, textAlign: TextAlign.center, style: priceChangeStyle)
      )
    );
  }
}