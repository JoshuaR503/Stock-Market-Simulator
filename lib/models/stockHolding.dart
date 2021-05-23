class StockHolding {
  final String ticker;
  final String quanity;
  final String orderType;
  final double baseCost;
  final double totalCost;


  const StockHolding({
    this.ticker,
    this.quanity,
    this.orderType,
    this.baseCost,
    this.totalCost
  });

  static List<StockHolding> toList(List<dynamic> items) {
    return items
    .map((item) => StockHolding.fromJson(item))
    .toList();
  }

  factory StockHolding.fromJson(Map<String, dynamic> json) {
    return StockHolding(
      ticker: json['ticker'],
      quanity: json['quanity'],
      orderType: json['orderType'],
      baseCost: double.tryParse(json['baseCost'].toString()),
      totalCost: double.tryParse(json['totalCost'].toString()),
    );
  }
}