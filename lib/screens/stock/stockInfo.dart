import 'package:flutter/material.dart';
import 'package:simulador/models/orderData.dart';
import 'package:simulador/models/orderType.dart';
import 'package:simulador/models/stockChart.dart';
import 'package:simulador/models/stockHolding.dart';
import 'package:simulador/models/stockQuote.dart';
import 'package:simulador/models/stockStats.dart';
import 'package:intl/intl.dart';
import 'package:simulador/screens/login/styles.dart';
import 'package:simulador/screens/stock/chart.dart';
import 'package:simulador/screens/stock/stockInfoStyles.dart';
import 'package:simulador/screens/trading/bottomSheet.dart';
import 'package:simulador/services/database.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:simulador/services/stock.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StockInfo extends StatefulWidget {

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

  @override
  _StockInfoState createState() => _StockInfoState();
}

class _StockInfoState extends State<StockInfo> {

  int stockAmount; 

  final green = [Color(0xff02da89), Color(0xff35e1a1)];
  final red = [Color(0xffff5e58), Color(0xffff6f55)];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Text(widget.quote.symbol, style: quoteSymbol),
        this._buildHeading(),
        SizedBox(height: 8),
        this._buildPrices(),
              
        SizedBox(height:28),
        LineChartSample2(stats: widget.stats, quote: widget.quote, chart: widget.chart),
        SizedBox(height:14),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTradeButtons("Comprar"),
            SizedBox(width: 14),
            _buildTradeButtons("Vender"),   
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
        widget.quote.companyName, 
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
        child: widget.stats.peRatio != 0.0 
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
        Text('\$${widget.quote.latestPrice.toString()}', style: quotePrice),
        SizedBox(width: 16),
        this._buildPriceInfo(widget.quote.changePercent * 100, widget.quote.change.toString()),
      ],
    );
  }

  Widget _buildTradeButtons(String title) {

    final double chartStart = widget.chart[0].close;
    final double chartEnd = widget.chart[widget.chart.length-1].close;
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
        onTap: () {
          this._displayTextInputDialog();
        },
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

  void _displayTextInputDialog() async {

    Widget buttonBuilder ({
    String title,
    Function callback
  }) {
    final TextStyle optionStyle = TextStyle(fontSize: 16);
    final ButtonStyle kButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2bc5aa)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    );

    return TextButton(
      onPressed: callback,
      style: kButtonStyle,
      child: Container(
        height: 34,
        child: Align(
          alignment: Alignment.center,
          child: Text(title, style: optionStyle),
        )
      ),
    );
  }

    final BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: new BorderRadius.only(
        topLeft: const Radius.circular(20.0),
        topRight: const Radius.circular(20.0)
      )
    );

    final TextStyle orderStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      height: 1.5
    );

    final double height = MediaQuery.of(context).size.height  * 0.285;

  final green = [Color(0xff02da89), Color(0xff35e1a1)];


    showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      return Container(
        height: height,
        color: Colors.transparent,
        child: Container(
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: boxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: height * 0.05),
                // Image(image: AssetImage('assets/checked.png',), height: 80, width: 80, ),
                // SizedBox(height: height * 0.05),
                Text("Introduzca el número de acciones que desea comprar",
                  textAlign: TextAlign.center,
                  style: orderStyle
                ),
                    SizedBox(height: 15,),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          // spreadRadius: 2,
                          // blurRadius: 2,
                        ),
                      ]
                    ),
                    child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    onChanged: (newText) {},
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.redAccent,
                      hoverColor: Colors.redAccent
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  height: 48,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    gradient: LinearGradient(begin: Alignment.topLeft, colors:green)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text('Aceptar', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),)
                  )
                ),

                // SizedBox(height: height * 0.05),
                // buttonBuilder( title: 'Realizar otra orden', callback: ( ) => Navigator.pop(context)),
                // SizedBox(height: height * 0.03),
                // buttonBuilder( title: 'Ver posiciones', callback: ( ) {
                //   Navigator.pop(context);
                // }),
              ],
            )
          ),
        ),
      );
    }
  );

  //  return showDialog(
  //   context: context,
  //   barrierDismissible: true,
  //   builder: (BuildContext context) {
  //     return AlertDialog(
  //       title: Text("Introduzca el número de acciones que desea comprar", style: TextStyle(
  //         height: 1.5
  //       )),
  //       content: Row(
  //         children: [
  //           Expanded(
  //             child: TextField(
  //               autofocus: true,
  //               decoration: InputDecoration(
  //                 fillColor: Colors.redAccent,
  //                 labelText: 'Número de acciones', 
                  
  //               ),
  //               keyboardType: TextInputType.number,
  //               onChanged: (value) {
  //                 if (value.isNotEmpty && int.tryParse(value) > 0) {

  //                   setState(() {
  //                     this.stockAmount = int.parse(value);
  //                   });

  //                 }
  //               },
  //             )
  //           )
  //         ],
  //       ),
  //       actions: [
  //         FlatButton(
  //           child: Text('Comprar'),
  //           onPressed: () async {
  //             final StockQuote sq = await StockService().fetchStockQuote(this.widget.quote.symbol);

  //             Database().handleBuyOrder(
  //               orderData: OrderData(
  //                 ticker: widget.quote.symbol,
  //                 quanity: this.stockAmount.toString(),
  //                 timestamp: DateTime.now().toString(),
  //                 orderType: EnumToString.convertToString(OrderType.buy),
  //                 baseCost: sq.latestPrice,
  //                 totalCost: sq.latestPrice * this.stockAmount
  //               )
  //             );

  //             Navigator.of(context, rootNavigator: true).pop();

  //           },
  //         ),
  //       ],
  //     );
  //   },
  // );
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
      image: widget.quote.symbol == 'JPM' 
        ? 'https://play-lh.googleusercontent.com/nSkpJQa6V2cjC0JEgerrwner4IelIQzg06DZY8dtGwRsq6iXcrxCX2Iop_VI9pohvnI' 
        : 'https://storage.googleapis.com/iex/api/logos/${widget.quote.symbol}.png'
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
        child: Text(widget.quote.symbol, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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