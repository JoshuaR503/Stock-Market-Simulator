class MarketPricesModel {
  final double changesPercentage;
  final double change;
  final double price;
  final dynamic eps;

  final String name;
  final String symbol;

  MarketPricesModel({
    this.changesPercentage, 
    this.change, 
    this.price,
    this.eps, 
    this.name,
    this.symbol
  });

  static List<MarketPricesModel> toList(List<dynamic> items) {
    return items
    .map((item) => MarketPricesModel.fromJson(item))
    .toList();
  }

  factory MarketPricesModel.fromJson(Map<String, dynamic> json) {
    return MarketPricesModel(
      changesPercentage: json['changesPercentage'],
      change: json['change'],
      price: json['price'],
      eps: json['eps'],
      name: json['name'],
      symbol: json['symbol']
    );
  }
}