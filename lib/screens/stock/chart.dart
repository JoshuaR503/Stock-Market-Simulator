import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:simulador/models/stockChart.dart';
import 'package:simulador/models/stockQuote.dart';
import 'package:simulador/models/stockStats.dart';

class LineChartSample2 extends StatelessWidget {

  final StockStats stats;
  final StockQuote quote;
  final List<StockChart> chart;

  const LineChartSample2({
    this.stats,
    this.quote,
    this.chart,
  });

  @override
  Widget build(BuildContext context) {

    List<double> nums = []; 
    List<FlSpot> spots = [];

    for (var i = 0; i < chart.length; i++) {
      nums.add(chart[i].close);
    }

    for (var i = 0; i < nums.length; i++) {
      spots.add( FlSpot(double.tryParse(i.toString()), chart[i].close));
    }

    final double chartStart = chart[0].close;
    final double chartEnd = chart[chart.length-1].close;

    final red  = [
      const Color(0xffff332e),
      const Color(0xffFF4B2B),
    ];

    final green  = [
      const Color(0xff02da79),
      const Color(0xff02da89),
    ];

    final color = chartStart > chartEnd ? red : green;
    
    nums.sort();

    final double high = nums[0];
    final double low = nums[nums.length -1];

    final diff = high - low;
    final chunk = diff / 4;

    final l1 = low + chunk.round();
    final l2 = l1 + chunk.round();
    final l3 = l2 + chunk.round();
    final l4 = l3 + chunk.round();

    final ls = [l1, l2, l3, l4];

    return Stack(
      children: <Widget>[
        
        AspectRatio(
          
          aspectRatio: 1.8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Padding(
              padding: EdgeInsets.only(top: ls[0] > 200  ? 40 : 10),
              child: LineChart(mainData(ls, spots, color)),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(
    List<double> ls, 
    List<FlSpot> spots, 
    List<Color> color
  ) {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(showTitles: false)
      ),
      borderData: FlBorderData(show: false, border: Border.all(color:  Colors.red, width: 100)),
      minX: 0,
      maxX: 125,  /// The size of the array.
      minY: ls[3] - 10,  /// All time low 
      maxY: ls[0] + 5,  /// Top all time high.
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          colors: color,
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: color.map((color) => color.withOpacity(.8)).toList(),
          ),
        ),
      ],
    );
  }
}