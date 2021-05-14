class TradingStockQuote {
  final String symbol;
  final String companyName;
  final dynamic latestPrice;

  TradingStockQuote({
    this.symbol, 
    this.companyName, 
    this.latestPrice
  });

  factory TradingStockQuote.fromJson(Map<String, dynamic> json) {    
    return TradingStockQuote(
      symbol: json['symbol'],
      companyName: json['companyName'],
      latestPrice: json['latestPrice']
    );
  }
}