import 'package:flutter/material.dart';
import 'package:simulador/helpers/http.dart';
import 'package:simulador/models/holdingData.dart';
import 'package:simulador/models/orderData.dart';
import 'package:simulador/models/orderType.dart';
import 'package:simulador/models/tradingStockQuote.dart';
import 'package:simulador/services/database.dart';
import 'package:simulador/shared/typography.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:enum_to_string/enum_to_string.dart';

final TextStyle kTitleStyle = TextStyle(
  fontSize: 16.5,
  height: 1.5,
  color: Colors.grey.shade600,
  fontWeight: FontWeight.w500,
);

final TextStyle kValueStyle = TextStyle(
  fontSize: 16.5,
  height: 1.5,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);



class TradingScreen extends StatefulWidget {
  @override
  _TradingScreenState createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {

  OrderType orderType = OrderType.unselected;
  double orderCost;

  TradingStockQuote tradingStockQuote;

  final _stockAmountController = TextEditingController();
  final _stockSymbolController = TextEditingController();

  Future<void> _getStockPrice() async {
    final HttpLibrary _httpLibrary = HttpLibrary();
    
    try {
      final Response<dynamic> response = await _httpLibrary.iexRequest('/v1/stock/AAPL/quote'); 
      final TradingStockQuote tradingStockQuote = TradingStockQuote.fromJson(response.data);

      final orderCost = tradingStockQuote != null 
        ? double.parse(tradingStockQuote.latestPrice.toString()) * 
          double.parse(_stockAmountController.text.isEmpty ? 1.0 : _stockAmountController.text.toString())
        : 'N/A';

      setState(() {
        this.tradingStockQuote = tradingStockQuote;
        this.orderCost = orderCost;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _stockAmountController.dispose();
    _stockSymbolController.dispose();
    super.dispose();
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height  * 0.5,
          color: Colors.transparent,
          child: Container(
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Image(image: AssetImage('assets/checked.png',), height: 100, width: 100, ),
                  SizedBox(height: 20),
                  Text("Su orden se ha\nrealizado con éxito ",
                    textAlign: TextAlign.center,
                   style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.5
                  ),),
                  SizedBox(height: 30),

                  TextButton(
                    onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2bc5aa)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Container(
                    height: 40,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Realizar otra orden', style: TextStyle(fontSize: 16)),
                    )
                  ),
                ),
                  SizedBox(height: 16),

                TextButton(
                    onPressed: () {
                       Navigator.pushNamed(context, '/holdings');
                    },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2bc5aa)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Container(
                    height: 40,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Ver posiciones', style: TextStyle(fontSize: 16)),
                    )
                  ),
                ),

                ],

              )
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfff2f1f6),
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24,),
                  Text(
                    'Trading\nCenter',
                    style: screenTitle
                  ),
                  SizedBox(height: 24),
                  
                  _buildAviabaleBalance(),
                  SizedBox(height: 16),

                  _buildOrderType(),
                  SizedBox(height: 16),

                  _buildInputBox(
                    inputLabel: "Cantidad de Acciones", 
                    inputHintText: "Acciones", 
                    keyboardType: TextInputType.number,
                    controller: _stockAmountController,
                  ),
                  SizedBox(height: 16),

                  _buildInputBox(
                    inputLabel: "Símbolo de la Bolsa", 
                    inputHintText: "Símbolo", 
                    keyboardType: TextInputType.text,
                    controller: _stockSymbolController,
                    action: () async => await this._getStockPrice()
                  ),
                  SizedBox(height: 16),

                  _buildCostEstimate(),
                  SizedBox(height: 24),

                  _buildOrderButton()
                ],
              )
            ),
          )
        ),
      ),
    );
  }

  Widget _buildAviabaleBalance( ) {
    return GestureDetector(
      onTap: () {},
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dinero\ndisponible', style: kTitleStyle),

                StreamBuilder(
                  stream: Database().cashBalance,
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      return Text('\$${NumberFormat().format(snapshot.data['cash'])}', style: kValueStyle);
                    } else {
                      return Text('cargando...', style: kValueStyle);
                    }
                  }
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrderType( ) {

    final ButtonStyle defaultStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade50),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    );

    final ButtonStyle selectedStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    );

    final buyButtonStyle = this.orderType == OrderType.buy ? selectedStyle : defaultStyle; 
    final buyButton = TextButton(
      style: buyButtonStyle, 
      child: Text('Comprar'), 
      onPressed: () => setState(() => this.orderType = OrderType.buy)
    );

    final sellButtonStyle = this.orderType == OrderType.sell ?  selectedStyle : defaultStyle;
    final sellButton = TextButton(
      style: sellButtonStyle, 
      child: Text('Vender'), 
      onPressed: () => setState(() => this.orderType = OrderType.sell)
    );

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tipo de\nOrden', style: kTitleStyle),
              Row(children: [
                buyButton, 
                SizedBox(width: 14), 
                sellButton
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox({
    String inputLabel, 
    String inputHintText, 
    TextInputType keyboardType,
    TextEditingController controller,
    Function action,
  }) {
    return GestureDetector(
      onTap: () {},
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(inputLabel, style: kTitleStyle)),
                SizedBox(width: 44),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: TextField(
                      keyboardType: keyboardType,
                      controller: controller,
                      onSubmitted: (value) {
                        if (action != null) {
                          action();
                        }
                      },
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        fillColor: Colors.blue,
                        focusColor: Colors.blueAccent,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: inputHintText,
                        hintStyle: TextStyle(color: Colors.blueAccent)
                      )
                    ),
                  )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostEstimate( ) {

    final orderTotal = orderCost != null 
      ? '\$${NumberFormat().format(orderCost)}' 
      : 'N/A';

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Costo estimado\nde la orden', style: kTitleStyle),
              Text(orderTotal, style: kValueStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderButton() {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: () async {

        await Database().changeCashbalance(
          orderValue: orderCost, 
          orderType: this.orderType
        );

        await Database().updateOrderHistory(
          orderData: OrderData(
            ticker: _stockSymbolController.text,
            quanity: _stockAmountController.text,
            timestamp: DateTime.now().toString(),
            orderType: EnumToString.convertToString(orderType),
            baseCost: double.parse(tradingStockQuote.latestPrice.toString()),
            totalCost: orderCost
          ),
          holdingData: HoldingData(
            ticker: _stockSymbolController.text,
            quanity: _stockAmountController.text,
            orderType: EnumToString.convertToString(orderType),
            baseCost: double.parse(tradingStockQuote.latestPrice.toString()),
            totalCost: orderCost
          )
        );

        // await Database().(
        //   orderData: OrderData(
        //     ticker: _stockSymbolController.text,
        //     quanity: _stockAmountController.text,
        //     timestamp: DateTime.now().toString(),
        //     orderType: EnumToString.convertToString(orderType),
        //     baseCost: double.parse(tradingStockQuote.latestPrice.toString()),
        //     totalCost: orderCost
        //   ),
        // );

        

        displayBottomSheet(context);

      },
      child: Container(
        height: 40,
        child: Align(
          alignment: Alignment.center,
          child: Text('Realizar orden', style: TextStyle(fontSize: 16)),
        )
      ),
    );
  }

}