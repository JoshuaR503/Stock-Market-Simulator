

import 'package:flutter/material.dart';
import 'package:simulador/screens/stock/stockInfoStyles.dart';

class HeadingWidget extends StatelessWidget {

  final String companyName;
  final String symbol;
  final double peRatio;

  const HeadingWidget({
    this.companyName,
    this.symbol,
    this.peRatio,
  });

  @override
  Widget build(BuildContext context) {

    final Widget leftRow = Flexible(
      child: Text(
        companyName, 
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
        child: peRatio != 0.0 
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

  Widget _buildImageWidget() {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/empty.png',
      image: symbol == 'JPM' 
        ? 'https://play-lh.googleusercontent.com/nSkpJQa6V2cjC0JEgerrwner4IelIQzg06DZY8dtGwRsq6iXcrxCX2Iop_VI9pohvnI' 
        : 'https://storage.googleapis.com/iex/api/logos/$symbol.png'
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
        child: Text(symbol, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}