import 'package:flutter/material.dart';
import 'package:simulador/models/stockQuote.dart';
import 'package:simulador/models/stockStats.dart';
import 'package:simulador/screens/stock/helpers/helpers.dart';

class OverviewSection extends StatelessWidget {

  final StockQuote quote;
  final StockStats stats;

  OverviewSection({
    @required this.quote,
    @required this.stats,
  });

  @override
  Widget build(BuildContext context) {

      final leftColumn =  Column(
    children: [
      buildTile(title: 'Apertura', trailing: quote.open.toString()),
      Divider(thickness: .75,),
      buildTile(title: 'Último cierre', trailing: quote.previousClose.toString()),
      Divider(thickness: .75,),
      buildTile(title: 'Máx. intradía', trailing: quote.high.toString()),
      Divider(thickness: .75,),
      buildTile(title: 'Min. intradía', trailing: quote.low.toString()),
      Divider(thickness: .75,),
      buildTile(title: 'Alta 52-sem.', trailing: stats.week52high.toString()),
      Divider(thickness: .75,),
      buildTile(title: 'Baja 52-sem', trailing: stats.week52low.toString()),
      Divider(thickness: .75,),
    ]
  );

  final rightColumn = Column(
    children: [
      buildTile(title: 'Acciones en circulación', trailing: TextHelpers.compact(stats.sharesOutstanding)),
      Divider(thickness: .75,),
      buildTile(title: '10D Vol. promedio', trailing: TextHelpers.compact( stats.avg10Volume)),
      Divider(thickness: .75,),
      buildTile(title: '30D Vol. promedio', trailing: TextHelpers.compact( stats.avg30Volume)),
      Divider(thickness: .75,),
      buildTile(title: 'Cap. mercado', trailing: TextHelpers.compact(stats.marketcap)),
      Divider(thickness: .75,),
      buildTile(title: 'PER', trailing: stats.peRatio.toStringAsFixed(2)),
      Divider(thickness: .75,),
      buildTile(title: 'BPA', trailing: stats.ttmEPS.toStringAsFixed(2)),
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
}

