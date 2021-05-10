import 'package:flutter/material.dart';
import 'package:simulador/shared/typography.dart';

class StockCard extends StatelessWidget {

  final String image; 
  final String ticker;
  final String companyName;
  final String change; 
  final String price;

  const StockCard({
    @required this.image,
    @required this.ticker,
    @required this.companyName,
    @required this.change,
    @required this.price,
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
                  this._buildImage(),
                  SizedBox(width: 14),
                  this._buildCompanyInfo(),
                ],
              ),

              this._buildPriceInfo()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 54.0,
      width: 54.0,
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: Colors.grey.shade200),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Image(image: AssetImage('assets/$image.png')),
      )
    );
  }

  Widget _buildCompanyInfo() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(companyName, style: kCardTitle),
        SizedBox(height: 2),
        Text(ticker, style: kCardsSubtitle),
      ],
    );
  }

  Widget _buildPriceInfo() {

    final isUp = double.parse(change)  > 0;
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

        Text('\$$price', style: kCardTitle ),

        SizedBox(height: 4),
        Container(
          width: 70,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(color: deepColor, borderRadius: BorderRadius.all(Radius.circular(2)),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(change, textAlign: TextAlign.end, style: priceChangeStyle)
          )
        ),
      ],
    );
  }
}