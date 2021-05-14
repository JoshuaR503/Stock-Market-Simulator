class OrderData {


  final String ticker;
  final String quanity;
  final String orderType;
  final String timestamp;
  final double baseCost;
  final double totalCost;

  OrderData({
    this.ticker,
    this.quanity,
    this.orderType,
    this.timestamp,
    this.baseCost,
    this.totalCost
  });


  Map<String, dynamic> toJson() => {
    'ticker': ticker,
    'quanity': quanity,
    'orderType': orderType,
    'timestamp': timestamp,
    'baseCost': baseCost,
    'totalCost': totalCost,

  };
}