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
import 'package:simulador/screens/stock/stockPosition.dart';
import 'package:simulador/screens/stock/stockStats.dart';
import 'package:simulador/screens/stock/widgets/bottomSheetButton.dart';

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
        Text(widget.quote.symbol, style: kQuoteSymbol),
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
        Text('Tu posición', style: kSectionTitle),
        SizedBox(height:14),

        StockPosition(
          stockHolding: widget.stockHolding,
          quote: widget.quote,
        ),
        Divider(thickness: .75,),
        SizedBox(height:28,),

        Text('Estadísticas', style: kSectionTitle),
        SizedBox(height:14,),
        OverviewSection(
          quote: widget.quote,
          stats: widget.stats,
        ),
      ]
    );
  }

  Widget _buildPrices() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('\$${widget.quote.latestPrice.toString()}', style: kQuotePrice),
        SizedBox(width: 16),
        this._buildPriceInfo(widget.quote.changePercent * 100, widget.quote.change.toString()),
      ],
    );
  }

  Widget _buildTradeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: this._buildTradeButton("Comprar")),
        SizedBox(width: 14),
        Expanded(child: this._buildTradeButton("Vender"))
      ],
    );
  }

  Widget _buildTradeButton(String title) {
    return BottomSheetButton(
      title: title,
      color: this._getColors(this.widget.quote.changePercent)[0],
      callback: () {
        displayInputDialogBottomSheet(
          context: context,
          inputFieldCallback: this.updateStockAmount,
          inputFieldButtonCallback: this._displayPurchaseRecipt,
        );
      },
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
      message: 'Ha comprado ${NumberFormat().format(this.stockAmount)} unidades de ${this.widget.quote.symbol} por un total de \$${NumberFormat().format(orderData.totalCost)}'
    );
    
  }

  List<Color> _getColors(double changePercent) {
    final List<Color> defaultColor = [Colors.grey, Colors.grey];
    final List<Color> customColor = changePercent > 0 ? green : red;

    return changePercent == 0
      ? defaultColor
      : customColor;
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
        child: Text(text, textAlign: TextAlign.center, style: kPriceChangeStyle)
      )
    );
  }
}