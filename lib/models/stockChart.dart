class StockChart {
  final double close;
  final double high;
  final double low;
  final double open;
  final String symbol;
  final double volume;
  final String id;
  final String key;
  final String subkey;
  final String date;
  final double updated;
  final double changeOverTime;
  final double marketChangeOverTime;
  final double uOpen;
  final double uClose;
  final double uHigh;
  final double uLow;
  final double uVolume;
  final double fOpen;
  final double fClose;
  final double fHigh;
  final double fLow;
  final double fVolume;
  final String label;
  final double change;
  final double changePercent;

  StockChart({
    this.close,
    this.high,
    this.low,
    this.open,
    this.symbol,
    this.volume,
    this.id,
    this.key,
    this.subkey,
    this.date,
    this.updated,
    this.changeOverTime,
    this.marketChangeOverTime,
    this.uOpen,
    this.uClose,
    this.uHigh,
    this.uLow,
    this.uVolume,
    this.fOpen,
    this.fClose,
    this.fHigh,
    this.fLow,
    this.fVolume,
    this.label,
    this.change,
    this.changePercent
  });

  factory StockChart.fromJson(Map<String, dynamic> json) {
    return StockChart(
      close: json['close'],
      high: json['high'],
      low: json['low'],
      open: json['open'],
      symbol: json['symbol'],
      volume: json['volume'],
      id: json['id'],
      key: json['key'],
      subkey: json['subkey'],
      date: json['date'],
      updated: json['updated'],
      changeOverTime: json['changeOverTime'],
      marketChangeOverTime: json['marketChangeOverTime'],
      uOpen: json['uOpen'],
      uClose: json['uClose'],
      uHigh: json['uHigh'],
      uLow: json['uLow'],
      uVolume: json['uVolume'],
      fOpen: json['fOpen'],
      fClose: json['fClose'],
      fHigh: json['fHigh'],
      fLow: json['fLow'],
      fVolume: json['fVolume'],
      label: json['label'],
      change: json['change'],
      changePercent: json['changePercent'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['close'] = this.close;
    data['high'] = this.high;
    data['low'] = this.low;
    data['open'] = this.open;
    data['symbol'] = this.symbol;
    data['volume'] = this.volume;
    data['id'] = this.id;
    data['key'] = this.key;
    data['subkey'] = this.subkey;
    data['date'] = this.date;
    data['updated'] = this.updated;
    data['changeOverTime'] = this.changeOverTime;
    data['marketChangeOverTime'] = this.marketChangeOverTime;
    data['uOpen'] = this.uOpen;
    data['uClose'] = this.uClose;
    data['uHigh'] = this.uHigh;
    data['uLow'] = this.uLow;
    data['uVolume'] = this.uVolume;
    data['fOpen'] = this.fOpen;
    data['fClose'] = this.fClose;
    data['fHigh'] = this.fHigh;
    data['fLow'] = this.fLow;
    data['fVolume'] = this.fVolume;
    data['label'] = this.label;
    data['change'] = this.change;
    data['changePercent'] = this.changePercent;
    return data;
  }
}