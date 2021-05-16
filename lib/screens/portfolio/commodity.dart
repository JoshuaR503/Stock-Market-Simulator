import 'package:flutter/material.dart';
import 'package:simulador/shared/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CommodityCard extends StatelessWidget {

  final String ticker;
  final String commodityName;
  final double change; 
  final double price;

  const CommodityCard({
    @required this.ticker,
    @required this.commodityName,
    @required this.change,
    @required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(
          Radius.circular(8)
        )
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
                  this._buildCommodityInfo(),
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

    String pic;
    double padding = 4.0;

    final bool isSilver = commodityName.contains(new RegExp(r'Silver', caseSensitive: false));
    final bool isGold = commodityName.contains(new RegExp(r'Gold', caseSensitive: false));
    final bool isCopper = commodityName.contains(new RegExp(r'Copper', caseSensitive: false));
    final bool isPlatinum = commodityName.contains(new RegExp(r'Platinum', caseSensitive: false));
    final bool isCattle = commodityName.contains(new RegExp(r'Cattle', caseSensitive: false));
    final bool isHogs = commodityName.contains(new RegExp(r'Hogs', caseSensitive: false));
    final bool isCocoa = commodityName.contains(new RegExp(r'Cocoa', caseSensitive: false));
    final bool isSoybean = commodityName.contains(new RegExp(r'Soybean', caseSensitive: false));
    final bool isCotton = commodityName.contains(new RegExp(r'Cotton', caseSensitive: false));
    final bool isCorn = commodityName.contains(new RegExp(r'Corn', caseSensitive: false));
    final bool isOats = commodityName.contains(new RegExp(r'Oats', caseSensitive: false));
    final bool isLumber = commodityName.contains(new RegExp(r'Lumber', caseSensitive: false));
    final bool isSugar = commodityName.contains(new RegExp(r'Sugar', caseSensitive: false));
    final bool isRice = commodityName.contains(new RegExp(r'Rice', caseSensitive: false));
    final bool isOrange = commodityName.contains(new RegExp(r'Orange', caseSensitive: false));

    if (commodityName == 'Crude Oil') {
      pic = 'oil';
      padding = 8;
    } else if (isGold) {
      pic = 'gold';
    } else if (isSilver || isPlatinum) {
      pic = 'silver';
    } else if (isCopper) {
      pic = 'copper';
    } else if (isCattle) {
      pic = 'cow';
    } else if (isHogs) {
      pic = 'pig';
    } else if (isCocoa) {
      pic = 'cocoa';
    } else if (isSoybean) {
      pic = 'soybean';
    } else if (isCotton) {
      pic = 'cotton';
    } else if (isCorn) {
      pic = 'corn';
    } else if (isOats) {
      pic = 'wheat';
    } else if (isLumber) {
      pic = 'lumber';
    } else if (isSugar) {
      pic = 'sugar';
    } else if (isRice) {
      pic = 'rice';
    } else if (isOrange) {
      pic = 'orange';
    } 

    return Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: Colors.grey.shade200),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SvgPicture.asset(
         'assets/$pic.svg',
        )
      )
    );
  }

  Widget _buildCommodityInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(commodityName, style: kCardTitle),
        SizedBox(height: 2),
        Text(ticker, style: kCardsSubtitle),
      ],
    );
  }

  Widget _buildPriceInfo() {

    final isUp = change  > 0;
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

        Text('\$${NumberFormat().format(price)}', style: kCardTitle ),

        SizedBox(height: 4),
        Container(
          width: 84,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(color: deepColor, borderRadius: BorderRadius.all(Radius.circular(2)),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text('${change.toStringAsFixed(2)} %', textAlign: TextAlign.end, style: priceChangeStyle)
          )
        ),
      ],
    );
  }
}