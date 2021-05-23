class StockQuote {
  final String symbol;
  final String companyName;
  final double open;
  final double high;
  final double low;

  final double latestPrice;
  final double extendedPrice;
  final double previousClose;

  final double change;
  final double changePercent;
  final bool isUSMarketOpen;


  StockQuote({
    this.symbol,
    this.companyName,
    this.open,
    this.high,
    this.low,

    this.latestPrice,
    this.extendedPrice,
    this.previousClose,

    this.change,
    this.changePercent,
    this.isUSMarketOpen,

  });


  factory StockQuote.fromJson(Map<String, dynamic> json) {
    print('OPEN');
    print(json['open']);

    return StockQuote(
      symbol: json['symbol'],
      companyName: json['companyName'],
      open: double.tryParse(json['iexOpen'].toString()),
      high: double.tryParse(json['high'].toString()),
      low: double.tryParse(json['low'].toString()),

      latestPrice: double.tryParse(json['latestPrice'].toString()),
      extendedPrice: double.tryParse(json['extendedPrice'].toString()),
      previousClose: double.tryParse(json['previousClose'].toString()),

      change: double.tryParse(json['change'].toString()),
      changePercent: double.tryParse(json['changePercent'].toString()),
      isUSMarketOpen: json['isUSMarketOpen'],

    );
  }
}