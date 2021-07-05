
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simulador/models/stockHolding.dart';
import 'package:simulador/models/stockQuote.dart';

import 'package:simulador/screens/stock/helpers/helpers.dart';

class StockPosition extends StatelessWidget {

  final StockQuote quote;
  final StockHolding stockHolding;

  const StockPosition({
    @required this.quote,
    @required this.stockHolding,
  });

  @override
  Widget build(BuildContext context) {
    final Widget leftColumn = Column(
      children: [
        buildTile(title: "Cantidad de acciones", trailing:  TextHelpers.compactOrFormat(int.parse(stockHolding.quanity))),
        Divider(thickness: .75,),
        buildTile(title: "Costo\npromedio", trailing: NumberFormat().format(stockHolding.baseCost)),
        Divider(thickness: .75),
        buildTile(
          title: "Rendimiento\nporcentaje", 
          trailing: "${(quote.latestPrice * int.parse(stockHolding.quanity) - stockHolding.totalCost).toStringAsFixed(2)}"
        )
      ]
    );

    final Widget rightColumn = Column(
      children: [
        buildTile(title: "Valor actual", trailing: TextHelpers.compactOrFormat(quote.latestPrice * int.parse(stockHolding.quanity))),
        Divider(thickness: .75,),
        buildTile(title: "Precio de compra", trailing: TextHelpers.compactOrFormat(stockHolding.totalCost)),
        Divider(thickness: .75,),
        
        buildTile(
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
}