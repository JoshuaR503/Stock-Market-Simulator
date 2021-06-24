import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:enum_to_string/enum_to_string.dart';

import 'package:simulador/models/orderData.dart';
import 'package:simulador/models/orderType.dart';
import 'package:simulador/models/stockChart.dart';
import 'package:simulador/models/stockHolding.dart';
import 'package:simulador/models/stockQuote.dart';
import 'package:simulador/models/stockStats.dart';

import 'package:simulador/screens/stock/chart.dart';
import 'package:simulador/screens/stock/stockInfoStyles.dart';

import 'package:simulador/screens/stock/widgets/heading.dart';
import 'package:simulador/screens/stock/widgets/bottomSheets.dart';
import 'package:simulador/services/database.dart';
import 'package:simulador/services/stock.dart';

class StockInfo extends StatefulWidget {

  final StockQuote quote;
  final StockStats stats;
  final StockHolding stockHolding;
  final List<StockChart> chart;

  const StockInfo({
    this.quote,
    this.stats,
    this.stockHolding,
    this.chart
  });

  @override
  _StockInfoState createState() => _StockInfoState();
}

class _StockInfoState extends State<StockInfo> {

  int stockAmount = 0; 

  final List<Color> green = [Color(0xff02da89), Color(0xff35e1a1)];
  final List<Color> red = [Color(0xffff5e58), Color(0xffff6f55)];

  final TextStyle kTradeButtonStyle = TextStyle(
    fontSize: 16,
    letterSpacing: 1,
    color: Colors.white,
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Text(widget.quote.symbol, style: quoteSymbol),
        HeadingWidget(
          companyName: widget.stats.companyName,
          symbol: widget.quote.symbol,
          peRatio: widget.stats.peRatio,
        ),
        SizedBox(height: 8),

        this._buildPrices(),
        SizedBox(height:28),
        LineChartSample2(stats: widget.stats, quote: widget.quote, chart: widget.chart),
        SizedBox(height:14),
        
        this._buildTradeButtons(),
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

  Widget _buildPrices() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('\$${widget.quote.latestPrice.toString()}', style: quotePrice),
        SizedBox(width: 16),
        this._buildPriceInfo(widget.quote.changePercent * 100, widget.quote.change.toString()),
      ],
    );
  }

  Widget _buildTradeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        this._buildTradeButton("Comprar"),
        SizedBox(width: 14),
        this._buildTradeButton("Vender"),   
      ],
    );
  }

  Widget _buildTradeButton(String title) {
    final double chartStart = widget.chart[0].close;
    final double chartEnd = widget.chart[widget.chart.length-1].close;
    final List<Color> colors = chartStart > chartEnd ? red : green;

    final Widget kChildButton = Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        gradient: LinearGradient(begin: Alignment.topLeft, colors:colors)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(title, textAlign: TextAlign.center, style: kTradeButtonStyle)
      )
    );

    return Expanded(
      flex: 1,
      child: GestureDetector(
        child: kChildButton,
        onTap: () => displayInputDialogBottomSheet(
          context: context,
          inputFieldCallback: this.updateStockAmount,
          inputFieldButtonCallback: this._displayPurchaseRecipt,
        ),
      )
    );
  }

  void updateStockAmount(value) {
    setState(() => this.stockAmount = value);
  }

  void _displayPurchaseRecipt() async {
    final StockQuote sq = await StockService().fetchStockQuote(this.widget.quote.symbol);
    final OrderData orderData = OrderData(
      ticker: widget.quote.symbol,
      quanity: this.stockAmount.toString(),
      timestamp: DateTime.now().toString(),
      orderType: EnumToString.convertToString(OrderType.buy),
      baseCost: sq.latestPrice,
      totalCost: sq.latestPrice * this.stockAmount
    );

    Database().handleBuyOrder(orderData: orderData);

    displayReciptBottomSheet(
      context: context, 
      callback: () => Navigator.of(context).pop(),
      message: 'Ha comprado ${this.stockAmount} unidades de ${this.widget.quote.symbol} por un total de \$${orderData.totalCost}'
    );
  }

  Widget _buildStockPosition() {
    final Widget leftColumn = Column(
      children: [
        _buildTile(title: "Cantidad de acciones", trailing: widget.stockHolding.quanity),
        Divider(thickness: .75,),
        _buildTile(title: "Costo\npromedio", trailing: NumberFormat().format(widget.stockHolding.baseCost)),
        Divider(thickness: .75),
        _buildTile(
          title: "Rendimiento\nporcentaje", 
          trailing: "${(widget.quote.latestPrice * int.parse(widget.stockHolding.quanity) - widget.stockHolding.totalCost).toStringAsFixed(2)}"
        )
      ]
    );

    final Widget rightColumn = Column(
      children: [
        _buildTile(title: "Valor actual", trailing: NumberFormat().format(widget.quote.latestPrice * int.parse(widget.stockHolding.quanity))),
        Divider(thickness: .75,),
        _buildTile(title: "Precio de compra", trailing: NumberFormat().format(widget.stockHolding.totalCost)),
        Divider(thickness: .75,),
        
        _buildTile(
          title: "Rendimiento",
          trailing: "${(widget.quote.latestPrice * int.parse(widget.stockHolding.quanity) - widget.stockHolding.totalCost).toStringAsFixed(2)}"
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
        _buildTile(title: 'Apertura', trailing: widget.quote.open.toString()),
        Divider(thickness: .75,),
        _buildTile(title: 'Último cierre', trailing: widget.quote.previousClose.toString()),
        Divider(thickness: .75,),
        _buildTile(title: 'Máx. intradía', trailing: widget.quote.high.toString()),
        Divider(thickness: .75,),
        _buildTile(title: 'Min. intradía', trailing: widget.quote.low.toString()),
        Divider(thickness: .75,),
        _buildTile(title: 'Alta 52-sem.', trailing: widget.stats.week52high.toString()),
        Divider(thickness: .75,),
        _buildTile(title: 'Baja 52-sem', trailing: widget.stats.week52low.toString()),
        Divider(thickness: .75,),
      ]
    );

    final rightColumn = Column(
      children: [
        _buildTile(title: 'Acciones en circulación', trailing: NumberFormat.compact().format(widget.stats.sharesOutstanding)),
        Divider(thickness: .75,),
        _buildTile(title: '10D Vol. promedio', trailing: NumberFormat.compact().format( widget.stats.avg10Volume)),
        Divider(thickness: .75,),
        _buildTile(title: '30D Vol. promedio', trailing: NumberFormat.compact().format( widget.stats.avg30Volume)),
        Divider(thickness: .75,),
        _buildTile(title: 'Cap. mercado', trailing: NumberFormat.compact().format(widget.stats.marketcap)),
        Divider(thickness: .75,),
        _buildTile(title: 'PER', trailing: widget.stats.peRatio.toStringAsFixed(2)),
        Divider(thickness: .75,),
        _buildTile(title: 'BPA', trailing: widget.stats.ttmEPS.toStringAsFixed(2)),
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
  List<Color> _getColors(double changePercent) {
    return changePercent == 0 /// If change is zero, then color is grey.
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