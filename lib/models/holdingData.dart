class HoldingData {
  final String ticker;
  final String quanity;
  final String orderType;
  final double baseCost;
  final double totalCost;

  HoldingData({
    this.ticker,
    this.quanity,
    this.orderType,
    this.baseCost,
    this.totalCost
  });


  Map<String, dynamic> toJson() => {
    'ticker': ticker,
    'quanity': quanity,
    'orderType': orderType,
    'baseCost': baseCost,
    'totalCost': totalCost,
  };
}