class MarketPricesModel {
  final double changesPercentage;
  final double change;
  final double price;
  final String name;
  final String symbol;

  MarketPricesModel({
    this.changesPercentage, 
    this.change, 
    this.price, 
    this.name,
    this.symbol
  });

  static List<MarketPricesModel> toList(List<dynamic> items) {
    return items
    .map((item) => MarketPricesModel.fromJson(item))
    .toList();
  }

  factory MarketPricesModel.fromJson(Map<String, dynamic> json) {

    final String companyName = json['name'];
    final String formattedCompanyName = companyName.replaceAll('Corporation', ' ');

    return MarketPricesModel(
      changesPercentage: json['changesPercentage'],
      change: json['change'],
      price: json['price'],
      name: formattedCompanyName,
      symbol: json['symbol']
    );
  }
}