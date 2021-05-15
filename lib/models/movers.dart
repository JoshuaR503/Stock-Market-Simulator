class MarketMover {
  final String ticker;
  final double changes;
  final String price;
  final String changesPercentage;
  final String companyName;

  MarketMover({
    this.ticker, 
    this.changes, 
    this.price, 
    this.changesPercentage, 
    this.companyName,
  });


  factory MarketMover.fromJson(Map<String, dynamic> json) {

    return MarketMover(
      ticker: json['ticker'],
      changes: json['changes'],
      price: json['price'],
      changesPercentage: json['changesPercentage'],
      companyName: json['companyName']
    );
  }
}