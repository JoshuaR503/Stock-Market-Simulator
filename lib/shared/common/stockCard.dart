import 'package:flutter/material.dart';
import 'package:simulador/models/marketPrices.dart';
import 'package:simulador/shared/typography.dart';
import 'package:intl/intl.dart';

class StockCard extends StatelessWidget {

  final MarketPricesModel marketQuote;

  const StockCard({
    @required this.marketQuote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [            
              Row(
                children: [
                  this._buildIcon(),
                  SizedBox(width: 14),
                  this._buildCompanyInfo(context)
                ],
              ),

              Row(children: [this._buildPriceInfo()],)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (this.marketQuote.eps != null) {
      return this._buildImage();
    } else {
      return this._buildEmpty();
    }
  }

  Widget _buildImage() {
    return Container(
      height: 54.0,
      width: 54.0,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.grey.shade100),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: EdgeInsets.all(4),
        // child: Image.network('https://storage.googleapis.com/iex/api/logos/$ticker.png'),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/empty.png',
          image: marketQuote.symbol == 'JPM' 
            ? 'https://play-lh.googleusercontent.com/nSkpJQa6V2cjC0JEgerrwner4IelIQzg06DZY8dtGwRsq6iXcrxCX2Iop_VI9pohvnI' 
            : 'https://storage.googleapis.com/iex/api/logos/${marketQuote.symbol}.png'
        )
      )
    );
  }

  Widget _buildEmpty() {
    return Container(
      height: 54.0,
      width: 54.0,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.grey.shade100),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.grey
      ),
      child: Center(
        child: Text(marketQuote.symbol, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget _buildCompanyInfo(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.35,
          child: Text(marketQuote.name, style: kCardTitle, overflow: TextOverflow.clip, softWrap: true, maxLines: 1,),
        ),
        SizedBox(height: 2),
        Text(marketQuote.symbol, style: kCardsSubtitle),
      ],
    );
  }

  Widget _buildPriceInfo() {

    final isUp = marketQuote.change  > 0;
    final deepColor = isUp ? Color(0xff51cd7b) : Colors.red;
    
    final TextStyle priceChangeStyle = TextStyle(
      fontSize: 16.0,
      height: 1.5,
      letterSpacing: -1,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        Text('\$${NumberFormat().format(marketQuote.price)}', style: kCardTitle ),

        SizedBox(height: 4),
        Container(
          width: 80,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(color: deepColor, borderRadius: BorderRadius.all(Radius.circular(2)),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text( '${NumberFormat().format(marketQuote.change)}' , textAlign: TextAlign.end, style: priceChangeStyle)
          )
        ),
      ],
    );
  }
}