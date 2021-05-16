import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:simulador/screens/stock/chart.dart';
import 'package:simulador/shared/typography.dart';
import 'package:intl/intl.dart';

const subtitleStyle = const TextStyle(
  color: Colors.grey,
  fontSize: 14.5,
  height: 1.5
);

class StockScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 40.0),
              child: FadeIn(
                duration: Duration(milliseconds: 300, ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20,),
                    
                    Text(
                      'GME',
                      style: TextStyle(
                        fontSize: 24.0,
                        height: 1.5,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(
                          'GameStop',
                          style: TextStyle(
                            fontSize: 34.0,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                        ),

                        _buildImage()

                      ],
                    ),

                    SizedBox(height: 4,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        Text(
                          '\$43.49',
                          style: TextStyle(
                            fontSize: 24.0,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        SizedBox(width: 10,),
                        this._buildPriceInfo(0),
                      ],
                    ),
                    SizedBox(height: 4,),

                    Text(
                      '-\$29.59',
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1.5,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(height:28,),
                    Divider(thickness: .75,),
                    LineChartSample2(),
                    Divider(thickness: .75,),
                    SizedBox(height:14,),
                    Text(
                      'Estadísticas',
                      style: TextStyle(
                        fontSize: 24.0,
                        height: 1.5,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      )
                    ),

                    Row(
                      children: <Widget>[
                        Expanded(child: Column(children: _leftColumn())),
                        SizedBox(width: 40),
                        Expanded(child: Column(children: _rightColumn()))
                      ],
                    ),

                    
                  ]
                )
              )
            ),
          )
        ),
      ),
    );
  }

  List<Widget> _leftColumn() {
    return [
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Open', style: subtitleStyle),
        trailing: Text('1.55')
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Prev close', style: subtitleStyle),
        trailing: Text('1.55')
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Day High', style: subtitleStyle),
        trailing: Text('1.55')
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Day Low', style: subtitleStyle),
        trailing: Text('1.55')
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('52 WK High', style: subtitleStyle),
        trailing: Text('1.55')
      ),

      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('52 WK Low', style: subtitleStyle),
        trailing: Text('1.55')
      ),
    ];
  }

  List<Widget> _rightColumn() {
    return [
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Outstanding Shares', style: subtitleStyle),
        trailing: Text('1.55')
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Volume', style: subtitleStyle),
        trailing: Text('1.55')
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Avg Vol', style: subtitleStyle),
        trailing: Text('1.55')
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('MKT Cap', style: subtitleStyle),
        trailing: Text('1.55')
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('P/E Ratio', style: subtitleStyle),
        trailing: Text('1.55')
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('EPS', style: subtitleStyle),
        trailing: Text('1.55')
      ),
    ];
  }

  Widget _buildImage() {
    return Container(
      height: 54.0,
      width: 54.0,
      decoration: BoxDecoration(
        border: Border.all(width: 5.0, color: Colors.grey.shade200),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        // child: Image.network('https://storage.googleapis.com/iex/api/logos/$ticker.png'),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/warning.png',
          image: 'https://storage.googleapis.com/iex/api/logos/GME.png'
        )
      )
    );
  }

  Widget _buildPriceInfo(change) {

    final isUp = change  > 0;
    final deepColor = isUp ? Color(0xff51cd7b) : Color(0xfffcdcdf);
    
    final TextStyle priceChangeStyle = TextStyle(
      fontSize: 16.0,
      height: 1.5,
      letterSpacing: -1,
      color: Color(0xffbc444b),
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        SizedBox(height: 4),
        Container(
          width: 90,
          height: 30,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: deepColor, 
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text( '-42.57%' , textAlign: TextAlign.center, style: priceChangeStyle)
          )
        ),
      ],
    );
  }
}