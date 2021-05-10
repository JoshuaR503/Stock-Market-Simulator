class MarketIndexModel {
  final double changesPercentage;
  final double change;
  final double price;
  final String name;
  final String symbol;

  MarketIndexModel({
    this.changesPercentage, 
    this.change, 
    this.price, 
    this.name,
    this.symbol
  });

  static List<MarketIndexModel> toList(List<dynamic> items) {
    return items
    .map((item) => MarketIndexModel.fromJson(item))
    .toList();
  }

  factory MarketIndexModel.fromJson(Map<String, dynamic> json) {

    final String customName = json['name'] == 'Dow Jones Industrial Average' ? 'Dow Jones' : json['name'];

    return MarketIndexModel(
      changesPercentage: json['changesPercentage'],
      change: json['change'],
      price: json['price'],
      name: customName,
      symbol: json['symbol']
    );
  }
}