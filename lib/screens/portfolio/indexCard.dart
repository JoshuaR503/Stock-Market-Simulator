import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simulador/shared/typography.dart';

class MarketIndexCard extends StatelessWidget {
  final String ticker;
  final String change;
  final String percentChange;
  final double price;

  const MarketIndexCard({
    @required this.ticker,
    @required this.change,
    @required this.percentChange,
    @required this.price
  });

  @override
  Widget build(BuildContext context) {

    final BoxDecoration boxDecoration = BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.all(Radius.circular(8))
    );

    return Container(
      padding: EdgeInsets.all(16),
      decoration: boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              this._buildLeftCardSide(),
              this._buildRightCardSide(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeftCardSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ticker, style: kCardTitle),
        Text(NumberFormat().format(price), style: kCardsSubtitle),
      ],
    );
  }

  Widget _buildRightCardSide() {
    final bool isPositiveChange = double.parse(change) > 0;

    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(2)),
      color: isPositiveChange 
        ? Color(0xff51cd7b) 
        : Colors.red,
    );

    final TextStyle changePercentStyle = TextStyle(
      fontSize: 16.0,
      height: 1.5,
      letterSpacing: -1,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(change, style: kCardTitle),
        SizedBox(height: 4),
        Container(
          width: 84,
          padding: EdgeInsets.all(0),
          decoration: boxDecoration,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text('$percentChange %',
              textAlign: TextAlign.end,
              style: changePercentStyle
            )
          )
        ),
      ],
    );
  }
}
